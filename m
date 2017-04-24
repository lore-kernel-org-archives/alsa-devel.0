From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5100: fix spelling mistake: "micropone" -> "microphone"" to the asoc tree
Date: Mon, 24 Apr 2017 19:20:45 +0100
Message-ID: <E1d2ibN-0000gR-Nt@debutante>
References: <20170422122842.8282-1-colin.king@canonical.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170422122842.8282-1-colin.king@canonical.com>
Sender: kernel-janitors-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>Linus Walleij <linus.walleij@linaro.org>, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5100: fix spelling mistake: "micropone" -> "microphone"

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

>From fd9f069d876d6a96eb0f731b1e293145352d5f4f Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Sat, 22 Apr 2017 13:28:42 +0100
Subject: [PATCH] ASoC: wm5100: fix spelling mistake: "micropone" ->
 "microphone"

Trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm5100.c b/sound/soc/codecs/wm5100.c
index 560575000cc5..138a84efdd54 100644
--- a/sound/soc/codecs/wm5100.c
+++ b/sound/soc/codecs/wm5100.c
@@ -2014,7 +2014,7 @@ static void wm5100_micd_irq(struct wm5100_priv *wm5100)
 
 	ret = regmap_read(wm5100->regmap, WM5100_MIC_DETECT_3, &val);
 	if (ret != 0) {
-		dev_err(wm5100->dev, "Failed to read micropone status: %d\n",
+		dev_err(wm5100->dev, "Failed to read microphone status: %d\n",
 			ret);
 		return;
 	}
-- 
2.11.0

