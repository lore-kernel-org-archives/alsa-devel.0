From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/5] ASoC: Intel: Skylake: reduce machine name
	for skl_nau88l25_ssm4567
Date: Wed, 13 Jul 2016 22:13:43 +0530
Message-ID: <1468428227-8239-2-git-send-email-vinod.koul@intel.com>
References: <1468428227-8239-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3471C265546
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 18:36:39 +0200 (CEST)
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

The platform device id table expects names to be less that
20chars, so truncate the name in skl id table and
skl_nau88l25_ssm4567 machine.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 4 ++--
 sound/soc/intel/skylake/skl.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 22f2e9d84e72..3e67d7b31e28 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -711,7 +711,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
-		.name = "skl_nau88l25_ssm4567_i2s",
+		.name = "skl_n88l25_s4567",
 		.pm = &snd_soc_pm_ops,
 	},
 };
@@ -726,4 +726,4 @@ MODULE_AUTHOR("Sathya Prakash M R <sathya.prakash.m.r@intel.com>");
 MODULE_AUTHOR("Yong Zhi <yong.zhi@intel.com>");
 MODULE_DESCRIPTION("Intel Audio Machine driver for SKL with NAU88L25 and SSM4567 in I2S Mode");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:skl_nau88l25_ssm4567_i2s");
+MODULE_ALIAS("platform:skl_n88l25_s4567");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 4e30effc5469..0c46ee5f31db 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -801,7 +801,7 @@ static void skl_remove(struct pci_dev *pci)
 
 static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
-	{ "INT343B", "skl_nau88l25_ssm4567_i2s", "intel/dsp_fw_release.bin",
+	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
 	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
-- 
1.9.1
