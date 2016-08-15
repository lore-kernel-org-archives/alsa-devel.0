From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: atom: enable configuration of
	SSP0" to the asoc tree
Date: Mon, 15 Aug 2016 15:16:00 +0100
Message-ID: <E1bZIgK-0007P6-60@debutante>
References: <1471037280-17433-7-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07CE5267877
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:16:07 +0200 (CEST)
In-Reply-To: <1471037280-17433-7-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: atom: enable configuration of SSP0

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From a3f10de1843ab6a37d34d1601cc520498c5d3bc9 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 12 Aug 2016 16:27:49 -0500
Subject: [PATCH] ASoC: Intel: atom: enable configuration of SSP0

Existing code used SSP2, make selection of SSP id
dependent on port name. This is required when the
machine driver uses non-default settings

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 28eea127ec33..0838478c4c3f 100644
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
2.8.1
