From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/4] ALSA: Include linux/io.h instead of
	asm/io.h
Date: Wed, 28 Jan 2015 17:37:43 +0100
Message-ID: <1422463066-18969-2-git-send-email-tiwai@suse.de>
References: <1422463066-18969-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A27B526262D
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:37:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1FA15ADE3
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 16:37:48 +0000 (UTC)
In-Reply-To: <1422463066-18969-1-git-send-email-tiwai@suse.de>
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

Nowadays it's recommended.  Replace all in a shot.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/emu10k1.h               | 2 +-
 include/sound/gus.h                   | 2 +-
 include/sound/sb.h                    | 2 +-
 sound/aoa/soundbus/i2sbus/control.c   | 2 +-
 sound/aoa/soundbus/i2sbus/pcm.c       | 2 +-
 sound/core/memory.c                   | 2 +-
 sound/core/pcm_memory.c               | 2 +-
 sound/core/pcm_native.c               | 2 +-
 sound/drivers/mpu401/mpu401_uart.c    | 2 +-
 sound/drivers/opl3/opl3_lib.c         | 2 +-
 sound/drivers/opl4/opl4_lib.c         | 2 +-
 sound/drivers/opl4/opl4_synth.c       | 2 +-
 sound/drivers/pcsp/pcsp_input.c       | 2 +-
 sound/drivers/pcsp/pcsp_lib.c         | 2 +-
 sound/drivers/serial-u16550.c         | 3 +--
 sound/drivers/vx/vx_core.c            | 2 +-
 sound/i2c/other/ak4xxx-adda.c         | 2 +-
 sound/isa/ad1816a/ad1816a_lib.c       | 2 +-
 sound/isa/azt2320.c                   | 2 +-
 sound/isa/cs423x/cs4236_lib.c         | 2 +-
 sound/isa/es1688/es1688_lib.c         | 2 +-
 sound/isa/es18xx.c                    | 2 +-
 sound/isa/opl3sa2.c                   | 3 +--
 sound/isa/opti9xx/miro.c              | 2 +-
 sound/isa/opti9xx/opti92x-ad1848.c    | 2 +-
 sound/isa/sb/emu8000.c                | 2 +-
 sound/isa/sb/sb16_main.c              | 2 +-
 sound/isa/sb/sb8_main.c               | 2 +-
 sound/isa/sb/sb8_midi.c               | 2 +-
 sound/isa/sb/sb_common.c              | 2 +-
 sound/isa/sb/sb_mixer.c               | 2 +-
 sound/isa/wavefront/wavefront_fx.c    | 2 +-
 sound/isa/wavefront/wavefront_midi.c  | 2 +-
 sound/isa/wavefront/wavefront_synth.c | 2 +-
 sound/isa/wss/wss_lib.c               | 2 +-
 sound/parisc/harmony.c                | 2 +-
 sound/pci/ad1889.c                    | 3 +--
 sound/pci/ali5451/ali5451.c           | 2 +-
 sound/pci/als300.c                    | 3 +--
 sound/pci/als4000.c                   | 2 +-
 sound/pci/atiixp.c                    | 2 +-
 sound/pci/atiixp_modem.c              | 2 +-
 sound/pci/au88x0/au88x0.h             | 2 +-
 sound/pci/aw2/aw2-saa7146.c           | 2 +-
 sound/pci/azt3328.c                   | 2 +-
 sound/pci/bt87x.c                     | 2 +-
 sound/pci/ca0106/ca0106_mixer.c       | 2 +-
 sound/pci/ca0106/ca0106_proc.c        | 2 +-
 sound/pci/cmipci.c                    | 2 +-
 sound/pci/cs4281.c                    | 2 +-
 sound/pci/cs46xx/cs46xx_lib.c         | 3 +--
 sound/pci/cs46xx/dsp_spos.c           | 2 +-
 sound/pci/cs46xx/dsp_spos_scb_lib.c   | 2 +-
 sound/pci/cs5535audio/cs5535audio.c   | 2 +-
 sound/pci/echoaudio/darla20.c         | 2 +-
 sound/pci/echoaudio/darla24.c         | 2 +-
 sound/pci/echoaudio/echo3g.c          | 2 +-
 sound/pci/echoaudio/gina20.c          | 2 +-
 sound/pci/echoaudio/gina24.c          | 2 +-
 sound/pci/echoaudio/indigo.c          | 2 +-
 sound/pci/echoaudio/indigodj.c        | 2 +-
 sound/pci/echoaudio/indigoio.c        | 2 +-
 sound/pci/echoaudio/layla20.c         | 2 +-
 sound/pci/echoaudio/layla24.c         | 2 +-
 sound/pci/echoaudio/mia.c             | 2 +-
 sound/pci/echoaudio/mona.c            | 2 +-
 sound/pci/ens1370.c                   | 2 +-
 sound/pci/es1938.c                    | 3 +--
 sound/pci/es1968.c                    | 2 +-
 sound/pci/ice1712/ak4xxx.c            | 2 +-
 sound/pci/intel8x0.c                  | 2 +-
 sound/pci/intel8x0m.c                 | 2 +-
 sound/pci/korg1212/korg1212.c         | 3 +--
 sound/pci/maestro3.c                  | 2 +-
 sound/pci/mixart/mixart_core.c        | 2 +-
 sound/pci/mixart/mixart_hwdep.c       | 2 +-
 sound/pci/nm256/nm256.c               | 2 +-
 sound/pci/oxygen/oxygen_io.c          | 2 +-
 sound/pci/pcxhr/pcxhr_core.c          | 2 +-
 sound/pci/pcxhr/pcxhr_hwdep.c         | 2 +-
 sound/pci/riptide/riptide.c           | 2 +-
 sound/pci/rme32.c                     | 3 +--
 sound/pci/rme96.c                     | 3 +--
 sound/pci/rme9652/hdsp.c              | 2 +-
 sound/pci/rme9652/hdspm.c             | 2 +-
 sound/pci/rme9652/rme9652.c           | 2 +-
 sound/pci/sonicvibes.c                | 3 +--
 sound/pci/trident/trident_main.c      | 3 +--
 sound/pci/trident/trident_memory.c    | 2 +-
 sound/pci/via82xx.c                   | 2 +-
 sound/pci/via82xx_modem.c             | 2 +-
 sound/pci/vx222/vx222_ops.c           | 2 +-
 sound/pci/ymfpci/ymfpci_main.c        | 2 +-
 sound/ppc/awacs.c                     | 2 +-
 sound/ppc/beep.c                      | 2 +-
 sound/ppc/burgundy.c                  | 2 +-
 sound/ppc/pmac.c                      | 2 +-
 sound/ppc/tumbler.c                   | 2 +-
 sound/sh/aica.c                       | 2 +-
 sound/sparc/amd7930.c                 | 2 +-
 100 files changed, 100 insertions(+), 111 deletions(-)

