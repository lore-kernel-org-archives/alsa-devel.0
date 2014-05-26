From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/4] ASoC: Intel: byt-rt5640: Use card PM ops
	from core
Date: Mon, 26 May 2014 16:56:33 +0300
Message-ID: <1401112593-2852-4-git-send-email-jarkko.nikula@linux.intel.com>
References: <1401112593-2852-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 3995A26522D
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:56:58 +0200 (CEST)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Use card PM ops from ASoC core instead of defining custom PM ops here since
we are calling anyway common suspend/resume callbacks.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index eac6566f42e6..ac52c77721b1 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -138,17 +138,6 @@ static struct snd_soc_card byt_rt5640_card = {
 	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
 };
 
-#ifdef CONFIG_PM_SLEEP
-static const struct dev_pm_ops byt_rt5640_pm_ops = {
-	.suspend = snd_soc_suspend,
-	.resume = snd_soc_resume,
-};
-
-#define BYT_RT5640_PM_OPS	(&byt_rt5640_pm_ops)
-#else
-#define BYT_RT5640_PM_OPS	NULL
-#endif
-
 static int byt_rt5640_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &byt_rt5640_card;
@@ -162,7 +151,7 @@ static struct platform_driver byt_rt5640_audio = {
 	.driver = {
 		.name = "byt-rt5640",
 		.owner = THIS_MODULE,
-		.pm = BYT_RT5640_PM_OPS,
+		.pm = &snd_soc_pm_ops,
 	},
 };
 module_platform_driver(byt_rt5640_audio)
-- 
2.0.0.rc2
