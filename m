Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A2412673E8
 for <alsa-devel@alsa-project.org>; Wed, 11 Apr 2018 12:25:55 +0200 (CEST)
From: Naveen Manohar <naveen.m@intel.com>
Date: Wed, 11 Apr 2018 15:54:59 +0530
Message-Id: <1523442303-12710-2-git-send-email-naveen.m@intel.com>
In-Reply-To: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
References: <1523442303-12710-1-git-send-email-naveen.m@intel.com>
Subject: [alsa-devel] [PATCH v2 1/5] ASoC: Intel: broxton: reduce machine
	name for bxt_da7219_max98357a
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: vinod.koul@intel.com, harshapriya.n@intel.com, naveen.m@intel.com, broonie@kernel.org, pierre-louis.bossart@intel.com
List-ID: <alsa-devel@alsa-project.org>

Use truncated names in bxt id table and bxt_da7219_max98357a machine
as platform device id table expects names to be less then 20chars.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 4 ++--
 sound/soc/intel/skylake/skl.c                 | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index 668c093..ce021a3 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -586,7 +586,7 @@ static int broxton_audio_probe(struct platform_device *pdev)
 static struct platform_driver broxton_audio = {
 	.probe = broxton_audio_probe,
 	.driver = {
-		.name = "bxt_da7219_max98357a_i2s",
+		.name = "bxt_da7219_max98357a",
 		.pm = &snd_soc_pm_ops,
 	},
 };
@@ -599,4 +599,4 @@ MODULE_AUTHOR("Rohit Ainapure <rohit.m.ainapure@intel.com>");
 MODULE_AUTHOR("Harsha Priya <harshapriya.n@intel.com>");
 MODULE_AUTHOR("Conrad Cooke <conrad.cooke@intel.com>");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:bxt_da7219_max98357a_i2s");
+MODULE_ALIAS("platform:bxt_da7219_max98357a");
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index abf3247..d50c2ee 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -1086,7 +1086,7 @@ static struct snd_soc_acpi_mach sst_bxtp_devdata[] = {
 	},
 	{
 		.id = "DLGS7219",
-		.drv_name = "bxt_da7219_max98357a_i2s",
+		.drv_name = "bxt_da7219_max98357a",
 		.fw_filename = "intel/dsp_fw_bxtn.bin",
 		.machine_quirk = snd_soc_acpi_codec_list,
 		.quirk_data = &bxt_codecs,
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