diff --git a/include/sound/emu10k1.h b/include/sound/emu10k1.h
index 7f6ab6cd5658..0de95ccb92cf 100644
--- a/include/sound/emu10k1.h
+++ b/include/sound/emu10k1.h
@@ -33,8 +33,8 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/firmware.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <uapi/sound/emu10k1.h>
 
 /* ------------------- DEFINES -------------------- */
diff --git a/include/sound/gus.h b/include/sound/gus.h
index 06bbdc25917c..07c116fe78c8 100644
--- a/include/sound/gus.h
+++ b/include/sound/gus.h
@@ -27,7 +27,7 @@
 #include <sound/timer.h>
 #include <sound/seq_midi_emul.h>
 #include <sound/seq_device.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 /* IO ports */
 
diff --git a/include/sound/sb.h b/include/sound/sb.h
index 33e2d11deedb..bacefaee411a 100644
--- a/include/sound/sb.h
+++ b/include/sound/sb.h
@@ -25,7 +25,7 @@
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
 #include <linux/interrupt.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 enum sb_hw_type {
 	SB_HW_AUTO,
diff --git a/sound/aoa/soundbus/i2sbus/control.c b/sound/aoa/soundbus/i2sbus/control.c
index 4dc9b49c02cf..f4495decc699 100644
--- a/sound/aoa/soundbus/i2sbus/control.c
+++ b/sound/aoa/soundbus/i2sbus/control.c
@@ -9,8 +9,8 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/prom.h>
 #include <asm/macio.h>
 #include <asm/pmac_feature.h>
diff --git a/sound/aoa/soundbus/i2sbus/pcm.c b/sound/aoa/soundbus/i2sbus/pcm.c
index 7b74a4ba75f8..4177d9729d0b 100644
--- a/sound/aoa/soundbus/i2sbus/pcm.c
+++ b/sound/aoa/soundbus/i2sbus/pcm.c
@@ -6,7 +6,7 @@
  * GPL v2, can be found in COPYING.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
 #include <sound/core.h>
diff --git a/sound/core/memory.c b/sound/core/memory.c
index 36c0f1a2e189..ca775d7589db 100644
--- a/sound/core/memory.c
+++ b/sound/core/memory.c
@@ -21,7 +21,7 @@
  */
 
 #include <linux/export.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/uaccess.h>
 #include <sound/core.h>
 
diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
index 54debc07f5cb..b45f6aa32264 100644
--- a/sound/core/pcm_memory.c
+++ b/sound/core/pcm_memory.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index ff3abc3b4ff5..932234d87927 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -26,6 +26,7 @@
 #include <linux/time.h>
 #include <linux/pm_qos.h>
 #include <linux/aio.h>
+#include <linux/io.h>
 #include <linux/dma-mapping.h>
 #include <sound/core.h>
 #include <sound/control.h>
@@ -34,7 +35,6 @@
 #include <sound/pcm_params.h>
 #include <sound/timer.h>
 #include <sound/minors.h>
-#include <asm/io.h>
 
 /*
  *  Compatibility
diff --git a/sound/drivers/mpu401/mpu401_uart.c b/sound/drivers/mpu401/mpu401_uart.c
index 1e19eb9e1596..776596b5ee05 100644
--- a/sound/drivers/mpu401/mpu401_uart.c
+++ b/sound/drivers/mpu401/mpu401_uart.c
@@ -28,7 +28,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index f66af5884c40..369cef212ea9 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -24,7 +24,7 @@
  */
 
 #include <sound/opl3.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/init.h>
