From: Matt Flax <flatmax@flatmax.org>
Subject: ASoC : question about custom rate
Date: Tue, 09 Sep 2014 18:43:36 +1000
Message-ID: <540EBDB8.20507@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [150.101.137.129])
 by alsa0.perex.cz (Postfix) with ESMTP id D95C7265087
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 10:43:46 +0200 (CEST)
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

Hi there,

I have an ASIC running on an ASoC with a custom rate @ 18750 Hz.
I would like ALSA to report the correct rate.

If I do nothing, then the following reports 16000 Hz :
cat /proc/asound/card0/pcm0c/sub0/hw_params

I have verified that the hardware is running at the expected 18750 Hz.
I am wondering what/where is the correct place to setup the actual rate ?

I am trying to set the rates at startup like so but ALSA will not work 
with the driver when I do this :

static int implant_startup(struct snd_pcm_substream *substream, struct 
snd_soc_dai *dai)
{
     snd_pcm_hw_constraint_minmax(substream->runtime, 
SNDRV_PCM_HW_PARAM_RATE, 18750, 18750);
     snd_pcm_hw_constraint_minmax(substream->runtime, 
SNDRV_PCM_HW_PARAM_CHANNELS, 2, 2);
     snd_pcm_hw_constraint_minmax(substream->runtime, 
SNDRV_PCM_HW_PARAM_SAMPLE_BITS, 16, 16);

     return 0;
}

static const struct snd_soc_dai_ops implant_dai_ops = {
     .set_fmt    = implant_set_dai_fmt,
     .startup = implant_startup,
};

thanks
Matt
