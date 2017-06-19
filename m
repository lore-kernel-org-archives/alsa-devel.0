From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3] ALSA: core: let low-level driver or
 userspace disable rewinds
Date: Mon, 19 Jun 2017 10:16:28 -0500
Message-ID: <a6c137ca-9158-50e2-fc55-eb6ef91db46c@linux.intel.com>
References: <1497853357-2931-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hr2yg74f4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id DCF62266C24
 for <alsa-devel@alsa-project.org>; Mon, 19 Jun 2017 17:16:31 +0200 (CEST)
In-Reply-To: <s5hr2yg74f4.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

On 6/19/17 3:44 AM, Takashi Iwai wrote:
> On Mon, 19 Jun 2017 08:22:37 +0200,
> Subhransu S. Prusty wrote:
>>
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Add new hw_params flag to explicitly tell driver that rewinds will never
>> be used. This can be used by low-level driver to optimize DMA operations
>> and reduce power consumption. Use this flag only when data written in
>> ring buffer will never be invalidated, e.g. any update of appl_ptr is
>> final.
>>
>> Note that the update of appl_ptr include both a read/write data
>> operation as well as snd_pcm_forward() whose behavior is not modified.
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Signed-off-by: Ramesh Babu <ramesh.babu@intel.com>
>> Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
>> ---
>>
>> v2 -> v3
>> 	return error for rewind operation if no_rewinds set.
>
> Now I'm thinking whether this change is really needed or in the right
> direction.  I suppose that the driver would change the behavior
> depending on the flag of this flag.  But then how can application know
> that it should not rewind on a certain device and set the flag?

The application (which is in most cases an audio server) *knows* if it 
requires rewinds or not. It's part of its design, with rewinds typically 
disabled if period interrupts are required. It's been that way for a 
number of years now. The use of rewinds is typically associated with the 
combination of a large buffer and no interrupts (having either of the 
two would not require rewinds).

So the idea is that the application makes a statement that rewinds will 
not be used, and the low-level driver makes use of the information to 
enable whatever optimizations are available at the hardware level.

Exposing more information to userspace would quickly lead to a confusing 
decision-making and would require more than just a flag.

>
> We may, instead, let the driver behaving in the deep buffer mode as
> default (or turned on/off via the kcontrol).  Then you can simply
> return an error for the negative appl_ptr change in ack callback --
> which effectively disables the rewind.
>
>
> thanks,
>
> Takashi
>
>>  include/sound/pcm.h         | 1 +
>>  include/uapi/sound/asound.h | 1 +
>>  sound/core/pcm_native.c     | 8 ++++++++
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/include/sound/pcm.h b/include/sound/pcm.h
>> index 79fedf517070..c1e2b87cd409 100644
>> --- a/include/sound/pcm.h
>> +++ b/include/sound/pcm.h
>> @@ -368,6 +368,7 @@ struct snd_pcm_runtime {
>>  	unsigned int rate_num;
>>  	unsigned int rate_den;
>>  	unsigned int no_period_wakeup: 1;
>> +	unsigned int no_rewinds:1;
>>
>>  	/* -- SW params -- */
>>  	int tstamp_mode;		/* mmap timestamp is updated */
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index fd41697cb4d3..c697ff90450d 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -365,6 +365,7 @@ struct snd_pcm_info {
>>  #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
>>  #define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER	(1<<1)	/* export buffer */
>>  #define SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP	(1<<2)	/* disable period wakeups */
>> +#define SNDRV_PCM_HW_PARAMS_NO_REWINDS	        (1<<3)	/* disable rewinds */
>>
>>  struct snd_interval {
>>  	unsigned int min, max;
>> diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
>> index bf5d0f2acfb9..6769f4751fa0 100644
>> --- a/sound/core/pcm_native.c
>> +++ b/sound/core/pcm_native.c
>> @@ -554,6 +554,8 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
>>  	runtime->no_period_wakeup =
>>  			(params->info & SNDRV_PCM_INFO_NO_PERIOD_WAKEUP) &&
>>  			(params->flags & SNDRV_PCM_HW_PARAMS_NO_PERIOD_WAKEUP);
>> +	runtime->no_rewinds =
>> +		(params->flags & SNDRV_PCM_HW_PARAMS_NO_REWINDS) ? 1 : 0;
>>
>>  	bits = snd_pcm_format_physical_width(runtime->format);
>>  	runtime->sample_bits = bits;
>> @@ -2521,6 +2523,9 @@ static snd_pcm_sframes_t snd_pcm_playback_rewind(struct snd_pcm_substream *subst
>>  	if (frames == 0)
>>  		return 0;
>>
>> +	if (runtime->no_rewinds)
>> +		return -ENODEV;
>> +
>>  	snd_pcm_stream_lock_irq(substream);
>>  	ret = do_pcm_hwsync(substream);
>>  	if (!ret)
>> @@ -2539,6 +2544,9 @@ static snd_pcm_sframes_t snd_pcm_capture_rewind(struct snd_pcm_substream *substr
>>  	if (frames == 0)
>>  		return 0;
>>
>> +	if (runtime->no_rewinds)
>> +		return -ENODEV;
>> +
>>  	snd_pcm_stream_lock_irq(substream);
>>  	ret = do_pcm_hwsync(substream);
>>  	if (!ret)
>> --
>> 1.9.1
>>