diff --git a/sound/drivers/opl4/opl4_lib.c b/sound/drivers/opl4/opl4_lib.c
index b953fb4aa298..3b0ee42a5343 100644
--- a/sound/drivers/opl4/opl4_lib.c
+++ b/sound/drivers/opl4/opl4_lib.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 MODULE_AUTHOR("Clemens Ladisch <clemens@ladisch.de>");
 MODULE_DESCRIPTION("OPL4 driver");
diff --git a/sound/drivers/opl4/opl4_synth.c b/sound/drivers/opl4/opl4_synth.c
index 4b91adc0238c..7bc1e58c95aa 100644
--- a/sound/drivers/opl4/opl4_synth.c
+++ b/sound/drivers/opl4/opl4_synth.c
@@ -33,7 +33,7 @@
 
 #include "opl4_local.h"
 #include <linux/delay.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/asoundef.h>
 
 /* GM2 controllers */
diff --git a/sound/drivers/pcsp/pcsp_input.c b/sound/drivers/pcsp/pcsp_input.c
index 0ecf8a453e01..bfc25811985f 100644
--- a/sound/drivers/pcsp/pcsp_input.c
+++ b/sound/drivers/pcsp/pcsp_input.c
@@ -14,7 +14,7 @@
 
 #include <linux/init.h>
 #include <linux/input.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "pcsp.h"
 #include "pcsp_input.h"
 
diff --git a/sound/drivers/pcsp/pcsp_lib.c b/sound/drivers/pcsp/pcsp_lib.c
index 29ebaa4ec0fd..3689f5f6be64 100644
--- a/sound/drivers/pcsp/pcsp_lib.c
+++ b/sound/drivers/pcsp/pcsp_lib.c
@@ -10,8 +10,8 @@
 #include <linux/gfp.h>
 #include <linux/moduleparam.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <sound/pcm.h>
-#include <asm/io.h>
 #include "pcsp.h"
 
 static bool nforce_wa;
diff --git a/sound/drivers/serial-u16550.c b/sound/drivers/serial-u16550.c
index 8c1dc73e14e4..1927b89e1d1f 100644
--- a/sound/drivers/serial-u16550.c
+++ b/sound/drivers/serial-u16550.c
@@ -37,6 +37,7 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/rawmidi.h>
 #include <sound/initval.h>
@@ -44,8 +45,6 @@
 #include <linux/serial_reg.h>
 #include <linux/jiffies.h>
 
-#include <asm/io.h>
-
 MODULE_DESCRIPTION("MIDI serial u16550");
 MODULE_LICENSE("GPL");
 MODULE_SUPPORTED_DEVICE("{{ALSA, MIDI serial u16550}}");
diff --git a/sound/drivers/vx/vx_core.c b/sound/drivers/vx/vx_core.c
index fc05a37fd017..289f041706cd 100644
--- a/sound/drivers/vx/vx_core.c
+++ b/sound/drivers/vx/vx_core.c
@@ -27,11 +27,11 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/asoundef.h>
 #include <sound/info.h>
-#include <asm/io.h>
 #include <sound/vx_core.h>
 #include "vx_cmd.h"
 
diff --git a/sound/i2c/other/ak4xxx-adda.c b/sound/i2c/other/ak4xxx-adda.c
index 67dbfde837ab..c65731088aa2 100644
--- a/sound/i2c/other/ak4xxx-adda.c
+++ b/sound/i2c/other/ak4xxx-adda.c
@@ -21,7 +21,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 5f99102cc0c1..5c815f5fb044 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -22,11 +22,11 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
 #include <sound/ad1816a.h>
 
-#include <asm/io.h>
 #include <asm/dma.h>
 
 static inline int snd_ad1816a_busy_wait(struct snd_ad1816a *chip)
diff --git a/sound/isa/azt2320.c b/sound/isa/azt2320.c
index b8e768e5ce80..fff186fa621e 100644
--- a/sound/isa/azt2320.c
+++ b/sound/isa/azt2320.c
@@ -29,7 +29,7 @@
     activation method (full-duplex audio!).
 */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/time.h>
diff --git a/sound/isa/cs423x/cs4236_lib.c b/sound/isa/cs423x/cs4236_lib.c
index add7ffc072c5..2b7cc596f4c6 100644
--- a/sound/isa/cs423x/cs4236_lib.c
+++ b/sound/isa/cs423x/cs4236_lib.c
@@ -79,7 +79,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/time.h>
diff --git a/sound/isa/es1688/es1688_lib.c b/sound/isa/es1688/es1688_lib.c
index 52aac8467178..e2cf508841b1 100644
--- a/sound/isa/es1688/es1688_lib.c
+++ b/sound/isa/es1688/es1688_lib.c
@@ -25,11 +25,11 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/es1688.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
 #include <asm/dma.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 6cc2d2bbde6a..5094b62d8f77 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -84,8 +84,8 @@
 #include <linux/isapnp.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/control.h>
diff --git a/sound/isa/opl3sa2.c b/sound/isa/opl3sa2.c
index d7aff527da88..ae133633a420 100644
--- a/sound/isa/opl3sa2.c
+++ b/sound/isa/opl3sa2.c
@@ -26,6 +26,7 @@
 #include <linux/pm.h>
 #include <linux/pnp.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/wss.h>
 #include <sound/mpu401.h>
