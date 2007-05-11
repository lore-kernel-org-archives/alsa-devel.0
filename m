From: Rene Herman <rene.herman@gmail.com>
Subject: [PATCH] remove email addresses from MODULE_AUTHOR tag
Date: Fri, 11 May 2007 03:08:28 +0200
Message-ID: <4643C20C.8050105@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060809030705080509070607"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 3481B2437C
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 03:11:02 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id j3so526483ugf
	for <alsa-devel@alsa-project.org>; Thu, 10 May 2007 18:11:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060809030705080509070607
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi Takashi.

Following up the recent MODULE_MAINTAINER discussion on LKML:

http://lkml.org/lkml/2007/4/4/170

that concluded with MODULE_MAINTAINER not being a good idea, here's a patch 
that just deletes the email addresses from the MODULE_AUTHOR tags for ALSA.

The email address is the problem I was trying to fix; with multiple current 
and non-current authors and maintainers who might not even be authors the 
address(es) available from the tag confuse the issue of whom to contact. 
It's moreover also information that easily outdated.

A bit more than half of the tags in the kernel don't include an email 
address already (the core contributors typically don't include any) and I'll 
submit patches removing more.

(this was generated against current -linus).

  aoa/codecs/snd-aoa-codec-onyx.c     |    2 +-
  aoa/codecs/snd-aoa-codec-tas.c      |    2 +-
  aoa/codecs/snd-aoa-codec-toonie.c   |    2 +-
  aoa/core/snd-aoa-core.c             |    2 +-
  aoa/fabrics/snd-aoa-fabric-layout.c |    2 +-
  aoa/soundbus/core.c                 |    2 +-
  aoa/soundbus/i2sbus/i2sbus-core.c   |    2 +-
  arm/sa11xx-uda1341.c                |    2 +-
  core/hwdep.c                        |    2 +-
  core/memalloc.c                     |    2 +-
  core/oss/mixer_oss.c                |    2 +-
  core/oss/pcm_oss.c                  |    2 +-
  core/pcm.c                          |    2 +-
  core/rawmidi.c                      |    2 +-
  core/seq/instr/ainstr_fm.c          |    2 +-
  core/seq/instr/ainstr_gf1.c         |    2 +-
  core/seq/instr/ainstr_iw.c          |    2 +-
  core/seq/instr/ainstr_simple.c      |    2 +-
  core/seq/oss/seq_oss.c              |    2 +-
  core/seq/seq.c                      |    2 +-
  core/seq/seq_device.c               |    2 +-
  core/seq/seq_dummy.c                |    2 +-
  core/seq/seq_instr.c                |    2 +-
  core/seq/seq_midi.c                 |    2 +-
  core/seq/seq_midi_emul.c            |    2 +-
  core/seq/seq_midi_event.c           |    2 +-
  core/seq/seq_virmidi.c              |    2 +-
  core/sound.c                        |    2 +-
  core/timer.c                        |    2 +-
  drivers/dummy.c                     |    2 +-
  drivers/mpu401/mpu401.c             |    2 +-
  drivers/mpu401/mpu401_uart.c        |    2 +-
  drivers/mts64.c                     |    2 +-
  drivers/opl3/opl3_lib.c             |    2 +-
  drivers/opl3/opl3_seq.c             |    2 +-
  drivers/opl4/opl4_lib.c             |    2 +-
  drivers/opl4/opl4_seq.c             |    2 +-
  drivers/virmidi.c                   |    2 +-
  drivers/vx/vx_core.c                |    2 +-
  i2c/cs8427.c                        |    2 +-
  i2c/i2c.c                           |    2 +-
  i2c/l3/uda1341.c                    |    2 +-
  i2c/other/ak4114.c                  |    2 +-
  i2c/other/ak4117.c                  |    2 +-
  i2c/other/ak4xxx-adda.c             |    2 +-
  i2c/other/pt2258.c                  |    2 +-
  i2c/other/tea575x-tuner.c           |    2 +-
  i2c/tea6330t.c                      |    2 +-
  isa/ad1816a/ad1816a.c               |    2 +-
  isa/ad1848/ad1848.c                 |    2 +-
  isa/ad1848/ad1848_lib.c             |    2 +-
  isa/als100.c                        |    2 +-
  isa/azt2320.c                       |    2 +-
  isa/cmi8330.c                       |    2 +-
  isa/cs423x/cs4231.c                 |    2 +-
  isa/cs423x/cs4231_lib.c             |    2 +-
  isa/cs423x/cs4236.c                 |    2 +-
  isa/cs423x/cs4236_lib.c             |    2 +-
  isa/dt019x.c                        |    2 +-
  isa/es1688/es1688.c                 |    2 +-
  isa/es1688/es1688_lib.c             |    2 +-
  isa/es18xx.c                        |    2 +-
  isa/gus/gus_main.c                  |    2 +-
  isa/gus/gus_synth.c                 |    2 +-
  isa/gus/gusclassic.c                |    2 +-
  isa/gus/gusextreme.c                |    2 +-
  isa/gus/gusmax.c                    |    2 +-
  isa/gus/interwave.c                 |    2 +-
  isa/opl3sa2.c                       |    2 +-
  isa/opti9xx/miro.c                  |    2 +-
  isa/opti9xx/opti92x-ad1848.c        |    2 +-
  isa/sb/es968.c                      |    2 +-
  isa/sb/sb16.c                       |    2 +-
  isa/sb/sb16_csp.c                   |    2 +-
  isa/sb/sb16_main.c                  |    2 +-
  isa/sb/sb8.c                        |    2 +-
  isa/sb/sb8_main.c                   |    2 +-
  isa/sb/sb_common.c                  |    2 +-
  isa/sgalaxy.c                       |    2 +-
  isa/wavefront/wavefront.c           |    2 +-
  mips/au1x00.c                       |    2 +-
  parisc/harmony.c                    |    2 +-
  pci/ac97/ac97_codec.c               |    2 +-
  pci/ac97/ak4531_codec.c             |    2 +-
  pci/ad1889.c                        |    2 +-
  pci/ali5451/ali5451.c               |    2 +-
  pci/als300.c                        |    2 +-
  pci/als4000.c                       |    2 +-
  pci/atiixp.c                        |    2 +-
  pci/atiixp_modem.c                  |    2 +-
  pci/azt3328.c                       |    2 +-
  pci/bt87x.c                         |    2 +-
  pci/ca0106/ca0106_main.c            |    2 +-
  pci/cmipci.c                        |    2 +-
  pci/cs4281.c                        |    2 +-
  pci/cs46xx/cs46xx.c                 |    2 +-
  pci/echoaudio/echoaudio.c           |    2 +-
  pci/emu10k1/emu10k1.c               |    2 +-
  pci/emu10k1/emu10k1x.c              |    2 +-
  pci/ens1370.c                       |    2 +-
  pci/es1938.c                        |    2 +-
  pci/fm801.c                         |    2 +-
  pci/hda/hda_codec.c                 |    2 +-
  pci/ice1712/ak4xxx.c                |    2 +-
  pci/ice1712/ice1712.c               |    2 +-
  pci/ice1712/ice1724.c               |    2 +-
  pci/intel8x0.c                      |    2 +-
  pci/intel8x0m.c                     |    2 +-
  pci/korg1212/korg1212.c             |    2 +-
  pci/maestro3.c                      |    2 +-
  pci/mixart/mixart.c                 |    2 +-
  pci/nm256/nm256.c                   |    2 +-
  pci/pcxhr/pcxhr.c                   |    2 +-
  pci/riptide/riptide.c               |    2 +-
  pci/rme32.c                         |    2 +-
  pci/rme96.c                         |    2 +-
  pci/rme9652/hdsp.c                  |    2 +-
  pci/rme9652/rme9652.c               |    2 +-
  pci/sonicvibes.c                    |    2 +-
  pci/trident/trident.c               |    2 +-
  pci/trident/trident_synth.c         |    2 +-
  pci/via82xx.c                       |    2 +-
  pci/via82xx_modem.c                 |    2 +-
  pci/vx222/vx222.c                   |    2 +-
  pci/ymfpci/ymfpci.c                 |    2 +-
  pcmcia/pdaudiocf/pdaudiocf.c        |    2 +-
  pcmcia/vx/vxpocket.c                |    2 +-
  soc/at91/at91-i2s.c                 |    2 +-
  soc/at91/at91-pcm.c                 |    2 +-
  soc/at91/eti_b1_wm8731.c            |    2 +-
  soc/pxa/pxa2xx-i2s.c                |    2 +-
  soc/soc-core.c                      |    2 +-
  soc/soc-dapm.c                      |    2 +-
  usb/usbaudio.c                      |    2 +-
  usb/usbmidi.c                       |    2 +-
  usb/usx2y/usbusx2y.c                |    2 +-
  136 files changed, 136 insertions(+), 136 deletions(-)

Signed-off-by: Rene Herman <rene.herman@gmail.com>

Rene.

--------------060809030705080509070607
Content-Type: text/plain;
 name="module_author_alsa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="module_author_alsa.diff"

commit 7c179369bc673d2bac7f67fb94aee1d39b4c3f4d
Author: Rene Herman <rene.herman@gmail.com>
Date:   Fri May 11 03:03:00 2007 +0200

    module_author: alsa
    
    Signed-off-by: Rene Herman <rene.herman@gmail.com>

diff --git a/sound/aoa/codecs/snd-aoa-codec-onyx.c b/sound/aoa/codecs/snd-aoa-codec-onyx.c
index e91f9f6..f9b8159 100644
--- a/sound/aoa/codecs/snd-aoa-codec-onyx.c
+++ b/sound/aoa/codecs/snd-aoa-codec-onyx.c
@@ -33,7 +33,7 @@
  */
 #include <linux/delay.h>
 #include <linux/module.h>
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("pcm3052 (onyx) codec driver for snd-aoa");
 
diff --git a/sound/aoa/codecs/snd-aoa-codec-tas.c b/sound/aoa/codecs/snd-aoa-codec-tas.c
index 041fe52..b1d2287 100644
--- a/sound/aoa/codecs/snd-aoa-codec-tas.c
+++ b/sound/aoa/codecs/snd-aoa-codec-tas.c
@@ -67,7 +67,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("tas codec driver for snd-aoa");
 
diff --git a/sound/aoa/codecs/snd-aoa-codec-toonie.c b/sound/aoa/codecs/snd-aoa-codec-toonie.c
index 3c7d1d8..0ccdaf9 100644
--- a/sound/aoa/codecs/snd-aoa-codec-toonie.c
+++ b/sound/aoa/codecs/snd-aoa-codec-toonie.c
@@ -11,7 +11,7 @@
  */
 #include <linux/delay.h>
 #include <linux/module.h>
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("toonie codec driver for snd-aoa");
 
diff --git a/sound/aoa/core/snd-aoa-core.c b/sound/aoa/core/snd-aoa-core.c
index 19fdae4..23372e3 100644
--- a/sound/aoa/core/snd-aoa-core.c
+++ b/sound/aoa/core/snd-aoa-core.c
@@ -13,7 +13,7 @@
 #include "snd-aoa-alsa.h"
 
 MODULE_DESCRIPTION("Apple Onboard Audio Sound Driver");
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 
 /* We allow only one fabric. This simplifies things,
diff --git a/sound/aoa/fabrics/snd-aoa-fabric-layout.c b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
index 9880628..f421ae7 100644
--- a/sound/aoa/fabrics/snd-aoa-fabric-layout.c
+++ b/sound/aoa/fabrics/snd-aoa-fabric-layout.c
@@ -17,7 +17,7 @@
 #include "../aoa.h"
 #include "../soundbus/soundbus.h"
 
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Layout-ID fabric for snd-aoa");
 
diff --git a/sound/aoa/soundbus/core.c b/sound/aoa/soundbus/core.c
index 8b2e9b9..d5f6851 100644
--- a/sound/aoa/soundbus/core.c
+++ b/sound/aoa/soundbus/core.c
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include "soundbus.h"
 
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Apple Soundbus");
 
diff --git a/sound/aoa/soundbus/i2sbus/i2sbus-core.c b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
index 0fccdbf..a99e26c 100644
--- a/sound/aoa/soundbus/i2sbus/i2sbus-core.c
+++ b/sound/aoa/soundbus/i2sbus/i2sbus-core.c
@@ -21,7 +21,7 @@
 #include "i2sbus.h"
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Johannes Berg <johannes@sipsolutions.net>");
+MODULE_AUTHOR("Johannes Berg");
 MODULE_DESCRIPTION("Apple Soundbus: I2S support");
 /* for auto-loading, declare that we handle this weird
  * string that macio puts into the relevant device */
diff --git a/sound/arm/sa11xx-uda1341.c b/sound/arm/sa11xx-uda1341.c
index c7e1b26..0eaf1d0 100644
--- a/sound/arm/sa11xx-uda1341.c
+++ b/sound/arm/sa11xx-uda1341.c
@@ -106,7 +106,7 @@
 
 /* {{{ Type definitions */
 
-MODULE_AUTHOR("Tomas Kasparek <tomas.kasparek@seznam.cz>");
+MODULE_AUTHOR("Tomas Kasparek");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("SA1100/SA1111 + UDA1341TS driver for ALSA");
 MODULE_SUPPORTED_DEVICE("{{UDA1341,iPAQ H3600 UDA1341TS}}");
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 51ad95b..2198ecb 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -31,7 +31,7 @@
 #include <sound/hwdep.h>
 #include <sound/info.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Hardware dependent layer");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/memalloc.c b/sound/core/memalloc.c
index f057430..0f79a51 100644
--- a/sound/core/memalloc.c
+++ b/sound/core/memalloc.c
@@ -37,7 +37,7 @@
 #endif
 
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Takashi Iwai, Jaroslav Kysela");
 MODULE_DESCRIPTION("Memory allocator for ALSA system.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/oss/mixer_oss.c b/sound/core/oss/mixer_oss.c
index fccad8f..36d417a 100644
--- a/sound/core/oss/mixer_oss.c
+++ b/sound/core/oss/mixer_oss.c
@@ -33,7 +33,7 @@
 
 #define OSS_ALSAEMULVER         _SIOR ('M', 249, int)
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Mixer OSS emulation for ALSA.");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_SNDRV_MINOR(SNDRV_MINOR_OSS_MIXER);
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index fc11572..97dcf58 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -48,7 +48,7 @@ static int dsp_map[SNDRV_CARDS];
 static int adsp_map[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS-1)] = 1};
 static int nonblock_open = 1;
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Abramo Bagnara <abramo@alsa-project.org>");
+MODULE_AUTHOR("Jaroslav Kysela, Abramo Bagnara");
 MODULE_DESCRIPTION("PCM OSS emulation for ALSA.");
 MODULE_LICENSE("GPL");
 module_param_array(dsp_map, int, NULL, 0444);
diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index 2743414..8be04b2 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -30,7 +30,7 @@
 #include <sound/control.h>
 #include <sound/info.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Abramo Bagnara <abramo@alsa-project.org>");
+MODULE_AUTHOR("Jaroslav Kysela, Abramo Bagnara");
 MODULE_DESCRIPTION("Midlevel PCM code for ALSA.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/rawmidi.c b/sound/core/rawmidi.c
index e470c3c..1419c4a 100644
--- a/sound/core/rawmidi.c
+++ b/sound/core/rawmidi.c
@@ -37,7 +37,7 @@
 #include <sound/minors.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Midlevel RawMidi code for ALSA.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/instr/ainstr_fm.c b/sound/core/seq/instr/ainstr_fm.c
index f80fab8..e9d680d 100644
--- a/sound/core/seq/instr/ainstr_fm.c
+++ b/sound/core/seq/instr/ainstr_fm.c
@@ -25,7 +25,7 @@
 #include <sound/initval.h>
 #include <asm/uaccess.h>
 
-MODULE_AUTHOR("Uros Bizjak <uros@kss-loka.si>");
+MODULE_AUTHOR("Uros Bizjak");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture FM Instrument support.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/instr/ainstr_gf1.c b/sound/core/seq/instr/ainstr_gf1.c
index c640e1c..3d4a411 100644
--- a/sound/core/seq/instr/ainstr_gf1.c
+++ b/sound/core/seq/instr/ainstr_gf1.c
@@ -26,7 +26,7 @@
 #include <sound/initval.h>
 #include <asm/uaccess.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture GF1 (GUS) Patch support.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/instr/ainstr_iw.c b/sound/core/seq/instr/ainstr_iw.c
index 5367bae..d2d42c9 100644
--- a/sound/core/seq/instr/ainstr_iw.c
+++ b/sound/core/seq/instr/ainstr_iw.c
@@ -26,7 +26,7 @@
 #include <sound/initval.h>
 #include <asm/uaccess.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture IWFFFF support.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/instr/ainstr_simple.c b/sound/core/seq/instr/ainstr_simple.c
index ac717be..12aeb66 100644
--- a/sound/core/seq/instr/ainstr_simple.c
+++ b/sound/core/seq/instr/ainstr_simple.c
@@ -26,7 +26,7 @@
 #include <sound/initval.h>
 #include <asm/uaccess.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture Simple Instrument support.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/oss/seq_oss.c b/sound/core/seq/oss/seq_oss.c
index bc09923..fcb85f0 100644
--- a/sound/core/seq/oss/seq_oss.c
+++ b/sound/core/seq/oss/seq_oss.c
@@ -33,7 +33,7 @@
 /*
  * module option
  */
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("OSS-compatible sequencer module");
 MODULE_LICENSE("GPL");
 /* Takashi says this is really only for sound-service-0-, but this is OK. */
diff --git a/sound/core/seq/seq.c b/sound/core/seq/seq.c
index 2f0d877..c5f98e0 100644
--- a/sound/core/seq/seq.c
+++ b/sound/core/seq/seq.c
@@ -53,7 +53,7 @@ int seq_default_timer_device =
 int seq_default_timer_subdevice = 0;
 int seq_default_timer_resolution = 0;	/* Hz */
 
-MODULE_AUTHOR("Frank van de Pol <fvdpol@coil.demon.nl>, Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Frank van de Pol, Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index 37852cd..c05f067 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -47,7 +47,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("ALSA sequencer device management");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/seq_dummy.c b/sound/core/seq/seq_dummy.c
index e55488d..bc84eb0 100644
--- a/sound/core/seq/seq_dummy.c
+++ b/sound/core/seq/seq_dummy.c
@@ -60,7 +60,7 @@
  */
 
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("ALSA sequencer MIDI-through client");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("snd-seq-client-" __stringify(SNDRV_SEQ_CLIENT_DUMMY));
diff --git a/sound/core/seq/seq_instr.c b/sound/core/seq/seq_instr.c
index f30d171..1332de0 100644
--- a/sound/core/seq/seq_instr.c
+++ b/sound/core/seq/seq_instr.c
@@ -26,7 +26,7 @@
 #include <sound/seq_instr.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer instrument library.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/seq_midi.c b/sound/core/seq/seq_midi.c
index 1daa5b0..07e8738 100644
--- a/sound/core/seq/seq_midi.c
+++ b/sound/core/seq/seq_midi.c
@@ -40,7 +40,7 @@ Possible options for midisynth module:
 #include <sound/seq_midi_event.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Frank van de Pol <fvdpol@coil.demon.nl>, Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Frank van de Pol, Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer MIDI synth.");
 MODULE_LICENSE("GPL");
 static int output_buffer_size = PAGE_SIZE;
diff --git a/sound/core/seq/seq_midi_emul.c b/sound/core/seq/seq_midi_emul.c
index d7c4fb8..bf23c5c 100644
--- a/sound/core/seq/seq_midi_emul.c
+++ b/sound/core/seq/seq_midi_emul.c
@@ -39,7 +39,7 @@
 #include <sound/initval.h>
 #include <sound/asoundef.h>
 
-MODULE_AUTHOR("Takashi Iwai / Steve Ratcliffe");
+MODULE_AUTHOR("Takashi Iwai, Steve Ratcliffe");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture sequencer MIDI emulation.");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/seq_midi_event.c b/sound/core/seq/seq_midi_event.c
index 5ff80b7..e0e7557 100644
--- a/sound/core/seq/seq_midi_event.c
+++ b/sound/core/seq/seq_midi_event.c
@@ -28,7 +28,7 @@
 #include <sound/seq_midi_event.h>
 #include <sound/asoundef.h>
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Takashi Iwai, Jaroslav Kysela");
 MODULE_DESCRIPTION("MIDI byte <-> sequencer event coder");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/seq/seq_virmidi.c b/sound/core/seq/seq_virmidi.c
index 061a7c6..52ce7c9 100644
--- a/sound/core/seq/seq_virmidi.c
+++ b/sound/core/seq/seq_virmidi.c
@@ -48,7 +48,7 @@
 #include <sound/seq_midi_event.h>
 #include <sound/seq_virmidi.h>
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("Virtual Raw MIDI client on Sequencer");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/core/sound.c b/sound/core/sound.c
index 70600df..fac94ea 100644
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -42,7 +42,7 @@ EXPORT_SYMBOL(snd_major);
 
 static int cards_limit = 1;
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture driver for soundcards.");
 MODULE_LICENSE("GPL");
 module_param(major, int, 0444);
diff --git a/sound/core/timer.c b/sound/core/timer.c
index 67520b3..e7c0552 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -44,7 +44,7 @@
 #endif
 
 static int timer_limit = DEFAULT_TIMER_LIMIT;
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Jaroslav Kysela, Takashi Iwai");
 MODULE_DESCRIPTION("ALSA timer interface");
 MODULE_LICENSE("GPL");
 module_param(timer_limit, int, 0444);
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index a0f28f5..5a9e5cc 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -34,7 +34,7 @@
 #include <sound/rawmidi.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Dummy soundcard (/dev/null)");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALSA,Dummy soundcard}}");
diff --git a/sound/drivers/mpu401/mpu401.c b/sound/drivers/mpu401/mpu401.c
index 2de181a..6f7af4c 100644
--- a/sound/drivers/mpu401/mpu401.c
+++ b/sound/drivers/mpu401/mpu401.c
@@ -30,7 +30,7 @@
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("MPU-401 UART");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 3daa9fa..9aa30a7 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -39,7 +39,7 @@
 #include <sound/core.h>
 #include <sound/mpu401.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of MPU-401 in UART mode");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/drivers/mts64.c b/sound/drivers/mts64.c
index 6c9f4c9..cd4e604 100644
--- a/sound/drivers/mts64.c
+++ b/sound/drivers/mts64.c
@@ -47,7 +47,7 @@ MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
 module_param_array(enable, bool, NULL, S_IRUGO);
 MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
 
-MODULE_AUTHOR("Matthias Koenig <mk@phasorlab.de>");
+MODULE_AUTHOR("Matthias Koenig");
 MODULE_DESCRIPTION("ESI Miditerminal 4140");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESI,Miditerminal 4140}}");
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index 87fe376..f041d4e 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -31,7 +31,7 @@
 #include <linux/ioport.h>
 #include <sound/minors.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Hannu Savolainen 1993-1996, Rob Hooft");
