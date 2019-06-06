From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: smdk_wm8994pcm: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:09 +0100 (BST)
Message-ID: <20190606212709.BE1C0440046@finisterre.sirena.org.uk>
References: <87tvd3l677.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74F96F897FF
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:10 +0200 (CEST)
In-Reply-To: <87tvd3l677.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: samsung: smdk_wm8994pcm: use modern dai_link style

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

>From 245139b2c25c62225577fd7b7a6125bf6f9717d4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:09:12 +0900
Subject: [PATCH] ASoC: samsung: smdk_wm8994pcm: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/smdk_wm8994pcm.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/samsung/smdk_wm8994pcm.c b/sound/soc/samsung/smdk_wm8994pcm.c
index 43171d6457fa..2e3dc7320c62 100644
--- a/sound/soc/samsung/smdk_wm8994pcm.c
+++ b/sound/soc/samsung/smdk_wm8994pcm.c
@@ -89,17 +89,19 @@ static struct snd_soc_ops smdk_wm8994_pcm_ops = {
 	.hw_params = smdk_wm8994_pcm_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(paif_pcm,
+	DAILINK_COMP_ARRAY(COMP_CPU("samsung-pcm.0")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8994-codec", "wm8994-aif1")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("samsung-pcm.0")));
+
 static struct snd_soc_dai_link smdk_dai[] = {
 	{
 		.name = "WM8994 PAIF PCM",
 		.stream_name = "Primary PCM",
-		.cpu_dai_name = "samsung-pcm.0",
-		.codec_dai_name = "wm8994-aif1",
-		.platform_name = "samsung-pcm.0",
-		.codec_name = "wm8994-codec",
 		.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_IB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
 		.ops = &smdk_wm8994_pcm_ops,
+		SND_SOC_DAILINK_REG(paif_pcm),
 	},
 };
 
-- 
2.20.1
