From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: cmd: Add missing newline to debug message" to the asoc tree
Date: Thu, 05 Jul 2018 11:08:37 +0100
Message-ID: <E1fb1Bl-0002uj-Pe@debutante>
References: <20180705022004.24524-1-jiada_wang@mentor.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180705022004.24524-1-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Jiada Wang <jiada_wang@mentor.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.comkuninori.morimoto.gx@renesas.comjiada_wang@mentor.com, keescook@chromium.org, andrew_gabbasov@mentor.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: cmd: Add missing newline to debug message

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

>From 74b37e299f038c910dc728d736e3f071ba0ead2a Mon Sep 17 00:00:00 2001
From: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Date: Thu, 5 Jul 2018 11:20:04 +0900
Subject: [PATCH] ASoC: rsnd: cmd: Add missing newline to debug message

To comply with the style of all kernel messages, add newline
to the end of every message.

Fixes: 70fb10529f61 ("ASoC: rsnd: add MIX (Mixer) support")
Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/cmd.c b/sound/soc/sh/rcar/cmd.c
index d8043ad33540..cc191cd5fb82 100644
--- a/sound/soc/sh/rcar/cmd.c
+++ b/sound/soc/sh/rcar/cmd.c
@@ -86,7 +86,7 @@ static int rsnd_cmd_init(struct rsnd_mod *mod,
 			cmd_case[rsnd_mod_id(src)] << 16;
 	}
 
-	dev_dbg(dev, "ctu/mix path = 0x%08x", data);
+	dev_dbg(dev, "ctu/mix path = 0x%08x\n", data);
 
 	rsnd_mod_write(mod, CMD_ROUTE_SLCT, data);
 	rsnd_mod_write(mod, CMD_BUSIF_MODE, rsnd_get_busif_shift(io, mod) | 1);
-- 
2.18.0.rc2
