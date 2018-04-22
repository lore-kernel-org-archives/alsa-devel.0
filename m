From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: core: Report audio_tstamp in
	snd_pcm_sync_ptr
Date: Sun, 22 Apr 2018 21:55:51 +0900
Message-ID: <faa892b4-38b3-f01c-7d40-bba9ac3e4e73@sakamocchi.jp>
References: <20180421125740.10931-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy003.phy.lolipop.jp (smtp-proxy003.phy.lolipop.jp
 [157.7.104.44]) by alsa0.perex.cz (Postfix) with ESMTP id 1BC77267265
 for <alsa-devel@alsa-project.org>; Sun, 22 Apr 2018 14:55:56 +0200 (CEST)
In-Reply-To: <20180421125740.10931-1-tiwai@suse.de>
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
Cc: David Henningsson <diwic@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Apr 21 2018 21:57, Takashi Iwai wrote:
> From: David Henningsson <diwic@ubuntu.com>
> 
> It looks like a simple mistake that this struct member
> was forgotten.
> 
> Audio_tstamp isn't used much, and on some archs (such as x86) this
> ioctl is not used by default, so that might be the reason why this
> has slipped for so long.

Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

However, with ALSA PCM interface v2.0.14 or later, theoretically in a 
case of driver's support for SNDRV_PCM_INFO_SYNC_APPLPTR, I perhaps can 
see the slip on x86 platform. In detail, please read below commits in order:
  * 42f945970af9 ('ALSA: pcm: Add the explicit appl_ptr sync support')
  * 4b671f577474 ('ALSA: pcm: Add an ioctl to specify the supported
    protocol version')
  * b602aa8eb1a0 ('ALSA: pcm: Disable only control mmap for explicit
    appl_ptr sync')

> Fixes: 4eeaaeaea1ce ("ALSA: core: add hooks for audio timestamps")
> Signed-off-by: David Henningsson <diwic@ubuntu.com>
> Cc: <stable@vger.kernel.org>

# v3.8+

$ git name-rev --tags 4eeaaeaea1cec
4eeaaeaea1cec tags/v3.8-rc1~29^2~127

> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> 
>   sound/core/pcm_native.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
> index 35ffcce..632228b 100644
> --- a/sound/core/pcm_native.c
> +++ b/sound/core/pcm_native.c
> @@ -2751,6 +2751,7 @@ static int snd_pcm_sync_ptr(struct snd_pcm_substream *substream,
>   	sync_ptr.s.status.hw_ptr = status->hw_ptr;
>   	sync_ptr.s.status.tstamp = status->tstamp;
>   	sync_ptr.s.status.suspended_state = status->suspended_state;
> +	sync_ptr.s.status.audio_tstamp = status->audio_tstamp;
>   	snd_pcm_stream_unlock_irq(substream);
>   	if (copy_to_user(_sync_ptr, &sync_ptr, sizeof(sync_ptr)))
>   		return -EFAULT;


Thanks

Takashi Sakamoto
