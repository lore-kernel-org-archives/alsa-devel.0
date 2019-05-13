From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: don't use codec_dais on
	soc_bind_dai_link()" to the asoc tree
Date: Mon, 13 May 2019 13:30:27 +0100 (BST)
Message-ID: <20190513123027.BB52B112923A@debutante.sirena.org.uk>
References: <87v9yealt2.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4171F89730
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2019 14:30:38 +0200 (CEST)
In-Reply-To: <87v9yealt2.wl-kuninori.morimoto.gx@renesas.com>
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

   ASoC: soc-core: don't use codec_dais on soc_bind_dai_link()

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

>From 0a2cfcd998e3503c20be497cadb0ef23edb984be Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 13 May 2019 16:06:30 +0900
Subject: [PATCH] ASoC: soc-core: don't use codec_dais on soc_bind_dai_link()

Current soc_bind_dai_link() is substituting rtd->codec_dais to
codec_dais, and sets found DAI into it.
But, it is a little bit un-readable / un-understandable to
know detail of rtd, and it will make difficult to understand
rtd->cpu_dais if Multi CPU was supported.
This patch cleanup it and prepare for Multi CPU support.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0d9b02075050..2ceca7fdf622 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -878,7 +878,6 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link_component *codecs;
 	struct snd_soc_dai_link_component cpu_dai_component;
 	struct snd_soc_component *component;
-	struct snd_soc_dai **codec_dais;
 	int i;
 
 	if (dai_link->ignore)
@@ -910,19 +909,18 @@ static int soc_bind_dai_link(struct snd_soc_card *card,
 	rtd->num_codecs = dai_link->num_codecs;
 
 	/* Find CODEC from registered CODECs */
-	codec_dais = rtd->codec_dais;
 	for_each_link_codecs(dai_link, i, codecs) {
-		codec_dais[i] = snd_soc_find_dai(codecs);
-		if (!codec_dais[i]) {
+		rtd->codec_dais[i] = snd_soc_find_dai(codecs);
+		if (!rtd->codec_dais[i]) {
 			dev_info(card->dev, "ASoC: CODEC DAI %s not registered\n",
 				 codecs->dai_name);
 			goto _err_defer;
 		}
-		snd_soc_rtdcom_add(rtd, codec_dais[i]->component);
+		snd_soc_rtdcom_add(rtd, rtd->codec_dais[i]->component);
 	}
 
 	/* Single codec links expect codec and codec_dai in runtime data */
-	rtd->codec_dai = codec_dais[0];
+	rtd->codec_dai = rtd->codec_dais[0];
 
 	/* find one from the set of registered platforms */
 	for_each_component(component) {
-- 
2.20.1
