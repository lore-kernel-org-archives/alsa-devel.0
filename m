From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Don't call DAI registration for CODECs
	with no DAI
Date: Fri, 20 Aug 2010 14:10:11 +0100
Message-ID: <1282309811-19405-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E16612451C
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 15:10:16 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Otherwise we generate worrying (but benign) warnings for amps.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 7093c17..65352c7 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3122,10 +3122,12 @@ int snd_soc_register_codec(struct device *dev,
 		fixup_codec_formats(&dai_drv[i].capture);
 	}
 
-	/* register DAIs */
-	ret = snd_soc_register_dais(dev, dai_drv, num_dai);
-	if (ret < 0)
+	/* register any DAIs */
+	if (num_dai) {
+		ret = snd_soc_register_dais(dev, dai_drv, num_dai);
+		if (ret < 0)
 			goto error;
+	}
 
 	mutex_lock(&client_mutex);
 	list_add(&codec->list, &codec_list);
@@ -3164,8 +3166,9 @@ void snd_soc_unregister_codec(struct device *dev)
 	return;
 
 found:
-	for (i = 0; i < codec->num_dai; i++)
-		snd_soc_unregister_dai(dev);
+	if (codec->num_dai)
+		for (i = 0; i < codec->num_dai; i++)
+			snd_soc_unregister_dai(dev);
 
 	mutex_lock(&client_mutex);
 	list_del(&codec->list);
-- 
1.7.1