@@ -33,8 +34,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include <asm/io.h>
-
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("Yamaha OPL3SA2+");
 MODULE_LICENSE("GPL");
diff --git a/sound/isa/opti9xx/miro.c b/sound/isa/opti9xx/miro.c
index 546452888aed..3a9067db1a84 100644
--- a/sound/isa/opti9xx/miro.c
+++ b/sound/isa/opti9xx/miro.c
@@ -29,7 +29,7 @@
 #include <linux/delay.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/wss.h>
diff --git a/sound/isa/opti9xx/opti92x-ad1848.c b/sound/isa/opti9xx/opti92x-ad1848.c
index 840831f1dd4e..0a5266003786 100644
--- a/sound/isa/opti9xx/opti92x-ad1848.c
+++ b/sound/isa/opti9xx/opti92x-ad1848.c
@@ -29,7 +29,7 @@
 #include <linux/delay.h>
 #include <linux/pnp.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/dma.h>
 #include <sound/core.h>
 #include <sound/tlv.h>
diff --git a/sound/isa/sb/emu8000.c b/sound/isa/sb/emu8000.c
index 96e9d94d07e4..1449354a23fe 100644
--- a/sound/isa/sb/emu8000.c
+++ b/sound/isa/sb/emu8000.c
@@ -26,10 +26,10 @@
 #include <linux/ioport.h>
 #include <linux/export.h>
 #include <linux/delay.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/emu8000.h>
 #include <sound/emu8000_reg.h>
-#include <asm/io.h>
 #include <asm/uaccess.h>
 #include <linux/init.h>
 #include <sound/control.h>
diff --git a/sound/isa/sb/sb16_main.c b/sound/isa/sb/sb16_main.c
index 63d11b7b9fe8..8b2d6c6bfe97 100644
--- a/sound/isa/sb/sb16_main.c
+++ b/sound/isa/sb/sb16_main.c
@@ -33,7 +33,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/time.h>
diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index d4d8b0e604ee..9043397fe62f 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -30,7 +30,7 @@
  *   Cleaned up and rewrote lowlevel routines.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>
 #include <linux/time.h>
diff --git a/sound/isa/sb/sb8_midi.c b/sound/isa/sb/sb8_midi.c
index 925ea45b3d97..d551c50e549f 100644
--- a/sound/isa/sb/sb8_midi.c
+++ b/sound/isa/sb/sb8_midi.c
@@ -26,7 +26,7 @@
  *   Added full duplex UART mode for DSP version 2.0 and later.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/time.h>
 #include <sound/core.h>
 #include <sound/sb.h>
diff --git a/sound/isa/sb/sb_common.c b/sound/isa/sb/sb_common.c
index f22b4480828e..787a4ade4afd 100644
--- a/sound/isa/sb/sb_common.c
+++ b/sound/isa/sb/sb_common.c
@@ -26,11 +26,11 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/sb.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
 #include <asm/dma.h>
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
diff --git a/sound/isa/sb/sb_mixer.c b/sound/isa/sb/sb_mixer.c
index e403334a19ad..add1d3f99609 100644
--- a/sound/isa/sb/sb_mixer.c
+++ b/sound/isa/sb/sb_mixer.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/time.h>
 #include <sound/core.h>
diff --git a/sound/isa/wavefront/wavefront_fx.c b/sound/isa/wavefront/wavefront_fx.c
index b77883c7ee76..b5a19708473a 100644
--- a/sound/isa/wavefront/wavefront_fx.c
+++ b/sound/isa/wavefront/wavefront_fx.c
@@ -16,7 +16,7 @@
  *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/wait.h>
diff --git a/sound/isa/wavefront/wavefront_midi.c b/sound/isa/wavefront/wavefront_midi.c
index b8009cbcd34e..8a80fc6a616b 100644
--- a/sound/isa/wavefront/wavefront_midi.c
+++ b/sound/isa/wavefront/wavefront_midi.c
@@ -47,7 +47,7 @@
  *  
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/time.h>
 #include <linux/wait.h>
diff --git a/sound/isa/wavefront/wavefront_synth.c b/sound/isa/wavefront/wavefront_synth.c
index e5db001363ee..33f5ec14fcfa 100644
--- a/sound/isa/wavefront/wavefront_synth.c
+++ b/sound/isa/wavefront/wavefront_synth.c
@@ -20,7 +20,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 6530d32901b9..913b731d2236 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -31,12 +31,12 @@
 #include <linux/slab.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/wss.h>
 #include <sound/pcm_params.h>
 #include <sound/tlv.h>
 
-#include <asm/io.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
 
diff --git a/sound/parisc/harmony.c b/sound/parisc/harmony.c
index f2350c1d6ee8..99b64cb3cef8 100644
--- a/sound/parisc/harmony.c
+++ b/sound/parisc/harmony.c
@@ -44,6 +44,7 @@
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -52,7 +53,6 @@
 #include <sound/initval.h>
 #include <sound/info.h>
 
-#include <asm/io.h>
 #include <asm/hardware.h>
 #include <asm/parisc-device.h>
 