+MODULE_AUTHOR("Jaroslav Kysela, Hannu Savolainen, Rob Hooft");
 MODULE_DESCRIPTION("Routines for control of AdLib FM cards (OPL2/OPL3/OPL4 chips)");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/drivers/opl3/opl3_seq.c b/sound/drivers/opl3/opl3_seq.c
index 96762c9..d5771d9 100644
--- a/sound/drivers/opl3/opl3_seq.c
+++ b/sound/drivers/opl3/opl3_seq.c
@@ -27,7 +27,7 @@
 #include <linux/moduleparam.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Uros Bizjak <uros@kss-loka.si>");
+MODULE_AUTHOR("Uros Bizjak");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("ALSA driver for OPL3 FM synth");
 
diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index 01997f2..8611a8e 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -23,7 +23,7 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_AUTHOR("Clemens Ladisch");
 MODULE_DESCRIPTION("OPL4 driver");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/drivers/opl4/opl4_seq.c b/sound/drivers/opl4/opl4_seq.c
index 43d8a2b..96f5b50 100644
--- a/sound/drivers/opl4/opl4_seq.c
+++ b/sound/drivers/opl4/opl4_seq.c
@@ -36,7 +36,7 @@
 #include <linux/moduleparam.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_AUTHOR("Clemens Ladisch");
 MODULE_DESCRIPTION("OPL4 wavetable synth driver");
 MODULE_LICENSE("Dual BSD/GPL");
 
