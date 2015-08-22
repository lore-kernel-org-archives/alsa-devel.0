From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: topology: Add support for TLV bytes
	controls" to the asoc tree
Date: Sat, 22 Aug 2015 08:55:30 -0700
Message-ID: <E1ZTB8k-0000Qe-JX@finisterre>
References: <354dceaa5ebfa4f3555eea42e29f32351dd14af5.1439892263.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2726D26047B
 for <alsa-devel@alsa-project.org>; Sat, 22 Aug 2015 17:55:44 +0200 (CEST)
In-Reply-To: <354dceaa5ebfa4f3555eea42e29f32351dd14af5.1439892263.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: topology: Add support for TLV bytes controls

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

>From 1a3232d2f61d2853a848464b7bde2d54960c58bb Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@intel.com>
Date: Tue, 18 Aug 2015 18:12:20 +0800
Subject: [PATCH] ASoC: topology: Add support for TLV bytes controls

Allow vendor drivers to define bespoke bytes ext handlers and IDs for
TLV bytes controls. And the topology core will bind these handlers by
matching IDs defined by the vendor driver and user space topology
data file.

And TLV callback binding is moved to soc_tplg_kcontrol_bind_io(). This
function process all handler binding now.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc-topology.h | 11 +++++++++++
 sound/soc/soc-topology.c     | 42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index a6541a1..ea387ed 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -89,6 +89,13 @@ struct snd_soc_tplg_kcontrol_ops {
 		struct snd_ctl_elem_info *uinfo);
 };
 
+/* Bytes ext operations, for TLV byte controls */
+struct snd_soc_tplg_bytes_ext_ops {
+	u32 id;
+	int (*get)(unsigned int __user *bytes, unsigned int size);
+	int (*put)(const unsigned int __user *bytes, unsigned int size);
+};
+
 /*
  * DAPM widget event handlers - used to map handlers onto widgets.
  */
@@ -139,6 +146,10 @@ struct snd_soc_tplg_ops {
 	/* vendor specific kcontrol handlers available for binding */
 	const struct snd_soc_tplg_kcontrol_ops *io_ops;
 	int io_ops_count;
+
+	/* vendor specific bytes ext handlers available for binding */
+	const struct snd_soc_tplg_bytes_ext_ops *bytes_ext_ops;
+	int bytes_ext_ops_count;
 };
 
 /* gets a pointer to data from the firmware block header */
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c4a58d7..5690b7e 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -70,6 +70,10 @@ struct soc_tplg {
 	const struct snd_soc_tplg_kcontrol_ops *io_ops;
 	int io_ops_count;
 
+	/* vendor specific bytes ext handlers, for TLV bytes controls */
+	const struct snd_soc_tplg_bytes_ext_ops *bytes_ext_ops;
+	int bytes_ext_ops_count;
+
 	/* optional fw loading callbacks to component drivers */
 	struct snd_soc_tplg_ops *ops;
 };
@@ -511,8 +515,40 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	const struct soc_tplg *tplg)
 {
 	const struct snd_soc_tplg_kcontrol_ops *ops;
+	const struct snd_soc_tplg_bytes_ext_ops *ext_ops;
 	int num_ops, i;
 
+	if (hdr->ops.info == SND_SOC_TPLG_CTL_BYTES
+		&& k->iface & SNDRV_CTL_ELEM_IFACE_MIXER
+		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
+		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
+		struct soc_bytes_ext *sbe;
+		struct snd_soc_tplg_bytes_control *be;
+
+		sbe = (struct soc_bytes_ext *)k->private_value;
+		be = container_of(hdr, struct snd_soc_tplg_bytes_control, hdr);
+
+		/* TLV bytes controls need standard kcontrol info handler,
+		 * TLV callback and extended put/get handlers.
+		 */
+		k->info = snd_soc_bytes_info;
+		k->tlv.c = snd_soc_bytes_tlv_callback;
+
+		ext_ops = tplg->bytes_ext_ops;
+		num_ops = tplg->bytes_ext_ops_count;
+		for (i = 0; i < num_ops; i++) {
+			if (!sbe->put && ext_ops[i].id == be->ext_ops.put)
+				sbe->put = ext_ops[i].put;
+			if (!sbe->get && ext_ops[i].id == be->ext_ops.get)
+				sbe->get = ext_ops[i].get;
+		}
+
+		if (sbe->put && sbe->get)
+			return 0;
+		else
+			return -EINVAL;
+	}
+
 	/* try and map vendor specific kcontrol handlers first */
 	ops = tplg->io_ops;
 	num_ops = tplg->io_ops_count;
@@ -613,9 +649,7 @@ static int soc_tplg_create_tlv(struct soc_tplg *tplg,
 	if (!(tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE))
 		return 0;
 
-	if (tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
-		kc->tlv.c = snd_soc_bytes_tlv_callback;
-	} else {
+	if (!(tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)) {
 		tplg_tlv = &tc->tlv;
 		switch (tplg_tlv->type) {
 		case SNDRV_CTL_TLVT_DB_SCALE:
@@ -1733,6 +1767,8 @@ int snd_soc_tplg_component_load(struct snd_soc_component *comp,
 	tplg.req_index = id;
 	tplg.io_ops = ops->io_ops;
 	tplg.io_ops_count = ops->io_ops_count;
+	tplg.bytes_ext_ops = ops->bytes_ext_ops;
+	tplg.bytes_ext_ops_count = ops->bytes_ext_ops_count;
 
 	return soc_tplg_load(&tplg);
 }
-- 
2.5.0
