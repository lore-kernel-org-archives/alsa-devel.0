From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add dmi_system_id "Google
	Wizpig"" to the asoc tree
Date: Fri, 20 Nov 2015 18:20:27 +0000
Message-ID: <E1ZzqIN-0003vo-Mu@debutante>
References: <1447993559-32245-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C4B266695
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 19:20:33 +0100 (CET)
In-Reply-To: <1447993559-32245-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add dmi_system_id "Google Wizpig"

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

>From 3f58b7039c70f1d0a19157c7bf97ef69d445565f Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Fri, 20 Nov 2015 12:25:59 +0800
Subject: [PATCH] ASoC: rt5645: Add dmi_system_id "Google Wizpig"

Add platform specific data for Wizpig project.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 647b594ad04e..5af90234d453 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3385,6 +3385,13 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Edgar"),
 		},
 	},
+	{
+		.ident = "Google Wizpig",
+		.callback = strago_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Wizpig"),
+		},
+	},
 	{ }
 };
 
-- 
2.6.2