diff --git a/sound/drivers/virmidi.c b/sound/drivers/virmidi.c
index 46f3d34..fb324c2 100644
--- a/sound/drivers/virmidi.c
+++ b/sound/drivers/virmidi.c
@@ -55,7 +55,7 @@
 /* hack: OSS defines midi_devs, so undefine it (versioned symbols) */
 #undef midi_devs
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("Dummy soundcard for virtual rawmidi devices");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALSA,Virtual rawmidi device}}");
diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index ed19bc1..594f577 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -35,7 +35,7 @@
 #include <sound/vx_core.h>
 #include "vx_cmd.h"
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("Common routines for Digigram VX drivers");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index 64388cb..73586e7 100644
--- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -32,7 +32,7 @@
 
 static void snd_cs8427_reset(struct snd_i2c_device *cs8427);
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("IEC958 (S/PDIF) receiver & transmitter by Cirrus Logic");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/i2c.c b/sound/i2c/i2c.c
index b60fb18..1218b9b 100644
--- a/sound/i2c/i2c.c
+++ b/sound/i2c/i2c.c
@@ -28,7 +28,7 @@
 #include <sound/core.h>
 #include <sound/i2c.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Generic i2c interface for ALSA");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/l3/uda1341.c b/sound/i2c/l3/uda1341.c
index b074fdd..7d18dd6 100644
--- a/sound/i2c/l3/uda1341.c
+++ b/sound/i2c/l3/uda1341.c
@@ -921,7 +921,7 @@ static void __exit uda1341_exit(void)
 module_init(uda1341_init);
 module_exit(uda1341_exit);
 
-MODULE_AUTHOR("Tomas Kasparek <tomas.kasparek@seznam.cz>");
+MODULE_AUTHOR("Tomas Kasparek");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Philips UDA1341 CODEC driver for ALSA");
 MODULE_SUPPORTED_DEVICE("{{UDA1341,UDA1341TS}}");
diff --git a/sound/i2c/other/ak4114.c b/sound/i2c/other/ak4114.c
index adbfd58..c32b717 100644
--- a/sound/i2c/other/ak4114.c
+++ b/sound/i2c/other/ak4114.c
@@ -29,7 +29,7 @@
 #include <sound/ak4114.h>
 #include <sound/asoundef.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("AK4114 IEC958 (S/PDIF) receiver by Asahi Kasei");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/other/ak4117.c b/sound/i2c/other/ak4117.c
index c022f29..0391f31 100644
--- a/sound/i2c/other/ak4117.c
+++ b/sound/i2c/other/ak4117.c
@@ -29,7 +29,7 @@
 #include <sound/ak4117.h>
 #include <sound/asoundef.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("AK4117 IEC958 (S/PDIF) receiver by Asahi Kasei");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 8805110..a38d2a2 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -31,7 +31,7 @@
 #include <sound/tlv.h>
 #include <sound/ak4xxx-adda.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Jaroslav Kysela, Takashi Iwai");
 MODULE_DESCRIPTION("Routines for control of AK452x / AK43xx  AD/DA converters");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/other/pt2258.c b/sound/i2c/other/pt2258.c
index e91cc3b..c8499ac 100644
--- a/sound/i2c/other/pt2258.c
+++ b/sound/i2c/other/pt2258.c
@@ -26,7 +26,7 @@
 #include <sound/i2c.h>
 #include <sound/pt2258.h>
 
-MODULE_AUTHOR("Jochen Voss <voss@seehuhn.de>");
+MODULE_AUTHOR("Jochen Voss");
 MODULE_DESCRIPTION("PT2258 volume controller (Princeton Technology Corp.)");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/other/tea575x-tuner.c b/sound/i2c/other/tea575x-tuner.c
index 4c2fd14..6ef2981 100644
--- a/sound/i2c/other/tea575x-tuner.c
+++ b/sound/i2c/other/tea575x-tuner.c
@@ -28,7 +28,7 @@
 #include <sound/core.h>
 #include <sound/tea575x-tuner.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of TEA5757/5759 Philips AM/FM radio tuner chips");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/i2c/tea6330t.c b/sound/i2c/tea6330t.c
index ae5b1e3..91e9ab5 100644
--- a/sound/i2c/tea6330t.c
+++ b/sound/i2c/tea6330t.c
@@ -27,7 +27,7 @@
 #include <sound/control.h>
 #include <sound/tea6330t.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of the TEA6330T circuit via i2c bus");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/ad1816a/ad1816a.c b/sound/isa/ad1816a/ad1816a.c
index 5903450..74adb20 100644
--- a/sound/isa/ad1816a/ad1816a.c
+++ b/sound/isa/ad1816a/ad1816a.c
@@ -32,7 +32,7 @@
 
 #define PFX "ad1816a: "
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_AUTHOR("Massimo Piccioni");
 MODULE_DESCRIPTION("AD1816A, AD1815");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Highscreen,Sound-Boostar 16 3D},"
diff --git a/sound/isa/ad1848/ad1848.c b/sound/isa/ad1848/ad1848.c
index 74e501d..49f1ef3 100644
--- a/sound/isa/ad1848/ad1848.c
+++ b/sound/isa/ad1848/ad1848.c
@@ -32,7 +32,7 @@
 #include <sound/ad1848.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Tugrul Galatali <galatalt@stuy.edu>, Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Tugrul Galatali, Jaroslav Kysela");
 MODULE_DESCRIPTION("AD1848/AD1847/CS4248");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Analog Devices,AD1848},"
diff --git a/sound/isa/ad1848/ad1848_lib.c b/sound/isa/ad1848/ad1848_lib.c
index 8094282..edad9ce 100644
--- a/sound/isa/ad1848/ad1848_lib.c
+++ b/sound/isa/ad1848/ad1848_lib.c
@@ -35,7 +35,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of AD1848/AD1847/CS4248");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/als100.c b/sound/isa/als100.c
index f2bcfb2..8939193 100644
--- a/sound/isa/als100.c
+++ b/sound/isa/als100.c
@@ -34,7 +34,7 @@
 
 #define PFX "als100: "
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_AUTHOR("Massimo Piccioni");
 MODULE_DESCRIPTION("Avance Logic ALS1X0");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS100 - PRO16PNP},"
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index b615538..e974387 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -45,7 +45,7 @@
 
 #define PFX "azt2320: "
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_AUTHOR("Massimo Piccioni");
 MODULE_DESCRIPTION("Aztech Systems AZT2320");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Aztech Systems,PRO16V},"
diff --git a/sound/isa/cmi8330.c b/sound/isa/cmi8330.c
index c09a800..3d4b2f3 100644
--- a/sound/isa/cmi8330.c
+++ b/sound/isa/cmi8330.c
@@ -62,7 +62,7 @@
 
 /*
  */
-MODULE_AUTHOR("George Talusan <gstalusan@uwaterloo.ca>");
+MODULE_AUTHOR("George Talusan");
 MODULE_DESCRIPTION("C-Media CMI8330");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{C-Media,CMI8330,isapnp:{CMI0001,@@@0001,@X@0001}}}");
