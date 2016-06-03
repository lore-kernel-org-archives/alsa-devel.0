From: Pietro Di Costanzo <pxpert@gmail.com>
Subject: [PATCH] ASoC: Intel: add bytcr_rt5651 machine driver
	for Cherryview-based platforms
Date: Fri,  3 Jun 2016 17:33:05 +0200
Message-ID: <1464967985-18355-2-git-send-email-pxpert@gmail.com>
References: <1464967985-18355-1-git-send-email-pxpert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id BC2C3265554
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 17:33:16 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id n184so220400wmn.1
 for <alsa-devel@alsa-project.org>; Fri, 03 Jun 2016 08:33:16 -0700 (PDT)
In-Reply-To: <1464967985-18355-1-git-send-email-pxpert@gmail.com>
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
Cc: Pietro Di Costanzo <pxpert@gmail.com>
List-Id: alsa-devel@alsa-project.org

Some CHT-T platforms rely on RT5651 (Just like RT5640). Add bytcr_rt5651 for these platforms

Signed-off-by: Pietro Di Costanzo <pxpert@gmail.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 3bc4b63..f1b1942 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -342,10 +342,11 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 						&chv_platform_data },
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
-	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
+	/* some CHT-T platforms rely on RT5640 and RT5651, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
 						&chv_platform_data },
-
+	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_22a8.bin", "bytcr_rt5651", NULL,
+						&chv_platform_data },
 	{},
 };
 
-- 
2.7.3
