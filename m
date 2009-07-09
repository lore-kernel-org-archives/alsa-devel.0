From: Paul Vojta <vojta@math.berkeley.edu>
Subject: [PATCH] snd-hda-intel: fix beep tone calculation for
 IDT/STAC codecs
Date: Wed, 8 Jul 2009 23:57:46 -0700
Message-ID: <20090709065746.GA2676@math.berkeley.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out1.berkeley.edu (smtp-out1.Berkeley.EDU [128.32.61.106])
	by alsa0.perex.cz (Postfix) with ESMTP id 6D4291037F1
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jul 2009 08:57:56 +0200 (CEST)
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
List-Id: alsa-devel@alsa-project.org

In the beep tone calculation for IDT/STAC codecs, lower numbers correspond
to higher frequencies and vice versa.  The current code has this backwards,
resulting in beep frequencies which are way too high (and sound bad on
tinny laptop speakers, resulting in complaints).

Signed-off-by: Paul Vojta <vojta@math.berkeley.edu>

diff --git a/sound/pci/hda/hda_beep.c b/sound/pci/hda/hda_beep.c
index 08fe659..d559a7a 100644
--- a/sound/pci/hda/hda_beep.c
+++ b/sound/pci/hda/hda_beep.c
@@ -51,19 +51,20 @@ static void snd_hda_generate_beep(struct work_struct *work)
  * The tone frequency of beep generator on IDT/STAC codecs is
  * defined from the 8bit tone parameter, in Hz,
  *    freq = 48000 * (257 - tone) / 1024
- * that is from 12kHz to 93.75kHz in step of 46.875 hz
+ * that is from 12kHz to 93.75Hz in steps of 46.875 Hz
  */
 static int beep_linear_tone(struct hda_beep *beep, int hz)
 {
 	hz *= 1000; /* fixed point */
-	hz = hz - DIGBEEP_HZ_MIN;
+	hz = hz - DIGBEEP_HZ_MIN
+	        + DIGBEEP_HZ_STEP / 2; /* round to nearest step */
 	if (hz < 0)
 		hz = 0; /* turn off PC beep*/
 	else if (hz >= (DIGBEEP_HZ_MAX - DIGBEEP_HZ_MIN))
-		hz = 0xff;
+		hz = 1; /* max frequency */
 	else {
 		hz /= DIGBEEP_HZ_STEP;
-		hz++;
+		hz = 255 - hz;
 	}
 	return hz;
 }
