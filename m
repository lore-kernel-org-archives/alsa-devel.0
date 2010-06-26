From: David Dillow <dave@thedillows.org>
Subject: [PATCH] sis7019: fix capture issues with multiple
 periods per buffer
Date: Sat, 26 Jun 2010 18:04:32 -0400
Message-ID: <1277589872.2438.5.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id BE47C2453F
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 00:04:45 +0200 (CEST)
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
Cc: tiwai@suse.de, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

When using a timing voice to clock out periods during capture, the
driver would slowly loose synchronization and never catch up, eventually
reaching a point where it no longer generated interrupts. To avoid
this situation, the virtual period clocking was changed to shorten the
next timing period when our timing voice falls too far behind the
capture voice. In addition, the first virtual period for the timing
voice was slightly too short, causing the timing voice to initially be
ahead of the capture voice.
    
While tracking down this problem, I noticed that the expected sample
offset was being incorrectly initialized, causing an overrun to be
incorrectly reported when the timing voice happened to be perfectly
synchronized.
    
Reported-by: Hans Schou <linux@schou.dk>
Signed-off-by: Dave Dillow <dave@thedillows.org>
---
This has survived overnight testing at 44.1 kHz/16 bit/mono without issue.

diff --git a/sound/pci/sis7019.c b/sound/pci/sis7019.c
index 9cc1b5a..614ff6e 100644
--- a/sound/pci/sis7019.c
+++ b/sound/pci/sis7019.c
@@ -264,11 +264,13 @@ static void sis_update_voice(struct voice *voice)
 		 * if using small periods.
 		 *
 		 * If we're less than 9 samples behind, we're on target.
+		 * Otherwise, shorten the next vperiod by the amount we've
+		 * been delayed.
 		 */
 		if (sync > -9)
 			voice->vperiod = voice->sync_period_size + 1;
 		else
-			voice->vperiod = voice->sync_period_size - 4;
+			voice->vperiod = voice->sync_period_size + sync + 10;
 
 		if (voice->vperiod < voice->buffer_size) {
 			sis_update_sso(voice, voice->vperiod);
@@ -736,7 +738,7 @@ static void sis_prepare_timing_voice(struct voice *voice,
 	period_size = buffer_size;
 
 	/* Initially, we want to interrupt just a bit behind the end of
-	 * the period we're clocking out. 10 samples seems to give a good
+	 * the period we're clocking out. 12 samples seems to give a good
 	 * delay.
 	 *
 	 * We want to spread our interrupts throughout the virtual period,
@@ -747,7 +749,7 @@ static void sis_prepare_timing_voice(struct voice *voice,
 	 *
 	 * This is all moot if we don't need to use virtual periods.
 	 */
-	vperiod = runtime->period_size + 10;
+	vperiod = runtime->period_size + 12;
 	if (vperiod > period_size) {
 		u16 tail = vperiod % period_size;
 		u16 quarter_period = period_size / 4;
@@ -776,7 +778,7 @@ static void sis_prepare_timing_voice(struct voice *voice,
 	 */
 	timing->flags |= VOICE_SYNC_TIMING;
 	timing->sync_base = voice->ctrl_base;
-	timing->sync_cso = runtime->period_size - 1;
+	timing->sync_cso = runtime->period_size;
 	timing->sync_period_size = runtime->period_size;
 	timing->sync_buffer_size = runtime->buffer_size;
 	timing->period_size = period_size;
