From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: dapm: Only lock CODEC for I/O if not
	using regmap
Date: Wed,  7 Mar 2012 00:03:15 +0000
Message-ID: <1331078595-6210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DFBDF10B8E6
	for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2012 01:03:17 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we do use regmap then regmap will take care of things for us. We
actually already have this check at a higher level for the current
users but this makes sure we do the right thing in the future too if
we need to.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 6f4ea12b..25a395e 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -208,7 +208,7 @@ static int soc_widget_write(struct snd_soc_dapm_widget *w, int reg, int val)
 
 static inline void soc_widget_lock(struct snd_soc_dapm_widget *w)
 {
-	if (w->codec)
+	if (w->codec && !w->codec->using_regmap)
 		mutex_lock(&w->codec->mutex);
 	else if (w->platform)
 		mutex_lock(&w->platform->mutex);
@@ -216,7 +216,7 @@ static inline void soc_widget_lock(struct snd_soc_dapm_widget *w)
 
 static inline void soc_widget_unlock(struct snd_soc_dapm_widget *w)
 {
-	if (w->codec)
+	if (w->codec && !w->codec->using_regmap)
 		mutex_unlock(&w->codec->mutex);
 	else if (w->platform)
 		mutex_unlock(&w->platform->mutex);
-- 
1.7.9.1