diff --git a/sound/pci/ad1889.c b/sound/pci/ad1889.c
index 0de31290411c..850a8c984c25 100644
--- a/sound/pci/ad1889.c
+++ b/sound/pci/ad1889.c
@@ -40,14 +40,13 @@
 #include <linux/compiler.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
 #include <sound/ac97_codec.h>
 
-#include <asm/io.h>
-
 #include "ad1889.h"
 #include "ac97/ac97_id.h"
 
diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
index 4cd2210fd95c..c8d499575c01 100644
--- a/sound/pci/ali5451/ali5451.c
+++ b/sound/pci/ali5451/ali5451.c
@@ -25,7 +25,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/als300.c b/sound/pci/als300.c
index bd01113de39a..57e034f208dc 100644
--- a/sound/pci/als300.c
+++ b/sound/pci/als300.c
@@ -37,8 +37,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
diff --git a/sound/pci/als4000.c b/sound/pci/als4000.c
index 94608524f3cc..a3dea464134d 100644
--- a/sound/pci/als4000.c
+++ b/sound/pci/als4000.c
@@ -65,7 +65,7 @@
  * - power management? (card can do voice wakeup according to datasheet!!)
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/gameport.h>
diff --git a/sound/pci/atiixp.c b/sound/pci/atiixp.c
index eb4f9ee54f85..d5f15c9bbeda 100644
--- a/sound/pci/atiixp.c
+++ b/sound/pci/atiixp.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/atiixp_modem.c b/sound/pci/atiixp_modem.c
index 349dd7ba6e43..0a38e08164ab 100644
--- a/sound/pci/atiixp_modem.c
+++ b/sound/pci/atiixp_modem.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index 3a8fefefea77..98c53bbf8837 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -19,7 +19,7 @@
 
 #ifdef __KERNEL__
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/rawmidi.h>
diff --git a/sound/pci/aw2/aw2-saa7146.c b/sound/pci/aw2/aw2-saa7146.c
index 6d24e9536777..1d7890459334 100644
--- a/sound/pci/aw2/aw2-saa7146.c
+++ b/sound/pci/aw2/aw2-saa7146.c
@@ -27,7 +27,7 @@
 #include <linux/pci.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
diff --git a/sound/pci/azt3328.c b/sound/pci/azt3328.c
index bbacc75c902a..a40a2b4c8fd7 100644
--- a/sound/pci/azt3328.c
+++ b/sound/pci/azt3328.c
@@ -179,7 +179,7 @@
  *  - use MMIO (memory-mapped I/O)? Slightly faster access, e.g. for gameport.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/bug.h> /* WARN_ONCE */
 #include <linux/pci.h>
diff --git a/sound/pci/bt87x.c b/sound/pci/bt87x.c
index e82ceacbe64f..5925b7170e25 100644
--- a/sound/pci/bt87x.c
+++ b/sound/pci/bt87x.c
@@ -27,7 +27,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
diff --git a/sound/pci/ca0106/ca0106_mixer.c b/sound/pci/ca0106/ca0106_mixer.c
index 68c0eb0a2807..025805cba779 100644
--- a/sound/pci/ca0106/ca0106_mixer.c
+++ b/sound/pci/ca0106/ca0106_mixer.c
@@ -70,7 +70,7 @@
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 #include <sound/tlv.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include "ca0106.h"
 
diff --git a/sound/pci/ca0106/ca0106_proc.c b/sound/pci/ca0106/ca0106_proc.c
index 4f9c2821bb31..2c5c28adbefd 100644
--- a/sound/pci/ca0106/ca0106_proc.c
+++ b/sound/pci/ca0106/ca0106_proc.c
@@ -64,13 +64,13 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 #include <sound/asoundef.h>
-#include <asm/io.h>
 
 #include "ca0106.h"
 
diff --git a/sound/pci/cmipci.c b/sound/pci/cmipci.c
index 63d2c8236ec6..1d0f2cad2f5a 100644
--- a/sound/pci/cmipci.c
+++ b/sound/pci/cmipci.c
@@ -20,7 +20,7 @@
 /* Does not work. Warning may block system in capture mode */
 /* #define USE_VAR48KRATE */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/cs4281.c b/sound/pci/cs4281.c
index 754613b772ab..c296fd0dbc9c 100644
--- a/sound/pci/cs4281.c
+++ b/sound/pci/cs4281.c
@@ -19,7 +19,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/cs46xx/cs46xx_lib.c b/sound/pci/cs46xx/cs46xx_lib.c
index fb3abb2203cd..8d74004b1ed2 100644
--- a/sound/pci/cs46xx/cs46xx_lib.c
+++ b/sound/pci/cs46xx/cs46xx_lib.c
@@ -57,6 +57,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/vmalloc.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -65,8 +66,6 @@
 #include <sound/pcm_params.h>
 #include "cs46xx.h"
 
-#include <asm/io.h>
-
 #include "cs46xx_lib.h"
 #include "dsp_spos.h"
 
diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index 1c4a0fb3ffef..5c99efb004c0 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -20,7 +20,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
diff --git a/sound/pci/cs46xx/dsp_spos_scb_lib.c b/sound/pci/cs46xx/dsp_spos_scb_lib.c
index 8284bc9b5858..2c90c0bded69 100644
--- a/sound/pci/cs46xx/dsp_spos_scb_lib.c
+++ b/sound/pci/cs46xx/dsp_spos_scb_lib.c
@@ -21,7 +21,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/init.h>
diff --git a/sound/pci/cs5535audio/cs5535audio.c b/sound/pci/cs5535audio/cs5535audio.c
index 16288e4d338a..802c33f1cc59 100644
--- a/sound/pci/cs5535audio/cs5535audio.c
+++ b/sound/pci/cs5535audio/cs5535audio.c
@@ -27,7 +27,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
diff --git a/sound/pci/echoaudio/darla20.c b/sound/pci/echoaudio/darla20.c
index 4632946205a8..c95da6301677 100644
--- a/sound/pci/echoaudio/darla20.c
+++ b/sound/pci/echoaudio/darla20.c
@@ -43,6 +43,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -51,7 +52,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/darla24.c b/sound/pci/echoaudio/darla24.c
index f81c839cc887..3013b4daa19e 100644
--- a/sound/pci/echoaudio/darla24.c
+++ b/sound/pci/echoaudio/darla24.c
@@ -47,6 +47,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -55,7 +56,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/echo3g.c b/sound/pci/echoaudio/echo3g.c
index 3a5346c33d76..1f34a07b0b19 100644
--- a/sound/pci/echoaudio/echo3g.c
+++ b/sound/pci/echoaudio/echo3g.c
@@ -54,6 +54,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -63,7 +64,6 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/gina20.c b/sound/pci/echoaudio/gina20.c
index 9cb81c500824..4fa32a2e97db 100644
--- a/sound/pci/echoaudio/gina20.c
+++ b/sound/pci/echoaudio/gina20.c
@@ -47,6 +47,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -55,7 +56,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/gina24.c b/sound/pci/echoaudio/gina24.c
index 35d3e6eac990..b1bcacaef257 100644
--- a/sound/pci/echoaudio/gina24.c
+++ b/sound/pci/echoaudio/gina24.c
@@ -53,6 +53,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -61,7 +62,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/indigo.c b/sound/pci/echoaudio/indigo.c
index 8d91842d1268..175af9b1435f 100644
--- a/sound/pci/echoaudio/indigo.c
+++ b/sound/pci/echoaudio/indigo.c
@@ -45,6 +45,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -53,7 +54,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/indigodj.c b/sound/pci/echoaudio/indigodj.c
index 289cb969f5b9..8c60314e4901 100644
--- a/sound/pci/echoaudio/indigodj.c
+++ b/sound/pci/echoaudio/indigodj.c
@@ -45,6 +45,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -53,7 +54,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/indigoio.c b/sound/pci/echoaudio/indigoio.c
index 405a3f2e496f..f7618edfd79c 100644
--- a/sound/pci/echoaudio/indigoio.c
+++ b/sound/pci/echoaudio/indigoio.c
@@ -46,6 +46,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -54,7 +55,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/layla20.c b/sound/pci/echoaudio/layla20.c
index b392dd776b71..12e5d2164dc4 100644
--- a/sound/pci/echoaudio/layla20.c
+++ b/sound/pci/echoaudio/layla20.c
@@ -52,6 +52,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -61,7 +62,6 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/layla24.c b/sound/pci/echoaudio/layla24.c
index bc7f730b0ec6..6e4023728ef5 100644
--- a/sound/pci/echoaudio/layla24.c
+++ b/sound/pci/echoaudio/layla24.c
@@ -54,6 +54,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -63,7 +64,6 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/mia.c b/sound/pci/echoaudio/mia.c
index 27a9a6e5db2d..2f7562f1aefb 100644
--- a/sound/pci/echoaudio/mia.c
+++ b/sound/pci/echoaudio/mia.c
@@ -53,6 +53,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -62,7 +63,6 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/mona.c b/sound/pci/echoaudio/mona.c
index 3d13875c303d..34d499466393 100644
--- a/sound/pci/echoaudio/mona.c
+++ b/sound/pci/echoaudio/mona.c
@@ -51,6 +51,7 @@
 #include <linux/module.h>
 #include <linux/firmware.h>
 #include <linux/slab.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
@@ -59,7 +60,6 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
 #include <linux/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/ens1370.c b/sound/pci/ens1370.c
index 219b8af29a49..0dc44ebb0032 100644
--- a/sound/pci/ens1370.c
+++ b/sound/pci/ens1370.c
@@ -26,7 +26,7 @@
  * by Kurt J. Bosch
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/es1938.c b/sound/pci/es1938.c
index a01454b545a0..e1858d9d23d8 100644
--- a/sound/pci/es1938.c
+++ b/sound/pci/es1938.c
@@ -55,6 +55,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
@@ -63,8 +64,6 @@
 #include <sound/initval.h>
 #include <sound/tlv.h>
 
-#include <asm/io.h>
-
 MODULE_AUTHOR("Jaromir Koutek <miri@punknet.cz>");
 MODULE_DESCRIPTION("ESS Solo-1");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/es1968.c b/sound/pci/es1968.c
index 631be029f8c0..059f3846d7b8 100644
--- a/sound/pci/es1968.c
+++ b/sound/pci/es1968.c
@@ -94,7 +94,7 @@
  *	places.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/ice1712/ak4xxx.c b/sound/pci/ice1712/ak4xxx.c
