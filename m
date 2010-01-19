From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
Subject: Re: [PATCH 1/2] ASoC: DaVinci: Voice Codec Support
Date: Tue, 19 Jan 2010 11:35:25 -0600
Message-ID: <4B55ED5D.8010309@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.navvo.net (mail.navvo.net [74.208.67.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 331F41037F1
	for <alsa-devel@alsa-project.org>; Tue, 19 Jan 2010 18:38:09 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: kevin Hilman <khilman@deeprootsystems.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

I have been trying to test the AIC3x and the Voice Codec in the same kernel, 
however only the AIC3x is working, I'm having problem when I try to use the 
Voice Codec, I already have verified that the Voice Codec works since I tested 
alone.

Please check the following output:

root@dm365-evm:~# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: EVM [DaVinci DM365 EVM], device 0: AIC3X tlv320aic3x-0 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0
card 0: EVM [DaVinci DM365 EVM], device 1: CQ93 CQ93VC-1 []
   Subdevices: 1/1
   Subdevice #0: subdevice #0

root@dm365-evm:~# aplay -L
default:CARD=EVM
     DaVinci DM365 EVM,
     Default Audio Device
null
     Discard all samples (playback) or generate zero samples (capture)

root@dm365-evm:~# cat /proc/asound/pcm
00-00: AIC3X tlv320aic3x-0 :  : playback 1 : capture 1
00-01: CQ93 CQ93VC-1 :  : playback 1 : capture 1

root@dm365-evm:~# cat /proc/asound/devices
   0: [ 0]   : control
  16: [ 0- 0]: digital audio playback
  17: [ 0- 1]: digital audio playback
  24: [ 0- 0]: digital audio capture
  25: [ 0- 1]: digital audio capture
  33:        : timer
 

root@dm365-evm:~# cat /proc/asound/cards
  0 [EVM            ]: tlv320aic3x - DaVinci DM365 EVM
                       DaVinci DM365 EVM (tlv320aic3x)

root@dm365-evm:~# cat /proc/asound/timers
G0: system timer : 10000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE

root@dm365-evm:~# arecord -D plughw:0,0 test.wav
Recording WAVE 'test.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono

*** This is the error that I have. I not sure if it has to do with the
root@dm365-evm:~# arecord -D plughw:0,1 test.wav
asoc: can't open platform davinci-audio
arecord: main:608: audio open error: No such device

The following is the patch to the davinci-evm.c please check it if you see 
something wrong there:

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 7ccbe66..951d730 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -29,8 +29,10 @@

  #include "../codecs/tlv320aic3x.h"
  #include "../codecs/spdif_transciever.h"
+#include "../codecs/cq93vc.h"
  #include "davinci-pcm.h"
  #include "davinci-i2s.h"
+#include "davinci-vcif.h"
  #include "davinci-mcasp.h"

  #define AUDIO_FORMAT (SND_SOC_DAIFMT_DSP_B | \
@@ -151,6 +153,23 @@ static struct snd_soc_dai_link evm_dai = {
         .ops = &evm_ops,
  };

+static struct snd_soc_dai_link dm365_evm_dai[] = {
+       {
+               .name = "TLV320AIC3X",
+               .stream_name = "AIC3X",
+               .cpu_dai = &davinci_i2s_dai,
+               .codec_dai = &aic3x_dai,
+               .init = evm_aic3x_init,
+               .ops = &evm_ops,
+       },
+       {
+               .name = "Voice Codec - CQ93VC",
+               .stream_name = "CQ93",
+       .cpu_dai = &davinci_vcif_dai,
+               .codec_dai = &cq93vc_dai,
+       },
+};
+
  static struct snd_soc_dai_link dm6467_evm_dai[] = {
         {
                 .name = "TLV320AIC3X",
@@ -177,7 +196,7 @@ static struct snd_soc_dai_link da8xx_evm_dai = {
         .ops = &evm_ops,
  };

-/* davinci dm6446, dm355 or dm365 evm audio machine driver */
+/* davinci dm6446, dm355 evm audio machine driver */
  static struct snd_soc_card snd_soc_card_evm = {
         .name = "DaVinci EVM",
         .platform = &davinci_soc_platform,
@@ -185,6 +204,14 @@ static struct snd_soc_card snd_soc_card_evm = {
         .num_links = 1,
  };

+/* davinci dm365 evm audio machine driver */
+static struct snd_soc_card dm365_snd_soc_card_evm = {
+       .name = "DaVinci DM365 EVM",
+       .platform = &davinci_soc_platform,
+       .dai_link = &dm365_evm_dai,
+       .num_links = ARRAY_SIZE(dm365_evm_dai),
+};
+
  /* davinci dm6467 evm audio machine driver */
  static struct snd_soc_card dm6467_snd_soc_card_evm = {
         .name = "DaVinci DM6467 EVM",
@@ -217,6 +244,13 @@ static struct snd_soc_device evm_snd_devdata = {
  };

  /* evm audio subsystem */
+static struct snd_soc_device dm365_evm_snd_devdata = {
+       .card = &dm365_snd_soc_card_evm,
+       .codec_dev = &soc_codec_dev_aic3x,
+       .codec_data = &aic3x_setup,
+};
+
+/* evm audio subsystem */
  static struct snd_soc_device dm6467_evm_snd_devdata = {
         .card = &dm6467_snd_soc_card_evm,
         .codec_dev = &soc_codec_dev_aic3x,
@@ -244,12 +278,15 @@ static int __init evm_init(void)
         int index;
         int ret;

-       if (machine_is_davinci_evm() || machine_is_davinci_dm365_evm()) {
+       if (machine_is_davinci_evm()) {
                 evm_snd_dev_data = &evm_snd_devdata;
                 index = 0;
         } else if (machine_is_davinci_dm355_evm()) {
                 evm_snd_dev_data = &evm_snd_devdata;
                 index = 1;
+       } else if (machine_is_davinci_dm365_evm()) {
+               evm_snd_dev_data = &dm365_evm_snd_devdata;
+               index = 0;
         } else if (machine_is_davinci_dm6467_evm()) {
                 evm_snd_dev_data = &dm6467_evm_snd_devdata;
                 index = 0;


Thanks,

Miguel Aguilar
