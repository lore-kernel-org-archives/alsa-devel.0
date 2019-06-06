From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: pxa: palm27x: use modern dai_link
	style" to the asoc tree
Date: Thu,  6 Jun 2019 22:26:53 +0100 (BST)
Message-ID: <20190606212654.0CFF5440046@finisterre.sirena.org.uk>
References: <87pnnrjri1.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C50FAF8972F
 for <alsa-devel@alsa-project.org>; Thu,  6 Jun 2019 23:26:54 +0200 (CEST)
In-Reply-To: <87pnnrjri1.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: pxa: palm27x: use modern dai_link style

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

>From ef15331de2e4e660361b3a72569011793d3a3d9c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Jun 2019 13:12:01 +0900
Subject: [PATCH] ASoC: pxa: palm27x: use modern dai_link style

ASoC is now supporting modern style dai_link
(= snd_soc_dai_link_component) for CPU/Codec/Platform.
This patch switches to use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/palm27x.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/sound/soc/pxa/palm27x.c b/sound/soc/pxa/palm27x.c
index 97167048572d..d973f9ba9fd7 100644
--- a/sound/soc/pxa/palm27x.c
+++ b/sound/soc/pxa/palm27x.c
@@ -87,23 +87,27 @@ static int palm27x_ac97_init(struct snd_soc_pcm_runtime *rtd)
 	return err;
 }
 
+SND_SOC_DAILINK_DEFS(hifi,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-ac97")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-hifi")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
+SND_SOC_DAILINK_DEFS(aux,
+	DAILINK_COMP_ARRAY(COMP_CPU("pxa2xx-ac97-aux")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("wm9712-codec", "wm9712-aux")),
+	DAILINK_COMP_ARRAY(COMP_PLATFORM("pxa-pcm-audio")));
+
 static struct snd_soc_dai_link palm27x_dai[] = {
 {
 	.name = "AC97 HiFi",
 	.stream_name = "AC97 HiFi",
-	.cpu_dai_name = "pxa2xx-ac97",
-	.codec_dai_name =  "wm9712-hifi",
-	.codec_name = "wm9712-codec",
-	.platform_name = "pxa-pcm-audio",
 	.init = palm27x_ac97_init,
+	SND_SOC_DAILINK_REG(hifi),
 },
 {
 	.name = "AC97 Aux",
 	.stream_name = "AC97 Aux",
-	.cpu_dai_name = "pxa2xx-ac97-aux",
-	.codec_dai_name = "wm9712-aux",
-	.codec_name = "wm9712-codec",
-	.platform_name = "pxa-pcm-audio",
+	SND_SOC_DAILINK_REG(aux),
 },
 };
 
-- 
2.20.1
