From: Matt Flax <flatmax@flatmax.org>
Subject: [question] Sample rate IC followed by DAC
Date: Fri, 4 Nov 2016 20:22:43 +1100
Message-ID: <5e9a9d77-4a01-b41c-32aa-130d76958bef@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nschwmtas04p.mx.bigpond.com (nschwmtas04p.mx.bigpond.com
 [61.9.189.146]) by alsa0.perex.cz (Postfix) with ESMTP id F40B3265A98
 for <alsa-devel@alsa-project.org>; Fri,  4 Nov 2016 10:22:46 +0100 (CET)
Received: from nschwcmgw07p ([61.9.190.167]) by nschwmtas04p.mx.bigpond.com
 with ESMTP
 id <20161104092244.INBP2115.nschwmtas04p.mx.bigpond.com@nschwcmgw07p>
 for <alsa-devel@alsa-project.org>; Fri, 4 Nov 2016 09:22:44 +0000
Received: from monstilationax2 ([192.168.0.51]) by meb with esmtp (Exim 4.84_2)
 (envelope-from <flatmax@flatmax.org>) id 1c2amN-00080h-25
 for alsa-devel@alsa-project.org; Fri, 04 Nov 2016 20:27:19 +1100
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

I have a sample rate converter IC, which is followed by a DAC. This kind 
of setup :

SoC chip -> Sample rate conv. chip -> DAC chip

I also have the reverse for the ADC... but this question is about the 
DAC path.

How do you construct a machine driver for this setup ?

Only the Sample rate converter ICs use the SoC I2S bus, the DAC and ADC, 
sit outside the I2S scope of the SoC... however all chips require I2C 
control.

Unfortunately the silicon only supports an older 3.14 kernel.

Can it be something like this :

static struct snd_soc_dai_link sr_dai[] = {
     {
         .name         = "Sample-rate-for-DAC",
         .stream_name     = "playback 0",
         .cpu_dai_name     = "nxp-i2s.0",
         .platform_name  = "nxp-pcm",
         .codec_dai_name = "sample-rate-in",
         .codec_name     = "sample-rate.4-0012",
     },
     {
         .name         = "DAC",
         .stream_name     = "playback 0",
         .cpu_dai_name     = "?????",
         .platform_name  = "????",
         .codec_dai_name = "codec-in",
         .codec_name     = "DAC.4-0010",
     },
};

thanks

Matt
