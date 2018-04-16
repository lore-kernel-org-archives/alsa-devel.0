From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Enable IPMMU v2" to the asoc tree
Date: Mon, 16 Apr 2018 12:59:39 +0100
Message-ID: <E1f82nL-00005S-Kz@debutante>
References: <87fu3vd9ct.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E316E2673C7
 for <alsa-devel@alsa-project.org>; Mon, 16 Apr 2018 13:59:41 +0200 (CEST)
In-Reply-To: <87fu3vd9ct.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Enable IPMMU v2

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

>From 5423d77253ac5bcb2d3de61cf0811c0f2a62c0af Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2018 05:14:01 +0000
Subject: [PATCH] ASoC: rsnd: Enable IPMMU v2

commit 4821d914fe747 ("ASoC: rsnd: use dma_sync_single_for_xxx() for
IOMMU") (= v1) which have been already reverted had supported IPMMU
support on rsnd driver.
Because memory allocating timing and DMAEngine access timing were
different, it used continuous memory and called dma map function by
itself.

OTOH, it is using DMA descriptor mode (= DMA cyclic mode), thus, there
was timing conflict between DMA sync/unsync and DMA transfer starting,
and it maked sound noise.

This patch supports IPMMU with coherent memory, and, it uses Audio DMAC
dev for allocating memory by snd_pcm_lib_preallocate_pages_for_all() to
indicate memory area to IPMMU.
One note is that Playback/Capture need each paired Audio DMAC dev.
Because of this, we need to keep each paired Audio DMAC dev when probing,
and use it when allocating each memory for IPMMU.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/core.c | 47 +++++++++++++++++++++++++++++++++++-----
 sound/soc/sh/rcar/dma.c  |  7 ++++++
 sound/soc/sh/rcar/rsnd.h |  1 +
 3 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 47a55d6bfd80..f9ac086d8e05 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1352,6 +1352,37 @@ int rsnd_kctrl_new(struct rsnd_mod *mod,
 #define PREALLOC_BUFFER		(32 * 1024)
 #define PREALLOC_BUFFER_MAX	(32 * 1024)
 
+static int rsnd_preallocate_pages(struct snd_soc_pcm_runtime *rtd,
+				  struct rsnd_dai_stream *io,
+				  int stream)
+{
+	struct rsnd_priv *priv = rsnd_io_to_priv(io);
+	struct device *dev = rsnd_priv_to_dev(priv);
+	struct snd_pcm_substream *substream;
+	int err;
+
+	/*
+	 * use Audio-DMAC dev if we can use IPMMU
+	 * see
+	 *	rsnd_dmaen_attach()
+	 */
+	if (io->dmac_dev)
+		dev = io->dmac_dev;
+
+	for (substream = rtd->pcm->streams[stream].substream;
+	     substream;
+	     substream = substream->next) {
+		err = snd_pcm_lib_preallocate_pages(substream,
+					SNDRV_DMA_TYPE_DEV,
+					dev,
+					PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_dai *dai = rtd->cpu_dai;
@@ -1366,11 +1397,17 @@ static int rsnd_pcm_new(struct snd_soc_pcm_runtime *rtd)
 	if (ret)
 		return ret;
 
-	return snd_pcm_lib_preallocate_pages_for_all(
-		rtd->pcm,
-		SNDRV_DMA_TYPE_DEV,
-		rtd->card->snd_card->dev,
-		PREALLOC_BUFFER, PREALLOC_BUFFER_MAX);
+	ret = rsnd_preallocate_pages(rtd, &rdai->playback,
+				     SNDRV_PCM_STREAM_PLAYBACK);
+	if (ret)
+		return ret;
+
+	ret = rsnd_preallocate_pages(rtd, &rdai->capture,
+				     SNDRV_PCM_STREAM_CAPTURE);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static const struct snd_soc_component_driver rsnd_soc_component = {
diff --git a/sound/soc/sh/rcar/dma.c b/sound/soc/sh/rcar/dma.c
index 32ac97be26f1..ef82b94d038b 100644
--- a/sound/soc/sh/rcar/dma.c
+++ b/sound/soc/sh/rcar/dma.c
@@ -253,6 +253,13 @@ static int rsnd_dmaen_attach(struct rsnd_dai_stream *io,
 		return -EAGAIN;
 	}
 
+	/*
+	 * use it for IPMMU if needed
+	 * see
+	 *	rsnd_preallocate_pages()
+	 */
+	io->dmac_dev = chan->device->dev;
+
 	dma_release_channel(chan);
 
 	dmac->dmaen_num++;
diff --git a/sound/soc/sh/rcar/rsnd.h b/sound/soc/sh/rcar/rsnd.h
index b1896f1eb214..6d7280d2d9be 100644
--- a/sound/soc/sh/rcar/rsnd.h
+++ b/sound/soc/sh/rcar/rsnd.h
@@ -435,6 +435,7 @@ struct rsnd_dai_stream {
 	struct snd_pcm_substream *substream;
 	struct rsnd_mod *mod[RSND_MOD_MAX];
 	struct rsnd_dai *rdai;
+	struct device *dmac_dev; /* for IPMMU */
 	u32 parent_ssi_status;
 };
 #define rsnd_io_to_mod(io, i)	((i) < RSND_MOD_MAX ? (io)->mod[(i)] : NULL)
-- 
2.17.0
