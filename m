From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc.h: add explanation of legacy/modern
	style of dai_link" to the asoc tree
Date: Fri, 18 Jan 2019 19:18:38 +0000 (GMT)
Message-ID: <20190118191838.364C111276E7@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A307B266AA9
 for <alsa-devel@alsa-project.org>; Fri, 18 Jan 2019 20:18:39 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc.h: add explanation of legacy/modern style of dai_link

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

>From 62bc79d35ebb55451112979babea864975cfd16d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Jan 2019 11:20:41 +0900
Subject: [PATCH] ASoC: soc.h: add explanation of legacy/modern style of
 dai_link

Current ALSA SoC is assuming 1 CPU 1 Platform (= DMA) style system.
Because of this background, it is directly using
xxx_name / xxx_of_node / xxx_dai_name on dai_link.
Let's call it as legacy style here.

More complex style system like multi CPU multi Platform (= DMA) will
coming. To supporting it, we can use snd_soc_dai_link_component on
dai_link. Let's call it as modern style here.
But current ALSA SoC can't support it so far. Thus, we need to have
multi CPU / multi Codec / multi Platform style in the future on ALSA SoC.

Currently we already have multi Codec support. Platform is starting to
use modern style on dai_link, but still style only. Multi Platform is
not yet implemented. And we still don't have multi CPU support on ALSA
SoC, and not have modern style either.

Currently, if driver is using legacy style Codec/Platform, it will be
converted to modern style on soc-core. This means, we are using glue code
for legacy vs modern style so far on ALSA SoC.
We can fully switch to modern style on all drivers if ALSA SoC supported
modern style for CPU, and then, legacy style code will be removed from
ALSA SoC.
Untile then, we need to keep both legacy/modern style and its glue code.
This patch adds such future plan and background on soc.h

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h  | 36 ++++++++++++++++++++++++++++++++++++
 sound/soc/soc-core.c | 20 ++++++++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e665f111b0d2..c31b6d122ff6 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -891,6 +891,18 @@ struct snd_soc_dai_link {
 	/* config - must be set by machine driver */
 	const char *name;			/* Codec name */
 	const char *stream_name;		/* Stream name */
+
+	/*
+	 *	cpu_name
+	 *	cpu_of_node
+	 *	cpu_dai_name
+	 *
+	 * These are legacy style, and will be replaced to
+	 * modern style (= snd_soc_dai_link_component) in the future,
+	 * but, not yet supported so far.
+	 * If modern style was supported for CPU, all driver will switch
+	 * to use it, and, legacy style code will be removed from ALSA SoC.
+	 */
 	/*
 	 * You MAY specify the link's CPU-side device, either by device name,
 	 * or by DT/OF node, but not both. If this information is omitted,
@@ -906,6 +918,19 @@ struct snd_soc_dai_link {
 	 * only, which only works well when that device exposes a single DAI.
 	 */
 	const char *cpu_dai_name;
+
+	/*
+	 *	codec_name
+	 *	codec_of_node
+	 *	codec_dai_name
+	 *
+	 * These are legacy style, it will be converted to modern style
+	 * (= snd_soc_dai_link_component) automatically in soc-core
+	 * if driver is using legacy style.
+	 * Driver shouldn't use both legacy and modern style in the same time.
+	 * If modern style was supported for CPU, all driver will switch
+	 * to use it, and, legacy style code will be removed from ALSA SoC.
+	 */
 	/*
 	 * You MUST specify the link's codec, either by device name, or by
 	 * DT/OF node, but not both.
@@ -918,6 +943,17 @@ struct snd_soc_dai_link {
 	struct snd_soc_dai_link_component *codecs;
 	unsigned int num_codecs;
 
+	/*
+	 *	platform_name
+	 *	platform_of_node
+	 *
+	 * These are legacy style, it will be converted to modern style
+	 * (= snd_soc_dai_link_component) automatically in soc-core
+	 * if driver is using legacy style.
+	 * Driver shouldn't use both legacy and modern style in the same time.
+	 * If modern style was supported for CPU, all driver will switch
+	 * to use it, and, legacy style code will be removed from ALSA SoC.
+	 */
 	/*
 	 * You MAY specify the link's platform/PCM/DMA driver, either by
 	 * device name, or by DT/OF node, but not both. Some forms of link
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 890d6c9c2752..de2851f1b3df 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1029,9 +1029,14 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 	struct snd_soc_dai_link_component *platform = dai_link->platform;
 
 	/*
-	 * FIXME
+	 * REMOVE ME
 	 *
-	 * this function should be removed in the future
+	 * This is glue code for Legacy vs Modern dai_link.
+	 * This function will be removed if all derivers are switched to
+	 * modern style dai_link.
+	 * Driver shouldn't use both legacy and modern style in the same time.
+	 * see
+	 *	soc.h :: struct snd_soc_dai_link
 	 */
 	/* convert Legacy platform link */
 	if (!platform || dai_link->legacy_platform) {
@@ -1059,6 +1064,17 @@ static int snd_soc_init_platform(struct snd_soc_card *card,
 static int snd_soc_init_multicodec(struct snd_soc_card *card,
 				   struct snd_soc_dai_link *dai_link)
 {
+	/*
+	 * REMOVE ME
+	 *
+	 * This is glue code for Legacy vs Modern dai_link.
+	 * This function will be removed if all derivers are switched to
+	 * modern style dai_link.
+	 * Driver shouldn't use both legacy and modern style in the same time.
+	 * see
+	 *	soc.h :: struct snd_soc_dai_link
+	 */
+
 	/* Legacy codec/codec_dai link is a single entry in multicodec */
 	if (dai_link->codec_name || dai_link->codec_of_node ||
 	    dai_link->codec_dai_name) {
-- 
2.20.1
