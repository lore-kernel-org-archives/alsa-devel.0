From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 1/3] ALSA: pcm: Add the explicit
	appl_ptr sync support
Date: Fri, 23 Jun 2017 17:07:50 +0900
Message-ID: <815c3b0d-de4a-c8d5-f1fa-f13731b917d9@sakamocchi.jp>
References: <20170621153114.6207-1-tiwai@suse.de>
 <20170621153114.6207-2-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id EF54F266D46
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 10:07:53 +0200 (CEST)
In-Reply-To: <20170621153114.6207-2-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Vinod Koul <vinod.koul@intel.com>, "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Jun 22 2017 00:31, Takashi Iwai wrote:
> Currently x86 platforms use the PCM status/control mmaps for
> transferring the PCM status and appl_ptr between kernel and
> user-spaces.  The mmap is a most efficient way of communication, but
> it has a drawback per its nature, namely, it can't notify the change
> explicitly to kernel.
> 
> The lack of appl_ptr update notification is a problem on a few
> existing drivers, but it's mostly a small issue and negligible.
> However, a new type of driver that uses DSP for a deep buffer
> management requires the exact position of appl_ptr for calculating the
> buffer prefetch size, and the asynchronous appl_ptr update between
> kernel and user-spaces becomes a significant problem for it.
> 
> How can we enforce user-space to report the appl_ptr update?  The way
> is relatively simple.  Just by disabling the PCM control mmap, the
> user-space is supposed to fall back to the mode using SYNC_PTR ioctl,
> and the kernel gets control over that.  This fallback mode is used in
> all non-x86 platforms as default, and also in the 32bit compatible
> model on all platforms including x86.  It's been implemented already
> over a decade, so we can say it's fairly safe and stably working.
> 
> With the help of the knowledge above, this patch introduces a new PCM
> info flag SNDRV_PCM_INFO_SYNC_APPLPTR for achieving the appl_ptr sync
> from user-space.  When a driver sets this flag at open, the PCM status
> / control mmap is disabled, which effectively switches to SYNC_PTR
> mode in user-space side.
> 
> In this version, both PCM status and control mmaps are disabled
> although only the latter, control mmap, is the target.  It's because
> the current alsa-lib implementation supposes that both status and
> control mmaps are always coupled, thus it handles a fatal error when
> only one of them fails.
> 
> Of course, the disablement of the status/control mmaps may bring a
> slight performance overhead.  Thus, as of now, this should be used
> only for the dedicated devices that deserves.
> 
> Note that the disablement of mmap is a sort of workaround.  In the
> later patch, we'll introduce the way to identify the protocol version
> alsa-lib supports, and keep mmap working while the sync_ptr is
> performed together.
> 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   include/uapi/sound/asound.h |  1 +
>   sound/core/pcm_native.c     | 23 +++++++++++++++++++++--
>   2 files changed, 22 insertions(+), 2 deletions(-)

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

I note that this patch changed 'asound.h'. We have a plan to bump up 
protocol version in future patches.

> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
> index fd41697cb4d3..7eee52eb7462 100644
> --- a/include/uapi/sound/asound.h
> +++ b/include/uapi/sound/asound.h
> @@ -268,6 +268,7 @@ typedef int __bitwise snd_pcm_subformat_t;
>   #define SNDRV_PCM_INFO_MMAP_VALID	0x00000002	/* period data are valid during transfer */
>   #define SNDRV_PCM_INFO_DOUBLE		0x00000004	/* Double buffering needed for PCM start/stop */
>   #define SNDRV_PCM_INFO_BATCH		0x00000010	/* double buffering */
> +#define SNDRV_PCM_INFO_SYNC_APPLPTR	0x00000020	/* need the explicit sync of appl_ptr update */
>   #define SNDRV_PCM_INFO_INTERLEAVED	0x00000100	/* channels are interleaved */
>   #define SNDRV_PCM_INFO_NONINTERLEAVED	0x00000200	/* channels are not interleaved */
>   #define SNDRV_PCM_INFO_COMPLEX		0x00000400	/* complex frame organization (mmap only) */
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index d35c6614fdab..9ade0c8b54a3 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -3376,10 +3376,29 @@ static int snd_pcm_mmap_control(struct snd_pcm_substream *substream, struct file
>   	area->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
>   	return 0;
>   }
> +
> +static bool pcm_status_mmap_allowed(struct snd_pcm_file *pcm_file)
> +{
> +	if (pcm_file->no_compat_mmap)
> +		return false;
> +	/* Disallow the status/control mmap when SYNC_APPLPTR flag is set;
> +	 * it enforces the user-space to fall back to snd_pcm_sync_ptr(),
> +	 * thus it effectively assures the manual update of appl_ptr.
> +	 * In theory, it should be enough to disallow only PCM control mmap,
> +	 * but since the current alsa-lib implementation requires both status
> +	 * and control mmaps always paired, we have to disable both of them.
> +	 */
> +	if (pcm_file->substream->runtime->hw.info & SNDRV_PCM_INFO_SYNC_APPLPTR)
> +		return false;
> +	return true;
> +}
> +
>   #else /* ! coherent mmap */
>   /*
>    * don't support mmap for status and control records.
>    */
> +#define pcm_status_mmap_allowed(pcm_file)	false
> +
>   static int snd_pcm_mmap_status(struct snd_pcm_substream *substream, struct file *file,
>   			       struct vm_area_struct *area)
>   {
> @@ -3563,11 +3582,11 @@ static int snd_pcm_mmap(struct file *file, struct vm_area_struct *area)
>   	offset = area->vm_pgoff << PAGE_SHIFT;
>   	switch (offset) {
>   	case SNDRV_PCM_MMAP_OFFSET_STATUS:
> -		if (pcm_file->no_compat_mmap)
> +		if (!pcm_status_mmap_allowed(pcm_file))
>   			return -ENXIO;
>   		return snd_pcm_mmap_status(substream, file, area);
>   	case SNDRV_PCM_MMAP_OFFSET_CONTROL:
> -		if (pcm_file->no_compat_mmap)
> +		if (!pcm_status_mmap_allowed(pcm_file))
>   			return -ENXIO;
>   		return snd_pcm_mmap_control(substream, file, area);
>   	default:


Regards

Takashi Sakamoto
