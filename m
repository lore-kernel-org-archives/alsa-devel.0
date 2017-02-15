From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
Subject: Re: [PATCH v4] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
Date: Wed, 15 Feb 2017 09:30:26 +0100
Message-ID: <7edd3866-2cad-37a2-ad87-cc8b2c49adb2@invoxia.com>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f180.google.com (mail-wr0-f180.google.com
 [209.85.128.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 2C9C1266569
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 09:30:29 +0100 (CET)
Received: by mail-wr0-f180.google.com with SMTP id o16so185954513wra.1
 for <alsa-devel@alsa-project.org>; Wed, 15 Feb 2017 00:30:29 -0800 (PST)
Received: from [192.168.65.131] (AAnnecy-653-1-34-223.w90-27.abo.wanadoo.fr.
 [90.27.45.223])
 by smtp.gmail.com with ESMTPSA id x39sm3944218wrb.3.2017.02.15.00.30.27
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Feb 2017 00:30:28 -0800 (PST)
In-Reply-To: <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 14/02/2017 22:04, Matt Flax wrote:
> [...]
> +	if (dev->fmt &
> +		(SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))

SND_SOC_DAIFMT_DSP_A is not a bit. It is an enum
	#define SND_SOC_DAIFMT_I2S		1 /* I2S mode */
	#define SND_SOC_DAIFMT_RIGHT_J		2 /* Right Justified mode */
	#define SND_SOC_DAIFMT_LEFT_J		3 /* Left Justified mode */
	#define SND_SOC_DAIFMT_DSP_A		4 /* L data MSB after FRM LRC */
	#define SND_SOC_DAIFMT_DSP_B		5 /* L data MSB during FRM LRC */
	#define SND_SOC_DAIFMT_AC97		6 /* AC97 */
	#define SND_SOC_DAIFMT_PDM		7 /* Pulse density modulation */

So your test is wrong.

Other question that bother me (I'm not familiar with bcm2835, so may be I'm wrong):
why should we put channel number constraint in the SOC driver whereas ASOC already compute
the constraint by making the intersection of channels constraints coming from soc AND codecs.

If you connect one 8 channel capable soc driver (eg. bcm2835) with a 2 channel codec in DSP_A mode, ASOC already tell
the user space that the limit is 2 channels.
Shouldn't you just specify that bcm2835 is 8 channel capable (and may be more), whatever the format is, and let ASOC do the job.
Given a specific device tree connecting the bcm2835 with one or more codecs is sufficient to specify the limits.

And if in the future someone wants to connect a 4 channels capable codec, or a 2x 2channels codecs, must he also send a new patch with 4 channels support ?

Regards,
Arnaud

> +		return snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 8);
> +	else
> +		return snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>   }
>   
>   static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
> @@ -549,6 +560,10 @@ static void bcm2835_i2s_shutdown(struct snd_pcm_substream *substream,
>   	 * not stop the clock when SND_SOC_DAIFMT_CONT
>   	 */
>   	bcm2835_i2s_stop_clock(dev);
> +
> +	/* Default to 2 channels */
> +	snd_pcm_hw_constraint_single(substream->runtime,
> +			SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>   }
>   
>   static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
> @@ -576,16 +591,12 @@ static struct snd_soc_dai_driver bcm2835_i2s_dai = {
>   	.name	= "bcm2835-i2s",
>   	.probe	= bcm2835_i2s_dai_probe,
>   	.playback = {
> -		.channels_min = 2,
> -		.channels_max = 2,
>   		.rates =	SNDRV_PCM_RATE_8000_192000,
>   		.formats =	SNDRV_PCM_FMTBIT_S16_LE
>   				| SNDRV_PCM_FMTBIT_S24_LE
>   				| SNDRV_PCM_FMTBIT_S32_LE
>   		},
>   	.capture = {
> -		.channels_min = 2,
> -		.channels_max = 2,
>   		.rates =	SNDRV_PCM_RATE_8000_192000,
>   		.formats =	SNDRV_PCM_FMTBIT_S16_LE
>   				| SNDRV_PCM_FMTBIT_S24_LE
