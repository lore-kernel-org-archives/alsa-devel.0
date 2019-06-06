From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: samsung: neo1973_wm8753: use modern
	dai_link style" to the asoc tree
Date: Thu,  6 Jun 2019 22:27:01 +0100 (BST)
Message-ID: <20190606212701.CFA9D440046@finisterre.sirena.org.uk>
References: <87a7evl64z.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F623F897E5
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:27:02 +0200 (CEST)
In-Reply-To: <87a7evl64z.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: samsung: neo1973_wm8753: use modern dai_link style

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

>From 0391b03374ceb8a4f40e13e1c5780d694488228d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:10:32 +0900
Subject: [PATCH] ASoC: samsung: neo1973_wm8753: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/samsung/neo1973_wm8753.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/sound/soc/samsung/neo1973_wm8753.c b/sound/soc/samsung/neo1973_wm8753.c
index 7e625066ddcd..396776ffd670 100644
--- a/sound/soc/samsung/neo1973_wm8753.c
+++ b/sound/soc/samsung/neo1973_wm8753.c
@@ -266,28 +266,32 @@ static int neo1973_wm8753_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+SND_SOC_DAILINK_DEFS(wm8753,
+	DAILINK_COMP_ARRAY(COMP_CPU("s3c24xx-iis")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8753.0-001a", "wm8753-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("s3c24xx-iis")));
+
+SND_SOC_DAILINK_DEFS(bluetooth,
+	DAILINK_COMP_ARRAY(COMP_CPU("bt-sco-pcm")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8753.0-001a", "wm8753-voice")));
+
 static struct snd_soc_dai_link neo1973_dai[] = {
 { /* Hifi Playback - for similatious use with voice below */
 	.name = "WM8753",
 	.stream_name = "WM8753 HiFi",
-	.platform_name = "s3c24xx-iis",
-	.cpu_dai_name = "s3c24xx-iis",
-	.codec_dai_name = "wm8753-hifi",
-	.codec_name = "wm8753.0-001a",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBM_CFM,
 	.init = neo1973_wm8753_init,
 	.ops = &neo1973_hifi_ops,
+	SND_SOC_DAILINK_REG(wm8753),
 },
 { /* Voice via BT */
 	.name = "Bluetooth",
 	.stream_name = "Voice",
-	.cpu_dai_name = "bt-sco-pcm",
-	.codec_dai_name = "wm8753-voice",
-	.codec_name = "wm8753.0-001a",
 	.dai_fmt = SND_SOC_DAIFMT_DSP_B | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &neo1973_voice_ops,
+	SND_SOC_DAILINK_REG(bluetooth),
 },
 };
 
-- 
2.20.1