diff --git a/sound/isa/cs423x/cs4231.c b/sound/isa/cs423x/cs4231.c
index 696a5c8..4a0e35d 100644
--- a/sound/isa/cs423x/cs4231.c
+++ b/sound/isa/cs423x/cs4231.c
@@ -32,7 +32,7 @@
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Generic CS4231");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Crystal Semiconductors,CS4231}}");
diff --git a/sound/isa/cs423x/cs4231_lib.c b/sound/isa/cs423x/cs4231_lib.c
index 75c7c5f..77b7af7 100644
--- a/sound/isa/cs423x/cs4231_lib.c
+++ b/sound/isa/cs423x/cs4231_lib.c
@@ -39,7 +39,7 @@
 #include <asm/dma.h>
 #include <asm/irq.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of CS4231(A)/CS4232/InterWave & compatible chips");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 07ffd5c..9dbcd2f 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -32,7 +32,7 @@
 #include <sound/opl3.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_LICENSE("GPL");
 #ifdef CS4232
 MODULE_DESCRIPTION("Cirrus Logic CS4232");
diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index 7a5a6c7..2cd2055 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -89,7 +89,7 @@
 #include <sound/cs4231.h>
 #include <sound/asoundef.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of CS4235/4236B/4237B/4238B/4239 chips");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/dt019x.c b/sound/isa/dt019x.c
index ce57d52..7955a1e 100644
--- a/sound/isa/dt019x.c
+++ b/sound/isa/dt019x.c
@@ -34,7 +34,7 @@
 
 #define PFX "dt019x: "
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_AUTHOR("Massimo Piccioni");
 MODULE_DESCRIPTION("Diamond Technologies DT-019X / Avance Logic ALS-007");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Diamond Technologies DT-019X},"
diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index 65f97ff..f496783 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -35,7 +35,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("ESS ESx688 AudioDrive");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESS,ES688 PnP AudioDrive,pnp:ESS0100},"
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index a2ab99f..2e407e8 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -32,7 +32,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("ESS ESx688 lowlevel module");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 725c115..e951f05 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1983,7 +1983,7 @@ static int __devinit snd_es18xx_mixer(struct snd_es18xx *chip)
 
 /* Card level */
 
-MODULE_AUTHOR("Christian Fischbach <fishbach@pool.informatik.rwth-aachen.de>, Abramo Bagnara <abramo@alsa-project.org>");  
+MODULE_AUTHOR("Christian Fischbach, Abramo Bagnara");
 MODULE_DESCRIPTION("ESS ES18xx AudioDrive");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESS,ES1868 PnP AudioDrive},"
diff --git a/sound/isa/gus/gus_main.c b/sound/isa/gus/gus_main.c
index 8ced5e8..45ca31c 100644
--- a/sound/isa/gus/gus_main.c
+++ b/sound/isa/gus/gus_main.c
@@ -31,7 +31,7 @@
 
 #include <asm/dma.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for Gravis UltraSound soundcards");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/gus/gus_synth.c b/sound/isa/gus/gus_synth.c
index 3e4d4d6..4ebd902 100644
--- a/sound/isa/gus/gus_synth.c
+++ b/sound/isa/gus/gus_synth.c
@@ -26,7 +26,7 @@
 #include <sound/gus.h>
 #include <sound/seq_device.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for Gravis UltraSound soundcards - Synthesizer");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/gus/gusclassic.c b/sound/isa/gus/gusclassic.c
index 0395e2e..ef6edeb 100644
--- a/sound/isa/gus/gusclassic.c
+++ b/sound/isa/gus/gusclassic.c
@@ -33,7 +33,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Gravis UltraSound Classic");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Classic}}");
diff --git a/sound/isa/gus/gusextreme.c b/sound/isa/gus/gusextreme.c
index 4f55fc3..76c04f5 100644
--- a/sound/isa/gus/gusextreme.c
+++ b/sound/isa/gus/gusextreme.c
@@ -37,7 +37,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Gravis UltraSound Extreme");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound Extreme}}");
diff --git a/sound/isa/gus/gusmax.c b/sound/isa/gus/gusmax.c
index d1ad90c..9ec9486 100644
--- a/sound/isa/gus/gusmax.c
+++ b/sound/isa/gus/gusmax.c
@@ -34,7 +34,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Gravis UltraSound MAX");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Gravis,UltraSound MAX}}");
diff --git a/sound/isa/gus/interwave.c b/sound/isa/gus/interwave.c
index 4ec2d79..08f1099 100644
--- a/sound/isa/gus/interwave.c
+++ b/sound/isa/gus/interwave.c
@@ -41,7 +41,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_LICENSE("GPL");
 #ifndef SNDRV_STB
 MODULE_DESCRIPTION("AMD InterWave");
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index f3db686..34f84d0 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -37,7 +37,7 @@
 
 #include <asm/io.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Yamaha OPL3SA2+");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Yamaha,YMF719E-S},"
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 1dd9837..758c511 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -43,7 +43,7 @@
 #include <sound/initval.h>
 #include "miro.h"
 
-MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>");
+MODULE_AUTHOR("Martin Langer");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Miro miroSOUND PCM1 pro, PCM12, PCM20 Radio");
 MODULE_SUPPORTED_DEVICE("{{Miro,miroSOUND PCM1 pro}, "
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index df22737..bf172e9 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -53,7 +53,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_AUTHOR("Massimo Piccioni");
 MODULE_LICENSE("GPL");
 #ifdef OPTi93X
 MODULE_DESCRIPTION("OPTi93X");
diff --git a/sound/isa/sb/es968.c b/sound/isa/sb/es968.c
index d4b2187..2d8b942 100644
--- a/sound/isa/sb/es968.c
+++ b/sound/isa/sb/es968.c
@@ -31,7 +31,7 @@
 
 #define PFX "es968: "
 
-MODULE_AUTHOR("Massimo Piccioni <dafastidio@libero.it>");
+MODULE_AUTHOR("Massimo Piccioni");
 MODULE_DESCRIPTION("ESS AudioDrive ES968");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESS,AudioDrive ES968}}");
diff --git a/sound/isa/sb/sb16.c b/sound/isa/sb/sb16.c
index d64e67f..ac84169 100644
--- a/sound/isa/sb/sb16.c
+++ b/sound/isa/sb/sb16.c
@@ -44,7 +44,7 @@
 #define PFX "sb16: "
 #endif
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_LICENSE("GPL");
 #ifndef SNDRV_SBAWE
 MODULE_DESCRIPTION("Sound Blaster 16");
diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 3d9d7e0..fd27bac 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -33,7 +33,7 @@
 #include <sound/sb16_csp.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Uros Bizjak <uros@kss-loka.si>");
+MODULE_AUTHOR("Uros Bizjak");
 MODULE_DESCRIPTION("ALSA driver for SB16 Creative Signal Processor");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 383911b..1c290a8 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -45,7 +45,7 @@
 #include <sound/control.h>
 #include <sound/info.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Routines for control of 16-bit SoundBlaster cards and clones");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/sb/sb8.c b/sound/isa/sb/sb8.c
index be1e83e..f11e672 100644
--- a/sound/isa/sb/sb8.c
+++ b/sound/isa/sb/sb8.c
@@ -31,7 +31,7 @@
 #include <sound/opl3.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Sound Blaster 1.0/2.0/Pro");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB 1.0/SB 2.0/SB Pro}}");
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index aea9e5e..8bdca08 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -38,7 +38,7 @@
 #include <sound/core.h>
 #include <sound/sb.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Uros Bizjak <uros@kss-loka.si>");
+MODULE_AUTHOR("Jaroslav Kysela, Uros Bizjak");
 MODULE_DESCRIPTION("Routines for control of 8-bit SoundBlaster cards and clones");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index 3094f38..658b571 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -33,7 +33,7 @@
 #include <asm/io.h>
 #include <asm/dma.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("ALSA lowlevel driver for Sound Blaster cards");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/isa/sgalaxy.c b/sound/isa/sgalaxy.c
