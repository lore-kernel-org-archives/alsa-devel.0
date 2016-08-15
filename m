From: Mark Brown <broonie@kernel.org>
Subject: Applied "AsoC: Intel: Add quirks for MinnowBoard MAX"
	to the asoc tree
Date: Mon, 15 Aug 2016 15:15:39 +0100
Message-ID: <E1bZIfz-0007HV-Df@debutante>
References: <1471037280-17433-16-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D1057267860
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:15:45 +0200 (CEST)
In-Reply-To: <1471037280-17433-16-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   AsoC: Intel: Add quirks for MinnowBoard MAX

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

>From 0565e773c272038dc917dde9ed3fb53f72692685 Mon Sep 17 00:00:00 2001
From: Irina Tirdea <irina.tirdea@intel.com>
Date: Fri, 12 Aug 2016 16:27:58 -0500
Subject: [PATCH] AsoC: Intel: Add quirks for MinnowBoard MAX

I2S MCLK has been routed to LSE connector on the MinnowBoard
starting with HW version 3. Older versions of the board do
not have MCLK wired.

Add dmi quirk to disable MCLK for MinnowBoard MAX (v2).

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 11e11c6caa89..230fc2333434 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -330,6 +330,15 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 		.driver_data = (unsigned long *)(BYT_RT5640_IN1_MAP |
 						 BYT_RT5640_MCLK_EN),
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Circuitco"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Minnowboard Max B3 PLATFORM"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_DMIC1_MAP |
+						 BYT_RT5640_DMIC_EN),
+	},
 	{}
 };
 
-- 
2.8.1
