From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 3/4] ASoC: factor out soc_remove_platform()
Date: Fri,  8 Jun 2012 12:34:22 -0600
Message-ID: <1339180463-21178-3-git-send-email-swarren@wwwdotorg.org>
References: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
	by alsa0.perex.cz (Postfix) with ESMTP id E1D71103E6F
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2012 20:34:32 +0200 (CEST)
In-Reply-To: <1339180463-21178-1-git-send-email-swarren@wwwdotorg.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

From: Stephen Warren <swarren@nvidia.com>

This change simply factors out part of soc_remove_dai_link() into a
standalone function. This makes platform and CODEC removal much more
similar at the call-sites.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 sound/soc/soc-core.c |   40 ++++++++++++++++++++++++----------------
 1 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 621c5bd..a539ade 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -898,6 +898,28 @@ static int soc_bind_dai_link(struct snd_soc_card *card, int num)
 	return 0;
 }
 
+static int soc_remove_platform(struct snd_soc_platform *platform)
+{
+	int ret;
+
+	if (platform->driver->remove) {
+		ret = platform->driver->remove(platform);
+		if (ret < 0)
+			pr_err("asoc: failed to remove %s: %d\n",
+				platform->name, ret);
+	}
+
+	/* Make sure all DAPM widgets are freed */
+	snd_soc_dapm_free(&platform->dapm);
+
+	soc_cleanup_platform_debugfs(platform);
+	platform->probed = 0;
+	list_del(&platform->card_list);
+	module_put(platform->dev->driver->owner);
+
+	return 0;
+}
+
 static void soc_remove_codec(struct snd_soc_codec *codec)
 {
 	int err;
@@ -950,22 +972,8 @@ static void soc_remove_dai_link(struct snd_soc_card *card, int num, int order)
 
 	/* remove the platform */
 	if (platform && platform->probed &&
-			platform->driver->remove_order == order) {
-		if (platform->driver->remove) {
-			err = platform->driver->remove(platform);
-			if (err < 0)
-				pr_err("asoc: failed to remove %s: %d\n",
-							platform->name, err);
-		}
-
-		/* Make sure all DAPM widgets are freed */
-		snd_soc_dapm_free(&platform->dapm);
-
-		soc_cleanup_platform_debugfs(platform);
-		platform->probed = 0;
-		list_del(&platform->card_list);
-		module_put(platform->dev->driver->owner);
-	}
+			platform->driver->remove_order == order)
+		soc_remove_platform(platform);
 
 	/* remove the CODEC */
 	if (codec && codec->probed &&
-- 
1.7.0.4
