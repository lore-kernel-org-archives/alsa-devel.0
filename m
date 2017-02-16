From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: Add DMI match for Geminilake
	reference platform" to the asoc tree
Date: Thu, 16 Feb 2017 19:04:00 +0000
Message-ID: <E1ceRLU-0007Q3-Aw@debutante>
References: <1486638844-17975-3-git-send-email-subhransu.s.prusty@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CFB68266D77
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 20:04:09 +0100 (CET)
In-Reply-To: <1486638844-17975-3-git-send-email-subhransu.s.prusty@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, patches.audio@intel.com, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: Add DMI match for Geminilake reference platform

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

>From 06a99ddd2049e2697de32a9435c4d5c5b5c78360 Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 9 Feb 2017 16:44:02 +0530
Subject: [PATCH] ASoC: rt298: Add DMI match for Geminilake reference platform

Geminilake reference platform also uses combo jack for audio connector
so we need to set codec pdata to use this based on DMI match for this
board.

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 7150a407ffd9..d9e96e65e1c4 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -1163,6 +1163,13 @@ static const struct dmi_system_id force_combo_jack_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Broxton P")
 		}
 	},
+	{
+		.ident = "Intel Gemini Lake",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Intel Corp"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Geminilake")
+		}
+	},
 	{ }
 };
 
-- 
2.11.0
