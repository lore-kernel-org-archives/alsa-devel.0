From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Mon, 1 Nov 2010 23:41:02 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1011012325540.29422@eeebox2.perex-int.cz>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FB6F103814
	for <alsa-devel@alsa-project.org>; Mon,  1 Nov 2010 23:41:03 +0100 (CET)
In-Reply-To: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <bossart.nospam@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 1 Nov 2010, Pierre-Louis Bossart wrote:

> Merged and cleaned patch based on earlier patches posted
> on alsa-devel by Clemens Ladisch <clemens@ladisch.de> and
> Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
>
> This patch disables period interrupts which are not
> needed when the application relies on a system timer
> to wake-up and refill the ring buffer. The behavior of
> the driver is left unchanged, and interrupts are only
> disabled if the application requests this configuration.
> The behavior in case of underruns is slightly different,
> instead of being detected during the period interrupts the
> underruns are detected when the application calls
> snd_pcm_update_avail, which in turns forces a refresh of the
> hw pointer and shows the buffer is empty.
>
> More specifically this patch makes a lot of sense when
> PulseAudio relies on timer-based scheduling to access audio
> devices such as HDAudio or Intel SST. Disabling interrupts
> removes two unwanted wake-ups due to period elapsed events
> in low-power playback modes. It also simplifies PulseAudio
> voice modules used for speech calls.
>
> To quote Lennart "This patch looks very interesting and
> desirable. This is something have long been waiting for."
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
> ---
> core/pcm_lib.c          |    8 ++++++--
> core/pcm_native.c       |    6 ++++++
> include/asound.h        |    4 ++++
> include/pcm.h           |    1 +
> pci/hda/hda_intel.c     |    9 ++++++---
> pci/oxygen/oxygen_pcm.c |   14 ++++++++++----
> 6 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/core/pcm_lib.c b/core/pcm_lib.c
> index a1707cc..4963d8f 100644
> --- a/core/pcm_lib.c
> +++ b/core/pcm_lib.c
> @@ -374,7 +374,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
> 			   (unsigned long)runtime->hw_ptr_base);
> 	}
> 	/* something must be really wrong */
> -	if (delta >= runtime->buffer_size + runtime->period_size) {
> +	if (delta >= runtime->buffer_size + runtime->period_size &&
> +            !runtime->no_period_irq) {
> 		hw_ptr_error(substream,
> 			       "Unexpected hw_pointer value %s"
> 			       "(stream=%i, pos=%ld, new_hw_ptr=%ld, "
> @@ -395,6 +396,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
> 	 */
> 	if (runtime->hw.info & SNDRV_PCM_INFO_BATCH)
> 		goto no_jiffies_check;
> +        if (runtime->no_period_irq)
> +                goto no_jiffies_check;
> 	hdelta = delta;
> 	if (hdelta < runtime->delay)
> 		goto no_jiffies_check;
> @@ -431,7 +434,8 @@ static int snd_pcm_update_hw_ptr0(struct snd_pcm_substream *substream,
> 		hw_base = new_hw_ptr - (new_hw_ptr % runtime->buffer_size);
> 	}
>  no_jiffies_check:
> -	if (delta > runtime->period_size + runtime->period_size / 2) {
> +	if (delta > runtime->period_size + runtime->period_size / 2 &&
> +            !runtime->no_period_irq) {
> 		hw_ptr_error(substream,
> 			     "Lost interrupts? %s"
> 			     "(stream=%i, delta=%ld, new_hw_ptr=%ld, "

Use one 'if' and a goto behind the last condition to simplify things.

> diff --git a/core/pcm_native.c b/core/pcm_native.c
> index 8bc7cb3..92c8c59 100644
> --- a/core/pcm_native.c
> +++ b/core/pcm_native.c
> @@ -412,6 +412,12 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
> 			goto _error;
> 	}
>
> +        if (params->info & SNDRV_PCM_INFO_NO_PERIOD_IRQ)
> +                runtime->no_period_irq = !!(params->flags &
> +                                            SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ);
> +        else
> +                runtime->no_period_irq = 0;
> +
> 	runtime->access = params_access(params);
> 	runtime->format = params_format(params);
> 	runtime->subformat = params_subformat(params);
> diff --git a/include/asound.h b/include/asound.h
> index a1803ec..d4b5f2d 100644
> --- a/include/asound.h
> +++ b/include/asound.h
> @@ -259,6 +259,7 @@ typedef int __bitwise snd_pcm_subformat_t;
> #define SNDRV_PCM_INFO_HALF_DUPLEX	0x00100000	/* only half duplex */
> #define SNDRV_PCM_INFO_JOINT_DUPLEX	0x00200000	/* playback and capture stream are somewhat correlated */
> #define SNDRV_PCM_INFO_SYNC_START	0x00400000	/* pcm support some kind of sync go */
> +#define SNDRV_PCM_INFO_NO_PERIOD_IRQ    0x00800000      /* period interrupt can be disabled */
> #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
>
> typedef int __bitwise snd_pcm_state_t;
> @@ -334,6 +335,9 @@ typedef int snd_pcm_hw_param_t;
> #define	SNDRV_PCM_HW_PARAM_LAST_INTERVAL	SNDRV_PCM_HW_PARAM_TICK_TIME
>
> #define SNDRV_PCM_HW_PARAMS_NORESAMPLE	(1<<0)	/* avoid rate resampling */
> +#define SNDRV_PCM_HW_PARAMS_EXPORT_BUFFER      (1<<1)  /* export buffer */
> +#define SNDRV_PCM_HW_PARAMS_NO_PERIOD_IRQ      (1<<2)  /* disable period
> +                                                          interrupts */
>
> struct snd_interval {
> 	unsigned int min, max;

The PCM protocol version should be increased.

> diff --git a/include/pcm.h b/include/pcm.h
> index dfd9b76..9abb4aa 100644
> --- a/include/pcm.h
> +++ b/include/pcm.h
> @@ -297,6 +297,7 @@ struct snd_pcm_runtime {
> 	unsigned int info;
> 	unsigned int rate_num;
> 	unsigned int rate_den;
> +        bool no_period_irq;

I would use an unsigned int bit field rather than bool in this case to 
make addition in-line with other structures in this file.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
