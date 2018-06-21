From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ASoC: Intel: common: fix missing rename from
	'reef' to 'sof'
Date: Thu, 21 Jun 2018 15:47:35 -0500
Message-ID: <20180621204735.6825-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 6309F267610
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 22:47:39 +0200 (CEST)
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
Cc: tiwai@suse.de, KCHSU0@nuvoton.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

Somehow I missed the Nau8824 support which was added in 4.17. Oops

Fixes: 4f722a6a736 ("ASoC: Intel: common: rename 'reef' to 'sof' in ACPI matching table")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-cht-match.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-cht-match.c b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
index 3c3f2f8585d7..91bb99b69601 100644
--- a/sound/soc/intel/common/soc-acpi-intel-cht-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-cht-match.c
@@ -122,8 +122,8 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_cherrytrail_machines[] = {
 		.drv_name = "cht-bsw-nau8824",
 		.fw_filename = "intel/fw_sst_22a8.bin",
 		.board = "cht-bsw",
-		.sof_fw_filename = "intel/reef-cht.ri",
-		.sof_tplg_filename = "intel/reef-cht-nau8824.tplg",
+		.sof_fw_filename = "intel/sof-cht.ri",
+		.sof_tplg_filename = "intel/sof-cht-nau8824.tplg",
 		.asoc_plat_name = "sst-mfld-platform",
 	},
 	{
-- 
2.14.1
