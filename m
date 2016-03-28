From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: cs47l24: Fix a couple of small
	whitespace errors
Date: Mon, 28 Mar 2016 14:29:23 +0100
Message-ID: <1459171764-29921-3-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0a-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id E709F2670C7
 for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2016 15:29:20 +0200 (CEST)
In-Reply-To: <1459171764-29921-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 576087b..383700a 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -1157,6 +1157,7 @@ static struct snd_compr_ops cs47l24_compr_ops = {
 static struct snd_soc_platform_driver cs47l24_compr_platform = {
 	.compr_ops = &cs47l24_compr_ops,
 };
+
 static int cs47l24_probe(struct platform_device *pdev)
 {
 	struct arizona *arizona = dev_get_drvdata(pdev->dev.parent);
@@ -1225,9 +1226,9 @@ static int cs47l24_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to register platform: %d\n", ret);
 		return ret;
 	}
+
 	ret = snd_soc_register_codec(&pdev->dev, &soc_codec_dev_cs47l24,
 				      cs47l24_dai, ARRAY_SIZE(cs47l24_dai));
-
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to register codec: %d\n", ret);
 		snd_soc_unregister_platform(&pdev->dev);
-- 
2.1.4
