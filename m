From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 07/24] sound/pci: coding style fixes: echoaudio
Date: Tue, 9 Sep 2008 05:50:22 +0400
Message-ID: <20080909015022.GK6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ABFA103828
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:50:27 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1535155fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:50:27 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/echoaudio/darla20.c       |    2 +-
 sound/pci/echoaudio/darla24.c       |    2 +-
 sound/pci/echoaudio/echo3g.c        |    2 +-
 sound/pci/echoaudio/echoaudio.c     |    2 +-
 sound/pci/echoaudio/echoaudio.h     |    2 +-
 sound/pci/echoaudio/echoaudio_dsp.h |   16 ++++++++--------
 sound/pci/echoaudio/gina20.c        |    2 +-
 sound/pci/echoaudio/gina24.c        |    2 +-
 sound/pci/echoaudio/indigo.c        |    2 +-
 sound/pci/echoaudio/indigodj.c      |    2 +-
 sound/pci/echoaudio/indigoio.c      |    2 +-
 sound/pci/echoaudio/layla20.c       |    2 +-
 sound/pci/echoaudio/layla24.c       |    2 +-
 sound/pci/echoaudio/layla24_dsp.c   |    4 ++--
 sound/pci/echoaudio/mia.c           |    2 +-
 sound/pci/echoaudio/midi.c          |    2 +-
 sound/pci/echoaudio/mona.c          |    2 +-
 sound/pci/echoaudio/mona_dsp.c      |    2 +-
 18 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/sound/pci/echoaudio/darla20.c b/sound/pci/echoaudio/darla20.c
