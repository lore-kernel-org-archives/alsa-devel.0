From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr-rt5651: enable MinnowBoard
	Turbot quirks" to the asoc tree
Date: Mon, 08 Jan 2018 16:23:01 +0000
Message-ID: <E1eYaCT-0002Cr-S8@debutante>
References: <20180105192023.11229-3-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 59E5B26748A
 for <alsa-devel@alsa-project.org>; Mon,  8 Jan 2018 17:23:08 +0100 (CET)
In-Reply-To: <20180105192023.11229-3-pierre-louis.bossart@linux.intel.com>
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
Cc: "Keqiao.Zhang" <Keqiao.zhang@intel.com>, alsa-devel@alsa-project.org, tiwai@suse.de, Keyon Jie <yang.jie@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, Carlo Caione <carlo@caione.org>, bardliao@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr-rt5651: enable MinnowBoard Turbot quirks

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 416f2b51119b8cdd899b226e4cf683d000797a8b Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Fri, 5 Jan 2018 13:20:20 -0600
Subject: [PATCH] ASoC: Intel: bytcr-rt5651: enable MinnowBoard Turbot quirks

Define DMI quirk for rt5651 eval board connected to MinnowBoard
Turbot. The only difference with a MinnowBoard MAX is that the MCLK
pin is enabled on the LSE connector

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Tested-by: Keqiao.Zhang <Keqiao.zhang@intel.com>
Acked-By: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5651.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index a958ed37569f..dfe6435f8ed0 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -266,6 +266,15 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
 		},
 		.driver_data = (void *)(BYT_RT5651_IN3_MAP),
 	},
+	{
+		.callback = byt_rt5651_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ADI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Turbot"),
+		},
+		.driver_data = (void *)(BYT_RT5651_MCLK_EN |
+					BYT_RT5651_IN3_MAP),
+	},
 	{
 		.callback = byt_rt5651_quirk_cb,
 		.matches = {
-- 
2.15.1
