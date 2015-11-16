From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Add struct dmi_system_id
	"Google Edgar" for Chrome OS" to the asoc tree
Date: Mon, 16 Nov 2015 17:51:48 +0000
Message-ID: <E1ZyNwS-0006o9-PI@debutante>
References: <1447226728-14648-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 96B5B2604E4
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:55 +0100 (CET)
In-Reply-To: <1447226728-14648-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Add struct dmi_system_id "Google Edgar" for Chrome OS

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

>From 0580bcc91d0aee7367c001955234d71b0b337b41 Mon Sep 17 00:00:00 2001
From: John Lin <john.lin@realtek.com>
Date: Wed, 11 Nov 2015 15:25:28 +0800
Subject: [PATCH] ASoC: rt5645: Add struct dmi_system_id "Google Edgar" for
 Chrome OS

Add platform specific data for Edgar project.

Signed-off-by: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index fa8b5dfa673e..647b594ad04e 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3378,6 +3378,13 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Reks"),
 		},
 	},
+	{
+		.ident = "Google Edgar",
+		.callback = strago_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_NAME, "Edgar"),
+		},
+	},
 	{ }
 };
 
-- 
2.6.2
