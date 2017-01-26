From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/17] ASoC: Intel: Atom: add machine driver
	for baytrail-rt5645 hardware
Date: Thu, 26 Jan 2017 14:09:39 -0600
Message-ID: <1485461385-14544-12-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 40099267774
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:27 +0100 (CET)
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

Use machine driver initially defined for CherryTrail

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 4cf95e7..8cc30df 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -480,6 +480,12 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
 						&byt_rvp_platform_data },
+	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
+	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
+						&byt_rvp_platform_data },
+	{"10EC5648", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
+						&byt_rvp_platform_data },
+
 	{},
 };
 
-- 
2.7.4
