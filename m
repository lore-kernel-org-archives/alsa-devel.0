From: mengdong.lin@intel.com
Subject: [PATCH v2 3/3] ASoC: topology: Add support for TLV
	bytes controls
Date: Tue, 18 Aug 2015 18:12:20 +0800
Message-ID: <354dceaa5ebfa4f3555eea42e29f32351dd14af5.1439892263.git.mengdong.lin@intel.com>
References: <cover.1439892263.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 09B262616F3
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 11:58:51 +0200 (CEST)
In-Reply-To: <cover.1439892263.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, mengdong.lin@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Allow vendor drivers to define bespoke bytes ext handlers and IDs for
TLV bytes controls. And the topology core will bind these handlers by
matching IDs defined by the vendor driver and user space topology
data file.

And TLV callback binding is moved to soc_tplg_kcontrol_bind_io(). This
function process all handler binding now.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

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
index 9ec97f4..69d01cd 100644
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
1.9.1