index 3981823f9094..179ef7a5f0d1 100644
--- a/sound/pci/ice1712/ak4xxx.c
+++ b/sound/pci/ice1712/ak4xxx.c
@@ -21,7 +21,7 @@
  *
  */      
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 67f9e8b77385..2c5484eeb963 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -26,7 +26,7 @@
  *
  */      
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/intel8x0m.c b/sound/pci/intel8x0m.c
index 748f6f67c982..7577f31cd504 100644
--- a/sound/pci/intel8x0m.c
+++ b/sound/pci/intel8x0m.c
@@ -23,7 +23,7 @@
  *
  */      
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index bd569e580277..7acbc21d642a 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -28,6 +28,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/firmware.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -36,8 +37,6 @@
 #include <sound/pcm_params.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
-
 // ----------------------------------------------------------------------------
 // Debug Stuff
 // ----------------------------------------------------------------------------
diff --git a/sound/pci/maestro3.c b/sound/pci/maestro3.c
index 18a60be63266..9be660993bd0 100644
--- a/sound/pci/maestro3.c
+++ b/sound/pci/maestro3.c
@@ -31,7 +31,7 @@
 #define CARD_NAME "ESS Maestro3/Allegro/Canyon3D-2"
 #define DRIVER_NAME "Maestro3"
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/mixart/mixart_core.c b/sound/pci/mixart/mixart_core.c
index fe80313674d9..dccf3db48fe0 100644
--- a/sound/pci/mixart/mixart_core.c
+++ b/sound/pci/mixart/mixart_core.c
@@ -23,8 +23,8 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/io.h>
 
-#include <asm/io.h>
 #include <sound/core.h>
 #include "mixart.h"
 #include "mixart_hwdep.h"
diff --git a/sound/pci/mixart/mixart_hwdep.c b/sound/pci/mixart/mixart_hwdep.c
index 9996a4dead0f..5bfd3ac80db5 100644
--- a/sound/pci/mixart/mixart_hwdep.c
+++ b/sound/pci/mixart/mixart_hwdep.c
@@ -26,7 +26,7 @@
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include "mixart.h"
 #include "mixart_mixer.h"
diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 90674b93b930..4735e27cc773 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -24,7 +24,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
   
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/oxygen/oxygen_io.c b/sound/pci/oxygen/oxygen_io.c
index 4b8a32c37e31..c7851da37749 100644
--- a/sound/pci/oxygen/oxygen_io.c
+++ b/sound/pci/oxygen/oxygen_io.c
@@ -20,9 +20,9 @@
 #include <linux/delay.h>
 #include <linux/sched.h>
 #include <linux/export.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/mpu401.h>
-#include <asm/io.h>
 #include "oxygen.h"
 
 u8 oxygen_read8(struct oxygen *chip, unsigned int reg)
diff --git a/sound/pci/pcxhr/pcxhr_core.c b/sound/pci/pcxhr/pcxhr_core.c
index 181f7729d409..c5194f5b150a 100644
--- a/sound/pci/pcxhr/pcxhr_core.c
+++ b/sound/pci/pcxhr/pcxhr_core.c
@@ -24,7 +24,7 @@
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/pci.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include "pcxhr.h"
 #include "pcxhr_mixer.h"
diff --git a/sound/pci/pcxhr/pcxhr_hwdep.c b/sound/pci/pcxhr/pcxhr_hwdep.c
index 15a8ce5f1f48..80633055e17e 100644
--- a/sound/pci/pcxhr/pcxhr_hwdep.c
+++ b/sound/pci/pcxhr/pcxhr_hwdep.c
@@ -25,7 +25,7 @@
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/hwdep.h>
 #include "pcxhr.h"
diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index a1521047e619..29f28273b2cc 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -99,7 +99,7 @@
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
 #include <sound/control.h>
diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 1a7affad7164..23d7f5d30c41 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -75,6 +75,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -85,8 +86,6 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
-
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
 static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;	/* Enable this card */
diff --git a/sound/pci/rme96.c b/sound/pci/rme96.c
index 236ac1d48184..2306ccf7281e 100644
--- a/sound/pci/rme96.c
+++ b/sound/pci/rme96.c
@@ -29,6 +29,7 @@
 #include <linux/pci.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -38,8 +39,6 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
-
 /* note, two last pcis should be equal, it is not a bug */
 
 MODULE_AUTHOR("Anders Torger <torger@ludd.luth.se>");
diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
index 98a2d911ef17..c19e021ccf66 100644
--- a/sound/pci/rme9652/hdsp.c
+++ b/sound/pci/rme9652/hdsp.c
@@ -29,6 +29,7 @@
 #include <linux/module.h>
 #include <linux/math64.h>
 #include <linux/vmalloc.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -42,7 +43,6 @@
 
 #include <asm/byteorder.h>
 #include <asm/current.h>
-#include <asm/io.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 1716323fed9c..2c363fdca9fd 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -136,7 +136,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <linux/math64.h>
-#include <asm/io.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 648911c1a226..fdbc0aa2776a 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -25,6 +25,7 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -34,7 +35,6 @@
 #include <sound/initval.h>
 
 #include <asm/current.h>
