From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda - Ignore small negative LPIB delay
	correction
Date: Fri,  6 Dec 2013 17:22:11 +0100
Message-ID: <1386346931-8357-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9432655C4
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 17:22:11 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 41B88A7CF4
 for <alsa-devel@alsa-project.org>; Fri,  6 Dec 2013 17:22:11 +0100 (CET)
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

Sometimes the hardware reports LPIB being advanced than POSBUF.
When this happens, the driver adjusts to a positive value by adding
the buffer size.  Then the driver detects it as an error (greater than
the period size), and stops the LPIB delay account from this point
on.

When I took a close look at these conditions, the values shown are all
very small numbers, and it'd be better to just ignore these values
instead of discontinuing the LPIB delay correction.

In this patch, the driver checks a negative delay value and ignores if
it's a significantly small error.  Currently the threshold is set to
64 frames, but could be smaller.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 80c5f14e8ecd..fd4f2288a33f 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -431,6 +431,8 @@ struct azx_dev {
 	struct timecounter  azx_tc;
 	struct cyclecounter azx_cc;
 
+	int delay_negative_threshold;
+
 #ifdef CONFIG_SND_HDA_DSP_LOADER
 	struct mutex dsp_mutex;
 #endif
@@ -2195,6 +2197,12 @@ static int azx_pcm_prepare(struct snd_pcm_substream *substream)
 			goto unlock;
 	}
 
+	/* when LPIB delay correction gives a small negative value,
+	 * we ignore it; currently set the threshold statically to
+	 * 64 frames
+	 */
+	azx_dev->delay_negative_threshold = -frames_to_bytes(runtime, 64);
+
 	/* wallclk has 24Mhz clock source */
 	azx_dev->period_wallclk = (((runtime->period_size * 24000) /
 						runtime->rate) * 1000);
@@ -2447,8 +2455,12 @@ static unsigned int azx_get_position(struct azx *chip,
 			delay = pos - lpib_pos;
 		else
 			delay = lpib_pos - pos;
-		if (delay < 0)
-			delay += azx_dev->bufsize;
+		if (delay < 0) {
+			if (delay >= azx_dev->delay_negative_threshold)
+				delay = 0;
+			else
+				delay += azx_dev->bufsize;
+		}
 		if (delay >= azx_dev->period_bytes) {
 			snd_printk(KERN_WARNING SFX
 				   "%s: Unstable LPIB (%d >= %d); "
-- 
1.8.5
