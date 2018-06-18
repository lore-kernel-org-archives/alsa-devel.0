From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 8/8] ASoC: Intel: common: fix copy/paste issue
	with SOF/broadwell topology file
Date: Mon, 18 Jun 2018 13:29:42 -0500
Message-ID: <20180618182942.4925-9-pierre-louis.bossart@linux.intel.com>
References: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 2444F266E91
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 20:29:52 +0200 (CEST)
In-Reply-To: <20180618182942.4925-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

There are two commercially-available Broadwell platforms based on I2S
(Dell XPS13 and 'Samus' Pixel 2015 Chromebook).

Fix a copy/paste issue to allow each platform to enable different
features if needed when SOF is enabled

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
index e0e8c8c27528..53e7acdfbb81 100644
--- a/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-hsw-bdw-match.c
@@ -45,7 +45,7 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_broadwell_machines[] = {
 		.drv_name = "bdw-rt5677",
 		.fw_filename =  "intel/IntcSST2.bin",
 		.sof_fw_filename = "intel/reef-bdw.ri",
-		.sof_tplg_filename = "intel/reef-bdw-rt286.tplg",
+		.sof_tplg_filename = "intel/reef-bdw-rt5677.tplg",
 		.asoc_plat_name = "haswell-pcm-audio",
 	},
 	{
-- 
2.14.1