-#include <asm/io.h>
 
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
diff --git a/sound/pci/sonicvibes.c b/sound/pci/sonicvibes.c
index 34cee5c1abd8..0f40624a4275 100644
--- a/sound/pci/sonicvibes.c
+++ b/sound/pci/sonicvibes.c
@@ -30,6 +30,7 @@
 #include <linux/gameport.h>
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -39,8 +40,6 @@
 #include <sound/opl3.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
-
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("S3 SonicVibes PCI");
 MODULE_LICENSE("GPL");
diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 2870cbf8cee0..b72be035f785 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -36,6 +36,7 @@
 #include <linux/gameport.h>
 #include <linux/dma-mapping.h>
 #include <linux/export.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/info.h>
@@ -44,8 +45,6 @@
 #include "trident.h"
 #include <sound/asoundef.h>
 
-#include <asm/io.h>
-
 static int snd_trident_pcm_mixer_build(struct snd_trident *trident,
 				       struct snd_trident_voice * voice,
 				       struct snd_pcm_substream *substream);
diff --git a/sound/pci/trident/trident_memory.c b/sound/pci/trident/trident_memory.c
index 04c474658e3c..b9ebb51893c5 100644
--- a/sound/pci/trident/trident_memory.c
+++ b/sound/pci/trident/trident_memory.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/pci.h>
 #include <linux/time.h>
 #include <linux/mutex.h>
diff --git a/sound/pci/via82xx.c b/sound/pci/via82xx.c
index 120fccbb2461..8622283e89f3 100644
--- a/sound/pci/via82xx.c
+++ b/sound/pci/via82xx.c
@@ -46,7 +46,7 @@
  *	- Optimize position calculation for the 823x chips. 
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/via82xx_modem.c b/sound/pci/via82xx_modem.c
index 884f49eea495..99b9137bc677 100644
--- a/sound/pci/via82xx_modem.c
+++ b/sound/pci/via82xx_modem.c
@@ -31,7 +31,7 @@
  *      modems.
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index 52c1a8d5b88a..af83b3b38052 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -24,11 +24,11 @@
 #include <linux/device.h>
 #include <linux/firmware.h>
 #include <linux/mutex.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/tlv.h>
-#include <asm/io.h>
 #include "vx222.h"
 
 
diff --git a/sound/pci/ymfpci/ymfpci_main.c b/sound/pci/ymfpci/ymfpci_main.c
index 227d5c9dfe09..4c26076dbf78 100644
--- a/sound/pci/ymfpci/ymfpci_main.c
+++ b/sound/pci/ymfpci/ymfpci_main.c
@@ -27,6 +27,7 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/module.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/control.h>
@@ -36,7 +37,6 @@
 #include <sound/asoundef.h>
 #include <sound/mpu401.h>
 
-#include <asm/io.h>
 #include <asm/byteorder.h>
 
 /*
diff --git a/sound/ppc/awacs.c b/sound/ppc/awacs.c
index 5fbf5db2543d..09da7b52bc2e 100644
--- a/sound/ppc/awacs.c
+++ b/sound/ppc/awacs.c
@@ -20,7 +20,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/nvram.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/ppc/beep.c b/sound/ppc/beep.c
index 0040f048221f..d3524f9fa05d 100644
--- a/sound/ppc/beep.c
+++ b/sound/ppc/beep.c
@@ -18,7 +18,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
 #include <linux/init.h>
 #include <linux/slab.h>
diff --git a/sound/ppc/burgundy.c b/sound/ppc/burgundy.c
index cb4f0a5e984e..b86159e04493 100644
--- a/sound/ppc/burgundy.c
+++ b/sound/ppc/burgundy.c
@@ -19,7 +19,7 @@
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <sound/core.h>
diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index d399df473896..13146d701413 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -20,7 +20,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/irq.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/sound/ppc/tumbler.c b/sound/ppc/tumbler.c
index 24c8766a925d..c8fafba218a5 100644
--- a/sound/ppc/tumbler.c
+++ b/sound/ppc/tumbler.c
@@ -32,8 +32,8 @@
 #include <linux/interrupt.h>
 #include <linux/string.h>
 #include <linux/of_irq.h>
+#include <linux/io.h>
 #include <sound/core.h>
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/machdep.h>
 #include <asm/pmac_feature.h>
diff --git a/sound/sh/aica.c b/sound/sh/aica.c
index 8212300088fc..ad3d9ae38034 100644
--- a/sound/sh/aica.c
+++ b/sound/sh/aica.c
@@ -35,12 +35,12 @@
 #include <linux/timer.h>
 #include <linux/delay.h>
 #include <linux/workqueue.h>
+#include <linux/io.h>
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
 #include <sound/initval.h>
 #include <sound/info.h>
-#include <asm/io.h>
 #include <asm/dma.h>
 #include <mach/sysasic.h>
 #include "aica.h"
diff --git a/sound/sparc/amd7930.c b/sound/sparc/amd7930.c
index 86280d63b76d..1b1a89e80d13 100644
--- a/sound/sparc/amd7930.c
+++ b/sound/sparc/amd7930.c
@@ -37,6 +37,7 @@
 #include <linux/moduleparam.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/io.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
@@ -44,7 +45,6 @@
 #include <sound/control.h>
 #include <sound/initval.h>
 
-#include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/prom.h>
 
-- 
2.2.2
