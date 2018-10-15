From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Add SND_JACK_LINEOUT jack type" to
	the asoc tree
Date: Mon, 15 Oct 2018 12:21:52 +0100 (BST)
Message-ID: <20181015112152.0EDB611224A9@debutante.sirena.org.uk>
References: <1539586502-12516-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 268822678FB
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 13:21:57 +0200 (CEST)
In-Reply-To: <1539586502-12516-1-git-send-email-akshu.agrawal@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, djkurtz@chromium.org, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, akshu.agrawal@amd.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Add SND_JACK_LINEOUT jack type

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

>From 2657c6a9037df1c98eb5dae10dd554ac8c37d38f Mon Sep 17 00:00:00 2001
From: Akshu Agrawal <akshu.agrawal@amd.com>
Date: Mon, 15 Oct 2018 12:24:44 +0530
Subject: [PATCH] ASoC: AMD: Add SND_JACK_LINEOUT jack type

Some 3 pole connectors report impedance greater than threshold of
1000Ohm. Thus, da7219 reports them as LINEOUT.
Adding the SND_JACK_LINEOUT type so that we don't fail to detect
any 3 pole jack type.
Also, changing
SND_JACK_HEADPHONE | SND_JACK_MICROPHONE -> SND_JACK_HEADSET

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index 717a017f0db6..3f813ea5210a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -75,7 +75,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	da7219_dai_clk = clk_get(component->dev, "da7219-dai-clks");
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
-				SND_JACK_HEADPHONE | SND_JACK_MICROPHONE |
+				SND_JACK_HEADSET | SND_JACK_LINEOUT |
 				SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				SND_JACK_BTN_2 | SND_JACK_BTN_3,
 				&cz_jack, NULL, 0);
-- 
2.19.0.rc2
