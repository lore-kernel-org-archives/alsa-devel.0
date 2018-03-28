From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: amd: don't use codec anymore" to the
	asoc tree
Date: Wed, 28 Mar 2018 03:20:56 +0100 (BST)
Message-ID: <20180328022056.81D0044007A@finisterre.ee.mobilebroadband>
References: <871sg555xp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4CA9B26721A
 for <alsa-devel@alsa-project.org>; Wed, 28 Mar 2018 04:21:00 +0200 (CEST)
In-Reply-To: <871sg555xp.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Dylan Reid <dgreid@chromium.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: amd: don't use codec anymore

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

>From 4c50e1e3e2c29899c0226f7ad56d7266e814f2b3 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Mar 2018 01:48:07 +0000
Subject: [PATCH] ASoC: amd: don't use codec anymore

commit c88d31153356 ("ASoC: amd: Enable da7219 master clock using common
clock framework") is using rtd->codec, but codec is replaced to component.
Let's use component

Fixes: c88d31153356 ("ASoC: amd: Enable da7219 master clock using common clock framework")
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 99c6b5ce5c6c..b205c782e494 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -49,7 +49,6 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
 	int ret;
 	struct snd_soc_card *card = rtd->card;
-	struct snd_soc_codec *codec = rtd->codec;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
 	struct snd_soc_component *component = codec_dai->component;
 
@@ -69,7 +68,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	da7219_dai_clk = clk_get(codec->dev, "da7219-dai-clks");
+	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
-- 
2.16.2
