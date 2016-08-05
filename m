From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add support for configuring
	existing BE DAIs" to the asoc tree
Date: Fri, 05 Aug 2016 13:08:52 +0100
Message-ID: <E1bVdvo-0002a9-PU@debutante>
References: <a57c9b685be05e5d860f6fe2693169aa0b005279.1469165422.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2291266901
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2016 14:09:03 +0200 (CEST)
In-Reply-To: <a57c9b685be05e5d860f6fe2693169aa0b005279.1469165422.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Add support for configuring existing BE DAIs

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From caa80ebdc00b0580174f804c96a1268c7f5eac1b Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Tue, 26 Jul 2016 14:32:37 +0800
Subject: [PATCH] ASoC: topology: Add support for configuring existing BE DAIs

The platform driver may just specify the BE (Back End) DAI name and ID.
And topology will find the existing BE DAI by its name and ID, and then
configure its stream caps and flags.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 111 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index ee7f15aa46fc..05a18f68bfd0 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -48,9 +48,10 @@
 #define SOC_TPLG_PASS_PCM_DAI		4
 #define SOC_TPLG_PASS_GRAPH		5
 #define SOC_TPLG_PASS_PINS		6
+#define SOC_TPLG_PASS_BE_DAI		7
 
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
-#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_PINS
+#define SOC_TPLG_PASS_END	SOC_TPLG_PASS_BE_DAI
 
 struct soc_tplg {
 	const struct firmware *fw;
@@ -1556,6 +1557,24 @@ static void set_stream_info(struct snd_soc_pcm_stream *stream,
 	stream->formats = caps->formats;
 }
 
+static void set_dai_flags(struct snd_soc_dai_driver *dai_drv,
+			  unsigned int flag_mask, unsigned int flags)
+{
+	if (flag_mask & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES)
+		dai_drv->symmetric_rates =
+			flags & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_RATES ? 1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS)
+		dai_drv->symmetric_channels =
+			flags & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_CHANNELS ?
+			1 : 0;
+
+	if (flag_mask & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS)
+		dai_drv->symmetric_samplebits =
+			flags & SND_SOC_TPLG_DAI_FLGBIT_SYMMETRIC_SAMPLEBITS ?
+			1 : 0;
+}
+
 static int soc_tplg_dai_create(struct soc_tplg *tplg,
 	struct snd_soc_tplg_pcm *pcm)
 {
@@ -1690,8 +1709,96 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/* *
+ * soc_tplg_be_dai_config - Find and configure an existing BE DAI.
+ * @tplg: topology context
+ * @be: topology BE DAI configs.
+ *
+ * The BE dai should already be registered by the platform driver. The
+ * platform driver should specify the BE DAI name and ID for matching.
+ */
+static int soc_tplg_be_dai_config(struct soc_tplg *tplg,
+				  struct snd_soc_tplg_be_dai *be)
+{
+	struct snd_soc_dai_link_component dai_component = {0};
+	struct snd_soc_dai *dai;
+	struct snd_soc_dai_driver *dai_drv;
+	struct snd_soc_pcm_stream *stream;
+	struct snd_soc_tplg_stream_caps *caps;
+	int ret;
+
+	dai_component.dai_name = be->dai_name;
+	dai = snd_soc_find_dai(&dai_component);
+	if (!dai) {
+		dev_err(tplg->dev, "ASoC: BE DAI %s not registered\n",
+			be->dai_name);
+		return -EINVAL;
+	}
+
+	if (be->dai_id != dai->id) {
+		dev_err(tplg->dev, "ASoC: BE DAI %s id mismatch\n",
+			be->dai_name);
+		return -EINVAL;
+	}
+
+	dai_drv = dai->driver;
+	if (!dai_drv)
+		return -EINVAL;
+
+	if (be->playback) {
+		stream = &dai_drv->playback;
+		caps = &be->caps[SND_SOC_TPLG_STREAM_PLAYBACK];
+		set_stream_info(stream, caps);
+	}
+
+	if (be->capture) {
+		stream = &dai_drv->capture;
+		caps = &be->caps[SND_SOC_TPLG_STREAM_CAPTURE];
+		set_stream_info(stream, caps);
+	}
+
+	if (be->flag_mask)
+		set_dai_flags(dai_drv, be->flag_mask, be->flags);
+
+	/* pass control to component driver for optional further init */
+	ret = soc_tplg_dai_load(tplg, dai_drv);
+	if (ret < 0) {
+		dev_err(tplg->comp->dev, "ASoC: DAI loading failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
+				      struct snd_soc_tplg_hdr *hdr)
+{
+	struct snd_soc_tplg_be_dai *be;
+	int count = hdr->count;
+	int i;
+
+	if (tplg->pass != SOC_TPLG_PASS_BE_DAI)
+		return 0;
+
+	/* config the existing BE DAIs */
+	for (i = 0; i < count; i++) {
+		be = (struct snd_soc_tplg_be_dai *)tplg->pos;
+		if (be->size != sizeof(*be)) {
+			dev_err(tplg->dev, "ASoC: invalid BE DAI size\n");
+			return -EINVAL;
+		}
+
+		soc_tplg_be_dai_config(tplg, be);
+		tplg->pos += (sizeof(*be) + be->priv.size);
+	}
+
+	dev_dbg(tplg->dev, "ASoC: Configure %d BE DAIs\n", count);
+	return 0;
+}
+
+
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
-	struct snd_soc_tplg_hdr *hdr)
+				  struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_manifest *manifest;
 
@@ -1793,6 +1900,8 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 		return soc_tplg_dapm_widget_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_PCM:
 		return soc_tplg_pcm_elems_load(tplg, hdr);
+	case SND_SOC_TPLG_TYPE_BE_DAI:
+		return soc_tplg_be_dai_elems_load(tplg, hdr);
 	case SND_SOC_TPLG_TYPE_MANIFEST:
 		return soc_tplg_manifest_load(tplg, hdr);
 	default:
-- 
2.8.1