index 4fcd0f4..76d7cbf 100644
--- a/sound/isa/sgalaxy.c
+++ b/sound/isa/sgalaxy.c
@@ -38,7 +38,7 @@
 #define SNDRV_LEGACY_FIND_FREE_DMA
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Christopher Butler <chrisb@sandy.force9.co.uk>");
+MODULE_AUTHOR("Christopher Butler");
 MODULE_DESCRIPTION("Aztech Sound Galaxy");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Aztech Systems,Sound Galaxy}}");
diff --git a/sound/isa/wavefront/wavefront.c b/sound/isa/wavefront/wavefront.c
index e2fdd5f..826d6d8 100644
--- a/sound/isa/wavefront/wavefront.c
+++ b/sound/isa/wavefront/wavefront.c
@@ -32,7 +32,7 @@
 #include <sound/opl3.h>
 #include <sound/snd_wavefront.h>
 
-MODULE_AUTHOR("Paul Barton-Davis <pbd@op.net>");
+MODULE_AUTHOR("Paul Barton-Davis");
 MODULE_DESCRIPTION("Turtle Beach Wavefront");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Turtle Beach,Maui/Tropez/Tropez+}}");
diff --git a/sound/mips/au1x00.c b/sound/mips/au1x00.c
index 8a61a11..3d4986a 100644
--- a/sound/mips/au1x00.c
+++ b/sound/mips/au1x00.c
@@ -48,7 +48,7 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1000_dma.h>
 
-MODULE_AUTHOR("Charles Eidsness <charles@cooper-street.com>");
+MODULE_AUTHOR("Charles Eidsness");
 MODULE_DESCRIPTION("Au1000 AC'97 ALSA Driver");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{AMD,Au1000 AC'97}}");
diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index ff705c6..d549168 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -1036,7 +1036,7 @@ alsa_harmony_fini(void)
 }
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Kyle McMartin <kyle@parisc-linux.org>");
+MODULE_AUTHOR("Kyle McMartin");
 MODULE_DESCRIPTION("Harmony sound driver");
 
 module_init(alsa_harmony_init);
diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 3bfb210..fe48c1b 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -39,7 +39,7 @@
 #include "ac97_id.h"
 #include "ac97_patch.h"
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Universal interface for Audio Codec '97");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/pci/ac97/ak4531_codec.c b/sound/pci/ac97/ak4531_codec.c
index dc26820..6b43fd4 100644
--- a/sound/pci/ac97/ak4531_codec.c
+++ b/sound/pci/ac97/ak4531_codec.c
@@ -29,7 +29,7 @@
 #include <sound/ak4531_codec.h>
 #include <sound/tlv.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Universal routines for AK4531 codec");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 98970d4..eb1ae50 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -53,7 +53,7 @@
 
 #define	AD1889_DRVVER	"Version: 1.7"
 
-MODULE_AUTHOR("Kyle McMartin <kyle@parisc-linux.org>, Thibaut Varene <t-bone@parisc-linux.org>");
+MODULE_AUTHOR("Kyle McMartin, Thibaut Varene");
 MODULE_DESCRIPTION("Analog Devices AD1889 ALSA sound driver");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Analog Devices,AD1889}}");
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index ba7fa22..14b5537 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -41,7 +41,7 @@
 #include <sound/mpu401.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Matt Wu <Matt_Wu@acersoftech.com.cn>");
+MODULE_AUTHOR("Matt Wu");
 MODULE_DESCRIPTION("ALI M5451");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALI,M5451,pci},{ALI,M5451}}");
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index 8afcb98..b0c922f 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -109,7 +109,7 @@
 
 enum {DEVICE_ALS300, DEVICE_ALS300_PLUS};
 
-MODULE_AUTHOR("Ash Willis <ashwillis@programmer.net>");
+MODULE_AUTHOR("Ash Willis");
 MODULE_DESCRIPTION("Avance Logic ALS300");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS300},{Avance Logic,ALS300+}}");
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 8fb55d3..af56e9e 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -79,7 +79,7 @@
 #include <sound/sb.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Bart Hartgers <bart@etpmod.phys.tue.nl>");
+MODULE_AUTHOR("Bart Hartgers");
 MODULE_DESCRIPTION("Avance Logic ALS4000");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Avance Logic,ALS4000}}");
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index 7d8053b..3ce34a3 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -35,7 +35,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("ATI IXP AC97 controller");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ATI,IXP150/200/250/300/400}}");
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 904023f..346912a 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -35,7 +35,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("ATI IXP MC97 controller");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ATI,IXP150/200/250}}");
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index 43edd28..8321f55 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -126,7 +126,7 @@
 #include <sound/initval.h>
 #include "azt3328.h"
 
-MODULE_AUTHOR("Andreas Mohr <andi AT lisas.de>");
+MODULE_AUTHOR("Andreas Mohr");
 MODULE_DESCRIPTION("Aztech AZF3328 (PCI168)");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Aztech,AZF3328}}");
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index e9b029e..b8a2130 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -35,7 +35,7 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_AUTHOR("Clemens Ladisch");
 MODULE_DESCRIPTION("Brooktree Bt87x audio driver");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Brooktree,Bt878},"
diff --git a/sound/pci/ca0106/ca0106_main.c b/sound/pci/ca0106/ca0106_main.c
index ea6712b..416567f 100644
--- a/sound/pci/ca0106/ca0106_main.c
+++ b/sound/pci/ca0106/ca0106_main.c
@@ -145,7 +145,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 
-MODULE_AUTHOR("James Courtier-Dutton <James@superbug.demon.co.uk>");
+MODULE_AUTHOR("James Courtier-Dutton");
 MODULE_DESCRIPTION("CA0106");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Creative,SB CA0106 chip}}");
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 7d3c5ee..ed43681 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -41,7 +41,7 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("C-Media CMI8x38 PCI");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{C-Media,CMI8738},"
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 44cf546..9bec625 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -38,7 +38,7 @@
 #include <sound/initval.h>
 
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Cirrus Logic CS4281");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Cirrus Logic,CS4281}}");
diff --git a/sound/pci/cs46xx/cs46xx.c b/sound/pci/cs46xx/cs46xx.c
index 8b6cd14..6e0926a 100644
--- a/sound/pci/cs46xx/cs46xx.c
+++ b/sound/pci/cs46xx/cs46xx.c
@@ -34,7 +34,7 @@
 #include <sound/cs46xx.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Cirrus Logic Sound Fusion CS46XX");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Cirrus Logic,Sound Fusion (CS4280)},"
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index e413da0..2f7c3f6 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -16,7 +16,7 @@
  *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
 
-MODULE_AUTHOR("Giuliano Pochini <pochini@shiny.it>");
+MODULE_AUTHOR("Giuliano Pochini");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Echoaudio " ECHOCARD_NAME " soundcards driver");
 MODULE_SUPPORTED_DEVICE("{{Echoaudio," ECHOCARD_NAME "}}");
diff --git a/sound/pci/emu10k1/emu10k1.c b/sound/pci/emu10k1/emu10k1.c
index 55caf34..34b9c35 100644
--- a/sound/pci/emu10k1/emu10k1.c
+++ b/sound/pci/emu10k1/emu10k1.c
@@ -32,7 +32,7 @@
 #include <sound/emu10k1.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("EMU10K1");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Creative Labs,SB Live!/PCI512/E-mu APS},"
diff --git a/sound/pci/emu10k1/emu10k1x.c b/sound/pci/emu10k1/emu10k1x.c
index bb0fec7..f299cf3 100644
--- a/sound/pci/emu10k1/emu10k1x.c
+++ b/sound/pci/emu10k1/emu10k1x.c
@@ -43,7 +43,7 @@
 #include <sound/info.h>
 #include <sound/rawmidi.h>
 
