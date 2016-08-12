From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 06/17] ASoC: Intel: atom: enable configuration
	of SSP0
Date: Fri, 12 Aug 2016 16:27:49 -0500
Message-ID: <1471037280-17433-7-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 9861A26600E
 for <alsa-devel@alsa-project.org>; Fri, 12 Aug 2016 23:28:47 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Existing code used SSP2, make selection of SSP id
dependent on port name. This is required when the
machine driver uses non-default settings

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 28eea12..0838478 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -935,17 +935,26 @@ void sst_fill_ssp_defaults(struct snd_soc_dai *dai)
 int send_ssp_cmd(struct snd_soc_dai *dai, const char *id, bool enable)
 {
 	struct sst_data *drv = snd_soc_dai_get_drvdata(dai);
-	const struct sst_ssp_config *config;
+	int ssp_id;
 
 	dev_info(dai->dev, "Enter: enable=%d port_name=%s\n", enable, id);
 
+	if (strcmp(id, "ssp0-port") == 0)
+		ssp_id = SSP_MODEM;
+	else if (strcmp(id, "ssp2-port") == 0)
+		ssp_id = SSP_CODEC;
+	else {
+		dev_dbg(dai->dev, "port %s is not supported\n", id);
+		return -1;
+	}
+
 	SST_FILL_DEFAULT_DESTINATION(drv->ssp_cmd.header.dst);
 	drv->ssp_cmd.header.command_id = SBA_HW_SET_SSP;
 	drv->ssp_cmd.header.length = sizeof(struct sst_cmd_sba_hw_set_ssp)
 				- sizeof(struct sst_dsp_header);
 
-	config = &sst_ssp_configs;
-	dev_dbg(dai->dev, "ssp_id: %u\n", config->ssp_id);
+	drv->ssp_cmd.selection = ssp_id;
+	dev_dbg(dai->dev, "ssp_id: %u\n", ssp_id);
 
 	if (enable)
 		drv->ssp_cmd.switch_state = SST_SWITCH_ON;
-- 
2.5.0
