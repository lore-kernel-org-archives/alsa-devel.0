From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: bytcr_rt5640: quirks for Insyde
	devices" to the asoc tree
Date: Fri, 06 Jan 2017 18:16:48 +0000
Message-ID: <E1cPZ4K-0003CM-U3@debutante>
References: <1483566293-27911-2-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 379182677FD
 for <alsa-devel@alsa-project.org>; Fri,  6 Jan 2017 19:16:55 +0100 (CET)
In-Reply-To: <1483566293-27911-2-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: youling257 <youling257@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: bytcr_rt5640: quirks for Insyde devices

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

>From 571800487837263e914ef68681e4ad6a57d49c7f Mon Sep 17 00:00:00 2001
From: youling257 <youling257@gmail.com>
Date: Wed, 4 Jan 2017 15:44:53 -0600
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: quirks for Insyde devices

There are literally dozens of Insyde devices with a different
name but with the same audio routing. Use a generic quirk to
match on vendor name only to avoid recurring edits of the
same thing.

Signed-off-by: youling257 <youling257@gmail.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 507a86a5eafe..613e5286555a 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -387,6 +387,16 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
 						 BYT_RT5640_SSP0_AIF1),
 
 	},
+	{
+		.callback = byt_rt5640_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Insyde"),
+		},
+		.driver_data = (unsigned long *)(BYT_RT5640_IN3_MAP |
+						 BYT_RT5640_MCLK_EN |
+						 BYT_RT5640_SSP0_AIF1),
+
+	},
 	{}
 };
 
-- 
2.11.0
