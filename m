From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 24/28] ASoC: intel: sst: drop owner assignment from platform_drivers
Date: Sun, 21 Dec 2014 22:14:45 +0100
Message-ID: <1419196495-9626-25-git-send-email-wsa@the-dreams.de>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This platform_driver does not need to set an owner, it will be populated by the
driver core.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
Generated with coccinelle. SmPL file is in the introductory msg. The big
cleanup was pulled in this merge window. This series catches the bits fallen
through. The patches shall go in via the subsystem trees.

 sound/soc/intel/sst/sst_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/sst/sst_acpi.c b/sound/soc/intel/sst/sst_acpi.c
index 3abc29e8a928..f1180ffdc393 100644
--- a/sound/soc/intel/sst/sst_acpi.c
+++ b/sound/soc/intel/sst/sst_acpi.c
@@ -366,7 +366,6 @@ MODULE_DEVICE_TABLE(acpi, sst_acpi_ids);
 static struct platform_driver sst_acpi_driver = {
 	.driver = {
 		.name			= "intel_sst_acpi",
-		.owner			= THIS_MODULE,
 		.acpi_match_table	= ACPI_PTR(sst_acpi_ids),
 		.pm			= &intel_sst_pm,
 	},
-- 
2.1.3
