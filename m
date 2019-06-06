From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: imote2: use modern dai_link style"
	to the asoc tree
Date: Thu,  6 Jun 2019 22:26:55 +0100 (BST)
Message-ID: <20190606212655.AD927440046@finisterre.sirena.org.uk>
References: <87tvd3jrig.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 63B6DF897DA
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:56 +0200 (CEST)
In-Reply-To: <87tvd3jrig.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pxa: imote2: use modern dai_link style

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

>From 76359b17c38d513743a151b3cf747a5867dd6216 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:11:46 +0900
Subject: [PATCH] ASoC: pxa: imote2: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/imote2.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 78475376f971..9095edd6a374 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -46,16 +46,19 @@ static const struct snd_soc_ops imote2_asoc_ops = {
 	.hw_params = imote2_asoc_hw_params,
 };
 
+SND_SOC_DAILINK_DEFS(wm8940,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-i2s")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm8940-codec.0-0034",
+				      "wm8940-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
 static struct snd_soc_dai_link imote2_dai = {
 	.name = "WM8940",
 	.stream_name = "WM8940",
-	.cpu_dai_name = "pxa2xx-i2s",
-	.codec_dai_name = "wm8940-hifi",
-	.platform_name = "pxa-pcm-audio",
-	.codec_name = "wm8940-codec.0-0034",
 	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &imote2_asoc_ops,
+	SND_SOC_DAILINK_REG(wm8940),
 };
 
 static struct snd_soc_card imote2 = {
-- 
2.20.1
