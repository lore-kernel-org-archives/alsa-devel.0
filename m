From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/3] ALSA: hdspm - Simplify with
	snd_pcm_hw_constraint_pow2()
Date: Mon, 15 Aug 2011 11:24:20 +0200
Message-ID: <1313400260-15203-3-git-send-email-tiwai@suse.de>
References: <s5h62lz6njt.wl%tiwai@suse.de>
	<1313400260-15203-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 52A7B24571
	for <alsa-devel@alsa-project.org>;
	Mon, 15 Aug 2011 11:24:46 +0200 (CEST)
In-Reply-To: <1313400260-15203-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Refactoring the code using snd_pcm_hw_constraint_pow2() helper function.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/rme9652/hdspm.c |   76 +++++++++++++++------------------------------
 1 files changed, 25 insertions(+), 51 deletions(-)

diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 4add485..214110d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -5705,19 +5705,6 @@ static int snd_hdspm_prepare(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static unsigned int period_sizes_old[] = {
-	64, 128, 256, 512, 1024, 2048, 4096, 8192
-};
-
-static unsigned int period_sizes_new[] = {
-	64, 128, 256, 512, 1024, 2048, 4096, 32
-};
-
-/* RayDAT and AIO always have a buffer of 16384 samples per channel */
-static unsigned int raydat_aio_buffer_sizes[] = {
-	16384
-};
-
 static struct snd_pcm_hardware snd_hdspm_playback_subinfo = {
 	.info = (SNDRV_PCM_INFO_MMAP |
 		 SNDRV_PCM_INFO_MMAP_VALID |
@@ -5768,24 +5755,6 @@ static struct snd_pcm_hardware snd_hdspm_capture_subinfo = {
 	.fifo_size = 0
 };
 
-static struct snd_pcm_hw_constraint_list hw_constraints_period_sizes_old = {
-	.count = ARRAY_SIZE(period_sizes_old),
-	.list = period_sizes_old,
-	.mask = 0
-};
-
-static struct snd_pcm_hw_constraint_list hw_constraints_period_sizes_new = {
-	.count = ARRAY_SIZE(period_sizes_new),
-	.list = period_sizes_new,
-	.mask = 0
-};
-
-static struct snd_pcm_hw_constraint_list hw_constraints_raydat_io_buffer = {
-	.count = ARRAY_SIZE(raydat_aio_buffer_sizes),
-	.list = raydat_aio_buffer_sizes,
-	.mask = 0
-};
-
 static int snd_hdspm_hw_rule_in_channels_rate(struct snd_pcm_hw_params *params,
 					   struct snd_pcm_hw_rule *rule)
 {
@@ -5986,23 +5955,25 @@ static int snd_hdspm_playback_open(struct snd_pcm_substream *substream)
 	spin_unlock_irq(&hdspm->lock);
 
 	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
 
 	switch (hdspm->io_type) {
 	case AIO:
 	case RayDAT:
-		snd_pcm_hw_constraint_list(runtime, 0,
-				SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-				&hw_constraints_period_sizes_new);
-		snd_pcm_hw_constraint_list(runtime, 0,
-				SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-				&hw_constraints_raydat_io_buffer);
-
+		snd_pcm_hw_constraint_minmax(runtime,
+					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					     32, 4096);
+		/* RayDAT & AIO have a fixed buffer of 16384 samples per channel */
+		snd_pcm_hw_constraint_minmax(runtime,
+					     SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					     16384, 16384);
 		break;
 
 	default:
-		snd_pcm_hw_constraint_list(runtime, 0,
-				SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-				&hw_constraints_period_sizes_old);
+		snd_pcm_hw_constraint_minmax(runtime,
+					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					     64, 8192);
+		break;
 	}
 
 	if (AES32 == hdspm->io_type) {
@@ -6059,21 +6030,24 @@ static int snd_hdspm_capture_open(struct snd_pcm_substream *substream)
 	spin_unlock_irq(&hdspm->lock);
 
 	snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24);
+	snd_pcm_hw_constraint_pow2(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE);
+
 	switch (hdspm->io_type) {
 	case AIO:
 	case RayDAT:
-	  snd_pcm_hw_constraint_list(runtime, 0,
-				     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-				     &hw_constraints_period_sizes_new);
-	  snd_pcm_hw_constraint_list(runtime, 0,
-				     SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
-				     &hw_constraints_raydat_io_buffer);
-	  break;
+		snd_pcm_hw_constraint_minmax(runtime,
+					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					     32, 4096);
+		snd_pcm_hw_constraint_minmax(runtime,
+					     SNDRV_PCM_HW_PARAM_BUFFER_SIZE,
+					     16384, 16384);
+		break;
 
 	default:
-	  snd_pcm_hw_constraint_list(runtime, 0,
-				     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
-				     &hw_constraints_period_sizes_old);
+		snd_pcm_hw_constraint_minmax(runtime,
+					     SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
+					     64, 8192);
+		break;
 	}
 
 	if (AES32 == hdspm->io_type) {
-- 
1.7.6
