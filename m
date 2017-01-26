From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 02/17] ASoC: Intel: boards: remove .pm_ops in
	all Atom/DPCM machine drivers
Date: Thu, 26 Jan 2017 14:09:30 -0600
Message-ID: <1485461385-14544-3-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A6CD726779E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:21 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patch corrects an omission in bytcr_rt5640 and bytcr_rt5651.
All existing machine drivers shall not use .pm_ops to avoid a double
suspend, as initially implemented by 3f2dcbeaeb2b
("ASoC: Intel: Remove soc pm handling to allow platform driver handle it").

Reported-by: Shrirang Bagul <shrirang.bagul@canonical.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 1 -
 sound/soc/intel/boards/bytcr_rt5651.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index cae441a..5c7219f 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -866,7 +866,6 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_rt5640_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5640",
-		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_byt_rt5640_mc_probe,
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 403dbfb..3186f01 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -319,7 +319,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_rt5651_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5651",
-		.pm = &snd_soc_pm_ops,
 	},
 	.probe = snd_byt_rt5651_mc_probe,
 };
-- 
2.7.4
