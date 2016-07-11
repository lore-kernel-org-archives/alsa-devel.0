From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/4] ASoC: Intel: board: add kabylake machine id
Date: Mon, 11 Jul 2016 22:02:11 +0530
Message-ID: <1468254731-15394-5-git-send-email-vinod.koul@intel.com>
References: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 10E0C265D2B
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 18:25:14 +0200 (CEST)
In-Reply-To: <1468254731-15394-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

Kabylake platform is similar to Skylake. So, add machine id.
Since same machine driver supports both, add these in id table.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_rt286.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 426b48233fdb..88c61e8cb87f 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -505,12 +505,20 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_rt286);
 }
 
+static const struct platform_device_id skl_board_ids[] = {
+	{ .name = "skl_alc286s_i2s" },
+	{ .name = "kbl_alc286s_i2s" },
+	{ }
+};
+
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
 		.name = "skl_alc286s_i2s",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = skl_board_ids,
+
 };
 
 module_platform_driver(skylake_audio)
@@ -520,3 +528,4 @@ MODULE_AUTHOR("Omair Mohammed Abdullah <omair.m.abdullah@intel.com>");
 MODULE_DESCRIPTION("Intel SST Audio for Skylake");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:skl_alc286s_i2s");
+MODULE_ALIAS("platform:kbl_alc286s_i2s");
-- 
1.9.1
