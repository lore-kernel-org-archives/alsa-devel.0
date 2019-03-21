From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Update DA7219 DAI clock name to align with codec updates" to the asoc tree
Date: Thu, 21 Mar 2019 15:07:05 +0000 (GMT)
Message-ID: <20190321150705.B71D111288EC@debutante.sirena.org.uk>
References: <3159a9ec4f79fe25219e04bafc29a842b650521c.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3159a9ec4f79fe25219e04bafc29a842b650521c.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Akshu Agrawal <Akshu.Agrawal@amd.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Update DA7219 DAI clock name to align with codec updates

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

>From 883149027a989dc121ad277785a4b4a901b7fd31 Mon Sep 17 00:00:00 2001
From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Date: Tue, 19 Mar 2019 17:49:32 +0000
Subject: [PATCH] ASoC: AMD: Update DA7219 DAI clock name to align with codec
 updates

As the DAI clocks for DA7219 have now been split into BCLK and WCLK,
the clock lookup name needs to be udpated here to select BCLK to
achieve the same functionality as before with regards to DAI clock
gating.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index a5daad973ce5..f37a588ba345 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -72,7 +72,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
+	da7219_dai_clk = clk_get(component->dev, "da7219-dai-bclk");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-- 
2.20.1
