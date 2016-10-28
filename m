From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Make manifest backward
	compatible from ABI v4" to the asoc tree
Date: Fri, 28 Oct 2016 20:03:08 +0100
Message-ID: <E1c0CQm-0006Q3-DF@finisterre>
References: <39acbd6c55ca9ac0855001d5a67d7d96fddd0c7b.1476162939.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C43A3265D93
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 21:03:35 +0200 (CEST)
In-Reply-To: <39acbd6c55ca9ac0855001d5a67d7d96fddd0c7b.1476162939.git.mengdong.lin@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Make manifest backward compatible from ABI v4

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

>From 583958fa2e522139a5fe8b039069e31502c20d31 Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Tue, 11 Oct 2016 14:36:42 +0800
Subject: [PATCH] ASoC: topology: Make manifest backward compatible from ABI v4

This patch adds support for old version 4 of manifest.

Topology ABI v5 added new fields to manifest while user space may still
uses v4. So kernel will check the ABI version by comparing the object
size. If user space uses v4 of manifest, kernel will create a latest
version of manifest from the old one, and use the new one internally and
free it later.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-topology.c | 87 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 79 insertions(+), 8 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 6b05047a4134..c832b24b0cde 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -53,6 +53,23 @@
 #define SOC_TPLG_PASS_START	SOC_TPLG_PASS_MANIFEST
 #define SOC_TPLG_PASS_END	SOC_TPLG_PASS_BE_DAI
 
+
+/*
+ * Old version of ABI structs, supported for backward compatibility.
+ */
+
+/* Manifest v4 */
+struct snd_soc_tplg_manifest_v4 {
+	__le32 size;		/* in bytes of this structure */
+	__le32 control_elems;	/* number of control elements */
+	__le32 widget_elems;	/* number of widget elements */
+	__le32 graph_elems;	/* number of graph elements */
+	__le32 pcm_elems;	/* number of PCM elements */
+	__le32 dai_link_elems;	/* number of DAI link elements */
+	struct snd_soc_tplg_private priv;
+} __packed;
+
+/* topology context */
 struct soc_tplg {
 	const struct firmware *fw;
 
@@ -1798,27 +1815,81 @@ static int soc_tplg_be_dai_elems_load(struct soc_tplg *tplg,
 	return 0;
 }
 
+/**
+ * manifest_new_ver - Create a new version of manifest from the old version
+ * of source.
+ * @toplogy: topology context
+ * @src: old version of manifest as a source
+ * @manifest: latest version of manifest created from the source
+ *
+ * Support from vesion 4. Users need free the returned manifest manually.
+ */
+static int manifest_new_ver(struct soc_tplg *tplg,
+			    struct snd_soc_tplg_manifest *src,
+			    struct snd_soc_tplg_manifest **manifest)
+{
+	struct snd_soc_tplg_manifest *dest;
+	struct snd_soc_tplg_manifest_v4 *src_v4;
+
+	*manifest = NULL;
+
+	if (src->size != sizeof(*src_v4)) {
+		dev_err(tplg->dev, "ASoC: invalid manifest size\n");
+		return -EINVAL;
+	}
+
+	dev_warn(tplg->dev, "ASoC: old version of manifest\n");
+
+	src_v4 = (struct snd_soc_tplg_manifest_v4 *)src;
+	dest = kzalloc(sizeof(*dest) + src_v4->priv.size, GFP_KERNEL);
+	if (!dest)
+		return -ENOMEM;
+
+	dest->size = sizeof(*dest);	/* size of latest abi version */
+	dest->control_elems = src_v4->control_elems;
+	dest->widget_elems = src_v4->widget_elems;
+	dest->graph_elems = src_v4->graph_elems;
+	dest->pcm_elems = src_v4->pcm_elems;
+	dest->dai_link_elems = src_v4->dai_link_elems;
+	dest->priv.size = src_v4->priv.size;
+	if (dest->priv.size)
+		memcpy(dest->priv.data, src_v4->priv.data,
+		       src_v4->priv.size);
+
+	*manifest = dest;
+	return 0;
+}
 
 static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 				  struct snd_soc_tplg_hdr *hdr)
 {
-	struct snd_soc_tplg_manifest *manifest;
+	struct snd_soc_tplg_manifest *manifest, *_manifest;
+	bool abi_match;
+	int err;
 
 	if (tplg->pass != SOC_TPLG_PASS_MANIFEST)
 		return 0;
 
 	manifest = (struct snd_soc_tplg_manifest *)tplg->pos;
-	if (manifest->size != sizeof(*manifest)) {
-		dev_err(tplg->dev, "ASoC: invalid manifest size\n");
-		return -EINVAL;
-	}
 
-	tplg->pos += sizeof(struct snd_soc_tplg_manifest);
+	/* check ABI version by size, create a new manifest if abi not match */
+	if (manifest->size == sizeof(*manifest)) {
+		abi_match = true;
+		_manifest = manifest;
+	} else {
+		abi_match = false;
+		err = manifest_new_ver(tplg, manifest, &_manifest);
+		if (err < 0)
+			return err;
+	}
 
+	/* pass control to component driver for optional further init */
 	if (tplg->comp && tplg->ops && tplg->ops->manifest)
-		return tplg->ops->manifest(tplg->comp, manifest);
+		return tplg->ops->manifest(tplg->comp, _manifest);
+
+	if (!abi_match)	/* free the duplicated one */
+		kfree(_manifest);
 
-	dev_err(tplg->dev, "ASoC: Firmware manifest not supported\n");
 	return 0;
 }
 
-- 
2.10.1
