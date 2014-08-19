From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 03/13] ASoC: Make rtd->codec optional
Date: Tue, 19 Aug 2014 15:51:20 +0200
Message-ID: <1408456290-13945-4-git-send-email-lars@metafoo.de>
References: <1408456290-13945-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-165.synserver.de (smtp-out-165.synserver.de
 [212.40.185.165])
 by alsa0.perex.cz (Postfix) with ESMTP id AD07D265676
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:51:41 +0200 (CEST)
In-Reply-To: <1408456290-13945-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

There are some place in the ASoC core that expect rtd->codec to be non NULL
(mainly CODEC specific sysfs files). With componentization going forward
rtd->codec might be NULL in some cases. This patch prepares the core for this by
not registering CODEC specific sysfs files if rtd->codec is NULL. sysfs file
removal does not need to be conditionalized as it handles the removal of
non-existing files just fine.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index abc1a05..1e0d212 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1261,17 +1261,21 @@ static int soc_post_component_init(struct snd_soc_pcm_runtime *rtd,
 	}
 	rtd->dev_registered = 1;
 
-	/* add DAPM sysfs entries for this codec */
-	ret = snd_soc_dapm_sys_add(rtd->dev);
-	if (ret < 0)
-		dev_err(rtd->dev,
-			"ASoC: failed to add codec dapm sysfs entries: %d\n", ret);
+	if (rtd->codec) {
+		/* add DAPM sysfs entries for this codec */
+		ret = snd_soc_dapm_sys_add(rtd->dev);
+		if (ret < 0)
+			dev_err(rtd->dev,
+				"ASoC: failed to add codec dapm sysfs entries: %d\n",
+				ret);
 
-	/* add codec sysfs entries */
-	ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
-	if (ret < 0)
-		dev_err(rtd->dev,
-			"ASoC: failed to add codec sysfs files: %d\n", ret);
+		/* add codec sysfs entries */
+		ret = device_create_file(rtd->dev, &dev_attr_codec_reg);
+		if (ret < 0)
+			dev_err(rtd->dev,
+				"ASoC: failed to add codec sysfs files: %d\n",
+				ret);
+	}
 
 	return 0;
 }
-- 
1.8.0
