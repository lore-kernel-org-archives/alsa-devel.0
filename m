From: "Ash Willis" <ashwillis@programmer.net>
Subject: [PATCH 1/2] Add SB_HW_CS5530 to the SB code
Date: Wed, 23 May 2007 15:49:33 -0500
Message-ID: <20070523204933.2B67C1158CC@ws1-7.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id CB1712467C
	for <alsa-devel@alsa-project.org>;
	Wed, 23 May 2007 22:49:39 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	CDE331800D82
	for <alsa-devel@alsa-project.org>; Wed, 23 May 2007 20:49:54 +0000 (GMT)
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Add support for the Cyrix/NatSemi Geode SC5530 chips.
This driver is ported from oss/kahlua.c and is made up of two patches.

Patch 1/2 adds some stuff to the SB layer to allow for some hardware quirks and
is to be applied to alsa-kernel.
Patch 2/2 adds the actual driver code to be applied to alsa-driver.
Patch 2 depends on patch 1.

Signed off by: Ash Willis <ashwillis@programmer.net>

---

summary:     Add SB_HW_CS5530 to the SB code

diff -r 45179b325c8e -r b8441e56e853 include/sb.h
--- a/include/sb.h	Wed May 23 16:27:32 2007 +0200
+++ b/include/sb.h	Thu May 24 03:09:49 2007 +0100
@@ -38,6 +38,7 @@ enum sb_hw_type {
 	SB_HW_ALS100,		/* Avance Logic ALS100 chip */
 	SB_HW_ALS4000,		/* Avance Logic ALS4000 chip */
 	SB_HW_DT019X,		/* Diamond Tech. DT-019X / Avance Logic ALS-007 */
+	SB_HW_CS5530,		/* Cyrix/NatSemi 5530 VSA1 */
 };
 
 #define SB_OPEN_PCM			0x01
diff -r 45179b325c8e -r b8441e56e853 isa/sb/sb16_main.c
--- a/isa/sb/sb16_main.c	Wed May 23 16:27:32 2007 +0200
+++ b/isa/sb/sb16_main.c	Thu May 24 03:09:49 2007 +0100
@@ -563,6 +563,11 @@ static int snd_sb16_playback_open(struct
       __open_ok:
 	if (chip->hardware == SB_HW_ALS100)
 		runtime->hw.rate_max = 48000;
+	if (chip->hardware == SB_HW_CS5530) {
+		runtime->hw.buffer_bytes_max = 32 * 1024;
+		runtime->hw.periods_min = 2;
+		runtime->hw.rate_min = 44100;
+	}
 	if (chip->mode & SB_RATE_LOCK)
 		runtime->hw.rate_min = runtime->hw.rate_max = chip->locked_rate;
 	chip->playback_substream = substream;
@@ -633,6 +638,11 @@ static int snd_sb16_capture_open(struct 
       __open_ok:
 	if (chip->hardware == SB_HW_ALS100)
 		runtime->hw.rate_max = 48000;
+	if (chip->hardware == SB_HW_CS5530) {
+		runtime->hw.buffer_bytes_max = 32 * 1024;
+		runtime->hw.periods_min = 2;
+		runtime->hw.rate_min = 44100;
+	}
 	if (chip->mode & SB_RATE_LOCK)
 		runtime->hw.rate_min = runtime->hw.rate_max = chip->locked_rate;
 	chip->capture_substream = substream;
diff -r 45179b325c8e -r b8441e56e853 isa/sb/sb_common.c
--- a/isa/sb/sb_common.c	Wed May 23 16:27:32 2007 +0200
+++ b/isa/sb/sb_common.c	Thu May 24 03:09:49 2007 +0100
@@ -128,7 +128,7 @@ static int snd_sbdsp_probe(struct snd_sb
 	minor = version & 0xff;
 	snd_printdd("SB [0x%lx]: DSP chip found, version = %i.%i\n",
 		    chip->port, major, minor);
-	
+
 	switch (chip->hardware) {
 	case SB_HW_AUTO:
 		switch (major) {
@@ -167,6 +167,9 @@ static int snd_sbdsp_probe(struct snd_sb
 		break;
 	case SB_HW_DT019X:
 		str = "(DT019X/ALS007)";
+		break;
+	case SB_HW_CS5530:
+		str = "16 (CS5530)";
 		break;
 	default:
 		return -ENODEV;
diff -r 45179b325c8e -r b8441e56e853 isa/sb/sb_mixer.c
--- a/isa/sb/sb_mixer.c	Wed May 23 16:27:32 2007 +0200
+++ b/isa/sb/sb_mixer.c	Thu May 24 03:09:49 2007 +0100
@@ -821,6 +821,7 @@ int snd_sbmixer_new(struct snd_sb *chip)
 		break;
 	case SB_HW_16:
 	case SB_HW_ALS100:
+	case SB_HW_CS5530:
 		if ((err = snd_sbmixer_init(chip,
 					    snd_sb16_controls,
 					    ARRAY_SIZE(snd_sb16_controls),
@@ -950,6 +951,7 @@ void snd_sbmixer_suspend(struct snd_sb *
 		break;
 	case SB_HW_16:
 	case SB_HW_ALS100:
+	case SB_HW_CS5530:
 		save_mixer(chip, sb16_saved_regs, ARRAY_SIZE(sb16_saved_regs));
 		break;
 	case SB_HW_ALS4000:
@@ -975,6 +977,7 @@ void snd_sbmixer_resume(struct snd_sb *c
 		break;
 	case SB_HW_16:
 	case SB_HW_ALS100:
+	case SB_HW_CS5530:
 		restore_mixer(chip, sb16_saved_regs, ARRAY_SIZE(sb16_saved_regs));
 		break;
 	case SB_HW_ALS4000:




=
