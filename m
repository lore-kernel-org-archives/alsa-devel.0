From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH v4] ASoC: bcm2835: Add 8 channel
 (multitrack) capability
Date: Wed, 22 Feb 2017 16:15:19 +1100
Message-ID: <1d651f9f-e911-aec4-376f-bb94e82a6c59@flatmax.org>
References: <1486942035-24038-1-git-send-email-flatmax@flatmax.org>
 <1487106275-4260-1-git-send-email-flatmax@flatmax.org>
 <7edd3866-2cad-37a2-ad87-cc8b2c49adb2@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta22p.bpe.bigpond.com (nsstlmta22p.bpe.bigpond.com
 [203.38.21.22]) by alsa0.perex.cz (Postfix) with ESMTP id 32497266E0C
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 06:20:57 +0100 (CET)
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep22p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20170222052054.SFKG24781.nsstlfep22p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 16:20:54 +1100
Received: from meb (124.190.105.82) by smtp.telstra.com (9.0.019.11-1)
 id 58A187A702FBEDC1 for alsa-devel@alsa-project.org;
 Wed, 22 Feb 2017 16:20:54 +1100
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1cgPLz-0005L7-6v
 for alsa-devel@alsa-project.org; Wed, 22 Feb 2017 16:20:40 +1100
In-Reply-To: <7edd3866-2cad-37a2-ad87-cc8b2c49adb2@invoxia.com>
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



On 15/02/17 19:30, Arnaud Mouiche wrote:
> Hi,
>
> On 14/02/2017 22:04, Matt Flax wrote:
>> [...]
>> +    if (dev->fmt &
>> +        (SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_DSP_A))
>
> SND_SOC_DAIFMT_DSP_A is not a bit. It is an enum
>     #define SND_SOC_DAIFMT_I2S        1 /* I2S mode */
>     #define SND_SOC_DAIFMT_RIGHT_J        2 /* Right Justified mode */
>     #define SND_SOC_DAIFMT_LEFT_J        3 /* Left Justified mode */
>     #define SND_SOC_DAIFMT_DSP_A        4 /* L data MSB after FRM LRC */
>     #define SND_SOC_DAIFMT_DSP_B        5 /* L data MSB during FRM LRC */
>     #define SND_SOC_DAIFMT_AC97        6 /* AC97 */
>     #define SND_SOC_DAIFMT_PDM        7 /* Pulse density modulation */
>
> So your test is wrong.
>

Indeed I am going to fix this in patch v5.

> Other question that bother me (I'm not familiar with bcm2835, so may 
> be I'm wrong):
> why should we put channel number constraint in the SOC driver whereas 
> ASOC already compute
> the constraint by making the intersection of channels constraints 
> coming from soc AND codecs.
>
> If you connect one 8 channel capable soc driver (eg. bcm2835) with a 2 
> channel codec in DSP_A mode, ASOC already tell
> the user space that the limit is 2 channels.
> Shouldn't you just specify that bcm2835 is 8 channel capable (and may 
> be more), whatever the format is, and let ASOC do the job.
> Given a specific device tree connecting the bcm2835 with one or more 
> codecs is sufficient to specify the limits.
>
> And if in the future someone wants to connect a 4 channels capable 
> codec, or a 2x 2channels codecs, must he also send a new patch with 4 
> channels support ?
>

It does seem simpler using this approach you mention. From what I 
understand it is necessary to guard carefully in the SoC driver so that 
the codecs and machine drivers don't have to implicitly define these guards.

> Regards,
> Arnaud
>
>> +        return snd_pcm_hw_constraint_single(substream->runtime,
>> +            SNDRV_PCM_HW_PARAM_CHANNELS, 8);
>> +    else
>> +        return snd_pcm_hw_constraint_single(substream->runtime,
>> +            SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>>   }
>>     static void bcm2835_i2s_shutdown(struct snd_pcm_substream 
>> *substream,
>> @@ -549,6 +560,10 @@ static void bcm2835_i2s_shutdown(struct 
>> snd_pcm_substream *substream,
>>        * not stop the clock when SND_SOC_DAIFMT_CONT
>>        */
>>       bcm2835_i2s_stop_clock(dev);
>> +
>> +    /* Default to 2 channels */
>> +    snd_pcm_hw_constraint_single(substream->runtime,
>> +            SNDRV_PCM_HW_PARAM_CHANNELS, 2);
>>   }
>>     static const struct snd_soc_dai_ops bcm2835_i2s_dai_ops = {
>> @@ -576,16 +591,12 @@ static struct snd_soc_dai_driver 
>> bcm2835_i2s_dai = {
>>       .name    = "bcm2835-i2s",
>>       .probe    = bcm2835_i2s_dai_probe,
>>       .playback = {
>> -        .channels_min = 2,
>> -        .channels_max = 2,
>>           .rates =    SNDRV_PCM_RATE_8000_192000,
>>           .formats =    SNDRV_PCM_FMTBIT_S16_LE
>>                   | SNDRV_PCM_FMTBIT_S24_LE
>>                   | SNDRV_PCM_FMTBIT_S32_LE
>>           },
>>       .capture = {
>> -        .channels_min = 2,
>> -        .channels_max = 2,
>>           .rates =    SNDRV_PCM_RATE_8000_192000,
>>           .formats =    SNDRV_PCM_FMTBIT_S16_LE
>>                   | SNDRV_PCM_FMTBIT_S24_LE
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
