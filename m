From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: allow muxes to force a disconnect" to the asoc tree
Date: Thu, 16 May 2019 12:13:54 +0100 (BST)
Message-ID: <20190516111354.6E96D1126D48@debutante.sirena.org.uk>
References: <20190515131858.32130-3-jbrunet@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190515131858.32130-3-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: allow muxes to force a disconnect

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From c3456a4b2142550944f73a87a8f338074508b249 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 15 May 2019 15:18:55 +0200
Subject: [PATCH] ASoC: dapm: allow muxes to force a disconnect

Let soc_dapm_mux_update_power() accept NULL as 'e' enum.

It makes the code a bit more robust and, more importantly, let the calling
mux force a disconnect of the output path if necessary.

This is useful if the dapm elements following the mux must be off
while updating the mux, to avoid glitches or force a (re)configuration.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 81a7a12196ff..a4d6c068b545 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2245,7 +2245,7 @@ static int soc_dapm_mux_update_power(struct snd_soc_card *card,
 	dapm_kcontrol_for_each_path(path, kcontrol) {
 		found = 1;
 		/* we now need to match the string in the enum to the path */
-		if (!(strcmp(path->name, e->texts[mux])))
+		if (e && !(strcmp(path->name, e->texts[mux])))
 			connect = true;
 		else
 			connect = false;
-- 
2.20.1