index 8c6db3a..c9a128a 100644
--- a/sound/pci/echoaudio/darla20.c
+++ b/sound/pci/echoaudio/darla20.c
@@ -51,7 +51,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/darla24.c b/sound/pci/echoaudio/darla24.c
index 04cbf3e..3771d02 100644
--- a/sound/pci/echoaudio/darla24.c
+++ b/sound/pci/echoaudio/darla24.c
@@ -55,7 +55,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/echo3g.c b/sound/pci/echoaudio/echo3g.c
index 4022e43..eb9bf6e 100644
--- a/sound/pci/echoaudio/echo3g.c
+++ b/sound/pci/echoaudio/echo3g.c
@@ -63,7 +63,7 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/echoaudio.c b/sound/pci/echoaudio/echoaudio.c
index 8dbc5c4..3004a58 100644
--- a/sound/pci/echoaudio/echoaudio.c
+++ b/sound/pci/echoaudio/echoaudio.c
@@ -1098,7 +1098,7 @@ static struct snd_kcontrol_new snd_echo_line_input_gain __devinitdata = {
 #ifdef ECHOCARD_HAS_OUTPUT_NOMINAL_LEVEL
 
 /************ Analog output nominal level (+4dBu / -10dBV) ***************/
-static int snd_echo_output_nominal_info (struct snd_kcontrol *kcontrol,
+static int snd_echo_output_nominal_info(struct snd_kcontrol *kcontrol,
 					 struct snd_ctl_elem_info *uinfo)
 {
 	struct echoaudio *chip;
diff --git a/sound/pci/echoaudio/echoaudio.h b/sound/pci/echoaudio/echoaudio.h
index 1c88e05..674ebf4 100644
--- a/sound/pci/echoaudio/echoaudio.h
+++ b/sound/pci/echoaudio/echoaudio.h
@@ -218,7 +218,7 @@
 
 
 /****************************************************************************
- 
+
    Clocks
 
 *****************************************************************************/
diff --git a/sound/pci/echoaudio/echoaudio_dsp.h b/sound/pci/echoaudio/echoaudio_dsp.h
index e352f3a..09ddbd3 100644
--- a/sound/pci/echoaudio/echoaudio_dsp.h
+++ b/sound/pci/echoaudio/echoaudio_dsp.h
@@ -103,7 +103,7 @@
 #define CHI32_STATUS_IRQ		0x00000040
 
 
-/* 
+/*
  *
  * DSP commands sent via slave mode; these are sent to the DSP by write_dsp()
  *
@@ -369,7 +369,7 @@ SET_LAYLA24_FREQUENCY_REG command.
  * via input and output pipes.  LE means little-endian,
  * BE means big-endian.
  *
- * DSP_AUDIOFORM_MS_8   
+ * DSP_AUDIOFORM_MS_8
  *
  *    8-bit mono unsigned samples.  For playback,
  *    mono data is duplicated out the left and right channels
@@ -388,10 +388,10 @@ SET_LAYLA24_FREQUENCY_REG command.
  *    they would be stored in memory like this: 33 22 11 66 55 44.
  *
  * DSP_AUDIOFORM_MS_32LE
- * 
- *    24-bit signed little-endian mono samples in a 32-bit 
- *    container.  In other words, each sample is a 32-bit signed 
- *    integer, where the actual audio data is left-justified 
+ *
+ *    24-bit signed little-endian mono samples in a 32-bit
+ *    container.  In other words, each sample is a 32-bit signed
+ *    integer, where the actual audio data is left-justified
  *    in the 32 bits and only the 24 most significant bits are valid.
  *
  * DSP_AUDIOFORM_SS_8
@@ -435,8 +435,8 @@ SET_LAYLA24_FREQUENCY_REG command.
  * Super-interleave is defined as interleaving by 4 or more.  Darla20 and Gina20
  * do not support super interleave.
  *
- * 16 bit, 24 bit, and 32 bit little endian samples are supported for super 
- * interleave.  The interleave factor must be even.  16 - way interleave is the 
+ * 16 bit, 24 bit, and 32 bit little endian samples are supported for super
+ * interleave.  The interleave factor must be even.  16 - way interleave is the
  * current maximum, so you can interleave by 4, 6, 8, 10, 12, 14, and 16.
  *
  * The actual format code is derived by taking the define below and or-ing with
diff --git a/sound/pci/echoaudio/gina20.c b/sound/pci/echoaudio/gina20.c
index c0e64b8..fa70fb1 100644
--- a/sound/pci/echoaudio/gina20.c
+++ b/sound/pci/echoaudio/gina20.c
@@ -55,7 +55,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/gina24.c b/sound/pci/echoaudio/gina24.c
index c36a78d..a33cc5a 100644
--- a/sound/pci/echoaudio/gina24.c
+++ b/sound/pci/echoaudio/gina24.c
@@ -61,7 +61,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/indigo.c b/sound/pci/echoaudio/indigo.c
index 0a58a7c..9097281 100644
--- a/sound/pci/echoaudio/indigo.c
+++ b/sound/pci/echoaudio/indigo.c
@@ -53,7 +53,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/indigodj.c b/sound/pci/echoaudio/indigodj.c
index 2db24d2..b3ff9a2 100644
--- a/sound/pci/echoaudio/indigodj.c
+++ b/sound/pci/echoaudio/indigodj.c
@@ -53,7 +53,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/indigoio.c b/sound/pci/echoaudio/indigoio.c
index a60c0a0..bd0c403 100644
--- a/sound/pci/echoaudio/indigoio.c
+++ b/sound/pci/echoaudio/indigoio.c
@@ -54,7 +54,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/layla20.c b/sound/pci/echoaudio/layla20.c
index 5061946..4a32154 100644
--- a/sound/pci/echoaudio/layla20.c
+++ b/sound/pci/echoaudio/layla20.c
@@ -61,7 +61,7 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/layla24.c b/sound/pci/echoaudio/layla24.c
index e09e3ea..a9b0ec0 100644
--- a/sound/pci/echoaudio/layla24.c
+++ b/sound/pci/echoaudio/layla24.c
@@ -63,7 +63,7 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/layla24_dsp.c b/sound/pci/echoaudio/layla24_dsp.c
index d61b5cb..03a3b38 100644
--- a/sound/pci/echoaudio/layla24_dsp.c
+++ b/sound/pci/echoaudio/layla24_dsp.c
@@ -149,7 +149,7 @@ static int load_asic(struct echoaudio *chip)
 	if (!err)
 		err = write_control_reg(chip, GML_CONVERTER_ENABLE | GML_48KHZ,
 					TRUE);
-	
+
 	DE_INIT(("load_asic() done\n"));
 	return err;
 }
@@ -307,7 +307,7 @@ static int switch_asic(struct echoaudio *chip, const struct firmware *asic)
 	if (asic != chip->asic_code) {
 		monitors = kmemdup(chip->comm_page->monitors,
 					MONITOR_ARRAY_SIZE, GFP_KERNEL);
-		if (! monitors)
+		if (!monitors)
 			return -ENOMEM;
 
 		memset(chip->comm_page->monitors, ECHOGAIN_MUTED,
diff --git a/sound/pci/echoaudio/mia.c b/sound/pci/echoaudio/mia.c
index f3b9b45..021b926 100644
--- a/sound/pci/echoaudio/mia.c
+++ b/sound/pci/echoaudio/mia.c
@@ -61,7 +61,7 @@
 #include <sound/asoundef.h>
 #include <sound/initval.h>
 #include <sound/rawmidi.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/midi.c b/sound/pci/echoaudio/midi.c
index 77bf2a8..837d239 100644
--- a/sound/pci/echoaudio/midi.c
+++ b/sound/pci/echoaudio/midi.c
@@ -66,7 +66,7 @@ static int write_midi(struct echoaudio *chip, u8 *data, int bytes)
 		return -EIO;
 
 	/* HF4 indicates that it is safe to write MIDI output data */
-	if (! (get_dsp_register(chip, CHI32_STATUS_REG) & CHI32_STATUS_REG_HF4))
+	if (!(get_dsp_register(chip, CHI32_STATUS_REG) & CHI32_STATUS_REG_HF4))
 		return 0;
 
 	chip->comm_page->midi_output[0] = bytes;
diff --git a/sound/pci/echoaudio/mona.c b/sound/pci/echoaudio/mona.c
index b05bad9..ead9ed4 100644
--- a/sound/pci/echoaudio/mona.c
+++ b/sound/pci/echoaudio/mona.c
@@ -59,7 +59,7 @@
 #include <sound/pcm_params.h>
 #include <sound/asoundef.h>
 #include <sound/initval.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/atomic.h>
 #include "echoaudio.h"
 
diff --git a/sound/pci/echoaudio/mona_dsp.c b/sound/pci/echoaudio/mona_dsp.c
index eaa619b..dc99bc0 100644
--- a/sound/pci/echoaudio/mona_dsp.c
+++ b/sound/pci/echoaudio/mona_dsp.c
@@ -114,7 +114,7 @@ static u32 detect_input_clocks(const struct echoaudio *chip)
 
 
 
-/* Mona has an ASIC on the PCI card and another ASIC in the external box; 
+/* Mona has an ASIC on the PCI card and another ASIC in the external box;
 both need to be loaded. */
 static int load_asic(struct echoaudio *chip)
 {
