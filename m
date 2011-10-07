From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Suppress early calls to
	snd_soc_dapm_sync()
Date: Fri,  7 Oct 2011 14:34:02 +0100
Message-ID: <1317994442-21459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E6AC8246B5
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Oct 2011 15:34:06 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Ensure we only have one sync during the initial startup of the card by
making snd_soc_dapm_sync() a noop on non-instantiated cards. This avoids
any bounces due to things like jacks reporting their initial state on
partially initialised cards. The callers that don't also get called at
runtime should just be removed.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    1 +
 sound/soc/soc-dapm.c |    7 +++++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2a25076..b65e3d4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1498,6 +1498,7 @@ static void snd_soc_instantiate_card(struct snd_soc_card *card)
 #endif
 
 	card->instantiated = 1;
+	snd_soc_dapm_sync(&card->dapm);
 	mutex_unlock(&card->mutex);
 	return;
 
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8711aab..e49c56d 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1845,6 +1845,13 @@ static int snd_soc_dapm_set_pin(struct snd_soc_dapm_context *dapm,
  */
 int snd_soc_dapm_sync(struct snd_soc_dapm_context *dapm)
 {
+	/*
+	 * Suppress early reports (eg, jacks syncing their state) to avoid
+	 * silly DAPM runs during card startup.
+	 */
+	if (!dapm->card || !dapm->card->instantiated)
+		return 0;
+
 	return dapm_power_widgets(dapm, SND_SOC_DAPM_STREAM_NOP);
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_sync);
-- 
1.7.6.3
