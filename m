From: Karl Beldan <karl.beldan@gmail.com>
Subject: Re: ASoC: pxa2xx-i2s
Date: Tue, 20 Jan 2009 16:44:32 +0100
Message-ID: <4975F160.8040001@gmail.com>
References: <4975E030.5080905@acdstar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 65ED41037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 16:43:43 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so1600062fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 07:43:43 -0800 (PST)
In-Reply-To: <4975E030.5080905@acdstar.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Brian Rhodes <bgr@acdstar.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Brian Rhodes wrote:
> i2s replay is not being enabled properly on occasion on my pxa270 
> board.  Current code is touching SACR1 in hw_params which I believe is 
> not correct.  That should be configured in trigger before enabling i2s.  
> Record is not disabled for playback mode.  Any invalid data in the 
> transmit fifo causes deadlock and replay is being disabled.
> 
> I have been able to reproduce it in kernel 2.6.26 as well as Linus' git 
> tree using speaker-test.  (repeatedly starting and stopping).  I've 
> verified that this fix prevents (at least) this condition.
> 
> Please review this patch and let me know if there is anything I have 
> overlooked.
> 
> Thanks
> 
> diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
> index 517991f..6cda7f1 100644
> --- a/sound/soc/pxa/pxa2xx-i2s.c
> +++ b/sound/soc/pxa/pxa2xx-i2s.c
> @@ -211,12 +211,10 @@ static int pxa2xx_i2s_hw_params(struct snd_pcm_substream *substream,
>  	if (!(SACR0 & SACR0_ENB)) {
>  
>  		SACR0 = 0;
> -		SACR1 = 0;
>  		if (pxa_i2s.master)
>  			SACR0 |= SACR0_BCKD;
>  
>  		SACR0 |= SACR0_RFTH(14) | SACR0_TFTH(1);
> -		SACR1 |= pxa_i2s.fmt;
>  	}
>  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
>  		SAIMR |= SAIMR_TFS;
> @@ -257,6 +255,12 @@ static int pxa2xx_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
>  
>  	switch (cmd) {
>  	case SNDRV_PCM_TRIGGER_START:
> +		SACR1 = pxa_i2s.fmt | SACR1_DRPL | SACR1_DREC;

Here you are stopping any ongoing stream - removing SACR1 reset in
hw_params should be enough.

> +		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			SACR1 &= ~SACR1_DRPL;
> +		} else {
> +			SACR1 &= ~SACR1_DREC;
> +		}
>  		SACR0 |= SACR0_ENB;
>  		break;
>  	case SNDRV_PCM_TRIGGER_RESUME:
> 

If - I can - I will post my changes, unless you are finished by then ;)

-- 
Karl
