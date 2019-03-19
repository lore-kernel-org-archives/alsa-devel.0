From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 3/3] ASoC: AMD: Update DA7219 DAI clock name to align with
 codec updates
Date: Tue, 19 Mar 2019 17:49:32 +0000
Message-ID: <3159a9ec4f79fe25219e04bafc29a842b650521c.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1553017237.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Akshu Agrawal <Akshu.Agrawal@amd.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

As the DAI clocks for DA7219 have now been split into BCLK and WCLK,
the clock lookup name needs to be udpated here to select BCLK to
achieve the same functionality as before with regards to DAI clock
gating.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index a5daad9..f37a588 100644
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
1.9.1
