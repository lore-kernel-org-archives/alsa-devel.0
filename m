From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt286: set combo jack for Skylake" to
	the asoc tree
Date: Tue, 17 Nov 2015 18:54:49 +0000
Message-ID: <E1ZylOz-00042C-FW@debutante>
References: <1447739253-22166-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7AF62652E9
 for <alsa-devel@alsa-project.org>; Tue, 17 Nov 2015 19:54:55 +0100 (CET)
In-Reply-To: <1447739253-22166-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt286: set combo jack for Skylake

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

>From 166765ea8b686c64b590fa62664a4adb35aa2d6a Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 17 Nov 2015 11:17:33 +0530
Subject: [PATCH] ASoC: rt286: set combo jack for Skylake

Skylake platform also uses combo jack configuration, so add
Skylake to existing DMI match for combo jack

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt286.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index af2ed774b552..bc08f0c5a5f6 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1114,6 +1114,12 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Wilson Beach SDS")
 		}
 	},
+	{
+		.ident = "Intel Skylake RVP",
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Skylake Client platform")
+		}
+	},
 	{ }
 };
 
-- 
2.6.2
