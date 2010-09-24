From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH V1 09/11] ASoC: DaVinci: i2s,
 add davinci_i2s_prepare and shutdown
Date: Fri, 24 Sep 2010 16:13:50 -0700
Message-ID: <4C9D30AE.6080103@boundarydevices.com>
References: <1246761001-21982-1-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-2-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-3-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-4-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-5-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-6-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-7-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-8-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-9-git-send-email-troy.kisky@boundarydevices.com>	<1246761001-21982-10-git-send-email-troy.kisky@boundarydevices.com>	<A24693684029E5489D1D202277BE89447289CD0A@dlee02.ent.ti.com>	<4C9CF898.7070906@boundarydevices.com>
	<A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cpoproxy3-pub.bluehost.com (cpoproxy3-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id CF5421037FC
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Sep 2010 01:13:57 +0200 (CEST)
In-Reply-To: <A24693684029E5489D1D202277BE89447289CF40@dlee02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ambrose, Martin" <martin@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> I don't see the problem because my codec waits until trigger to activate its interface.
> 
> Thanks for the feedback. I'm using the tlv320aic3x codec driver. Which codec are you using?

A modified tlv320aic23. I wrote it before it was available in the kernel, and never finished
a merge.

> 
>> So the question is, who should be responsible for the final turn on?
>>
>> My thought was that the device (master) which starts the external wires to wiggling should be last.
> 
> Fair enough. I suppose that is the reasoning for the addition of the prepare function.
> The assumption being that a cpu_dai callback to the prepare function will always proceed
> a call to the codec_dai trigger function. In this way the serial port can be configured and enabled.
> Then the codec can turn on the bit/frame clocks which will start the flow of data. 
> Although it would seem the codec is unmuted a bit prematurely in this scenario since it happens
> before the clocks are enabled in the core prepare function -- at least I think this is the case.
> 
> However there would still seem to be spurious, or at least superfluous, calls
> to mcbsp_stop/start when just requesting the device to enter the pause state.
> 
> I guess the call tree is then different in the case where the cpu, or machine, is the 
> clock master. This has pros/cons obviously.
> 
>> If the codec is master, and starts the clocks before the mcbsp is ready that could also cause a pop
>> or noise.
> 
> I still a newbie when it comes to the ALSA architecture.
> Is the proper signal indicating everything is ready, including valid data, a trigger call with cmd=START?
> 

That is my understanding.

I think the main problem with using trigger to start the codec wiggling wires
is the need to use schedule_work to do i2c writes. That's probably why the mainline
aic23 driver doesn't use trigger. Sample below.


static void codec_trigger_deferred(struct work_struct *work)
{
       struct aic23 *aic23 = container_of(work, struct aic23,
                       deferred_trigger_work);
       struct snd_soc_codec *codec = &aic23->codec;
       int playback = aic23->active_mask & ACTIVE_PLAYBACK;
       u16 dia = (aic23->active_mask) ? 1 : 0;
       if (playback) {
               tlv320aic23_set(codec, TLV320AIC23_ACTIVE, 1);
               tlv320aic23_modify(codec, TLV320AIC23_ANLG, 0, TLV320AIC23_DAC_SELECTED);
               tlv320aic23_mute_volume(codec, 0);
       } else {
               tlv320aic23_mute_volume(codec, 1);
               if (dia)
                       tlv320aic23_set(codec, TLV320AIC23_ACTIVE, dia);
               tlv320aic23_modify(codec, TLV320AIC23_ANLG, TLV320AIC23_DAC_SELECTED, 0);
               if (!dia)
                       tlv320aic23_set(codec, TLV320AIC23_ACTIVE, dia);
       }
}

static int tlv320aic23_trigger(struct snd_pcm_substream *substream, int cmd,
                  struct snd_soc_dai *dai)
{
       struct snd_soc_pcm_runtime *rtd = substream->private_data;
       struct snd_soc_device *socdev = rtd->socdev;
       struct snd_soc_codec *codec = socdev->card->codec;
       struct aic23 *aic23 = container_of(codec, struct aic23, codec);
       int ret = 0;
       int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
       unsigned char mask = (playback)? ACTIVE_PLAYBACK : ACTIVE_CAPTURE;

       switch (cmd) {
       case SNDRV_PCM_TRIGGER_START:
       case SNDRV_PCM_TRIGGER_RESUME:
       case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
               aic23->active_mask |= mask;
               schedule_work(&aic23->deferred_trigger_work);
               break;
       case SNDRV_PCM_TRIGGER_STOP:
       case SNDRV_PCM_TRIGGER_SUSPEND:
       case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
               aic23->active_mask &= ~mask;
               schedule_work(&aic23->deferred_trigger_work);
               /* don't stop driving data lines
                * until digital_mute done
                */
               break;
       default:
       return ret;
}
