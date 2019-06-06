From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: e800_wm9712: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:57 +0100 (BST)
Message-ID: <20190606212657.57430440046@finisterre.sirena.org.uk>
References: <87y32fjrje.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0FFF0F89755
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:58 +0200 (CEST)
In-Reply-To: <87y32fjrje.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pxa: e800_wm9712: use modern dai_link style

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

>From 32b787a0ce77221f809b42b4cb21b176a0422068 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:11:12 +0900
Subject: [PATCH] ASoC: pxa: e800_wm9712: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/e800_wm9712.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/e800_wm9712.c b/sound/soc/pxa/e800_wm9712.c
index 1ed8aa2348f1..fc3aa3d77c75 100644
--- a/sound/soc/pxa/e800_wm9712.c
+++ b/sound/soc/pxa/e800_wm9712.c
@@ -68,22 +68,27 @@ static const struct snd_soc_dapm_route audio_map[] = {
 	{"MIC2", NULL, "Mic (Internal2)"},
 };
 
+
+SND_SOC_DAILINK_DEFS(ac97,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-ac97")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
+SND_SOC_DAILINK_DEFS(ac97_aux,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-ac97-aux")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-aux")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
 static struct snd_soc_dai_link e800_dai[] = {
 	{
 		.name = "AC97",
 		.stream_name = "AC97 HiFi",
-		.cpu_dai_name = "pxa2xx-ac97",
-		.codec_dai_name = "wm9712-hifi",
-		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		SND_SOC_DAILINK_REG(ac97),
 	},
 	{
 		.name = "AC97 Aux",
 		.stream_name = "AC97 Aux",
-		.cpu_dai_name = "pxa2xx-ac97-aux",
-		.codec_dai_name = "wm9712-aux",
-		.platform_name = "pxa-pcm-audio",
-		.codec_name = "wm9712-codec",
+		SND_SOC_DAILINK_REG(ac97_aux),
 	},
 };
 
-- 
2.20.1
