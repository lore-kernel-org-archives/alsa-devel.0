From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 3/5] ASoC: Intel: Atom: enable BYT/CHT+DA7213
	machine driver
Date: Thu,  9 Mar 2017 18:19:00 -0600
Message-ID: <1489105142-25878-4-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1489105142-25878-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4440C267028
 for <alsa-devel@alsa-project.org>; Fri, 10 Mar 2017 01:19:11 +0100 (CET)
In-Reply-To: <1489105142-25878-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, vinod.koul@intel.com, Adam.Thomson.Opensource@diasemi.com, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Add entries in HID table and reference to bytcht_da7213 driver

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 747c0f3..b24bf08 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -480,6 +480,10 @@ static struct sst_acpi_mach sst_acpi_bytcr[] = {
 						&byt_rvp_platform_data },
 	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_0f28.bin", "bytcr_rt5651", NULL,
 						&byt_rvp_platform_data },
+	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
+						&byt_rvp_platform_data },
+	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_0f28.bin", "bytcht_da7213", NULL,
+						&byt_rvp_platform_data },
 	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
 	{"10EC5645", "cht-bsw-rt5645", "intel/fw_sst_0f28.bin", "cht-bsw", NULL,
 						&byt_rvp_platform_data },
@@ -504,6 +508,10 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
 
 	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
 						&chv_platform_data },
+	{"DLGS7212", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
+						&chv_platform_data },
+	{"DLGS7213", "bytcht_da7213", "intel/fw_sst_22a8.bin", "bytcht_da7213", NULL,
+						&chv_platform_data },
 	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
 	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
 						&chv_platform_data },
-- 
2.7.4
