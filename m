From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 3/4] ASoC: Intel: Use
	devm_snd_soc_unregister_card
Date: Mon, 26 May 2014 16:56:32 +0300
Message-ID: <1401112593-2852-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1401112593-2852-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3BA2D26522D
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:56:55 +0200 (CEST)
In-Reply-To: <1401112593-2852-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Simplify byt-rt5640.c and haswell.c machine drivers by using
devm_snd_soc_unregister_card(). Remove also needless dev_set_drvdata()
from byt_rt5640_probe() since snd_soc_register_card() does it too.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 14 +-------------
 sound/soc/intel/haswell.c    |  9 +--------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index dbc63d09f424..eac6566f42e6 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -152,25 +152,13 @@ static const struct dev_pm_ops byt_rt5640_pm_ops = {
 static int byt_rt5640_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &byt_rt5640_card;
-	struct device *dev = &pdev->dev;
 
 	card->dev = &pdev->dev;
-	dev_set_drvdata(dev, card);
-	return snd_soc_register_card(card);
-}
-
-static int byt_rt5640_remove(struct platform_device *pdev)
-{
-	struct snd_soc_card *card = platform_get_drvdata(pdev);
-
-	snd_soc_unregister_card(card);
-
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, card);
 }
 
 static struct platform_driver byt_rt5640_audio = {
 	.probe = byt_rt5640_probe,
-	.remove = byt_rt5640_remove,
 	.driver = {
 		.name = "byt-rt5640",
 		.owner = THIS_MODULE,
diff --git a/sound/soc/intel/haswell.c b/sound/soc/intel/haswell.c
index 54345a2a7386..6faa8de24f24 100644
--- a/sound/soc/intel/haswell.c
+++ b/sound/soc/intel/haswell.c
@@ -208,18 +208,11 @@ static int haswell_audio_probe(struct platform_device *pdev)
 {
 	haswell_rt5640.dev = &pdev->dev;
 
-	return snd_soc_register_card(&haswell_rt5640);
-}
-
-static int haswell_audio_remove(struct platform_device *pdev)
-{
-	snd_soc_unregister_card(&haswell_rt5640);
-	return 0;
+	return devm_snd_soc_register_card(&pdev->dev, &haswell_rt5640);
 }
 
 static struct platform_driver haswell_audio = {
 	.probe = haswell_audio_probe,
-	.remove = haswell_audio_remove,
 	.driver = {
 		.name = "haswell-audio",
 		.owner = THIS_MODULE,
-- 
2.0.0.rc2
