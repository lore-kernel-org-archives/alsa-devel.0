From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 4/5] ASoC: Intel: board: add kabylake
	nau88l25_max98357a machine id
Date: Wed, 13 Jul 2016 22:13:46 +0530
Message-ID: <1468428227-8239-5-git-send-email-vinod.koul@intel.com>
References: <1468428227-8239-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C4312265969
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 18:36:47 +0200 (CEST)
In-Reply-To: <1468428227-8239-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Like SKL we have skl_nau88l25_max98357a machine for KBL,
so add the ID for this machine too.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 80efe5e32291..25db5be7fdfa 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -656,12 +656,19 @@ static int skylake_audio_probe(struct platform_device *pdev)
 	return devm_snd_soc_register_card(&pdev->dev, &skylake_audio_card);
 }
 
+static const struct platform_device_id skl_board_ids[] = {
+	{ .name = "skl_n88l25_m98357a" },
+	{ .name = "kbl_n88l25_m98357a" },
+	{ }
+};
+
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
 		.name = "skl_n88l25_m98357a",
 		.pm = &snd_soc_pm_ops,
 	},
+	.id_table = skl_board_ids,
 };
 
 module_platform_driver(skylake_audio)
@@ -671,3 +678,4 @@ MODULE_DESCRIPTION("Audio Machine driver-NAU88L25 & MAX98357A in I2S mode");
 MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:skl_n88l25_m98357a");
+MODULE_ALIAS("platform:kbl_n88l25_m98357a");
-- 
1.9.1
