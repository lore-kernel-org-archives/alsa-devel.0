From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 2/5] ASoC: Intel: Skylake: reduce machine name
	for skl_nau88l25_max98357a
Date: Wed, 13 Jul 2016 22:13:44 +0530
Message-ID: <1468428227-8239-3-git-send-email-vinod.koul@intel.com>
References: <1468428227-8239-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 25BD2265654
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 18:36:45 +0200 (CEST)
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
skl_nau88l25_max98357a machine.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 4 ++--
 sound/soc/intel/skylake/skl.c                   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index afc6f744dff1..80efe5e32291 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -659,7 +659,7 @@ static int skylake_audio_probe(struct platform_device *pdev)
 static struct platform_driver skylake_audio = {
 	.probe = skylake_audio_probe,
 	.driver = {
-		.name = "skl_nau88l25_max98357a_i2s",
+		.name = "skl_n88l25_m98357a",
 		.pm = &snd_soc_pm_ops,
 	},
 };
@@ -670,4 +670,4 @@ module_platform_driver(skylake_audio)
 MODULE_DESCRIPTION("Audio Machine driver-NAU88L25 & MAX98357A in I2S mode");
 MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:skl_nau88l25_max98357a_i2s");
+MODULE_ALIAS("platform:skl_n88l25_m98357a");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 0c46ee5f31db..9f6733d72bde 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -803,7 +803,7 @@ static struct sst_acpi_mach sst_skl_devdata[] = {
 	{ "INT343A", "skl_alc286s_i2s", "intel/dsp_fw_release.bin", NULL, NULL, NULL },
 	{ "INT343B", "skl_n88l25_s4567", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
-	{ "MX98357A", "skl_nau88l25_max98357a_i2s", "intel/dsp_fw_release.bin",
+	{ "MX98357A", "skl_n88l25_m98357a", "intel/dsp_fw_release.bin",
 				NULL, NULL, &skl_dmic_data },
 	{}
 };
-- 
1.9.1