-MODULE_AUTHOR("Francisco Moraes <fmoraes@nc.rr.com>");
+MODULE_AUTHOR("Francisco Moraes");
 MODULE_DESCRIPTION("EMU10K1X");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Dell Creative Labs,SB Live!}");
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 425b167..48ff186 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -61,7 +61,7 @@
 #endif
 
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, Thomas Sailer <sailer@ife.ee.ethz.ch>");
+MODULE_AUTHOR("Jaroslav Kysela, Thomas Sailer");
 MODULE_LICENSE("GPL");
 #ifdef CHIP1370
 MODULE_DESCRIPTION("Ensoniq AudioPCI ES1370");
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index fec29a1..0e084d3 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -66,7 +66,7 @@
 
 #include <asm/io.h>
 
-MODULE_AUTHOR("Jaromir Koutek <miri@punknet.cz>");
+MODULE_AUTHOR("Jaromir Koutek");
 MODULE_DESCRIPTION("ESS Solo-1");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESS,ES1938},"
diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index 6dc578b..02256f2 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -42,7 +42,7 @@
 #define TEA575X_RADIO 1
 #endif
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("ForteMedia FM801");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ForteMedia,FM801},"
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 8f34fb4..48d05e6 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -34,7 +34,7 @@
 #include "hda_local.h"
 
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("Universal interface for High Definition Audio Codec");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/pci/ice1712/ak4xxx.c b/sound/pci/ice1712/ak4xxx.c
index ab00cce..fab0813 100644
--- a/sound/pci/ice1712/ak4xxx.c
+++ b/sound/pci/ice1712/ak4xxx.c
@@ -30,7 +30,7 @@
 #include <sound/initval.h>
 #include "ice1712.h"
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("ICEnsemble ICE17xx <-> AK4xxx AD/DA chip interface");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 830a1bb..2d62c5e 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -73,7 +73,7 @@
 #include "ews.h"
 #include "hoontech.h"
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("ICEnsemble ICE1712 (Envy24)");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{"
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 1127ebd..aeff346 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -52,7 +52,7 @@
 #include "phase.h"
 #include "wtm.h"
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("VIA ICEnsemble ICE1724/1720 (Envy24HT/PT)");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{"
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 7cf2dcb..ba95dc2 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -43,7 +43,7 @@
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; SiS 7012; Ali 5455");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Intel,82801AA-ICH},"
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index c155e1f..8736c02 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -37,7 +37,7 @@
 #include <sound/info.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Intel 82801AA,82901AB,i810,i820,i830,i840,i845,MX440; "
 		   "SiS 7013; NVidia MCP/2/2S/3 modems");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 21d0899..9b98090 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -429,7 +429,7 @@ module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for Korg 1212 soundcard.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable Korg 1212 soundcard.");
-MODULE_AUTHOR("Haroldo Gamal <gamal@alternex.com.br>");
+MODULE_AUTHOR("Haroldo Gamal");
 
 static struct pci_device_id snd_korg1212_ids[] = {
 	{
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 4526904..0f9f218 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -51,7 +51,7 @@
 #include <sound/initval.h>
 #include <asm/byteorder.h>
 
-MODULE_AUTHOR("Zach Brown <zab@zabbo.net>, Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Zach Brown, Takashi Iwai");
 MODULE_DESCRIPTION("ESS Maestro3 PCI");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ESS,Maestro3 PCI},"
diff --git a/sound/pci/mixart/mixart.c b/sound/pci/mixart/mixart.c
index ac007ce..c2ebdd9 100644
--- a/sound/pci/mixart/mixart.c
+++ b/sound/pci/mixart/mixart.c
@@ -42,7 +42,7 @@
 
 #define CARD_NAME "miXart"
 
-MODULE_AUTHOR("Digigram <alsa@digigram.com>");
+MODULE_AUTHOR("Digigram");
 MODULE_DESCRIPTION("Digigram " CARD_NAME);
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Digigram," CARD_NAME "}}");
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 03b3a47..a47a5e8 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -44,7 +44,7 @@
 #define CARD_NAME "NeoMagic 256AV/ZX"
 #define DRIVER_NAME "NM256"
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("NeoMagic NM256AV/ZX");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{NeoMagic,NM256AV},"
diff --git a/sound/pci/pcxhr/pcxhr.c b/sound/pci/pcxhr/pcxhr.c
index d974134..cd29197 100644
--- a/sound/pci/pcxhr/pcxhr.c
+++ b/sound/pci/pcxhr/pcxhr.c
@@ -44,7 +44,7 @@
 
 #define DRIVER_NAME "pcxhr"
 
-MODULE_AUTHOR("Markus Bollinger <bollinger@digigram.com>");
+MODULE_AUTHOR("Markus Bollinger");
 MODULE_DESCRIPTION("Digigram " DRIVER_NAME " " PCXHR_DRIVER_VERSION_STRING);
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Digigram," DRIVER_NAME "}}");
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index 952625d..6854b62 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -113,7 +113,7 @@
 #define SUPPORT_JOYSTICK 1
 #endif
 
-MODULE_AUTHOR("Peter Gruber <nokos@gmx.net>");
+MODULE_AUTHOR("Peter Gruber");
 MODULE_DESCRIPTION("riptide");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Conexant,Riptide}}");
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 6bb7ac6..19fb89a 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -101,7 +101,7 @@ module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable RME Digi32 soundcard.");
 module_param_array(fullduplex, bool, NULL, 0444);
 MODULE_PARM_DESC(fullduplex, "Support full-duplex mode.");
-MODULE_AUTHOR("Martin Langer <martin-langer@gmx.de>, Pilo Chambert <pilo.c@wanadoo.fr>");
+MODULE_AUTHOR("Martin Langer, Pilo Chambert");
 MODULE_DESCRIPTION("RME Digi32, Digi32/8, Digi32 PRO");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME,Digi32}," "{RME,Digi32/8}," "{RME,Digi32 PRO}}");
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index e3304b7..aed6e67 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -43,7 +43,7 @@
 
 /* note, two last pcis should be equal, it is not a bug */
 
-MODULE_AUTHOR("Anders Torger <torger@ludd.luth.se>");
+MODULE_AUTHOR("Anders Torger");
 MODULE_DESCRIPTION("RME Digi96, Digi96/8, Digi96/8 PRO, Digi96/8 PST, "
 		   "Digi96/8 PAD");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 89b3c7f..70ce246 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -54,7 +54,7 @@ module_param_array(id, charp, NULL, 0444);
 MODULE_PARM_DESC(id, "ID string for RME Hammerfall DSP interface.");
 module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable/disable specific Hammerfall DSP soundcards.");
-MODULE_AUTHOR("Paul Davis <paul@linuxaudiosystems.com>, Marcus Andersson, Thomas Charbonnel <thomas@undata.org>");
+MODULE_AUTHOR("Paul Davis, Marcus Andersson, Thomas Charbonnel");
 MODULE_DESCRIPTION("RME Hammerfall DSP");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME Hammerfall-DSP},"
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index cc3bdec..8235870 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -51,7 +51,7 @@ module_param_array(enable, bool, NULL, 0444);
 MODULE_PARM_DESC(enable, "Enable/disable specific RME96{52,36} soundcards.");
 module_param_array(precise_ptr, bool, NULL, 0444);
 MODULE_PARM_DESC(precise_ptr, "Enable precise pointer (doesn't work reliably).");
-MODULE_AUTHOR("Paul Davis <pbd@op.net>, Winfried Ritsch");
+MODULE_AUTHOR("Paul Davis, Winfried Ritsch");
 MODULE_DESCRIPTION("RME Digi9652/Digi9636");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{RME,Hammerfall},"
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 9f25d93..1fff81b 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -42,7 +42,7 @@
 
 #include <asm/io.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("S3 SonicVibes PCI");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{S3,SonicVibes PCI}}");
diff --git a/sound/pci/trident/trident.c b/sound/pci/trident/trident.c
index 9145f7c..f6019a4 100644
--- a/sound/pci/trident/trident.c
+++ b/sound/pci/trident/trident.c
@@ -30,7 +30,7 @@
 #include <sound/trident.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>, <audio@tridentmicro.com>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Trident 4D-WaveDX/NX & SiS SI7018");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Trident,4DWave DX},"
diff --git a/sound/pci/trident/trident_synth.c b/sound/pci/trident/trident_synth.c
index 9b7dee8..e29553e 100644
--- a/sound/pci/trident/trident_synth.c
+++ b/sound/pci/trident/trident_synth.c
@@ -28,7 +28,7 @@
 #include <sound/trident.h>
 #include <sound/seq_device.h>
 
-MODULE_AUTHOR("Scott McNab <jedi@tartarus.uwa.edu.au>");
+MODULE_AUTHOR("Scott McNab");
 MODULE_DESCRIPTION("Routines for Trident 4DWave NX/DX soundcards - Synthesizer");
 MODULE_LICENSE("GPL");
 
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index a289922..e905bd3 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -68,7 +68,7 @@
 #define POINTER_DEBUG
 #endif
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("VIA VT82xx audio");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{VIA,VT82C686A/B/C,pci},{VIA,VT8233A/C,8235}}");
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index b338e15..17a2cb0 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -50,7 +50,7 @@
 #define POINTER_DEBUG
 #endif
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("VIA VT82xx modem");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{VIA,VT82C686A/B/C modem,pci}}");
diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index 474eac9..7aedb2f 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -31,7 +31,7 @@
 
 #define CARD_NAME "VX222"
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("Digigram VX222 V2/Mic");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Digigram," CARD_NAME "}}");
diff --git a/sound/pci/ymfpci/ymfpci.c b/sound/pci/ymfpci/ymfpci.c
index fd9b7b8..73e204f 100644
--- a/sound/pci/ymfpci/ymfpci.c
+++ b/sound/pci/ymfpci/ymfpci.c
@@ -30,7 +30,7 @@
 #include <sound/opl3.h>
 #include <sound/initval.h>
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Yamaha DS-1 PCI");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Yamaha,YMF724},"
diff --git a/sound/pcmcia/pdaudiocf/pdaudiocf.c b/sound/pcmcia/pdaudiocf/pdaudiocf.c
index 2d40cc7..3176554 100644
--- a/sound/pcmcia/pdaudiocf/pdaudiocf.c
+++ b/sound/pcmcia/pdaudiocf/pdaudiocf.c
@@ -33,7 +33,7 @@
 
 #define CARD_NAME	"PDAudio-CF"
 
-MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
+MODULE_AUTHOR("Jaroslav Kysela");
 MODULE_DESCRIPTION("Sound Core " CARD_NAME);
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Sound Core," CARD_NAME "}}");
diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 363bcb5..7d58d16 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -32,7 +32,7 @@
 /*
  */
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("Digigram VXPocket");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Digigram,VXPocket},{Digigram,VXPocket440}}");
diff --git a/sound/soc/at91/at91-i2s.c b/sound/soc/at91/at91-i2s.c
index 9fc0c03..3b33274 100644
--- a/sound/soc/at91/at91-i2s.c
+++ b/sound/soc/at91/at91-i2s.c
@@ -716,6 +716,6 @@ struct snd_soc_cpu_dai at91_i2s_dai[NUM_SSC_DEVICES] = {
 EXPORT_SYMBOL_GPL(at91_i2s_dai);
 
 /* Module information */
-MODULE_AUTHOR("Frank Mandarino, fmandarino@endrelia.com, www.endrelia.com");
+MODULE_AUTHOR("Frank Mandarino");
 MODULE_DESCRIPTION("AT91 I2S ASoC Interface");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/at91/at91-pcm.c b/sound/soc/at91/at91-pcm.c
index b39b95a..f548391 100644
--- a/sound/soc/at91/at91-pcm.c
+++ b/sound/soc/at91/at91-pcm.c
@@ -427,6 +427,6 @@ struct snd_soc_platform at91_soc_platform = {
 
 EXPORT_SYMBOL_GPL(at91_soc_platform);
 
-MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
+MODULE_AUTHOR("Frank Mandarino");
 MODULE_DESCRIPTION("Atmel AT91 PCM module");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/at91/eti_b1_wm8731.c b/sound/soc/at91/eti_b1_wm8731.c
index 8179df3..58bcbb8 100644
--- a/sound/soc/at91/eti_b1_wm8731.c
+++ b/sound/soc/at91/eti_b1_wm8731.c
@@ -370,6 +370,6 @@ module_init(eti_b1_init);
 module_exit(eti_b1_exit);
 
 /* Module information */
-MODULE_AUTHOR("Frank Mandarino <fmandarino@endrelia.com>");
+MODULE_AUTHOR("Frank Mandarino");
 MODULE_DESCRIPTION("ALSA SoC ETI-B1-WM8731");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/pxa/pxa2xx-i2s.c b/sound/soc/pxa/pxa2xx-i2s.c
index 50c5c83..3da33b6 100644
--- a/sound/soc/pxa/pxa2xx-i2s.c
+++ b/sound/soc/pxa/pxa2xx-i2s.c
@@ -313,6 +313,6 @@ struct snd_soc_cpu_dai pxa_i2s_dai = {
 EXPORT_SYMBOL_GPL(pxa_i2s_dai);
 
 /* Module information */
-MODULE_AUTHOR("Liam Girdwood, liam.girdwood@wolfsonmicro.com, www.wolfsonmicro.com");
+MODULE_AUTHOR("Liam Girdwood");
 MODULE_DESCRIPTION("pxa2xx I2S SoC Interface");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 36519ae..49be095 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1582,6 +1582,6 @@ module_init(snd_soc_init);
 module_exit(snd_soc_exit);
 
 /* Module information */
-MODULE_AUTHOR("Liam Girdwood, liam.girdwood@wolfsonmicro.com, www.wolfsonmicro.com");
+MODULE_AUTHOR("Liam Girdwood");
 MODULE_DESCRIPTION("ALSA SoC Core");
 MODULE_LICENSE("GPL");
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 7caf8c7..303846a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1318,6 +1318,6 @@ void snd_soc_dapm_free(struct snd_soc_device *socdev)
 EXPORT_SYMBOL_GPL(snd_soc_dapm_free);
 
 /* Module information */
-MODULE_AUTHOR("Liam Girdwood, liam.girdwood@wolfsonmicro.com, www.wolfsonmicro.com");
+MODULE_AUTHOR("Liam Girdwood");
 MODULE_DESCRIPTION("Dynamic Audio Power Management core for ALSA SoC");
 MODULE_LICENSE("GPL");
diff --git a/sound/usb/usbaudio.c b/sound/usb/usbaudio.c
index b6d8863..21ec11c 100644
--- a/sound/usb/usbaudio.c
+++ b/sound/usb/usbaudio.c
@@ -57,7 +57,7 @@
 #include "usbaudio.h"
 
 
-MODULE_AUTHOR("Takashi Iwai <tiwai@suse.de>");
+MODULE_AUTHOR("Takashi Iwai");
 MODULE_DESCRIPTION("USB Audio");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{Generic,USB Audio}}");
diff --git a/sound/usb/usbmidi.c b/sound/usb/usbmidi.c
index 24f5a26..b0d304e 100644
--- a/sound/usb/usbmidi.c
+++ b/sound/usb/usbmidi.c
@@ -64,7 +64,7 @@
 #define ERROR_DELAY_JIFFIES (HZ / 10)
 
 
-MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
+MODULE_AUTHOR("Clemens Ladisch");
 MODULE_DESCRIPTION("USB Audio/MIDI helper module");
 MODULE_LICENSE("Dual BSD/GPL");
 
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index e011fca..926d652 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -147,7 +147,7 @@
 
 
 
-MODULE_AUTHOR("Karsten Wiese <annabellesgarden@yahoo.de>");
+MODULE_AUTHOR("Karsten Wiese");
 MODULE_DESCRIPTION("TASCAM "NAME_ALLCAPS" Version 0.8.7.2");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{TASCAM(0x1604), "NAME_ALLCAPS"(0x8001)(0x8005)(0x8007) }}");

--------------060809030705080509070607
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060809030705080509070607--
