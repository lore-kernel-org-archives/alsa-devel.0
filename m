From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 046/112] ALSA: hda - Merge Realtek parser code
	to generic parser
Date: Tue,  8 Jan 2013 12:38:39 +0100
Message-ID: <1357645185-7645-47-git-send-email-tiwai@suse.de>
References: <1357645185-7645-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A64AB2651C5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:25 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id E6363A5257
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 12:40:22 +0100 (CET)
In-Reply-To: <1357645185-7645-1-git-send-email-tiwai@suse.de>
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
List-Id: alsa-devel@alsa-project.org

Finally the whole generic parser code in Realtek driver is moved into
hda_generic.c so that it can be used for generic codec driver.
The old dumb generic driver is replaced.  Yay.

The future plan is to adapt this generic parser for other codecs,
i.e. the codec driver calls the exported functions in generic driver
but adds some codec-specific fixes and setups.

As of this commit, the complete driver code is still duplicated in
Realtek codec driver.  The big code reduction will come from now on.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 4130 ++++++++++++++++++++++++++++++++++---------
 sound/pci/hda/hda_generic.h |  199 +++
 2 files changed, 3518 insertions(+), 811 deletions(-)
 create mode 100644 sound/pci/hda/hda_generic.h

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b81d3d0..2d19b91 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -23,1063 +23,3571 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/export.h>
+#include <linux/sort.h>
 #include <sound/core.h>
+#include <sound/jack.h>
 #include "hda_codec.h"
 #include "hda_local.h"
+#include "hda_auto_parser.h"
+#include "hda_jack.h"
+#include "hda_generic.h"
 
-/* widget node for parsing */
-struct hda_gnode {
-	hda_nid_t nid;		/* NID of this widget */
-	unsigned short nconns;	/* number of input connections */
-	hda_nid_t *conn_list;
-	hda_nid_t slist[2];	/* temporay list */
-	unsigned int wid_caps;	/* widget capabilities */
-	unsigned char type;	/* widget type */
-	unsigned char pin_ctl;	/* pin controls */
-	unsigned char checked;	/* the flag indicates that the node is already parsed */
-	unsigned int pin_caps;	/* pin widget capabilities */
-	unsigned int def_cfg;	/* default configuration */
-	unsigned int amp_out_caps;	/* AMP out capabilities */
-	unsigned int amp_in_caps;	/* AMP in capabilities */
-	struct list_head list;
-};
-
-/* patch-specific record */
-
-#define MAX_PCM_VOLS	2
-struct pcm_vol {
-	struct hda_gnode *node;	/* Node for PCM volume */
-	unsigned int index;	/* connection of PCM volume */
-};
 
-struct hda_gspec {
-	struct hda_gnode *dac_node[2];	/* DAC node */
-	struct hda_gnode *out_pin_node[2];	/* Output pin (Line-Out) node */
-	struct pcm_vol pcm_vol[MAX_PCM_VOLS];	/* PCM volumes */
-	unsigned int pcm_vol_nodes;	/* number of PCM volumes */
+/* initialize hda_gen_spec struct */
+int snd_hda_gen_spec_init(struct hda_gen_spec *spec)
+{
+	snd_array_init(&spec->kctls, sizeof(struct snd_kcontrol_new), 32);
+	snd_array_init(&spec->bind_ctls, sizeof(struct hda_bind_ctls *), 8);
+	snd_array_init(&spec->paths, sizeof(struct nid_path), 8);
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_gen_spec_init);
 
-	struct hda_gnode *adc_node;	/* ADC node */
-	struct hda_gnode *cap_vol_node;	/* Node for capture volume */
-	unsigned int cur_cap_src;	/* current capture source */
-	struct hda_input_mux input_mux;
+static struct snd_kcontrol_new *
+add_kctl(struct hda_gen_spec *spec, const char *name,
+	 const struct snd_kcontrol_new *temp)
+{
+	struct snd_kcontrol_new *knew = snd_array_new(&spec->kctls);
+	if (!knew)
+		return NULL;
+	*knew = *temp;
+	if (name)
+		knew->name = kstrdup(name, GFP_KERNEL);
+	else if (knew->name)
+		knew->name = kstrdup(knew->name, GFP_KERNEL);
+	if (!knew->name)
+		return NULL;
+	return knew;
+}
 
-	unsigned int def_amp_in_caps;
-	unsigned int def_amp_out_caps;
+static void free_kctls(struct hda_gen_spec *spec)
+{
+	if (spec->kctls.list) {
+		struct snd_kcontrol_new *kctl = spec->kctls.list;
+		int i;
+		for (i = 0; i < spec->kctls.used; i++)
+			kfree(kctl[i].name);
+	}
+	snd_array_free(&spec->kctls);
+}
 
-	struct hda_pcm pcm_rec;		/* PCM information */
+static struct hda_bind_ctls *new_bind_ctl(struct hda_codec *codec,
+					  unsigned int nums,
+					  struct hda_ctl_ops *ops)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_bind_ctls **ctlp, *ctl;
+	ctlp = snd_array_new(&spec->bind_ctls);
+	if (!ctlp)
+		return NULL;
+	ctl = kzalloc(sizeof(*ctl) + sizeof(long) * (nums + 1), GFP_KERNEL);
+	*ctlp = ctl;
+	if (ctl)
+		ctl->ops = ops;
+	return ctl;
+}
 
-	struct list_head nid_list;	/* list of widgets */
+static void free_bind_ctls(struct hda_gen_spec *spec)
+{
+	if (spec->bind_ctls.list) {
+		struct hda_bind_ctls **ctl = spec->bind_ctls.list;
+		int i;
+		for (i = 0; i < spec->bind_ctls.used; i++)
+			kfree(ctl[i]);
+	}
+	snd_array_free(&spec->bind_ctls);
+}
 
-#ifdef CONFIG_PM
-#define MAX_LOOPBACK_AMPS	7
-	struct hda_loopback_check loopback;
-	int num_loopbacks;
-	struct hda_amp_list loopback_list[MAX_LOOPBACK_AMPS + 1];
-#endif
-};
+void snd_hda_gen_spec_free(struct hda_gen_spec *spec)
+{
+	if (!spec)
+		return;
+	free_kctls(spec);
+	free_bind_ctls(spec);
+	snd_array_free(&spec->paths);
+}
+EXPORT_SYMBOL_HDA(snd_hda_gen_spec_free);
 
 /*
- * retrieve the default device type from the default config value
+ * parsing paths
  */
-#define defcfg_type(node) (((node)->def_cfg & AC_DEFCFG_DEVICE) >> \
-			   AC_DEFCFG_DEVICE_SHIFT)
-#define defcfg_location(node) (((node)->def_cfg & AC_DEFCFG_LOCATION) >> \
-			       AC_DEFCFG_LOCATION_SHIFT)
-#define defcfg_port_conn(node) (((node)->def_cfg & AC_DEFCFG_PORT_CONN) >> \
-				AC_DEFCFG_PORT_CONN_SHIFT)
 
-/*
- * destructor
+/* get the path between the given NIDs;
+ * passing 0 to either @pin or @dac behaves as a wildcard
  */
-static void snd_hda_generic_free(struct hda_codec *codec)
+struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
+				      hda_nid_t from_nid, hda_nid_t to_nid)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_gnode *node, *n;
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
 
-	if (! spec)
-		return;
-	/* free all widgets */
-	list_for_each_entry_safe(node, n, &spec->nid_list, list) {
-		if (node->conn_list != node->slist)
-			kfree(node->conn_list);
-		kfree(node);
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, i);
+		if (path->depth <= 0)
+			continue;
+		if ((!from_nid || path->path[0] == from_nid) &&
+		    (!to_nid || path->path[path->depth - 1] == to_nid))
+			return path;
 	}
-	kfree(spec);
+	return NULL;
 }
+EXPORT_SYMBOL_HDA(snd_hda_get_nid_path);
 
-
-/*
- * add a new widget node and read its attributes
- */
-static int add_new_node(struct hda_codec *codec, struct hda_gspec *spec, hda_nid_t nid)
+/* check whether the given DAC is already found in any existing paths */
+static bool is_dac_already_used(struct hda_codec *codec, hda_nid_t nid)
 {
-	struct hda_gnode *node;
-	int nconns;
-	hda_nid_t conn_list[HDA_MAX_CONNECTIONS];
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
 
-	node = kzalloc(sizeof(*node), GFP_KERNEL);
-	if (node == NULL)
-		return -ENOMEM;
-	node->nid = nid;
-	node->wid_caps = get_wcaps(codec, nid);
-	node->type = get_wcaps_type(node->wid_caps);
-	if (node->wid_caps & AC_WCAP_CONN_LIST) {
-		nconns = snd_hda_get_connections(codec, nid, conn_list,
-						 HDA_MAX_CONNECTIONS);
-		if (nconns < 0) {
-			kfree(node);
-			return nconns;
-		}
-	} else {
-		nconns = 0;
-	}
-	if (nconns <= ARRAY_SIZE(node->slist))
-		node->conn_list = node->slist;
-	else {
-		node->conn_list = kmalloc(sizeof(hda_nid_t) * nconns,
-					  GFP_KERNEL);
-		if (! node->conn_list) {
-			snd_printk(KERN_ERR "hda-generic: cannot malloc\n");
-			kfree(node);
-			return -ENOMEM;
-		}
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, i);
+		if (path->path[0] == nid)
+			return true;
 	}
-	memcpy(node->conn_list, conn_list, nconns * sizeof(hda_nid_t));
-	node->nconns = nconns;
+	return false;
+}
 
-	if (node->type == AC_WID_PIN) {
-		node->pin_caps = snd_hda_query_pin_caps(codec, node->nid);
-		node->pin_ctl = snd_hda_codec_read(codec, node->nid, 0, AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
-		node->def_cfg = snd_hda_codec_get_pincfg(codec, node->nid);
-	}
+/* check whether the given two widgets can be connected */
+static bool is_reachable_path(struct hda_codec *codec,
+			      hda_nid_t from_nid, hda_nid_t to_nid)
+{
+	if (!from_nid || !to_nid)
+		return false;
+	return snd_hda_get_conn_index(codec, to_nid, from_nid, true) >= 0;
+}
 
-	if (node->wid_caps & AC_WCAP_OUT_AMP) {
-		if (node->wid_caps & AC_WCAP_AMP_OVRD)
-			node->amp_out_caps = snd_hda_param_read(codec, node->nid, AC_PAR_AMP_OUT_CAP);
-		if (! node->amp_out_caps)
-			node->amp_out_caps = spec->def_amp_out_caps;
-	}
-	if (node->wid_caps & AC_WCAP_IN_AMP) {
-		if (node->wid_caps & AC_WCAP_AMP_OVRD)
-			node->amp_in_caps = snd_hda_param_read(codec, node->nid, AC_PAR_AMP_IN_CAP);
-		if (! node->amp_in_caps)
-			node->amp_in_caps = spec->def_amp_in_caps;
+/* nid, dir and idx */
+#define AMP_VAL_COMPARE_MASK	(0xffff | (1U << 18) | (0x0f << 19))
+
+/* check whether the given ctl is already assigned in any path elements */
+static bool is_ctl_used(struct hda_codec *codec, unsigned int val, int type)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+
+	val &= AMP_VAL_COMPARE_MASK;
+	for (i = 0; i < spec->paths.used; i++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, i);
+		if ((path->ctls[type] & AMP_VAL_COMPARE_MASK) == val)
+			return true;
 	}
-	list_add_tail(&node->list, &spec->nid_list);
-	return 0;
+	return false;
 }
 
-/*
- * build the AFG subtree
- */
-static int build_afg_tree(struct hda_codec *codec)
+/* check whether a control with the given (nid, dir, idx) was assigned */
+static bool is_ctl_associated(struct hda_codec *codec, hda_nid_t nid,
+			      int dir, int idx)
 {
-	struct hda_gspec *spec = codec->spec;
-	int i, nodes, err;
-	hda_nid_t nid;
-
-	if (snd_BUG_ON(!spec))
-		return -EINVAL;
-
-	spec->def_amp_out_caps = snd_hda_param_read(codec, codec->afg, AC_PAR_AMP_OUT_CAP);
-	spec->def_amp_in_caps = snd_hda_param_read(codec, codec->afg, AC_PAR_AMP_IN_CAP);
+	unsigned int val = HDA_COMPOSE_AMP_VAL(nid, 3, idx, dir);
+	return is_ctl_used(codec, val, NID_PATH_VOL_CTL) ||
+		is_ctl_used(codec, val, NID_PATH_MUTE_CTL);
+}
 
-	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
-	if (! nid || nodes < 0) {
-		printk(KERN_ERR "Invalid AFG subtree\n");
-		return -EINVAL;
+/* called recursively */
+static bool __parse_nid_path(struct hda_codec *codec,
+			     hda_nid_t from_nid, hda_nid_t to_nid,
+			     int with_aa_mix, struct nid_path *path, int depth)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t conn[16];
+	int i, nums;
+
+	if (to_nid == spec->mixer_nid) {
+		if (!with_aa_mix)
+			return false;
+		with_aa_mix = 2; /* mark aa-mix is included */
 	}
 
-	/* parse all nodes belonging to the AFG */
-	for (i = 0; i < nodes; i++, nid++) {
-		if ((err = add_new_node(codec, spec, nid)) < 0)
-			return err;
+	nums = snd_hda_get_connections(codec, to_nid, conn, ARRAY_SIZE(conn));
+	for (i = 0; i < nums; i++) {
+		if (conn[i] != from_nid) {
+			/* special case: when from_nid is 0,
+			 * try to find an empty DAC
+			 */
+			if (from_nid ||
+			    get_wcaps_type(get_wcaps(codec, conn[i])) != AC_WID_AUD_OUT ||
+			    is_dac_already_used(codec, conn[i]))
+				continue;
+		}
+		/* aa-mix is requested but not included? */
+		if (!(spec->mixer_nid && with_aa_mix == 1))
+			goto found;
 	}
-
-	return 0;
+	if (depth >= MAX_NID_PATH_DEPTH)
+		return false;
+	for (i = 0; i < nums; i++) {
+		unsigned int type;
+		type = get_wcaps_type(get_wcaps(codec, conn[i]));
+		if (type == AC_WID_AUD_OUT || type == AC_WID_AUD_IN ||
+		    type == AC_WID_PIN)
+			continue;
+		if (__parse_nid_path(codec, from_nid, conn[i],
+				     with_aa_mix, path, depth + 1))
+			goto found;
+	}
+	return false;
+
+ found:
+	path->path[path->depth] = conn[i];
+	path->idx[path->depth + 1] = i;
+	if (nums > 1 && get_wcaps_type(get_wcaps(codec, to_nid)) != AC_WID_AUD_MIX)
+		path->multi[path->depth + 1] = 1;
+	path->depth++;
+	return true;
 }
 
-
-/*
- * look for the node record for the given NID
+/* parse the widget path from the given nid to the target nid;
+ * when @from_nid is 0, try to find an empty DAC;
+ * when @with_aa_mix is 0, paths with spec->mixer_nid are excluded.
+ * when @with_aa_mix is 1, paths without spec->mixer_nid are excluded.
+ * when @with_aa_mix is 2, no special handling about spec->mixer_nid.
  */
-/* FIXME: should avoid the braindead linear search */
-static struct hda_gnode *hda_get_node(struct hda_gspec *spec, hda_nid_t nid)
+bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
+			    hda_nid_t to_nid, int with_aa_mix,
+			    struct nid_path *path)
 {
-	struct hda_gnode *node;
-
-	list_for_each_entry(node, &spec->nid_list, list) {
-		if (node->nid == nid)
-			return node;
+	if (__parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path, 1)) {
+		path->path[path->depth] = to_nid;
+		path->depth++;
+#if 0
+		snd_printdd("path: depth=%d, %02x/%02x/%02x/%02x/%02x\n",
+			    path->depth, path->path[0], path->path[1],
+			    path->path[2], path->path[3], path->path[4]);
+#endif
+		return true;
 	}
-	return NULL;
+	return false;
 }
+EXPORT_SYMBOL_HDA(snd_hda_parse_nid_path);
 
 /*
- * unmute (and set max vol) the output amplifier
+ * parse the path between the given NIDs and add to the path list.
+ * if no valid path is found, return NULL
  */
-static int unmute_output(struct hda_codec *codec, struct hda_gnode *node)
-{
-	unsigned int val, ofs;
-	snd_printdd("UNMUTE OUT: NID=0x%x\n", node->nid);
-	val = (node->amp_out_caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
-	ofs = (node->amp_out_caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
-	if (val >= ofs)
-		val -= ofs;
-	snd_hda_codec_amp_stereo(codec, node->nid, HDA_OUTPUT, 0, 0xff, val);
-	return 0;
+struct nid_path *
+snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
+		     hda_nid_t to_nid, int with_aa_mix)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *path;
+
+	if (from_nid && to_nid && !is_reachable_path(codec, from_nid, to_nid))
+		return NULL;
+
+	path = snd_array_new(&spec->paths);
+	if (!path)
+		return NULL;
+	memset(path, 0, sizeof(*path));
+	if (snd_hda_parse_nid_path(codec, from_nid, to_nid, with_aa_mix, path))
+		return path;
+	/* push back */
+	spec->paths.used--;
+	return NULL;
 }
+EXPORT_SYMBOL_HDA(snd_hda_add_new_path);
 
-/*
- * unmute (and set max vol) the input amplifier
- */
-static int unmute_input(struct hda_codec *codec, struct hda_gnode *node, unsigned int index)
-{
-	unsigned int val, ofs;
-	snd_printdd("UNMUTE IN: NID=0x%x IDX=0x%x\n", node->nid, index);
-	val = (node->amp_in_caps & AC_AMPCAP_NUM_STEPS) >> AC_AMPCAP_NUM_STEPS_SHIFT;
-	ofs = (node->amp_in_caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
-	if (val >= ofs)
-		val -= ofs;
-	snd_hda_codec_amp_stereo(codec, node->nid, HDA_INPUT, index, 0xff, val);
+/* look for an empty DAC slot */
+static hda_nid_t look_for_dac(struct hda_codec *codec, hda_nid_t pin,
+			      bool is_digital)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	bool cap_digital;
+	int i;
+
+	for (i = 0; i < spec->num_all_dacs; i++) {
+		hda_nid_t nid = spec->all_dacs[i];
+		if (!nid || is_dac_already_used(codec, nid))
+			continue;
+		cap_digital = !!(get_wcaps(codec, nid) & AC_WCAP_DIGITAL);
+		if (is_digital != cap_digital)
+			continue;
+		if (is_reachable_path(codec, nid, pin))
+			return nid;
+	}
 	return 0;
 }
 
-/*
- * select the input connection of the given node.
- */
-static int select_input_connection(struct hda_codec *codec, struct hda_gnode *node,
-				   unsigned int index)
+/* replace the channels in the composed amp value with the given number */
+static unsigned int amp_val_replace_channels(unsigned int val, unsigned int chs)
 {
-	snd_printdd("CONNECT: NID=0x%x IDX=0x%x\n", node->nid, index);
-	return snd_hda_codec_write_cache(codec, node->nid, 0,
-					 AC_VERB_SET_CONNECT_SEL, index);
+	val &= ~(0x3U << 16);
+	val |= chs << 16;
+	return val;
 }
 
-/*
- * clear checked flag of each node in the node list
- */
-static void clear_check_flags(struct hda_gspec *spec)
+/* check whether the widget has the given amp capability for the direction */
+static bool check_amp_caps(struct hda_codec *codec, hda_nid_t nid,
+			   int dir, unsigned int bits)
 {
-	struct hda_gnode *node;
+	if (!nid)
+		return false;
+	if (get_wcaps(codec, nid) & (1 << (dir + 1)))
+		if (query_amp_caps(codec, nid, dir) & bits)
+			return true;
+	return false;
+}
+
+#define nid_has_mute(codec, nid, dir) \
+	check_amp_caps(codec, nid, dir, AC_AMPCAP_MUTE)
+#define nid_has_volume(codec, nid, dir) \
+	check_amp_caps(codec, nid, dir, AC_AMPCAP_NUM_STEPS)
+
+/* look for a widget suitable for assigning a mute switch in the path */
+static hda_nid_t look_for_out_mute_nid(struct hda_codec *codec,
+				       struct nid_path *path)
+{
+	int i;
+
+	for (i = path->depth - 1; i >= 0; i--) {
+		if (nid_has_mute(codec, path->path[i], HDA_OUTPUT))
+			return path->path[i];
+		if (i != path->depth - 1 && i != 0 &&
+		    nid_has_mute(codec, path->path[i], HDA_INPUT))
+			return path->path[i];
+	}
+	return 0;
+}
+
+/* look for a widget suitable for assigning a volume ctl in the path */
+static hda_nid_t look_for_out_vol_nid(struct hda_codec *codec,
+				      struct nid_path *path)
+{
+	int i;
 
-	list_for_each_entry(node, &spec->nid_list, list) {
-		node->checked = 0;
+	for (i = path->depth - 1; i >= 0; i--) {
+		if (nid_has_volume(codec, path->path[i], HDA_OUTPUT))
+			return path->path[i];
 	}
+	return 0;
 }
 
 /*
- * parse the output path recursively until reach to an audio output widget
- *
- * returns 0 if not found, 1 if found, or a negative error code.
+ * path activation / deactivation
  */
-static int parse_output_path(struct hda_codec *codec, struct hda_gspec *spec,
-			     struct hda_gnode *node, int dac_idx)
+
+/* can have the amp-in capability? */
+static bool has_amp_in(struct hda_codec *codec, struct nid_path *path, int idx)
 {
-	int i, err;
-	struct hda_gnode *child;
+	hda_nid_t nid = path->path[idx];
+	unsigned int caps = get_wcaps(codec, nid);
+	unsigned int type = get_wcaps_type(caps);
+
+	if (!(caps & AC_WCAP_IN_AMP))
+		return false;
+	if (type == AC_WID_PIN && idx > 0) /* only for input pins */
+		return false;
+	return true;
+}
 
-	if (node->checked)
-		return 0;
+/* can have the amp-out capability? */
+static bool has_amp_out(struct hda_codec *codec, struct nid_path *path, int idx)
+{
+	hda_nid_t nid = path->path[idx];
+	unsigned int caps = get_wcaps(codec, nid);
+	unsigned int type = get_wcaps_type(caps);
+
+	if (!(caps & AC_WCAP_OUT_AMP))
+		return false;
+	if (type == AC_WID_PIN && !idx) /* only for output pins */
+		return false;
+	return true;
+}
 
-	node->checked = 1;
-	if (node->type == AC_WID_AUD_OUT) {
-		if (node->wid_caps & AC_WCAP_DIGITAL) {
-			snd_printdd("Skip Digital OUT node %x\n", node->nid);
-			return 0;
-		}
-		snd_printdd("AUD_OUT found %x\n", node->nid);
-		if (spec->dac_node[dac_idx]) {
-			/* already DAC node is assigned, just unmute & connect */
-			return node == spec->dac_node[dac_idx];
-		}
-		spec->dac_node[dac_idx] = node;
-		if ((node->wid_caps & AC_WCAP_OUT_AMP) &&
-		    spec->pcm_vol_nodes < MAX_PCM_VOLS) {
-			spec->pcm_vol[spec->pcm_vol_nodes].node = node;
-			spec->pcm_vol[spec->pcm_vol_nodes].index = 0;
-			spec->pcm_vol_nodes++;
-		}
-		return 1; /* found */
-	}
+/* check whether the given (nid,dir,idx) is active */
+static bool is_active_nid(struct hda_codec *codec, hda_nid_t nid,
+			  unsigned int idx, unsigned int dir)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i, n;
 
-	for (i = 0; i < node->nconns; i++) {
-		child = hda_get_node(spec, node->conn_list[i]);
-		if (! child)
+	for (n = 0; n < spec->paths.used; n++) {
+		struct nid_path *path = snd_array_elem(&spec->paths, n);
+		if (!path->active)
 			continue;
-		err = parse_output_path(codec, spec, child, dac_idx);
-		if (err < 0)
-			return err;
-		else if (err > 0) {
-			/* found one,
-			 * select the path, unmute both input and output
-			 */
-			if (node->nconns > 1)
-				select_input_connection(codec, node, i);
-			unmute_input(codec, node, i);
-			unmute_output(codec, node);
-			if (spec->dac_node[dac_idx] &&
-			    spec->pcm_vol_nodes < MAX_PCM_VOLS &&
-			    !(spec->dac_node[dac_idx]->wid_caps &
-			      AC_WCAP_OUT_AMP)) {
-				if ((node->wid_caps & AC_WCAP_IN_AMP) ||
-				    (node->wid_caps & AC_WCAP_OUT_AMP)) {
-					int n = spec->pcm_vol_nodes;
-					spec->pcm_vol[n].node = node;
-					spec->pcm_vol[n].index = i;
-					spec->pcm_vol_nodes++;
-				}
+		for (i = 0; i < path->depth; i++) {
+			if (path->path[i] == nid) {
+				if (dir == HDA_OUTPUT || path->idx[i] == idx)
+					return true;
+				break;
 			}
-			return 1;
 		}
 	}
-	return 0;
+	return false;
 }
 
-/*
- * Look for the output PIN widget with the given jack type
- * and parse the output path to that PIN.
- *
- * Returns the PIN node when the path to DAC is established.
- */
-static struct hda_gnode *parse_output_jack(struct hda_codec *codec,
-					   struct hda_gspec *spec,
-					   int jack_type)
+/* get the default amp value for the target state */
+static int get_amp_val_to_activate(struct hda_codec *codec, hda_nid_t nid,
+				   int dir, bool enable)
 {
-	struct hda_gnode *node;
-	int err;
-
-	list_for_each_entry(node, &spec->nid_list, list) {
-		if (node->type != AC_WID_PIN)
-			continue;
-		/* output capable? */
-		if (! (node->pin_caps & AC_PINCAP_OUT))
-			continue;
-		if (defcfg_port_conn(node) == AC_JACK_PORT_NONE)
-			continue; /* unconnected */
-		if (jack_type >= 0) {
-			if (jack_type != defcfg_type(node))
-				continue;
-			if (node->wid_caps & AC_WCAP_DIGITAL)
-				continue; /* skip SPDIF */
-		} else {
-			/* output as default? */
-			if (! (node->pin_ctl & AC_PINCTL_OUT_EN))
-				continue;
-		}
-		clear_check_flags(spec);
-		err = parse_output_path(codec, spec, node, 0);
-		if (err < 0)
-			return NULL;
-		if (! err && spec->out_pin_node[0]) {
-			err = parse_output_path(codec, spec, node, 1);
-			if (err < 0)
-				return NULL;
-		}
-		if (err > 0) {
-			/* unmute the PIN output */
-			unmute_output(codec, node);
-			/* set PIN-Out enable */
-			snd_hda_codec_write_cache(codec, node->nid, 0,
-					    AC_VERB_SET_PIN_WIDGET_CONTROL,
-					    AC_PINCTL_OUT_EN |
-					    ((node->pin_caps & AC_PINCAP_HP_DRV) ?
-					     AC_PINCTL_HP_EN : 0));
-			return node;
-		}
+	unsigned int caps;
+	unsigned int val = 0;
+
+	caps = query_amp_caps(codec, nid, dir);
+	if (caps & AC_AMPCAP_NUM_STEPS) {
+		/* set to 0dB */
+		if (enable)
+			val = (caps & AC_AMPCAP_OFFSET) >> AC_AMPCAP_OFFSET_SHIFT;
 	}
-	return NULL;
+	if (caps & AC_AMPCAP_MUTE) {
+		if (!enable)
+			val |= HDA_AMP_MUTE;
+	}
+	return val;
 }
 
+/* initialize the amp value (only at the first time) */
+static void init_amp(struct hda_codec *codec, hda_nid_t nid, int dir, int idx)
+{
+	int val = get_amp_val_to_activate(codec, nid, dir, false);
+	snd_hda_codec_amp_init_stereo(codec, nid, dir, idx, 0xff, val);
+}
 
-/*
- * parse outputs
- */
-static int parse_output(struct hda_codec *codec)
+static void activate_amp(struct hda_codec *codec, hda_nid_t nid, int dir,
+			 int idx, bool enable)
+{
+	int val;
+	if (is_ctl_associated(codec, nid, dir, idx) ||
+	    is_active_nid(codec, nid, dir, idx))
+		return;
+	val = get_amp_val_to_activate(codec, nid, dir, enable);
+	snd_hda_codec_amp_stereo(codec, nid, dir, idx, 0xff, val);
+}
+
+static void activate_amp_out(struct hda_codec *codec, struct nid_path *path,
+			     int i, bool enable)
+{
+	hda_nid_t nid = path->path[i];
+	init_amp(codec, nid, HDA_OUTPUT, 0);
+	activate_amp(codec, nid, HDA_OUTPUT, 0, enable);
+}
+
+static void activate_amp_in(struct hda_codec *codec, struct nid_path *path,
+			    int i, bool enable, bool add_aamix)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_gnode *node;
+	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t conn[16];
+	int n, nums, idx;
+	int type;
+	hda_nid_t nid = path->path[i];
+
+	nums = snd_hda_get_connections(codec, nid, conn, ARRAY_SIZE(conn));
+	type = get_wcaps_type(get_wcaps(codec, nid));
+	if (type == AC_WID_PIN ||
+	    (type == AC_WID_AUD_IN && codec->single_adc_amp)) {
+		nums = 1;
+		idx = 0;
+	} else
+		idx = path->idx[i];
+
+	for (n = 0; n < nums; n++)
+		init_amp(codec, nid, HDA_INPUT, n);
+
+	if (is_ctl_associated(codec, nid, HDA_INPUT, idx))
+		return;
 
-	/*
-	 * Look for the output PIN widget
+	/* here is a little bit tricky in comparison with activate_amp_out();
+	 * when aa-mixer is available, we need to enable the path as well
 	 */
-	/* first, look for the line-out pin */
-	node = parse_output_jack(codec, spec, AC_JACK_LINE_OUT);
-	if (node) /* found, remember the PIN node */
-		spec->out_pin_node[0] = node;
-	else {
-		/* if no line-out is found, try speaker out */
-		node = parse_output_jack(codec, spec, AC_JACK_SPEAKER);
-		if (node)
-			spec->out_pin_node[0] = node;
-	}
-	/* look for the HP-out pin */
-	node = parse_output_jack(codec, spec, AC_JACK_HP_OUT);
-	if (node) {
-		if (! spec->out_pin_node[0])
-			spec->out_pin_node[0] = node;
-		else
-			spec->out_pin_node[1] = node;
+	for (n = 0; n < nums; n++) {
+		if (n != idx && (!add_aamix || conn[n] != spec->mixer_nid))
+			continue;
+		activate_amp(codec, nid, HDA_INPUT, n, enable);
 	}
+}
 
-	if (! spec->out_pin_node[0]) {
-		/* no line-out or HP pins found,
-		 * then choose for the first output pin
-		 */
-		spec->out_pin_node[0] = parse_output_jack(codec, spec, -1);
-		if (! spec->out_pin_node[0])
-			snd_printd("hda_generic: no proper output path found\n");
+/* activate or deactivate the given path
+ * if @add_aamix is set, enable the input from aa-mix NID as well (if any)
+ */
+void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
+			   bool enable, bool add_aamix)
+{
+	int i;
+
+	if (!enable)
+		path->active = false;
+
+	for (i = path->depth - 1; i >= 0; i--) {
+		if (enable && path->multi[i])
+			snd_hda_codec_write_cache(codec, path->path[i], 0,
+					    AC_VERB_SET_CONNECT_SEL,
+					    path->idx[i]);
+		if (has_amp_in(codec, path, i))
+			activate_amp_in(codec, path, i, enable, add_aamix);
+		if (has_amp_out(codec, path, i))
+			activate_amp_out(codec, path, i, enable);
 	}
 
-	return 0;
+	if (enable)
+		path->active = true;
 }
+EXPORT_SYMBOL_HDA(snd_hda_activate_path);
+
 
 /*
- * input MUX
+ * Helper functions for creating mixer ctl elements
  */
 
-/* control callbacks */
-static int capture_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
-{
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_gspec *spec = codec->spec;
-	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
-}
+enum {
+	HDA_CTL_WIDGET_VOL,
+	HDA_CTL_WIDGET_MUTE,
+	HDA_CTL_BIND_MUTE,
+	HDA_CTL_BIND_VOL,
+	HDA_CTL_BIND_SW,
+};
+static const struct snd_kcontrol_new control_templates[] = {
+	HDA_CODEC_VOLUME(NULL, 0, 0, 0),
+	HDA_CODEC_MUTE(NULL, 0, 0, 0),
+	HDA_BIND_MUTE(NULL, 0, 0, 0),
+	HDA_BIND_VOL(NULL, 0),
+	HDA_BIND_SW(NULL, 0),
+};
 
-static int capture_source_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+/* add dynamic controls from template */
+static int add_control(struct hda_gen_spec *spec, int type, const char *name,
+		       int cidx, unsigned long val)
 {
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_gspec *spec = codec->spec;
+	struct snd_kcontrol_new *knew;
 
-	ucontrol->value.enumerated.item[0] = spec->cur_cap_src;
+	knew = add_kctl(spec, name, &control_templates[type]);
+	if (!knew)
+		return -ENOMEM;
+	knew->index = cidx;
+	if (get_amp_nid_(val))
+		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
+	knew->private_value = val;
 	return 0;
 }
 
-static int capture_source_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+static int add_control_with_pfx(struct hda_gen_spec *spec, int type,
+				const char *pfx, const char *dir,
+				const char *sfx, int cidx, unsigned long val)
 {
-	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
-	struct hda_gspec *spec = codec->spec;
-	return snd_hda_input_mux_put(codec, &spec->input_mux, ucontrol,
-				     spec->adc_node->nid, &spec->cur_cap_src);
+	char name[32];
+	snprintf(name, sizeof(name), "%s %s %s", pfx, dir, sfx);
+	return add_control(spec, type, name, cidx, val);
 }
 
-/*
- * return the string name of the given input PIN widget
- */
-static const char *get_input_type(struct hda_gnode *node, unsigned int *pinctl)
-{
-	unsigned int location = defcfg_location(node);
-	switch (defcfg_type(node)) {
-	case AC_JACK_LINE_IN:
-		if ((location & 0x0f) == AC_JACK_LOC_FRONT)
-			return "Front Line";
-		return "Line";
-	case AC_JACK_CD:
-#if 0
-		if (pinctl)
-			*pinctl |= AC_PINCTL_VREF_GRD;
-#endif
-		return "CD";
-	case AC_JACK_AUX:
-		if ((location & 0x0f) == AC_JACK_LOC_FRONT)
-			return "Front Aux";
-		return "Aux";
-	case AC_JACK_MIC_IN:
-		if (pinctl &&
-		    (node->pin_caps &
-		     (AC_PINCAP_VREF_80 << AC_PINCAP_VREF_SHIFT)))
-			*pinctl |= AC_PINCTL_VREF_80;
-		if ((location & 0x0f) == AC_JACK_LOC_FRONT)
-			return "Front Mic";
-		return "Mic";
-	case AC_JACK_SPDIF_IN:
-		return "SPDIF";
-	case AC_JACK_DIG_OTHER_IN:
-		return "Digital";
+#define add_pb_vol_ctrl(spec, type, pfx, val)			\
+	add_control_with_pfx(spec, type, pfx, "Playback", "Volume", 0, val)
+#define add_pb_sw_ctrl(spec, type, pfx, val)			\
+	add_control_with_pfx(spec, type, pfx, "Playback", "Switch", 0, val)
+#define __add_pb_vol_ctrl(spec, type, pfx, cidx, val)			\
+	add_control_with_pfx(spec, type, pfx, "Playback", "Volume", cidx, val)
+#define __add_pb_sw_ctrl(spec, type, pfx, cidx, val)			\
+	add_control_with_pfx(spec, type, pfx, "Playback", "Switch", cidx, val)
+
+static int add_vol_ctl(struct hda_codec *codec, const char *pfx, int cidx,
+		       unsigned int chs, struct nid_path *path)
+{
+	unsigned int val;
+	if (!path)
+		return 0;
+	val = path->ctls[NID_PATH_VOL_CTL];
+	if (!val)
+		return 0;
+	val = amp_val_replace_channels(val, chs);
+	return __add_pb_vol_ctrl(codec->spec, HDA_CTL_WIDGET_VOL, pfx, cidx, val);
+}
+
+/* return the channel bits suitable for the given path->ctls[] */
+static int get_default_ch_nums(struct hda_codec *codec, struct nid_path *path,
+			       int type)
+{
+	int chs = 1; /* mono (left only) */
+	if (path) {
+		hda_nid_t nid = get_amp_nid_(path->ctls[type]);
+		if (nid && (get_wcaps(codec, nid) & AC_WCAP_STEREO))
+			chs = 3; /* stereo */
 	}
-	return NULL;
+	return chs;
 }
 
-/*
- * parse the nodes recursively until reach to the input PIN
- *
- * returns 0 if not found, 1 if found, or a negative error code.
+static int add_stereo_vol(struct hda_codec *codec, const char *pfx, int cidx,
+			  struct nid_path *path)
+{
+	int chs = get_default_ch_nums(codec, path, NID_PATH_VOL_CTL);
+	return add_vol_ctl(codec, pfx, cidx, chs, path);
+}
+
+/* create a mute-switch for the given mixer widget;
+ * if it has multiple sources (e.g. DAC and loopback), create a bind-mute
  */
-static int parse_adc_sub_nodes(struct hda_codec *codec, struct hda_gspec *spec,
-			       struct hda_gnode *node, int idx)
+static int add_sw_ctl(struct hda_codec *codec, const char *pfx, int cidx,
+		      unsigned int chs, struct nid_path *path)
 {
-	int i, err;
-	unsigned int pinctl;
-	const char *type;
+	unsigned int val;
+	int type = HDA_CTL_WIDGET_MUTE;
 
-	if (node->checked)
+	if (!path)
 		return 0;
-
-	node->checked = 1;
-	if (node->type != AC_WID_PIN) {
-		for (i = 0; i < node->nconns; i++) {
-			struct hda_gnode *child;
-			child = hda_get_node(spec, node->conn_list[i]);
-			if (! child)
-				continue;
-			err = parse_adc_sub_nodes(codec, spec, child, idx);
-			if (err < 0)
-				return err;
-			if (err > 0) {
-				/* found one,
-				 * select the path, unmute both input and output
-				 */
-				if (node->nconns > 1)
-					select_input_connection(codec, node, i);
-				unmute_input(codec, node, i);
-				unmute_output(codec, node);
-				return err;
-			}
-		}
+	val = path->ctls[NID_PATH_MUTE_CTL];
+	if (!val)
 		return 0;
+	val = amp_val_replace_channels(val, chs);
+	if (get_amp_direction_(val) == HDA_INPUT) {
+		hda_nid_t nid = get_amp_nid_(val);
+		int nums = snd_hda_get_num_conns(codec, nid);
+		if (nums > 1) {
+			type = HDA_CTL_BIND_MUTE;
+			val |= nums << 19;
+		}
 	}
+	return __add_pb_sw_ctrl(codec->spec, type, pfx, cidx, val);
+}
 
-	/* input capable? */
-	if (! (node->pin_caps & AC_PINCAP_IN))
-		return 0;
+static int add_stereo_sw(struct hda_codec *codec, const char *pfx,
+				  int cidx, struct nid_path *path)
+{
+	int chs = get_default_ch_nums(codec, path, NID_PATH_MUTE_CTL);
+	return add_sw_ctl(codec, pfx, cidx, chs, path);
+}
 
-	if (defcfg_port_conn(node) == AC_JACK_PORT_NONE)
-		return 0; /* unconnected */
+static const char * const channel_name[4] = {
+	"Front", "Surround", "CLFE", "Side"
+};
 
-	if (node->wid_caps & AC_WCAP_DIGITAL)
-		return 0; /* skip SPDIF */
+/* give some appropriate ctl name prefix for the given line out channel */
+static const char *get_line_out_pfx(struct hda_gen_spec *spec, int ch,
+				    bool can_be_master, int *index)
+{
+	struct auto_pin_cfg *cfg = &spec->autocfg;
 
-	if (spec->input_mux.num_items >= HDA_MAX_NUM_INPUTS) {
-		snd_printk(KERN_ERR "hda_generic: Too many items for capture\n");
-		return -EINVAL;
-	}
+	*index = 0;
+	if (cfg->line_outs == 1 && !spec->multi_ios &&
+	    !cfg->hp_outs && !cfg->speaker_outs && can_be_master)
+		return spec->vmaster_mute.hook ? "PCM" : "Master";
 
-	pinctl = AC_PINCTL_IN_EN;
-	/* create a proper capture source label */
-	type = get_input_type(node, &pinctl);
-	if (! type) {
-		/* input as default? */
-		if (! (node->pin_ctl & AC_PINCTL_IN_EN))
-			return 0;
-		type = "Input";
+	/* if there is really a single DAC used in the whole output paths,
+	 * use it master (or "PCM" if a vmaster hook is present)
+	 */
+	if (spec->multiout.num_dacs == 1 && !spec->mixer_nid &&
+	    !spec->multiout.hp_out_nid[0] && !spec->multiout.extra_out_nid[0])
+		return spec->vmaster_mute.hook ? "PCM" : "Master";
+
+	switch (cfg->line_out_type) {
+	case AUTO_PIN_SPEAKER_OUT:
+		if (cfg->line_outs == 1)
+			return "Speaker";
+		if (cfg->line_outs == 2)
+			return ch ? "Bass Speaker" : "Speaker";
+		break;
+	case AUTO_PIN_HP_OUT:
+		/* for multi-io case, only the primary out */
+		if (ch && spec->multi_ios)
+			break;
+		*index = ch;
+		return "Headphone";
+	default:
+		if (cfg->line_outs == 1 && !spec->multi_ios)
+			return "PCM";
+		break;
+	}
+	if (ch >= ARRAY_SIZE(channel_name)) {
+		snd_BUG();
+		return "PCM";
 	}
-	snd_hda_add_imux_item(&spec->input_mux, type, idx, NULL);
-
-	/* unmute the PIN external input */
-	unmute_input(codec, node, 0); /* index = 0? */
-	/* set PIN-In enable */
-	snd_hda_codec_write_cache(codec, node->nid, 0,
-				  AC_VERB_SET_PIN_WIDGET_CONTROL, pinctl);
 
-	return 1; /* found */
+	return channel_name[ch];
 }
 
 /*
- * parse input
+ * Parse output paths
  */
-static int parse_input_path(struct hda_codec *codec, struct hda_gnode *adc_node)
+
+/* badness definition */
+enum {
+	/* No primary DAC is found for the main output */
+	BAD_NO_PRIMARY_DAC = 0x10000,
+	/* No DAC is found for the extra output */
+	BAD_NO_DAC = 0x4000,
+	/* No possible multi-ios */
+	BAD_MULTI_IO = 0x103,
+	/* No individual DAC for extra output */
+	BAD_NO_EXTRA_DAC = 0x102,
+	/* No individual DAC for extra surrounds */
+	BAD_NO_EXTRA_SURR_DAC = 0x101,
+	/* Primary DAC shared with main surrounds */
+	BAD_SHARED_SURROUND = 0x100,
+	/* Primary DAC shared with main CLFE */
+	BAD_SHARED_CLFE = 0x10,
+	/* Primary DAC shared with extra surrounds */
+	BAD_SHARED_EXTRA_SURROUND = 0x10,
+	/* Volume widget is shared */
+	BAD_SHARED_VOL = 0x10,
+};
+
+/* look for widgets in the path between the given NIDs appropriate for
+ * volume and mute controls, and assign the values to ctls[].
+ *
+ * When no appropriate widget is found in the path, the badness value
+ * is incremented depending on the situation.  The function returns the
+ * total badness for both volume and mute controls.
+ */
+static int assign_out_path_ctls(struct hda_codec *codec, hda_nid_t pin,
+				hda_nid_t dac)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_gnode *node;
-	int i, err;
+	struct nid_path *path = snd_hda_get_nid_path(codec, dac, pin);
+	hda_nid_t nid;
+	unsigned int val;
+	int badness = 0;
+
+	if (!path)
+		return BAD_SHARED_VOL * 2;
+	nid = look_for_out_vol_nid(codec, path);
+	if (nid) {
+		val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+		if (is_ctl_used(codec, val, NID_PATH_VOL_CTL))
+			badness += BAD_SHARED_VOL;
+		else
+			path->ctls[NID_PATH_VOL_CTL] = val;
+	} else
+		badness += BAD_SHARED_VOL;
+	nid = look_for_out_mute_nid(codec, path);
+	if (nid) {
+		unsigned int wid_type = get_wcaps_type(get_wcaps(codec, nid));
+		if (wid_type == AC_WID_PIN || wid_type == AC_WID_AUD_OUT ||
+		    nid_has_mute(codec, nid, HDA_OUTPUT))
+			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+		else
+			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT);
+		if (is_ctl_used(codec, val, NID_PATH_MUTE_CTL))
+			badness += BAD_SHARED_VOL;
+		else
+			path->ctls[NID_PATH_MUTE_CTL] = val;
+	} else
+		badness += BAD_SHARED_VOL;
+	return badness;
+}
 
-	snd_printdd("AUD_IN = %x\n", adc_node->nid);
-	clear_check_flags(spec);
+struct badness_table {
+	int no_primary_dac;	/* no primary DAC */
+	int no_dac;		/* no secondary DACs */
+	int shared_primary;	/* primary DAC is shared with main output */
+	int shared_surr;	/* secondary DAC shared with main or primary */
+	int shared_clfe;	/* third DAC shared with main or primary */
+	int shared_surr_main;	/* secondary DAC sahred with main/DAC0 */
+};
 
-	// awk added - fixed no recording due to muted widget
-	unmute_input(codec, adc_node, 0);
-	
-	/*
-	 * check each connection of the ADC
-	 * if it reaches to a proper input PIN, add the path as the
-	 * input path.
-	 */
-	/* first, check the direct connections to PIN widgets */
-	for (i = 0; i < adc_node->nconns; i++) {
-		node = hda_get_node(spec, adc_node->conn_list[i]);
-		if (node && node->type == AC_WID_PIN) {
-			err = parse_adc_sub_nodes(codec, spec, node, i);
-			if (err < 0)
-				return err;
+static struct badness_table main_out_badness = {
+	.no_primary_dac = BAD_NO_PRIMARY_DAC,
+	.no_dac = BAD_NO_DAC,
+	.shared_primary = BAD_NO_PRIMARY_DAC,
+	.shared_surr = BAD_SHARED_SURROUND,
+	.shared_clfe = BAD_SHARED_CLFE,
+	.shared_surr_main = BAD_SHARED_SURROUND,
+};
+
+static struct badness_table extra_out_badness = {
+	.no_primary_dac = BAD_NO_DAC,
+	.no_dac = BAD_NO_DAC,
+	.shared_primary = BAD_NO_EXTRA_DAC,
+	.shared_surr = BAD_SHARED_EXTRA_SURROUND,
+	.shared_clfe = BAD_SHARED_EXTRA_SURROUND,
+	.shared_surr_main = BAD_NO_EXTRA_SURR_DAC,
+};
+
+/* try to assign DACs to pins and return the resultant badness */
+static int try_assign_dacs(struct hda_codec *codec, int num_outs,
+			   const hda_nid_t *pins, hda_nid_t *dacs,
+			   const struct badness_table *bad)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i, j;
+	int badness = 0;
+	hda_nid_t dac;
+
+	if (!num_outs)
+		return 0;
+
+	for (i = 0; i < num_outs; i++) {
+		hda_nid_t pin = pins[i];
+		if (!dacs[i])
+			dacs[i] = look_for_dac(codec, pin, false);
+		if (!dacs[i] && !i) {
+			for (j = 1; j < num_outs; j++) {
+				if (is_reachable_path(codec, dacs[j], pin)) {
+					dacs[0] = dacs[j];
+					dacs[j] = 0;
+					break;
+				}
+			}
 		}
-	}
-	/* ... then check the rests, more complicated connections */
-	for (i = 0; i < adc_node->nconns; i++) {
-		node = hda_get_node(spec, adc_node->conn_list[i]);
-		if (node && node->type != AC_WID_PIN) {
-			err = parse_adc_sub_nodes(codec, spec, node, i);
-			if (err < 0)
-				return err;
+		dac = dacs[i];
+		if (!dac) {
+			if (is_reachable_path(codec, dacs[0], pin))
+				dac = dacs[0];
+			else if (cfg->line_outs > i &&
+				 is_reachable_path(codec, spec->private_dac_nids[i], pin))
+				dac = spec->private_dac_nids[i];
+			if (dac) {
+				if (!i)
+					badness += bad->shared_primary;
+				else if (i == 1)
+					badness += bad->shared_surr;
+				else
+					badness += bad->shared_clfe;
+			} else if (is_reachable_path(codec, spec->private_dac_nids[0], pin)) {
+				dac = spec->private_dac_nids[0];
+				badness += bad->shared_surr_main;
+			} else if (!i)
+				badness += bad->no_primary_dac;
+			else
+				badness += bad->no_dac;
 		}
+		if (!snd_hda_add_new_path(codec, dac, pin, 0))
+			dac = dacs[i] = 0;
+		if (dac)
+			badness += assign_out_path_ctls(codec, pin, dac);
 	}
 
-	if (! spec->input_mux.num_items)
-		return 0; /* no input path found... */
-
-	snd_printdd("[Capture Source] NID=0x%x, #SRC=%d\n", adc_node->nid, spec->input_mux.num_items);
-	for (i = 0; i < spec->input_mux.num_items; i++)
-		snd_printdd("  [%s] IDX=0x%x\n", spec->input_mux.items[i].label,
-			    spec->input_mux.items[i].index);
-
-	spec->adc_node = adc_node;
-	return 1;
+	return badness;
 }
 
-/*
- * parse input
- */
-static int parse_input(struct hda_codec *codec)
+/* return NID if the given pin has only a single connection to a certain DAC */
+static hda_nid_t get_dac_if_single(struct hda_codec *codec, hda_nid_t pin)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_gnode *node;
-	int err;
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+	hda_nid_t nid_found = 0;
 
-	/*
-	 * At first we look for an audio input widget.
-	 * If it reaches to certain input PINs, we take it as the
-	 * input path.
-	 */
-	list_for_each_entry(node, &spec->nid_list, list) {
-		if (node->wid_caps & AC_WCAP_DIGITAL)
-			continue; /* skip SPDIF */
-		if (node->type == AC_WID_AUD_IN) {
-			err = parse_input_path(codec, node);
-			if (err < 0)
-				return err;
-			else if (err > 0)
+	for (i = 0; i < spec->num_all_dacs; i++) {
+		hda_nid_t nid = spec->all_dacs[i];
+		if (!nid || is_dac_already_used(codec, nid))
+			continue;
+		if (is_reachable_path(codec, nid, pin)) {
+			if (nid_found)
 				return 0;
+			nid_found = nid;
 		}
 	}
-	snd_printd("hda_generic: no proper input path found\n");
-	return 0;
+	return nid_found;
 }
 
-#ifdef CONFIG_PM
-static void add_input_loopback(struct hda_codec *codec, hda_nid_t nid,
-			       int dir, int idx)
+/* check whether the given pin can be a multi-io pin */
+static bool can_be_multiio_pin(struct hda_codec *codec,
+			       unsigned int location, hda_nid_t nid)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_amp_list *p;
-
-	if (spec->num_loopbacks >= MAX_LOOPBACK_AMPS) {
-		snd_printk(KERN_ERR "hda_generic: Too many loopback ctls\n");
-		return;
-	}
-	p = &spec->loopback_list[spec->num_loopbacks++];
-	p->nid = nid;
-	p->dir = dir;
-	p->idx = idx;
-	spec->loopback.amplist = spec->loopback_list;
+	unsigned int defcfg, caps;
+
+	defcfg = snd_hda_codec_get_pincfg(codec, nid);
+	if (get_defcfg_connect(defcfg) != AC_JACK_PORT_COMPLEX)
+		return false;
+	if (location && get_defcfg_location(defcfg) != location)
+		return false;
+	caps = snd_hda_query_pin_caps(codec, nid);
+	if (!(caps & AC_PINCAP_OUT))
+		return false;
+	return true;
 }
-#else
-#define add_input_loopback(codec,nid,dir,idx)
-#endif
 
 /*
- * create mixer controls if possible
+ * multi-io helper
+ *
+ * When hardwired is set, try to fill ony hardwired pins, and returns
+ * zero if any pins are filled, non-zero if nothing found.
+ * When hardwired is off, try to fill possible input pins, and returns
+ * the badness value.
  */
-static int create_mixer(struct hda_codec *codec, struct hda_gnode *node,
-			unsigned int index, const char *type,
-			const char *dir_sfx, int is_loopback)
+static int fill_multi_ios(struct hda_codec *codec,
+			  hda_nid_t reference_pin,
+			  bool hardwired, int offset)
 {
-	char name[32];
-	int err;
-	int created = 0;
-	struct snd_kcontrol_new knew;
-
-	if (type)
-		sprintf(name, "%s %s Switch", type, dir_sfx);
-	else
-		sprintf(name, "%s Switch", dir_sfx);
-	if ((node->wid_caps & AC_WCAP_IN_AMP) &&
-	    (node->amp_in_caps & AC_AMPCAP_MUTE)) {
-		knew = (struct snd_kcontrol_new)HDA_CODEC_MUTE(name, node->nid, index, HDA_INPUT);
-		if (is_loopback)
-			add_input_loopback(codec, node->nid, HDA_INPUT, index);
-		snd_printdd("[%s] NID=0x%x, DIR=IN, IDX=0x%x\n", name, node->nid, index);
-		err = snd_hda_ctl_add(codec, node->nid,
-					snd_ctl_new1(&knew, codec));
-		if (err < 0)
-			return err;
-		created = 1;
-	} else if ((node->wid_caps & AC_WCAP_OUT_AMP) &&
-		   (node->amp_out_caps & AC_AMPCAP_MUTE)) {
-		knew = (struct snd_kcontrol_new)HDA_CODEC_MUTE(name, node->nid, 0, HDA_OUTPUT);
-		if (is_loopback)
-			add_input_loopback(codec, node->nid, HDA_OUTPUT, 0);
-		snd_printdd("[%s] NID=0x%x, DIR=OUT\n", name, node->nid);
-		err = snd_hda_ctl_add(codec, node->nid,
-					snd_ctl_new1(&knew, codec));
-		if (err < 0)
-			return err;
-		created = 1;
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int type, i, j, dacs, num_pins, old_pins;
+	unsigned int defcfg = snd_hda_codec_get_pincfg(codec, reference_pin);
+	unsigned int location = get_defcfg_location(defcfg);
+	int badness = 0;
+
+	old_pins = spec->multi_ios;
+	if (old_pins >= 2)
+		goto end_fill;
+
+	num_pins = 0;
+	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
+		for (i = 0; i < cfg->num_inputs; i++) {
+			if (cfg->inputs[i].type != type)
+				continue;
+			if (can_be_multiio_pin(codec, location,
+					       cfg->inputs[i].pin))
+				num_pins++;
+		}
 	}
+	if (num_pins < 2)
+		goto end_fill;
 
-	if (type)
-		sprintf(name, "%s %s Volume", type, dir_sfx);
-	else
-		sprintf(name, "%s Volume", dir_sfx);
-	if ((node->wid_caps & AC_WCAP_IN_AMP) &&
-	    (node->amp_in_caps & AC_AMPCAP_NUM_STEPS)) {
-		knew = (struct snd_kcontrol_new)HDA_CODEC_VOLUME(name, node->nid, index, HDA_INPUT);
-		snd_printdd("[%s] NID=0x%x, DIR=IN, IDX=0x%x\n", name, node->nid, index);
-		err = snd_hda_ctl_add(codec, node->nid,
-					snd_ctl_new1(&knew, codec));
-		if (err < 0)
-			return err;
-		created = 1;
-	} else if ((node->wid_caps & AC_WCAP_OUT_AMP) &&
-		   (node->amp_out_caps & AC_AMPCAP_NUM_STEPS)) {
-		knew = (struct snd_kcontrol_new)HDA_CODEC_VOLUME(name, node->nid, 0, HDA_OUTPUT);
-		snd_printdd("[%s] NID=0x%x, DIR=OUT\n", name, node->nid);
-		err = snd_hda_ctl_add(codec, node->nid,
-					snd_ctl_new1(&knew, codec));
-		if (err < 0)
-			return err;
-		created = 1;
-	}
+	dacs = spec->multiout.num_dacs;
+	for (type = AUTO_PIN_LINE_IN; type >= AUTO_PIN_MIC; type--) {
+		for (i = 0; i < cfg->num_inputs; i++) {
+			hda_nid_t nid = cfg->inputs[i].pin;
+			hda_nid_t dac = 0;
 
-	return created;
-}
+			if (cfg->inputs[i].type != type)
+				continue;
+			if (!can_be_multiio_pin(codec, location, nid))
+				continue;
+			for (j = 0; j < spec->multi_ios; j++) {
+				if (nid == spec->multi_io[j].pin)
+					break;
+			}
+			if (j < spec->multi_ios)
+				continue;
+
+			if (offset && offset + spec->multi_ios < dacs) {
+				dac = spec->private_dac_nids[offset + spec->multi_ios];
+				if (!is_reachable_path(codec, dac, nid))
+					dac = 0;
+			}
+			if (hardwired)
+				dac = get_dac_if_single(codec, nid);
+			else if (!dac)
+				dac = look_for_dac(codec, nid, false);
+			if (!dac) {
+				badness++;
+				continue;
+			}
+			if (!snd_hda_add_new_path(codec, dac, nid, 0)) {
+				badness++;
+				continue;
+			}
+			spec->multi_io[spec->multi_ios].pin = nid;
+			spec->multi_io[spec->multi_ios].dac = dac;
+			spec->multi_ios++;
+			if (spec->multi_ios >= 2)
+				break;
+		}
+	}
+ end_fill:
+	if (badness)
+		badness = BAD_MULTI_IO;
+	if (old_pins == spec->multi_ios) {
+		if (hardwired)
+			return 1; /* nothing found */
+		else
+			return badness; /* no badness if nothing found */
+	}
+	if (!hardwired && spec->multi_ios < 2) {
+		/* cancel newly assigned paths */
+		spec->paths.used -= spec->multi_ios - old_pins;
+		spec->multi_ios = old_pins;
+		return badness;
+	}
+
+	/* assign volume and mute controls */
+	for (i = old_pins; i < spec->multi_ios; i++)
+		badness += assign_out_path_ctls(codec, spec->multi_io[i].pin,
+						spec->multi_io[i].dac);
+
+	return badness;
+}
+
+/* map DACs for all pins in the list if they are single connections */
+static bool map_singles(struct hda_codec *codec, int outs,
+			const hda_nid_t *pins, hda_nid_t *dacs)
+{
+	int i;
+	bool found = false;
+	for (i = 0; i < outs; i++) {
+		hda_nid_t dac;
+		if (dacs[i])
+			continue;
+		dac = get_dac_if_single(codec, pins[i]);
+		if (!dac)
+			continue;
+		if (snd_hda_add_new_path(codec, dac, pins[i], 0)) {
+			dacs[i] = dac;
+			found = true;
+		}
+	}
+	return found;
+}
+
+/* fill in the dac_nids table from the parsed pin configuration */
+static int fill_and_eval_dacs(struct hda_codec *codec,
+			      bool fill_hardwired,
+			      bool fill_mio_first)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i, err, badness;
+
+	/* set num_dacs once to full for look_for_dac() */
+	spec->multiout.num_dacs = cfg->line_outs;
+	spec->multiout.dac_nids = spec->private_dac_nids;
+	memset(spec->private_dac_nids, 0, sizeof(spec->private_dac_nids));
+	memset(spec->multiout.hp_out_nid, 0, sizeof(spec->multiout.hp_out_nid));
+	memset(spec->multiout.extra_out_nid, 0, sizeof(spec->multiout.extra_out_nid));
+	spec->multi_ios = 0;
+	snd_array_free(&spec->paths);
+	badness = 0;
+
+	/* fill hard-wired DACs first */
+	if (fill_hardwired) {
+		bool mapped;
+		do {
+			mapped = map_singles(codec, cfg->line_outs,
+					     cfg->line_out_pins,
+					     spec->private_dac_nids);
+			mapped |= map_singles(codec, cfg->hp_outs,
+					      cfg->hp_pins,
+					      spec->multiout.hp_out_nid);
+			mapped |= map_singles(codec, cfg->speaker_outs,
+					      cfg->speaker_pins,
+					      spec->multiout.extra_out_nid);
+			if (fill_mio_first && cfg->line_outs == 1 &&
+			    cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+				err = fill_multi_ios(codec, cfg->line_out_pins[0], true, 0);
+				if (!err)
+					mapped = true;
+			}
+		} while (mapped);
+	}
+
+	badness += try_assign_dacs(codec, cfg->line_outs, cfg->line_out_pins,
+				   spec->private_dac_nids,
+				   &main_out_badness);
+
+	/* re-count num_dacs and squash invalid entries */
+	spec->multiout.num_dacs = 0;
+	for (i = 0; i < cfg->line_outs; i++) {
+		if (spec->private_dac_nids[i])
+			spec->multiout.num_dacs++;
+		else {
+			memmove(spec->private_dac_nids + i,
+				spec->private_dac_nids + i + 1,
+				sizeof(hda_nid_t) * (cfg->line_outs - i - 1));
+			spec->private_dac_nids[cfg->line_outs - 1] = 0;
+		}
+	}
+
+	if (fill_mio_first &&
+	    cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		/* try to fill multi-io first */
+		err = fill_multi_ios(codec, cfg->line_out_pins[0], false, 0);
+		if (err < 0)
+			return err;
+		/* we don't count badness at this stage yet */
+	}
+
+	if (cfg->line_out_type != AUTO_PIN_HP_OUT) {
+		err = try_assign_dacs(codec, cfg->hp_outs, cfg->hp_pins,
+				      spec->multiout.hp_out_nid,
+				      &extra_out_badness);
+		if (err < 0)
+			return err;
+		badness += err;
+	}
+	if (cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		err = try_assign_dacs(codec, cfg->speaker_outs,
+				      cfg->speaker_pins,
+				      spec->multiout.extra_out_nid,
+					 &extra_out_badness);
+		if (err < 0)
+			return err;
+		badness += err;
+	}
+	if (cfg->line_outs == 1 && cfg->line_out_type != AUTO_PIN_SPEAKER_OUT) {
+		err = fill_multi_ios(codec, cfg->line_out_pins[0], false, 0);
+		if (err < 0)
+			return err;
+		badness += err;
+	}
+	if (cfg->hp_outs && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
+		/* try multi-ios with HP + inputs */
+		int offset = 0;
+		if (cfg->line_outs >= 3)
+			offset = 1;
+		err = fill_multi_ios(codec, cfg->hp_pins[0], false, offset);
+		if (err < 0)
+			return err;
+		badness += err;
+	}
+
+	if (spec->multi_ios == 2) {
+		for (i = 0; i < 2; i++)
+			spec->private_dac_nids[spec->multiout.num_dacs++] =
+				spec->multi_io[i].dac;
+		spec->ext_channel_count = 2;
+	} else if (spec->multi_ios) {
+		spec->multi_ios = 0;
+		badness += BAD_MULTI_IO;
+	}
+
+	return badness;
+}
+
+#define DEBUG_BADNESS
+
+#ifdef DEBUG_BADNESS
+#define debug_badness	snd_printdd
+#else
+#define debug_badness(...)
+#endif
+
+static void debug_show_configs(struct hda_gen_spec *spec, struct auto_pin_cfg *cfg)
+{
+	debug_badness("multi_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
+		      cfg->line_out_pins[0], cfg->line_out_pins[1],
+		      cfg->line_out_pins[2], cfg->line_out_pins[2],
+		      spec->multiout.dac_nids[0],
+		      spec->multiout.dac_nids[1],
+		      spec->multiout.dac_nids[2],
+		      spec->multiout.dac_nids[3]);
+	if (spec->multi_ios > 0)
+		debug_badness("multi_ios(%d) = %x/%x : %x/%x\n",
+			      spec->multi_ios,
+			      spec->multi_io[0].pin, spec->multi_io[1].pin,
+			      spec->multi_io[0].dac, spec->multi_io[1].dac);
+	debug_badness("hp_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
+		      cfg->hp_pins[0], cfg->hp_pins[1],
+		      cfg->hp_pins[2], cfg->hp_pins[2],
+		      spec->multiout.hp_out_nid[0],
+		      spec->multiout.hp_out_nid[1],
+		      spec->multiout.hp_out_nid[2],
+		      spec->multiout.hp_out_nid[3]);
+	debug_badness("spk_outs = %x/%x/%x/%x : %x/%x/%x/%x\n",
+		      cfg->speaker_pins[0], cfg->speaker_pins[1],
+		      cfg->speaker_pins[2], cfg->speaker_pins[3],
+		      spec->multiout.extra_out_nid[0],
+		      spec->multiout.extra_out_nid[1],
+		      spec->multiout.extra_out_nid[2],
+		      spec->multiout.extra_out_nid[3]);
+}
+
+/* find all available DACs of the codec */
+static void fill_all_dac_nids(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+	hda_nid_t nid = codec->start_nid;
+
+	spec->num_all_dacs = 0;
+	memset(spec->all_dacs, 0, sizeof(spec->all_dacs));
+	for (i = 0; i < codec->num_nodes; i++, nid++) {
+		if (get_wcaps_type(get_wcaps(codec, nid)) != AC_WID_AUD_OUT)
+			continue;
+		if (spec->num_all_dacs >= ARRAY_SIZE(spec->all_dacs)) {
+			snd_printk(KERN_ERR "hda: Too many DACs!\n");
+			break;
+		}
+		spec->all_dacs[spec->num_all_dacs++] = nid;
+	}
+}
+
+static int parse_output_paths(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	struct auto_pin_cfg *best_cfg;
+	int best_badness = INT_MAX;
+	int badness;
+	bool fill_hardwired = true, fill_mio_first = true;
+	bool best_wired = true, best_mio = true;
+	bool hp_spk_swapped = false;
+
+	fill_all_dac_nids(codec);
+
+	best_cfg = kmalloc(sizeof(*best_cfg), GFP_KERNEL);
+	if (!best_cfg)
+		return -ENOMEM;
+	*best_cfg = *cfg;
+
+	for (;;) {
+		badness = fill_and_eval_dacs(codec, fill_hardwired,
+					     fill_mio_first);
+		if (badness < 0) {
+			kfree(best_cfg);
+			return badness;
+		}
+		debug_badness("==> lo_type=%d, wired=%d, mio=%d, badness=0x%x\n",
+			      cfg->line_out_type, fill_hardwired, fill_mio_first,
+			      badness);
+		debug_show_configs(spec, cfg);
+		if (badness < best_badness) {
+			best_badness = badness;
+			*best_cfg = *cfg;
+			best_wired = fill_hardwired;
+			best_mio = fill_mio_first;
+		}
+		if (!badness)
+			break;
+		fill_mio_first = !fill_mio_first;
+		if (!fill_mio_first)
+			continue;
+		fill_hardwired = !fill_hardwired;
+		if (!fill_hardwired)
+			continue;
+		if (hp_spk_swapped)
+			break;
+		hp_spk_swapped = true;
+		if (cfg->speaker_outs > 0 &&
+		    cfg->line_out_type == AUTO_PIN_HP_OUT) {
+			cfg->hp_outs = cfg->line_outs;
+			memcpy(cfg->hp_pins, cfg->line_out_pins,
+			       sizeof(cfg->hp_pins));
+			cfg->line_outs = cfg->speaker_outs;
+			memcpy(cfg->line_out_pins, cfg->speaker_pins,
+			       sizeof(cfg->speaker_pins));
+			cfg->speaker_outs = 0;
+			memset(cfg->speaker_pins, 0, sizeof(cfg->speaker_pins));
+			cfg->line_out_type = AUTO_PIN_SPEAKER_OUT;
+			fill_hardwired = true;
+			continue;
+		}
+		if (cfg->hp_outs > 0 &&
+		    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
+			cfg->speaker_outs = cfg->line_outs;
+			memcpy(cfg->speaker_pins, cfg->line_out_pins,
+			       sizeof(cfg->speaker_pins));
+			cfg->line_outs = cfg->hp_outs;
+			memcpy(cfg->line_out_pins, cfg->hp_pins,
+			       sizeof(cfg->hp_pins));
+			cfg->hp_outs = 0;
+			memset(cfg->hp_pins, 0, sizeof(cfg->hp_pins));
+			cfg->line_out_type = AUTO_PIN_HP_OUT;
+			fill_hardwired = true;
+			continue;
+		}
+		break;
+	}
+
+	if (badness) {
+		*cfg = *best_cfg;
+		fill_and_eval_dacs(codec, best_wired, best_mio);
+	}
+	debug_badness("==> Best config: lo_type=%d, wired=%d, mio=%d\n",
+		      cfg->line_out_type, best_wired, best_mio);
+	debug_show_configs(spec, cfg);
+
+	if (cfg->line_out_pins[0]) {
+		struct nid_path *path;
+		path = snd_hda_get_nid_path(codec,
+					    spec->multiout.dac_nids[0],
+					    cfg->line_out_pins[0]);
+		if (path)
+			spec->vmaster_nid = look_for_out_vol_nid(codec, path);
+	}
+
+	kfree(best_cfg);
+	return 0;
+}
+
+/* add playback controls from the parsed DAC table */
+static int create_multi_out_ctls(struct hda_codec *codec,
+				 const struct auto_pin_cfg *cfg)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i, err, noutputs;
+
+	noutputs = cfg->line_outs;
+	if (spec->multi_ios > 0 && cfg->line_outs < 3)
+		noutputs += spec->multi_ios;
+
+	for (i = 0; i < noutputs; i++) {
+		const char *name;
+		int index;
+		hda_nid_t dac, pin;
+		struct nid_path *path;
+
+		dac = spec->multiout.dac_nids[i];
+		if (!dac)
+			continue;
+		if (i >= cfg->line_outs) {
+			pin = spec->multi_io[i - 1].pin;
+			index = 0;
+			name = channel_name[i];
+		} else {
+			pin = cfg->line_out_pins[i];
+			name = get_line_out_pfx(spec, i, true, &index);
+		}
+
+		path = snd_hda_get_nid_path(codec, dac, pin);
+		if (!path)
+			continue;
+		if (!name || !strcmp(name, "CLFE")) {
+			/* Center/LFE */
+			err = add_vol_ctl(codec, "Center", 0, 1, path);
+			if (err < 0)
+				return err;
+			err = add_vol_ctl(codec, "LFE", 0, 2, path);
+			if (err < 0)
+				return err;
+			err = add_sw_ctl(codec, "Center", 0, 1, path);
+			if (err < 0)
+				return err;
+			err = add_sw_ctl(codec, "LFE", 0, 2, path);
+			if (err < 0)
+				return err;
+		} else {
+			err = add_stereo_vol(codec, name, index, path);
+			if (err < 0)
+				return err;
+			err = add_stereo_sw(codec, name, index, path);
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+
+static int create_extra_out(struct hda_codec *codec, hda_nid_t pin,
+			    hda_nid_t dac, const char *pfx, int cidx)
+{
+	struct nid_path *path;
+	int err;
+
+	path = snd_hda_get_nid_path(codec, dac, pin);
+	if (!path)
+		return 0;
+	/* bind volume control will be created in the case of dac = 0 */
+	if (dac) {
+		err = add_stereo_vol(codec, pfx, cidx, path);
+		if (err < 0)
+			return err;
+	}
+	err = add_stereo_sw(codec, pfx, cidx, path);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+/* add playback controls for speaker and HP outputs */
+static int create_extra_outs(struct hda_codec *codec, int num_pins,
+			     const hda_nid_t *pins, const hda_nid_t *dacs,
+			     const char *pfx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_bind_ctls *ctl;
+	char name[32];
+	int i, n, err;
+
+	if (!num_pins || !pins[0])
+		return 0;
+
+	if (num_pins == 1) {
+		hda_nid_t dac = *dacs;
+		if (!dac)
+			dac = spec->multiout.dac_nids[0];
+		return create_extra_out(codec, *pins, dac, pfx, 0);
+	}
+
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t dac;
+		if (dacs[num_pins - 1])
+			dac = dacs[i]; /* with individual volumes */
+		else
+			dac = 0;
+		if (num_pins == 2 && i == 1 && !strcmp(pfx, "Speaker")) {
+			err = create_extra_out(codec, pins[i], dac,
+					       "Bass Speaker", 0);
+		} else if (num_pins >= 3) {
+			snprintf(name, sizeof(name), "%s %s",
+				 pfx, channel_name[i]);
+			err = create_extra_out(codec, pins[i], dac, name, 0);
+		} else {
+			err = create_extra_out(codec, pins[i], dac, pfx, i);
+		}
+		if (err < 0)
+			return err;
+	}
+	if (dacs[num_pins - 1])
+		return 0;
+
+	/* Let's create a bind-controls for volumes */
+	ctl = new_bind_ctl(codec, num_pins, &snd_hda_bind_vol);
+	if (!ctl)
+		return -ENOMEM;
+	n = 0;
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t vol;
+		struct nid_path *path;
+		if (!pins[i] || !dacs[i])
+			continue;
+		path = snd_hda_get_nid_path(codec, dacs[i], pins[i]);
+		if (!path)
+			continue;
+		vol = look_for_out_vol_nid(codec, path);
+		if (vol)
+			ctl->values[n++] =
+				HDA_COMPOSE_AMP_VAL(vol, 3, 0, HDA_OUTPUT);
+	}
+	if (n) {
+		snprintf(name, sizeof(name), "%s Playback Volume", pfx);
+		err = add_control(spec, HDA_CTL_BIND_VOL, name, 0, (long)ctl);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+static int create_hp_out_ctls(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return create_extra_outs(codec, spec->autocfg.hp_outs,
+				 spec->autocfg.hp_pins,
+				 spec->multiout.hp_out_nid,
+				 "Headphone");
+}
+
+static int create_speaker_out_ctls(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return create_extra_outs(codec, spec->autocfg.speaker_outs,
+				 spec->autocfg.speaker_pins,
+				 spec->multiout.extra_out_nid,
+				 "Speaker");
+}
+
+/*
+ * channel mode enum control
+ */
+
+static int ch_mode_info(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = spec->multi_ios + 1;
+	if (uinfo->value.enumerated.item > spec->multi_ios)
+		uinfo->value.enumerated.item = spec->multi_ios;
+	sprintf(uinfo->value.enumerated.name, "%dch",
+		(uinfo->value.enumerated.item + 1) * 2);
+	return 0;
+}
+
+static int ch_mode_get(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	ucontrol->value.enumerated.item[0] = (spec->ext_channel_count - 1) / 2;
+	return 0;
+}
+
+static int set_multi_io(struct hda_codec *codec, int idx, bool output)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t nid = spec->multi_io[idx].pin;
+	struct nid_path *path;
+
+	path = snd_hda_get_nid_path(codec, spec->multi_io[idx].dac, nid);
+	if (!path)
+		return -EINVAL;
+
+	if (path->active == output)
+		return 0;
+
+	if (output) {
+		snd_hda_set_pin_ctl_cache(codec, nid, PIN_OUT);
+		snd_hda_activate_path(codec, path, true, true);
+	} else {
+		snd_hda_activate_path(codec, path, false, true);
+		snd_hda_set_pin_ctl_cache(codec, nid,
+					  spec->multi_io[idx].ctl_in);
+	}
+	return 0;
+}
+
+static int ch_mode_put(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	int i, ch;
+
+	ch = ucontrol->value.enumerated.item[0];
+	if (ch < 0 || ch > spec->multi_ios)
+		return -EINVAL;
+	if (ch == (spec->ext_channel_count - 1) / 2)
+		return 0;
+	spec->ext_channel_count = (ch + 1) * 2;
+	for (i = 0; i < spec->multi_ios; i++)
+		set_multi_io(codec, i, i < ch);
+	spec->multiout.max_channels = max(spec->ext_channel_count,
+					  spec->const_channel_count);
+	if (spec->need_dac_fix)
+		spec->multiout.num_dacs = spec->multiout.max_channels / 2;
+	return 1;
+}
+
+static const struct snd_kcontrol_new channel_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Channel Mode",
+	.info = ch_mode_info,
+	.get = ch_mode_get,
+	.put = ch_mode_put,
+};
+
+static int create_multi_channel_mode(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->multi_ios > 0) {
+		if (!add_kctl(spec, NULL, &channel_mode_enum))
+			return -ENOMEM;
+	}
+	return 0;
+}
+
+/*
+ * shared headphone/mic handling
+ */
+
+static void call_update_outputs(struct hda_codec *codec);
+
+/* for shared I/O, change the pin-control accordingly */
+static void update_shared_mic_hp(struct hda_codec *codec, bool set_as_mic)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	unsigned int val;
+	hda_nid_t pin = spec->autocfg.inputs[1].pin;
+	/* NOTE: this assumes that there are only two inputs, the
+	 * first is the real internal mic and the second is HP/mic jack.
+	 */
+
+	val = snd_hda_get_default_vref(codec, pin);
+
+	/* This pin does not have vref caps - let's enable vref on pin 0x18
+	   instead, as suggested by Realtek */
+	if (val == AC_PINCTL_VREF_HIZ && spec->shared_mic_vref_pin) {
+		const hda_nid_t vref_pin = spec->shared_mic_vref_pin;
+		unsigned int vref_val = snd_hda_get_default_vref(codec, vref_pin);
+		if (vref_val != AC_PINCTL_VREF_HIZ)
+			snd_hda_set_pin_ctl(codec, vref_pin, PIN_IN | (set_as_mic ? vref_val : 0));
+	}
+
+	val = set_as_mic ? val | PIN_IN : PIN_HP;
+	snd_hda_set_pin_ctl(codec, pin, val);
+
+	spec->automute_speaker = !set_as_mic;
+	call_update_outputs(codec);
+}
+
+/* create a shared input with the headphone out */
+static int create_shared_input(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int defcfg;
+	hda_nid_t nid;
+
+	/* only one internal input pin? */
+	if (cfg->num_inputs != 1)
+		return 0;
+	defcfg = snd_hda_codec_get_pincfg(codec, cfg->inputs[0].pin);
+	if (snd_hda_get_input_pin_attr(defcfg) != INPUT_PIN_ATTR_INT)
+		return 0;
+
+	if (cfg->hp_outs == 1 && cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
+		nid = cfg->hp_pins[0]; /* OK, we have a single HP-out */
+	else if (cfg->line_outs == 1 && cfg->line_out_type == AUTO_PIN_HP_OUT)
+		nid = cfg->line_out_pins[0]; /* OK, we have a single line-out */
+	else
+		return 0; /* both not available */
+
+	if (!(snd_hda_query_pin_caps(codec, nid) & AC_PINCAP_IN))
+		return 0; /* no input */
+
+	cfg->inputs[1].pin = nid;
+	cfg->inputs[1].type = AUTO_PIN_MIC;
+	cfg->num_inputs = 2;
+	spec->shared_mic_hp = 1;
+	snd_printdd("hda-codec: Enable shared I/O jack on NID 0x%x\n", nid);
+	return 0;
+}
+
+
+/*
+ * Parse input paths
+ */
+
+#ifdef CONFIG_PM
+/* add the powersave loopback-list entry */
+static void add_loopback_list(struct hda_gen_spec *spec, hda_nid_t mix, int idx)
+{
+	struct hda_amp_list *list;
+
+	if (spec->num_loopbacks >= ARRAY_SIZE(spec->loopback_list) - 1)
+		return;
+	list = spec->loopback_list + spec->num_loopbacks;
+	list->nid = mix;
+	list->dir = HDA_INPUT;
+	list->idx = idx;
+	spec->num_loopbacks++;
+	spec->loopback.amplist = spec->loopback_list;
+}
+#else
+#define add_loopback_list(spec, mix, idx) /* NOP */
+#endif
+
+/* create input playback/capture controls for the given pin */
+static int new_analog_input(struct hda_codec *codec, hda_nid_t pin,
+			    const char *ctlname, int ctlidx,
+			    hda_nid_t mix_nid)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *path;
+	unsigned int val;
+	int err, idx;
+
+	if (!nid_has_volume(codec, mix_nid, HDA_INPUT) &&
+	    !nid_has_mute(codec, mix_nid, HDA_INPUT))
+		return 0; /* no need for analog loopback */
+
+	path = snd_hda_add_new_path(codec, pin, mix_nid, 2);
+	if (!path)
+		return -EINVAL;
+
+	idx = path->idx[path->depth - 1];
+	if (nid_has_volume(codec, mix_nid, HDA_INPUT)) {
+		val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
+		err = __add_pb_vol_ctrl(spec, HDA_CTL_WIDGET_VOL, ctlname, ctlidx, val);
+		if (err < 0)
+			return err;
+		path->ctls[NID_PATH_VOL_CTL] = val;
+	}
+
+	if (nid_has_mute(codec, mix_nid, HDA_INPUT)) {
+		val = HDA_COMPOSE_AMP_VAL(mix_nid, 3, idx, HDA_INPUT);
+		err = __add_pb_sw_ctrl(spec, HDA_CTL_WIDGET_MUTE, ctlname, ctlidx, val);
+		if (err < 0)
+			return err;
+		path->ctls[NID_PATH_MUTE_CTL] = val;
+	}
+
+	path->active = true;
+	add_loopback_list(spec, mix_nid, idx);
+	return 0;
+}
+
+static int is_input_pin(struct hda_codec *codec, hda_nid_t nid)
+{
+	unsigned int pincap = snd_hda_query_pin_caps(codec, nid);
+	return (pincap & AC_PINCAP_IN) != 0;
+}
+
+/* Parse the codec tree and retrieve ADCs */
+static int fill_adc_nids(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t nid;
+	hda_nid_t *adc_nids = spec->adc_nids;
+	int max_nums = ARRAY_SIZE(spec->adc_nids);
+	int i, nums = 0;
+
+	nid = codec->start_nid;
+	for (i = 0; i < codec->num_nodes; i++, nid++) {
+		unsigned int caps = get_wcaps(codec, nid);
+		int type = get_wcaps_type(caps);
+
+		if (type != AC_WID_AUD_IN || (caps & AC_WCAP_DIGITAL))
+			continue;
+		adc_nids[nums] = nid;
+		if (++nums >= max_nums)
+			break;
+	}
+	spec->num_adc_nids = nums;
+	return nums;
+}
+
+/* filter out invalid adc_nids that don't give all active input pins;
+ * if needed, check whether dynamic ADC-switching is available
+ */
+static int check_dyn_adc_switch(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->input_mux;
+	hda_nid_t adc_nids[ARRAY_SIZE(spec->adc_nids)];
+	int i, n, nums;
+	hda_nid_t pin, adc;
+
+ again:
+	nums = 0;
+	for (n = 0; n < spec->num_adc_nids; n++) {
+		adc = spec->adc_nids[n];
+		for (i = 0; i < imux->num_items; i++) {
+			pin = spec->imux_pins[i];
+			if (!is_reachable_path(codec, pin, adc))
+				break;
+		}
+		if (i >= imux->num_items)
+			adc_nids[nums++] = adc;
+	}
+
+	if (!nums) {
+		if (spec->shared_mic_hp) {
+			spec->shared_mic_hp = 0;
+			imux->num_items = 1;
+			goto again;
+		}
+
+		/* check whether ADC-switch is possible */
+		for (i = 0; i < imux->num_items; i++) {
+			pin = spec->imux_pins[i];
+			for (n = 0; n < spec->num_adc_nids; n++) {
+				adc = spec->adc_nids[n];
+				if (is_reachable_path(codec, pin, adc)) {
+					spec->dyn_adc_idx[i] = n;
+					break;
+				}
+			}
+		}
+
+		snd_printdd("hda-codec: enabling ADC switching\n");
+		spec->dyn_adc_switch = 1;
+	} else if (nums != spec->num_adc_nids) {
+		memcpy(spec->adc_nids, adc_nids, nums * sizeof(hda_nid_t));
+		spec->num_adc_nids = nums;
+	}
+
+	if (imux->num_items == 1 || spec->shared_mic_hp) {
+		snd_printdd("hda-codec: reducing to a single ADC\n");
+		spec->num_adc_nids = 1; /* reduce to a single ADC */
+	}
+
+	/* single index for individual volumes ctls */
+	if (!spec->dyn_adc_switch && spec->multi_cap_vol)
+		spec->num_adc_nids = 1;
+
+	return 0;
+}
+
+/*
+ * create playback/capture controls for input pins
+ */
+static int create_input_ctls(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const struct auto_pin_cfg *cfg = &spec->autocfg;
+	hda_nid_t mixer = spec->mixer_nid;
+	struct hda_input_mux *imux = &spec->input_mux;
+	int num_adcs;
+	int i, c, err, type_idx = 0;
+	const char *prev_label = NULL;
+
+	num_adcs = fill_adc_nids(codec);
+	if (num_adcs < 0)
+		return 0;
+
+	for (i = 0; i < cfg->num_inputs; i++) {
+		hda_nid_t pin;
+		const char *label;
+		bool imux_added;
+
+		pin = cfg->inputs[i].pin;
+		if (!is_input_pin(codec, pin))
+			continue;
+
+		label = hda_get_autocfg_input_label(codec, cfg, i);
+		if (spec->shared_mic_hp && !strcmp(label, "Misc"))
+			label = "Headphone Mic";
+		if (prev_label && !strcmp(label, prev_label))
+			type_idx++;
+		else
+			type_idx = 0;
+		prev_label = label;
+
+		if (mixer) {
+			if (is_reachable_path(codec, pin, mixer)) {
+				err = new_analog_input(codec, pin,
+						       label, type_idx, mixer);
+				if (err < 0)
+					return err;
+			}
+		}
+
+		imux_added = false;
+		for (c = 0; c < num_adcs; c++) {
+			struct nid_path *path;
+			hda_nid_t adc = spec->adc_nids[c];
+
+			if (!is_reachable_path(codec, pin, adc))
+				continue;
+			path = snd_array_new(&spec->paths);
+			if (!path)
+				return -ENOMEM;
+			memset(path, 0, sizeof(*path));
+			if (!snd_hda_parse_nid_path(codec, pin, adc, 2, path)) {
+				snd_printd(KERN_ERR
+					   "invalid input path 0x%x -> 0x%x\n",
+					   pin, adc);
+				spec->paths.used--;
+				continue;
+			}
+
+			if (!imux_added) {
+				spec->imux_pins[imux->num_items] = pin;
+				snd_hda_add_imux_item(imux, label,
+						      imux->num_items, NULL);
+				imux_added = true;
+			}
+		}
+	}
+
+	return 0;
+}
+
+
+/*
+ * input source mux
+ */
+
+/* get the ADC NID corresponding to the given index */
+static hda_nid_t get_adc_nid(struct hda_codec *codec, int adc_idx, int imux_idx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	if (spec->dyn_adc_switch)
+		adc_idx = spec->dyn_adc_idx[imux_idx];
+	return spec->adc_nids[adc_idx];
+}
+
+static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
+		      unsigned int idx);
+
+static int mux_enum_info(struct snd_kcontrol *kcontrol,
+			 struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_input_mux_info(&spec->input_mux, uinfo);
+}
+
+static int mux_enum_get(struct snd_kcontrol *kcontrol,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	ucontrol->value.enumerated.item[0] = spec->cur_mux[adc_idx];
+	return 0;
+}
+
+static int mux_enum_put(struct snd_kcontrol *kcontrol,
+			    struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	unsigned int adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	return mux_select(codec, adc_idx,
+			  ucontrol->value.enumerated.item[0]);
+}
+
+/*
+ * capture volume and capture switch ctls
+ */
+
+static const struct snd_kcontrol_new cap_src_temp = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Input Source",
+	.info = mux_enum_info,
+	.get = mux_enum_get,
+	.put = mux_enum_put,
+};
+
+typedef int (*put_call_t)(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol);
+
+static int cap_put_caller(struct snd_kcontrol *kcontrol,
+			  struct snd_ctl_elem_value *ucontrol,
+			  put_call_t func, int type)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	const struct hda_input_mux *imux;
+	struct nid_path *path;
+	int i, adc_idx, err = 0;
+
+	imux = &spec->input_mux;
+	adc_idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	mutex_lock(&codec->control_mutex);
+	codec->cached_write = 1;
+	for (i = 0; i < imux->num_items; i++) {
+		path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
+					    get_adc_nid(codec, adc_idx, i));
+		if (!path->ctls[type])
+			continue;
+		kcontrol->private_value = path->ctls[type];
+		err = func(kcontrol, ucontrol);
+		if (err < 0)
+			goto error;
+	}
+ error:
+	codec->cached_write = 0;
+	mutex_unlock(&codec->control_mutex);
+	if (err >= 0 && spec->cap_sync_hook)
+		spec->cap_sync_hook(codec);
+	return err;
+}
+
+/* capture volume ctl callbacks */
+#define cap_vol_info		snd_hda_mixer_amp_volume_info
+#define cap_vol_get		snd_hda_mixer_amp_volume_get
+#define cap_vol_tlv		snd_hda_mixer_amp_tlv
+
+static int cap_vol_put(struct snd_kcontrol *kcontrol,
+		       struct snd_ctl_elem_value *ucontrol)
+{
+	return cap_put_caller(kcontrol, ucontrol,
+			      snd_hda_mixer_amp_volume_put,
+			      NID_PATH_VOL_CTL);
+}
+
+static const struct snd_kcontrol_new cap_vol_temp = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Volume",
+	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+		   SNDRV_CTL_ELEM_ACCESS_TLV_READ |
+		   SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK),
+	.info = cap_vol_info,
+	.get = cap_vol_get,
+	.put = cap_vol_put,
+	.tlv = { .c = cap_vol_tlv },
+};
+
+/* capture switch ctl callbacks */
+#define cap_sw_info		snd_ctl_boolean_stereo_info
+#define cap_sw_get		snd_hda_mixer_amp_switch_get
+
+static int cap_sw_put(struct snd_kcontrol *kcontrol,
+		      struct snd_ctl_elem_value *ucontrol)
+{
+	return cap_put_caller(kcontrol, ucontrol,
+			      snd_hda_mixer_amp_switch_put,
+			      NID_PATH_MUTE_CTL);
+}
+
+static const struct snd_kcontrol_new cap_sw_temp = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Capture Switch",
+	.info = cap_sw_info,
+	.get = cap_sw_get,
+	.put = cap_sw_put,
+};
+
+static int parse_capvol_in_path(struct hda_codec *codec, struct nid_path *path)
+{
+	hda_nid_t nid;
+	int i, depth;
+
+	path->ctls[NID_PATH_VOL_CTL] = path->ctls[NID_PATH_MUTE_CTL] = 0;
+	for (depth = 0; depth < 3; depth++) {
+		if (depth >= path->depth)
+			return -EINVAL;
+		i = path->depth - depth - 1;
+		nid = path->path[i];
+		if (!path->ctls[NID_PATH_VOL_CTL]) {
+			if (nid_has_volume(codec, nid, HDA_OUTPUT))
+				path->ctls[NID_PATH_VOL_CTL] =
+					HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+			else if (nid_has_volume(codec, nid, HDA_INPUT)) {
+				int idx = path->idx[i];
+				if (!depth && codec->single_adc_amp)
+					idx = 0;
+				path->ctls[NID_PATH_VOL_CTL] =
+					HDA_COMPOSE_AMP_VAL(nid, 3, idx, HDA_INPUT);
+			}
+		}
+		if (!path->ctls[NID_PATH_MUTE_CTL]) {
+			if (nid_has_mute(codec, nid, HDA_OUTPUT))
+				path->ctls[NID_PATH_MUTE_CTL] =
+					HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_OUTPUT);
+			else if (nid_has_mute(codec, nid, HDA_INPUT)) {
+				int idx = path->idx[i];
+				if (!depth && codec->single_adc_amp)
+					idx = 0;
+				path->ctls[NID_PATH_MUTE_CTL] =
+					HDA_COMPOSE_AMP_VAL(nid, 3, idx, HDA_INPUT);
+			}
+		}
+	}
+	return 0;
+}
+
+static bool is_inv_dmic_pin(struct hda_codec *codec, hda_nid_t nid)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int val;
+	int i;
+
+	if (!spec->inv_dmic_split)
+		return false;
+	for (i = 0; i < cfg->num_inputs; i++) {
+		if (cfg->inputs[i].pin != nid)
+			continue;
+		if (cfg->inputs[i].type != AUTO_PIN_MIC)
+			return false;
+		val = snd_hda_codec_get_pincfg(codec, nid);
+		return snd_hda_get_input_pin_attr(val) == INPUT_PIN_ATTR_INT;
+	}
+	return false;
+}
+
+static int add_single_cap_ctl(struct hda_codec *codec, const char *label,
+			      int idx, bool is_switch, unsigned int ctl,
+			      bool inv_dmic)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	char tmpname[44];
+	int type = is_switch ? HDA_CTL_WIDGET_MUTE : HDA_CTL_WIDGET_VOL;
+	const char *sfx = is_switch ? "Switch" : "Volume";
+	unsigned int chs = inv_dmic ? 1 : 3;
+	int err;
+
+	if (!ctl)
+		return 0;
+
+	if (label)
+		snprintf(tmpname, sizeof(tmpname),
+			 "%s Capture %s", label, sfx);
+	else
+		snprintf(tmpname, sizeof(tmpname),
+			 "Capture %s", sfx);
+	err = add_control(spec, type, tmpname, idx,
+			  amp_val_replace_channels(ctl, chs));
+	if (err < 0 || !inv_dmic)
+		return err;
+
+	/* Make independent right kcontrol */
+	if (label)
+		snprintf(tmpname, sizeof(tmpname),
+			 "Inverted %s Capture %s", label, sfx);
+	else
+		snprintf(tmpname, sizeof(tmpname),
+			 "Inverted Capture %s", sfx);
+	return add_control(spec, type, tmpname, idx,
+			   amp_val_replace_channels(ctl, 2));
+}
+
+/* create single (and simple) capture volume and switch controls */
+static int create_single_cap_vol_ctl(struct hda_codec *codec, int idx,
+				     unsigned int vol_ctl, unsigned int sw_ctl,
+				     bool inv_dmic)
+{
+	int err;
+	err = add_single_cap_ctl(codec, NULL, idx, false, vol_ctl, inv_dmic);
+	if (err < 0)
+		return err;
+	err = add_single_cap_ctl(codec, NULL, idx, true, sw_ctl, inv_dmic);
+	if (err < 0)
+		return err;
+	return 0;
+}
+
+/* create bound capture volume and switch controls */
+static int create_bind_cap_vol_ctl(struct hda_codec *codec, int idx,
+				   unsigned int vol_ctl, unsigned int sw_ctl)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct snd_kcontrol_new *knew;
+
+	if (vol_ctl) {
+		knew = add_kctl(spec, NULL, &cap_vol_temp);
+		if (!knew)
+			return -ENOMEM;
+		knew->index = idx;
+		knew->private_value = vol_ctl;
+		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
+	}
+	if (sw_ctl) {
+		knew = add_kctl(spec, NULL, &cap_sw_temp);
+		if (!knew)
+			return -ENOMEM;
+		knew->index = idx;
+		knew->private_value = sw_ctl;
+		knew->subdevice = HDA_SUBDEV_AMP_FLAG;
+	}
+	return 0;
+}
+
+/* return the vol ctl when used first in the imux list */
+static unsigned int get_first_cap_ctl(struct hda_codec *codec, int idx, int type)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct nid_path *path;
+	unsigned int ctl;
+	int i;
+
+	path = snd_hda_get_nid_path(codec, spec->imux_pins[idx],
+				    get_adc_nid(codec, 0, idx));
+	if (!path)
+		return 0;
+	ctl = path->ctls[type];
+	if (!ctl)
+		return 0;
+	for (i = 0; i < idx - 1; i++) {
+		path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
+					    get_adc_nid(codec, 0, i));
+		if (path && path->ctls[type] == ctl)
+			return 0;
+	}
+	return ctl;
+}
+
+/* create individual capture volume and switch controls per input */
+static int create_multi_cap_vol_ctl(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->input_mux;
+	int i, err, type, type_idx = 0;
+	const char *prev_label = NULL;
+
+	for (i = 0; i < imux->num_items; i++) {
+		const char *label;
+		bool inv_dmic;
+		label = hda_get_autocfg_input_label(codec, &spec->autocfg, i);
+		if (prev_label && !strcmp(label, prev_label))
+			type_idx++;
+		else
+			type_idx = 0;
+		prev_label = label;
+		inv_dmic = is_inv_dmic_pin(codec, spec->imux_pins[i]);
+
+		for (type = 0; type < 2; type++) {
+			err = add_single_cap_ctl(codec, label, type_idx, type,
+						 get_first_cap_ctl(codec, i, type),
+						 inv_dmic);
+			if (err < 0)
+				return err;
+		}
+	}
+	return 0;
+}
+
+static int create_capture_mixers(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->input_mux;
+	int i, n, nums, err;
+
+	if (spec->dyn_adc_switch)
+		nums = 1;
+	else
+		nums = spec->num_adc_nids;
+
+	if (!spec->auto_mic && imux->num_items > 1) {
+		struct snd_kcontrol_new *knew;
+		knew = add_kctl(spec, NULL, &cap_src_temp);
+		if (!knew)
+			return -ENOMEM;
+		knew->count = nums;
+	}
+
+	for (n = 0; n < nums; n++) {
+		bool multi = false;
+		bool inv_dmic = false;
+		int vol, sw;
+
+		vol = sw = 0;
+		for (i = 0; i < imux->num_items; i++) {
+			struct nid_path *path;
+			path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
+						    get_adc_nid(codec, n, i));
+			if (!path)
+				continue;
+			parse_capvol_in_path(codec, path);
+			if (!vol)
+				vol = path->ctls[NID_PATH_VOL_CTL];
+			else if (vol != path->ctls[NID_PATH_VOL_CTL])
+				multi = true;
+			if (!sw)
+				sw = path->ctls[NID_PATH_MUTE_CTL];
+			else if (sw != path->ctls[NID_PATH_MUTE_CTL])
+				multi = true;
+			if (is_inv_dmic_pin(codec, spec->imux_pins[i]))
+				inv_dmic = true;
+		}
+
+		if (!multi)
+			err = create_single_cap_vol_ctl(codec, n, vol, sw,
+							inv_dmic);
+		else if (!spec->multi_cap_vol)
+			err = create_bind_cap_vol_ctl(codec, n, vol, sw);
+		else
+			err = create_multi_cap_vol_ctl(codec);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
+/*
+ * add mic boosts if needed
+ */
+static int parse_mic_boost(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i, err;
+	int type_idx = 0;
+	hda_nid_t nid;
+	const char *prev_label = NULL;
+
+	for (i = 0; i < cfg->num_inputs; i++) {
+		if (cfg->inputs[i].type > AUTO_PIN_MIC)
+			break;
+		nid = cfg->inputs[i].pin;
+		if (get_wcaps(codec, nid) & AC_WCAP_IN_AMP) {
+			const char *label;
+			char boost_label[32];
+			struct nid_path *path;
+			unsigned int val;
+
+			label = hda_get_autocfg_input_label(codec, cfg, i);
+			if (spec->shared_mic_hp && !strcmp(label, "Misc"))
+				label = "Headphone Mic";
+			if (prev_label && !strcmp(label, prev_label))
+				type_idx++;
+			else
+				type_idx = 0;
+			prev_label = label;
+
+			snprintf(boost_label, sizeof(boost_label),
+				 "%s Boost Volume", label);
+			val = HDA_COMPOSE_AMP_VAL(nid, 3, 0, HDA_INPUT);
+			err = add_control(spec, HDA_CTL_WIDGET_VOL,
+					  boost_label, type_idx, val);
+			if (err < 0)
+				return err;
+
+			path = snd_hda_get_nid_path(codec, nid, 0);
+			if (path)
+				path->ctls[NID_PATH_BOOST_CTL] = val;
+		}
+	}
+	return 0;
+}
+
+/*
+ * parse digital I/Os and set up NIDs in BIOS auto-parse mode
+ */
+static void parse_digital(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i, nums;
+	hda_nid_t dig_nid;
+
+	/* support multiple SPDIFs; the secondary is set up as a slave */
+	nums = 0;
+	for (i = 0; i < spec->autocfg.dig_outs; i++) {
+		hda_nid_t pin = spec->autocfg.dig_out_pins[i];
+		dig_nid = look_for_dac(codec, pin, true);
+		if (!dig_nid)
+			continue;
+		if (!snd_hda_add_new_path(codec, dig_nid, pin, 2))
+			continue;
+		if (!nums) {
+			spec->multiout.dig_out_nid = dig_nid;
+			spec->dig_out_type = spec->autocfg.dig_out_type[0];
+		} else {
+			spec->multiout.slave_dig_outs = spec->slave_dig_outs;
+			if (nums >= ARRAY_SIZE(spec->slave_dig_outs) - 1)
+			break;
+			spec->slave_dig_outs[nums - 1] = dig_nid;
+		}
+		nums++;
+	}
+
+	if (spec->autocfg.dig_in_pin) {
+		dig_nid = codec->start_nid;
+		for (i = 0; i < codec->num_nodes; i++, dig_nid++) {
+			struct nid_path *path;
+			unsigned int wcaps = get_wcaps(codec, dig_nid);
+			if (get_wcaps_type(wcaps) != AC_WID_AUD_IN)
+				continue;
+			if (!(wcaps & AC_WCAP_DIGITAL))
+				continue;
+			path = snd_hda_add_new_path(codec,
+						    spec->autocfg.dig_in_pin,
+						    dig_nid, 2);
+			if (path) {
+				path->active = true;
+				spec->dig_in_nid = dig_nid;
+				break;
+			}
+		}
+	}
+}
+
+
+/*
+ * input MUX handling
+ */
+
+static bool dyn_adc_pcm_resetup(struct hda_codec *codec, int cur);
+
+/* select the given imux item; either unmute exclusively or select the route */
+static int mux_select(struct hda_codec *codec, unsigned int adc_idx,
+		      unsigned int idx)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const struct hda_input_mux *imux;
+	struct nid_path *path;
+
+	imux = &spec->input_mux;
+	if (!imux->num_items)
+		return 0;
+
+	if (idx >= imux->num_items)
+		idx = imux->num_items - 1;
+	if (spec->cur_mux[adc_idx] == idx)
+		return 0;
+
+	path = snd_hda_get_nid_path(codec,
+				    spec->imux_pins[spec->cur_mux[adc_idx]],
+				    spec->adc_nids[adc_idx]);
+	if (!path)
+		return 0;
+	if (path->active)
+		snd_hda_activate_path(codec, path, false, false);
+
+	spec->cur_mux[adc_idx] = idx;
+
+	if (spec->shared_mic_hp)
+		update_shared_mic_hp(codec, spec->cur_mux[adc_idx]);
+
+	if (spec->dyn_adc_switch)
+		dyn_adc_pcm_resetup(codec, idx);
+
+	path = snd_hda_get_nid_path(codec, spec->imux_pins[idx],
+				    get_adc_nid(codec, adc_idx, idx));
+	if (!path)
+		return 0;
+	if (path->active)
+		return 0;
+	snd_hda_activate_path(codec, path, true, false);
+	if (spec->cap_sync_hook)
+		spec->cap_sync_hook(codec);
+	return 1;
+}
+
+
+/*
+ * Jack detections for HP auto-mute and mic-switch
+ */
+
+/* check each pin in the given array; returns true if any of them is plugged */
+static bool detect_jacks(struct hda_codec *codec, int num_pins, hda_nid_t *pins)
+{
+	int i, present = 0;
+
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t nid = pins[i];
+		if (!nid)
+			break;
+		present |= snd_hda_jack_detect(codec, nid);
+	}
+	return present;
+}
+
+/* standard HP/line-out auto-mute helper */
+static void do_automute(struct hda_codec *codec, int num_pins, hda_nid_t *pins,
+			bool mute, bool hp_out)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	unsigned int pin_bits = mute ? 0 : (hp_out ? PIN_HP : PIN_OUT);
+	int i;
+
+	for (i = 0; i < num_pins; i++) {
+		hda_nid_t nid = pins[i];
+		unsigned int val;
+		if (!nid)
+			break;
+		/* don't reset VREF value in case it's controlling
+		 * the amp (see alc861_fixup_asus_amp_vref_0f())
+		 */
+		if (spec->keep_vref_in_automute) {
+			val = snd_hda_codec_read(codec, nid, 0,
+					AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+			val &= ~PIN_HP;
+		} else
+			val = 0;
+		val |= pin_bits;
+		snd_hda_set_pin_ctl(codec, nid, val);
+	}
+}
+
+/* Toggle outputs muting */
+static void update_outputs(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int on;
+
+	/* Control HP pins/amps depending on master_mute state;
+	 * in general, HP pins/amps control should be enabled in all cases,
+	 * but currently set only for master_mute, just to be safe
+	 */
+	if (!spec->shared_mic_hp) /* don't change HP-pin when shared with mic */
+		do_automute(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
+		    spec->autocfg.hp_pins, spec->master_mute, true);
+
+	if (!spec->automute_speaker)
+		on = 0;
+	else
+		on = spec->hp_jack_present | spec->line_jack_present;
+	on |= spec->master_mute;
+	do_automute(codec, ARRAY_SIZE(spec->autocfg.speaker_pins),
+		    spec->autocfg.speaker_pins, on, false);
+
+	/* toggle line-out mutes if needed, too */
+	/* if LO is a copy of either HP or Speaker, don't need to handle it */
+	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0] ||
+	    spec->autocfg.line_out_pins[0] == spec->autocfg.speaker_pins[0])
+		return;
+	if (!spec->automute_lo)
+		on = 0;
+	else
+		on = spec->hp_jack_present;
+	on |= spec->master_mute;
+	do_automute(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
+		    spec->autocfg.line_out_pins, on, false);
+}
+
+static void call_update_outputs(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	if (spec->automute_hook)
+		spec->automute_hook(codec);
+	else
+		update_outputs(codec);
+}
+
+/* standard HP-automute helper */
+static void hp_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	spec->hp_jack_present =
+		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.hp_pins),
+			     spec->autocfg.hp_pins);
+	if (!spec->detect_hp || (!spec->automute_speaker && !spec->automute_lo))
+		return;
+	call_update_outputs(codec);
+}
+
+/* standard line-out-automute helper */
+static void line_automute(struct hda_codec *codec, struct hda_jack_tbl *jack)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
+		return;
+	/* check LO jack only when it's different from HP */
+	if (spec->autocfg.line_out_pins[0] == spec->autocfg.hp_pins[0])
+		return;
+
+	spec->line_jack_present =
+		detect_jacks(codec, ARRAY_SIZE(spec->autocfg.line_out_pins),
+			     spec->autocfg.line_out_pins);
+	if (!spec->automute_speaker || !spec->detect_lo)
+		return;
+	call_update_outputs(codec);
+}
+
+/* standard mic auto-switch helper */
+static void mic_autoswitch(struct hda_codec *codec, struct hda_jack_tbl *jack)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+
+	if (!spec->auto_mic)
+		return;
+
+	for (i = spec->am_num_entries - 1; i > 0; i--) {
+		if (snd_hda_jack_detect(codec, spec->am_entry[i].pin)) {
+			mux_select(codec, 0, spec->am_entry[i].idx);
+			return;
+		}
+	}
+	mux_select(codec, 0, spec->am_entry[0].idx);
+}
+
+/*
+ * Auto-Mute mode mixer enum support
+ */
+static int automute_mode_info(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_info *uinfo)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	static const char * const texts3[] = {
+		"Disabled", "Speaker Only", "Line Out+Speaker"
+	};
+
+	if (spec->automute_speaker_possible && spec->automute_lo_possible)
+		return snd_hda_enum_helper_info(kcontrol, uinfo, 3, texts3);
+	return snd_hda_enum_bool_helper_info(kcontrol, uinfo);
+}
+
+static int automute_mode_get(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+	unsigned int val = 0;
+	if (spec->automute_speaker)
+		val++;
+	if (spec->automute_lo)
+		val++;
+
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int automute_mode_put(struct snd_kcontrol *kcontrol,
+			     struct snd_ctl_elem_value *ucontrol)
+{
+	struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
+	struct hda_gen_spec *spec = codec->spec;
+
+	switch (ucontrol->value.enumerated.item[0]) {
+	case 0:
+		if (!spec->automute_speaker && !spec->automute_lo)
+			return 0;
+		spec->automute_speaker = 0;
+		spec->automute_lo = 0;
+		break;
+	case 1:
+		if (spec->automute_speaker_possible) {
+			if (!spec->automute_lo && spec->automute_speaker)
+				return 0;
+			spec->automute_speaker = 1;
+			spec->automute_lo = 0;
+		} else if (spec->automute_lo_possible) {
+			if (spec->automute_lo)
+				return 0;
+			spec->automute_lo = 1;
+		} else
+			return -EINVAL;
+		break;
+	case 2:
+		if (!spec->automute_lo_possible || !spec->automute_speaker_possible)
+			return -EINVAL;
+		if (spec->automute_speaker && spec->automute_lo)
+			return 0;
+		spec->automute_speaker = 1;
+		spec->automute_lo = 1;
+		break;
+	default:
+		return -EINVAL;
+	}
+	call_update_outputs(codec);
+	return 1;
+}
+
+static const struct snd_kcontrol_new automute_mode_enum = {
+	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name = "Auto-Mute Mode",
+	.info = automute_mode_info,
+	.get = automute_mode_get,
+	.put = automute_mode_put,
+};
+
+static int add_automute_mode_enum(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (!add_kctl(spec, NULL, &automute_mode_enum))
+		return -ENOMEM;
+	return 0;
+}
+
+/*
+ * Check the availability of HP/line-out auto-mute;
+ * Set up appropriately if really supported
+ */
+static int check_auto_mute_availability(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int present = 0;
+	int i, err;
+
+	if (cfg->hp_pins[0])
+		present++;
+	if (cfg->line_out_pins[0])
+		present++;
+	if (cfg->speaker_pins[0])
+		present++;
+	if (present < 2) /* need two different output types */
+		return 0;
+
+	if (!cfg->speaker_pins[0] &&
+	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT) {
+		memcpy(cfg->speaker_pins, cfg->line_out_pins,
+		       sizeof(cfg->speaker_pins));
+		cfg->speaker_outs = cfg->line_outs;
+	}
+
+	if (!cfg->hp_pins[0] &&
+	    cfg->line_out_type == AUTO_PIN_HP_OUT) {
+		memcpy(cfg->hp_pins, cfg->line_out_pins,
+		       sizeof(cfg->hp_pins));
+		cfg->hp_outs = cfg->line_outs;
+	}
+
+	for (i = 0; i < cfg->hp_outs; i++) {
+		hda_nid_t nid = cfg->hp_pins[i];
+		if (!is_jack_detectable(codec, nid))
+			continue;
+		snd_printdd("hda-codec: Enable HP auto-muting on NID 0x%x\n",
+			    nid);
+		snd_hda_jack_detect_enable_callback(codec, nid, HDA_GEN_HP_EVENT,
+						    hp_automute);
+		spec->detect_hp = 1;
+	}
+
+	if (cfg->line_out_type == AUTO_PIN_LINE_OUT && cfg->line_outs) {
+		if (cfg->speaker_outs)
+			for (i = 0; i < cfg->line_outs; i++) {
+				hda_nid_t nid = cfg->line_out_pins[i];
+				if (!is_jack_detectable(codec, nid))
+					continue;
+				snd_printdd("hda-codec: Enable Line-Out auto-muting on NID 0x%x\n", nid);
+				snd_hda_jack_detect_enable_callback(codec, nid,
+								    HDA_GEN_FRONT_EVENT,
+								    line_automute);
+				spec->detect_lo = 1;
+			}
+		spec->automute_lo_possible = spec->detect_hp;
+	}
+
+	spec->automute_speaker_possible = cfg->speaker_outs &&
+		(spec->detect_hp || spec->detect_lo);
+
+	spec->automute_lo = spec->automute_lo_possible;
+	spec->automute_speaker = spec->automute_speaker_possible;
+
+	if (spec->automute_speaker_possible || spec->automute_lo_possible) {
+		/* create a control for automute mode */
+		err = add_automute_mode_enum(codec);
+		if (err < 0)
+			return err;
+	}
+	return 0;
+}
+
+/* return the position of NID in the list, or -1 if not found */
+static int find_idx_in_nid_list(hda_nid_t nid, const hda_nid_t *list, int nums)
+{
+	int i;
+	for (i = 0; i < nums; i++)
+		if (list[i] == nid)
+			return i;
+	return -1;
+}
+
+/* check whether all auto-mic pins are valid; setup indices if OK */
+static bool auto_mic_check_imux(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	const struct hda_input_mux *imux;
+	int i;
+
+	imux = &spec->input_mux;
+	for (i = 0; i < spec->am_num_entries; i++) {
+		spec->am_entry[i].idx =
+			find_idx_in_nid_list(spec->am_entry[i].pin,
+					     spec->imux_pins, imux->num_items);
+		if (spec->am_entry[i].idx < 0)
+			return false; /* no corresponding imux */
+	}
+
+	/* we don't need the jack detection for the first pin */
+	for (i = 1; i < spec->am_num_entries; i++)
+		snd_hda_jack_detect_enable_callback(codec,
+						    spec->am_entry[i].pin,
+						    HDA_GEN_MIC_EVENT,
+						    mic_autoswitch);
+	return true;
+}
+
+static int compare_attr(const void *ap, const void *bp)
+{
+	const struct automic_entry *a = ap;
+	const struct automic_entry *b = bp;
+	return (int)(a->attr - b->attr);
+}
 
 /*
- * check whether the controls with the given name and direction suffix already exist
+ * Check the availability of auto-mic switch;
+ * Set up if really supported
  */
-static int check_existing_control(struct hda_codec *codec, const char *type, const char *dir)
-{
-	struct snd_ctl_elem_id id;
-	memset(&id, 0, sizeof(id));
-	sprintf(id.name, "%s %s Volume", type, dir);
-	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	if (snd_ctl_find_id(codec->bus->card, &id))
-		return 1;
-	sprintf(id.name, "%s %s Switch", type, dir);
-	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	if (snd_ctl_find_id(codec->bus->card, &id))
-		return 1;
+static int check_auto_mic_availability(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	unsigned int types;
+	int i, num_pins;
+
+	types = 0;
+	num_pins = 0;
+	for (i = 0; i < cfg->num_inputs; i++) {
+		hda_nid_t nid = cfg->inputs[i].pin;
+		unsigned int attr;
+		attr = snd_hda_codec_get_pincfg(codec, nid);
+		attr = snd_hda_get_input_pin_attr(attr);
+		if (types & (1 << attr))
+			return 0; /* already occupied */
+		switch (attr) {
+		case INPUT_PIN_ATTR_INT:
+			if (cfg->inputs[i].type != AUTO_PIN_MIC)
+				return 0; /* invalid type */
+			break;
+		case INPUT_PIN_ATTR_UNUSED:
+			return 0; /* invalid entry */
+		default:
+			if (cfg->inputs[i].type > AUTO_PIN_LINE_IN)
+				return 0; /* invalid type */
+			if (!spec->line_in_auto_switch &&
+			    cfg->inputs[i].type != AUTO_PIN_MIC)
+				return 0; /* only mic is allowed */
+			if (!is_jack_detectable(codec, nid))
+				return 0; /* no unsol support */
+			break;
+		}
+		if (num_pins >= MAX_AUTO_MIC_PINS)
+			return 0;
+		types |= (1 << attr);
+		spec->am_entry[num_pins].pin = nid;
+		spec->am_entry[num_pins].attr = attr;
+		num_pins++;
+	}
+
+	if (num_pins < 2)
+		return 0;
+
+	spec->am_num_entries = num_pins;
+	/* sort the am_entry in the order of attr so that the pin with a
+	 * higher attr will be selected when the jack is plugged.
+	 */
+	sort(spec->am_entry, num_pins, sizeof(spec->am_entry[0]),
+	     compare_attr, NULL);
+
+	if (!auto_mic_check_imux(codec))
+		return 0;
+
+	spec->auto_mic = 1;
+	spec->num_adc_nids = 1;
+	spec->cur_mux[0] = spec->am_entry[0].idx;
+	snd_printdd("hda-codec: Enable auto-mic switch on NID 0x%x/0x%x/0x%x\n",
+		    spec->am_entry[0].pin,
+		    spec->am_entry[1].pin,
+		    spec->am_entry[2].pin);
+
 	return 0;
 }
 
-/*
- * build output mixer controls
- */
-static int create_output_mixers(struct hda_codec *codec,
-				const char * const *names)
-{
-	struct hda_gspec *spec = codec->spec;
-	int i, err;
 
-	for (i = 0; i < spec->pcm_vol_nodes; i++) {
-		err = create_mixer(codec, spec->pcm_vol[i].node,
-				   spec->pcm_vol[i].index,
-				   names[i], "Playback", 0);
+/* parse the BIOS configuration and set up the hda_gen_spec */
+/* return 1 if successful, 0 if the proper config is not found,
+ * or a negative error code
+ */
+int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
+				  const hda_nid_t *ignore_nids)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int err;
+
+	err = snd_hda_parse_pin_defcfg(codec, cfg, ignore_nids,
+				       spec->parse_flags);
+	if (err < 0)
+		return err;
+	if (!cfg->line_outs) {
+		if (cfg->dig_outs || cfg->dig_in_pin) {
+			spec->multiout.max_channels = 2;
+			spec->no_analog = 1;
+			goto dig_only;
+		}
+		return 0; /* can't find valid BIOS pin config */
+	}
+
+	if (!spec->no_primary_hp &&
+	    cfg->line_out_type == AUTO_PIN_SPEAKER_OUT &&
+	    cfg->line_outs <= cfg->hp_outs) {
+		/* use HP as primary out */
+		cfg->speaker_outs = cfg->line_outs;
+		memcpy(cfg->speaker_pins, cfg->line_out_pins,
+		       sizeof(cfg->speaker_pins));
+		cfg->line_outs = cfg->hp_outs;
+		memcpy(cfg->line_out_pins, cfg->hp_pins, sizeof(cfg->hp_pins));
+		cfg->hp_outs = 0;
+		memset(cfg->hp_pins, 0, sizeof(cfg->hp_pins));
+		cfg->line_out_type = AUTO_PIN_HP_OUT;
+	}
+
+	err = parse_output_paths(codec);
+	if (err < 0)
+		return err;
+	err = create_multi_channel_mode(codec);
+	if (err < 0)
+		return err;
+	err = create_multi_out_ctls(codec, cfg);
+	if (err < 0)
+		return err;
+	err = create_hp_out_ctls(codec);
+	if (err < 0)
+		return err;
+	err = create_speaker_out_ctls(codec);
+	if (err < 0)
+		return err;
+	err = create_shared_input(codec);
+	if (err < 0)
+		return err;
+	err = create_input_ctls(codec);
+	if (err < 0)
+		return err;
+
+	/* check the multiple speaker pins */
+	if (cfg->line_out_type == AUTO_PIN_SPEAKER_OUT)
+		spec->const_channel_count = cfg->line_outs * 2;
+	else
+		spec->const_channel_count = cfg->speaker_outs * 2;
+
+	if (spec->multi_ios > 0)
+		spec->multiout.max_channels = max(spec->ext_channel_count,
+						  spec->const_channel_count);
+	else
+		spec->multiout.max_channels = spec->multiout.num_dacs * 2;
+
+	err = check_auto_mute_availability(codec);
+	if (err < 0)
+		return err;
+
+	err = check_dyn_adc_switch(codec);
+	if (err < 0)
+		return err;
+
+	if (!spec->shared_mic_hp) {
+		err = check_auto_mic_availability(codec);
 		if (err < 0)
 			return err;
 	}
-	return 0;
-}
 
-static int build_output_controls(struct hda_codec *codec)
-{
-	struct hda_gspec *spec = codec->spec;
-	static const char * const types_speaker[] = { "Speaker", "Headphone" };
-	static const char * const types_line[] = { "Front", "Headphone" };
+	err = create_capture_mixers(codec);
+	if (err < 0)
+		return err;
 
-	switch (spec->pcm_vol_nodes) {
-	case 1:
-		return create_mixer(codec, spec->pcm_vol[0].node,
-				    spec->pcm_vol[0].index,
-				    "Master", "Playback", 0);
-	case 2:
-		if (defcfg_type(spec->out_pin_node[0]) == AC_JACK_SPEAKER)
-			return create_output_mixers(codec, types_speaker);
-		else
-			return create_output_mixers(codec, types_line);
-	}
-	return 0;
+	err = parse_mic_boost(codec);
+	if (err < 0)
+		return err;
+
+ dig_only:
+	parse_digital(codec);
+
+	return 1;
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_parse_auto_config);
 
-/* create capture volume/switch */
-static int build_input_controls(struct hda_codec *codec)
-{
-	struct hda_gspec *spec = codec->spec;
-	struct hda_gnode *adc_node = spec->adc_node;
-	int i, err;
-	static struct snd_kcontrol_new cap_sel = {
-		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-		.name = "Capture Source",
-		.info = capture_source_info,
-		.get = capture_source_get,
-		.put = capture_source_put,
-	};
 
-	if (! adc_node || ! spec->input_mux.num_items)
-		return 0; /* not found */
+/*
+ * Build control elements
+ */
+
+/* slave controls for virtual master */
+static const char * const slave_pfxs[] = {
+	"Front", "Surround", "Center", "LFE", "Side",
+	"Headphone", "Speaker", "Mono", "Line Out",
+	"CLFE", "Bass Speaker", "PCM",
+	NULL,
+};
+
+int snd_hda_gen_build_controls(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int err;
 
-	spec->cur_cap_src = 0;
-	select_input_connection(codec, adc_node,
-				spec->input_mux.items[0].index);
+	err = snd_hda_add_new_ctls(codec, spec->kctls.list);
+	if (err < 0)
+		return err;
 
-	/* create capture volume and switch controls if the ADC has an amp */
-	/* do we have only a single item? */
-	if (spec->input_mux.num_items == 1) {
-		err = create_mixer(codec, adc_node,
-				   spec->input_mux.items[0].index,
-				   NULL, "Capture", 0);
+	if (spec->multiout.dig_out_nid) {
+		err = snd_hda_create_dig_out_ctls(codec,
+						  spec->multiout.dig_out_nid,
+						  spec->multiout.dig_out_nid,
+						  spec->pcm_rec[1].pcm_type);
+		if (err < 0)
+			return err;
+		if (!spec->no_analog) {
+			err = snd_hda_create_spdif_share_sw(codec,
+							    &spec->multiout);
+			if (err < 0)
+				return err;
+			spec->multiout.share_spdif = 1;
+		}
+	}
+	if (spec->dig_in_nid) {
+		err = snd_hda_create_spdif_in_ctls(codec, spec->dig_in_nid);
 		if (err < 0)
 			return err;
-		return 0;
 	}
 
-	/* create input MUX if multiple sources are available */
-	err = snd_hda_ctl_add(codec, spec->adc_node->nid,
-			      snd_ctl_new1(&cap_sel, codec));
-	if (err < 0)
-		return err;
+	/* if we have no master control, let's create it */
+	if (!spec->no_analog &&
+	    !snd_hda_find_mixer_ctl(codec, "Master Playback Volume")) {
+		unsigned int vmaster_tlv[4];
+		snd_hda_set_vmaster_tlv(codec, spec->vmaster_nid,
+					HDA_OUTPUT, vmaster_tlv);
+		err = snd_hda_add_vmaster(codec, "Master Playback Volume",
+					  vmaster_tlv, slave_pfxs,
+					  "Playback Volume");
+		if (err < 0)
+			return err;
+	}
+	if (!spec->no_analog &&
+	    !snd_hda_find_mixer_ctl(codec, "Master Playback Switch")) {
+		err = __snd_hda_add_vmaster(codec, "Master Playback Switch",
+					    NULL, slave_pfxs,
+					    "Playback Switch",
+					    true, &spec->vmaster_mute.sw_kctl);
+		if (err < 0)
+			return err;
+		if (spec->vmaster_mute.hook)
+			snd_hda_add_vmaster_hook(codec, &spec->vmaster_mute, true);
+	}
 
-	/* no volume control? */
-	if (! (adc_node->wid_caps & AC_WCAP_IN_AMP) ||
-	    ! (adc_node->amp_in_caps & AC_AMPCAP_NUM_STEPS))
-		return 0;
+	free_kctls(spec); /* no longer needed */
 
-	for (i = 0; i < spec->input_mux.num_items; i++) {
-		struct snd_kcontrol_new knew;
-		char name[32];
-		sprintf(name, "%s Capture Volume",
-			spec->input_mux.items[i].label);
-		knew = (struct snd_kcontrol_new)
-			HDA_CODEC_VOLUME(name, adc_node->nid,
-					 spec->input_mux.items[i].index,
-					 HDA_INPUT);
-		err = snd_hda_ctl_add(codec, adc_node->nid,
-					snd_ctl_new1(&knew, codec));
+	if (spec->shared_mic_hp) {
+		int err;
+		int nid = spec->autocfg.inputs[1].pin;
+		err = snd_hda_jack_add_kctl(codec, nid, "Headphone Mic", 0);
+		if (err < 0)
+			return err;
+		err = snd_hda_jack_detect_enable(codec, nid, 0);
 		if (err < 0)
 			return err;
 	}
 
+	err = snd_hda_jack_add_kctls(codec, &spec->autocfg);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
+EXPORT_SYMBOL_HDA(snd_hda_gen_build_controls);
 
 
 /*
- * parse the nodes recursively until reach to the output PIN.
- *
- * returns 0 - if not found,
- *         1 - if found, but no mixer is created
- *         2 - if found and mixer was already created, (just skip)
- *         a negative error code
+ * PCM definitions
  */
-static int parse_loopback_path(struct hda_codec *codec, struct hda_gspec *spec,
-			       struct hda_gnode *node, struct hda_gnode *dest_node,
-			       const char *type)
-{
-	int i, err;
 
-	if (node->checked)
-		return 0;
+/*
+ * Analog playback callbacks
+ */
+static int playback_pcm_open(struct hda_pcm_stream *hinfo,
+			     struct hda_codec *codec,
+			     struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_open(codec, &spec->multiout, substream,
+					     hinfo);
+}
 
-	node->checked = 1;
-	if (node == dest_node) {
-		/* loopback connection found */
-		return 1;
-	}
+static int playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+				struct hda_codec *codec,
+				unsigned int stream_tag,
+				unsigned int format,
+				struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_prepare(codec, &spec->multiout,
+						stream_tag, format, substream);
+}
 
-	for (i = 0; i < node->nconns; i++) {
-		struct hda_gnode *child = hda_get_node(spec, node->conn_list[i]);
-		if (! child)
-			continue;
-		err = parse_loopback_path(codec, spec, child, dest_node, type);
-		if (err < 0)
-			return err;
-		else if (err >= 1) {
-			if (err == 1) {
-				err = create_mixer(codec, node, i, type,
-						   "Playback", 1);
-				if (err < 0)
-					return err;
-				if (err > 0)
-					return 2; /* ok, created */
-				/* not created, maybe in the lower path */
-				err = 1;
-			}
-			/* connect and unmute */
-			if (node->nconns > 1)
-				select_input_connection(codec, node, i);
-			unmute_input(codec, node, i);
-			unmute_output(codec, node);
-			return err;
-		}
-	}
-	return 0;
+static int playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				struct hda_codec *codec,
+				struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_analog_cleanup(codec, &spec->multiout);
 }
 
 /*
- * parse the tree and build the loopback controls
+ * Digital out
  */
-static int build_loopback_controls(struct hda_codec *codec)
+static int dig_playback_pcm_open(struct hda_pcm_stream *hinfo,
+				 struct hda_codec *codec,
+				 struct snd_pcm_substream *substream)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_gnode *node;
-	int err;
-	const char *type;
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_open(codec, &spec->multiout);
+}
 
-	if (! spec->out_pin_node[0])
-		return 0;
+static int dig_playback_pcm_prepare(struct hda_pcm_stream *hinfo,
+				    struct hda_codec *codec,
+				    unsigned int stream_tag,
+				    unsigned int format,
+				    struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_prepare(codec, &spec->multiout,
+					     stream_tag, format, substream);
+}
 
-	list_for_each_entry(node, &spec->nid_list, list) {
-		if (node->type != AC_WID_PIN)
-			continue;
-		/* input capable? */
-		if (! (node->pin_caps & AC_PINCAP_IN))
-			return 0;
-		type = get_input_type(node, NULL);
-		if (type) {
-			if (check_existing_control(codec, type, "Playback"))
-				continue;
-			clear_check_flags(spec);
-			err = parse_loopback_path(codec, spec,
-						  spec->out_pin_node[0],
-						  node, type);
-			if (err < 0)
-				return err;
-			if (! err)
-				continue;
-		}
-	}
-	return 0;
+static int dig_playback_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				    struct hda_codec *codec,
+				    struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_cleanup(codec, &spec->multiout);
+}
+
+static int dig_playback_pcm_close(struct hda_pcm_stream *hinfo,
+				  struct hda_codec *codec,
+				  struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	return snd_hda_multi_out_dig_close(codec, &spec->multiout);
 }
 
 /*
- * build mixer controls
+ * Analog capture
  */
-static int build_generic_controls(struct hda_codec *codec)
+static int alt_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+				   struct hda_codec *codec,
+				   unsigned int stream_tag,
+				   unsigned int format,
+				   struct snd_pcm_substream *substream)
 {
-	int err;
+	struct hda_gen_spec *spec = codec->spec;
 
-	if ((err = build_input_controls(codec)) < 0 ||
-	    (err = build_output_controls(codec)) < 0 ||
-	    (err = build_loopback_controls(codec)) < 0)
-		return err;
+	snd_hda_codec_setup_stream(codec, spec->adc_nids[substream->number + 1],
+				   stream_tag, 0, format);
+	return 0;
+}
+
+static int alt_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				   struct hda_codec *codec,
+				   struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
 
+	snd_hda_codec_cleanup_stream(codec,
+				     spec->adc_nids[substream->number + 1]);
 	return 0;
 }
 
 /*
- * PCM
  */
-static struct hda_pcm_stream generic_pcm_playback = {
+static const struct hda_pcm_stream pcm_analog_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 8,
+	/* NID is set in build_pcms */
+	.ops = {
+		.open = playback_pcm_open,
+		.prepare = playback_pcm_prepare,
+		.cleanup = playback_pcm_cleanup
+	},
+};
+
+static const struct hda_pcm_stream pcm_analog_capture = {
 	.substreams = 1,
 	.channels_min = 2,
 	.channels_max = 2,
+	/* NID is set in build_pcms */
 };
 
-static int generic_pcm2_prepare(struct hda_pcm_stream *hinfo,
-				struct hda_codec *codec,
-				unsigned int stream_tag,
-				unsigned int format,
-				struct snd_pcm_substream *substream)
+static const struct hda_pcm_stream pcm_analog_alt_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in build_pcms */
+};
+
+static const struct hda_pcm_stream pcm_analog_alt_capture = {
+	.substreams = 2, /* can be overridden */
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in build_pcms */
+	.ops = {
+		.prepare = alt_capture_pcm_prepare,
+		.cleanup = alt_capture_pcm_cleanup
+	},
+};
+
+static const struct hda_pcm_stream pcm_digital_playback = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in build_pcms */
+	.ops = {
+		.open = dig_playback_pcm_open,
+		.close = dig_playback_pcm_close,
+		.prepare = dig_playback_pcm_prepare,
+		.cleanup = dig_playback_pcm_cleanup
+	},
+};
+
+static const struct hda_pcm_stream pcm_digital_capture = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	/* NID is set in build_pcms */
+};
+
+/* Used by build_pcms to flag that a PCM has no playback stream */
+static const struct hda_pcm_stream pcm_null_stream = {
+	.substreams = 0,
+	.channels_min = 0,
+	.channels_max = 0,
+};
+
+/*
+ * dynamic changing ADC PCM streams
+ */
+static bool dyn_adc_pcm_resetup(struct hda_codec *codec, int cur)
 {
-	struct hda_gspec *spec = codec->spec;
+	struct hda_gen_spec *spec = codec->spec;
+	hda_nid_t new_adc = spec->adc_nids[spec->dyn_adc_idx[cur]];
+
+	if (spec->cur_adc && spec->cur_adc != new_adc) {
+		/* stream is running, let's swap the current ADC */
+		__snd_hda_codec_cleanup_stream(codec, spec->cur_adc, 1);
+		spec->cur_adc = new_adc;
+		snd_hda_codec_setup_stream(codec, new_adc,
+					   spec->cur_adc_stream_tag, 0,
+					   spec->cur_adc_format);
+		return true;
+	}
+	return false;
+}
 
-	snd_hda_codec_setup_stream(codec, hinfo->nid, stream_tag, 0, format);
-	snd_hda_codec_setup_stream(codec, spec->dac_node[1]->nid,
-				   stream_tag, 0, format);
+/* analog capture with dynamic dual-adc changes */
+static int dyn_adc_capture_pcm_prepare(struct hda_pcm_stream *hinfo,
+				       struct hda_codec *codec,
+				       unsigned int stream_tag,
+				       unsigned int format,
+				       struct snd_pcm_substream *substream)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	spec->cur_adc = spec->adc_nids[spec->dyn_adc_idx[spec->cur_mux[0]]];
+	spec->cur_adc_stream_tag = stream_tag;
+	spec->cur_adc_format = format;
+	snd_hda_codec_setup_stream(codec, spec->cur_adc, stream_tag, 0, format);
 	return 0;
 }
 
-static int generic_pcm2_cleanup(struct hda_pcm_stream *hinfo,
-				struct hda_codec *codec,
-				struct snd_pcm_substream *substream)
+static int dyn_adc_capture_pcm_cleanup(struct hda_pcm_stream *hinfo,
+				       struct hda_codec *codec,
+				       struct snd_pcm_substream *substream)
 {
-	struct hda_gspec *spec = codec->spec;
-
-	snd_hda_codec_cleanup_stream(codec, hinfo->nid);
-	snd_hda_codec_cleanup_stream(codec, spec->dac_node[1]->nid);
+	struct hda_gen_spec *spec = codec->spec;
+	snd_hda_codec_cleanup_stream(codec, spec->cur_adc);
+	spec->cur_adc = 0;
 	return 0;
 }
 
-static int build_generic_pcms(struct hda_codec *codec)
+static const struct hda_pcm_stream dyn_adc_pcm_analog_capture = {
+	.substreams = 1,
+	.channels_min = 2,
+	.channels_max = 2,
+	.nid = 0, /* fill later */
+	.ops = {
+		.prepare = dyn_adc_capture_pcm_prepare,
+		.cleanup = dyn_adc_capture_pcm_cleanup
+	},
+};
+
+/* build PCM streams based on the parsed results */
+int snd_hda_gen_build_pcms(struct hda_codec *codec)
 {
-	struct hda_gspec *spec = codec->spec;
-	struct hda_pcm *info = &spec->pcm_rec;
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_pcm *info = spec->pcm_rec;
+	const struct hda_pcm_stream *p;
+	bool have_multi_adcs;
+	int i;
+
+	codec->num_pcms = 1;
+	codec->pcm_info = info;
+
+	if (spec->no_analog)
+		goto skip_analog;
+
+	snprintf(spec->stream_name_analog, sizeof(spec->stream_name_analog),
+		 "%s Analog", codec->chip_name);
+	info->name = spec->stream_name_analog;
+
+	if (spec->multiout.num_dacs > 0) {
+		p = spec->stream_analog_playback;
+		if (!p)
+			p = &pcm_analog_playback;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK] = *p;
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dac_nids[0];
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max =
+			spec->multiout.max_channels;
+		if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT &&
+		    spec->autocfg.line_outs == 2)
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK].chmap =
+				snd_pcm_2_1_chmaps;
+	}
+	if (spec->num_adc_nids) {
+		p = spec->stream_analog_capture;
+		if (!p) {
+			if (spec->dyn_adc_switch)
+				p = &dyn_adc_pcm_analog_capture;
+			else
+				p = &pcm_analog_capture;
+		}
+		info->stream[SNDRV_PCM_STREAM_CAPTURE] = *p;
+		info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->adc_nids[0];
+	}
+
+	if (spec->channel_mode) {
+		info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = 0;
+		for (i = 0; i < spec->num_channel_mode; i++) {
+			if (spec->channel_mode[i].channels > info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max) {
+				info->stream[SNDRV_PCM_STREAM_PLAYBACK].channels_max = spec->channel_mode[i].channels;
+			}
+		}
+	}
+
+ skip_analog:
+	/* SPDIF for stream index #1 */
+	if (spec->multiout.dig_out_nid || spec->dig_in_nid) {
+		snprintf(spec->stream_name_digital,
+			 sizeof(spec->stream_name_digital),
+			 "%s Digital", codec->chip_name);
+		codec->num_pcms = 2;
+		codec->slave_dig_outs = spec->multiout.slave_dig_outs;
+		info = spec->pcm_rec + 1;
+		info->name = spec->stream_name_digital;
+		if (spec->dig_out_type)
+			info->pcm_type = spec->dig_out_type;
+		else
+			info->pcm_type = HDA_PCM_TYPE_SPDIF;
+		if (spec->multiout.dig_out_nid) {
+			p = spec->stream_digital_playback;
+			if (!p)
+				p = &pcm_digital_playback;
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK] = *p;
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = spec->multiout.dig_out_nid;
+		}
+		if (spec->dig_in_nid) {
+			p = spec->stream_digital_capture;
+			if (!p)
+				p = &pcm_digital_capture;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE] = *p;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = spec->dig_in_nid;
+		}
+	}
 
-	if (! spec->dac_node[0] && ! spec->adc_node) {
-		snd_printd("hda_generic: no PCM found\n");
+	if (spec->no_analog)
 		return 0;
+
+	/* If the use of more than one ADC is requested for the current
+	 * model, configure a second analog capture-only PCM.
+	 */
+	have_multi_adcs = (spec->num_adc_nids > 1) &&
+		!spec->dyn_adc_switch && !spec->auto_mic;
+	/* Additional Analaog capture for index #2 */
+	if (spec->alt_dac_nid || have_multi_adcs) {
+		codec->num_pcms = 3;
+		info = spec->pcm_rec + 2;
+		info->name = spec->stream_name_analog;
+		if (spec->alt_dac_nid) {
+			p = spec->stream_analog_alt_playback;
+			if (!p)
+				p = &pcm_analog_alt_playback;
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK] = *p;
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid =
+				spec->alt_dac_nid;
+		} else {
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK] =
+				pcm_null_stream;
+			info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid = 0;
+		}
+		if (have_multi_adcs) {
+			p = spec->stream_analog_alt_capture;
+			if (!p)
+				p = &pcm_analog_alt_capture;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE] = *p;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid =
+				spec->adc_nids[1];
+			info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams =
+				spec->num_adc_nids - 1;
+		} else {
+			info->stream[SNDRV_PCM_STREAM_CAPTURE] =
+				pcm_null_stream;
+			info->stream[SNDRV_PCM_STREAM_CAPTURE].nid = 0;
+		}
 	}
 
-	codec->num_pcms = 1;
-	codec->pcm_info = info;
+	return 0;
+}
+EXPORT_SYMBOL_HDA(snd_hda_gen_build_pcms);
+
+
+/*
+ * Standard auto-parser initializations
+ */
+
+/* configure the path from the given dac to the pin as the proper output */
+static void set_output_and_unmute(struct hda_codec *codec, hda_nid_t pin,
+				  int pin_type, hda_nid_t dac)
+{
+	struct nid_path *path;
+
+	snd_hda_set_pin_ctl_cache(codec, pin, pin_type);
+	path = snd_hda_get_nid_path(codec, dac, pin);
+	if (!path)
+		return;
+	if (path->active)
+		return;
+	snd_hda_activate_path(codec, path, true, true);
+}
+
+/* initialize primary output paths */
+static void init_multi_out(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int pin_type;
+	int i;
+
+	if (spec->autocfg.line_out_type == AUTO_PIN_HP_OUT)
+		pin_type = PIN_HP;
+	else
+		pin_type = PIN_OUT;
+
+	for (i = 0; i <= HDA_SIDE; i++) {
+		hda_nid_t nid = spec->autocfg.line_out_pins[i];
+		if (nid)
+			set_output_and_unmute(codec, nid, pin_type,
+					      spec->multiout.dac_nids[i]);
+
+	}
+}
+
+/* initialize hp and speaker paths */
+static void init_extra_out(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+	hda_nid_t pin, dac;
+
+	for (i = 0; i < spec->autocfg.hp_outs; i++) {
+		if (spec->autocfg.line_out_type == AUTO_PIN_HP_OUT)
+			break;
+		pin = spec->autocfg.hp_pins[i];
+		if (!pin)
+			break;
+		dac = spec->multiout.hp_out_nid[i];
+		if (!dac) {
+			if (i > 0 && spec->multiout.hp_out_nid[0])
+				dac = spec->multiout.hp_out_nid[0];
+			else
+				dac = spec->multiout.dac_nids[0];
+		}
+		set_output_and_unmute(codec, pin, PIN_HP, dac);
+	}
+	for (i = 0; i < spec->autocfg.speaker_outs; i++) {
+		if (spec->autocfg.line_out_type == AUTO_PIN_SPEAKER_OUT)
+			break;
+		pin = spec->autocfg.speaker_pins[i];
+		if (!pin)
+			break;
+		dac = spec->multiout.extra_out_nid[i];
+		if (!dac) {
+			if (i > 0 && spec->multiout.extra_out_nid[0])
+				dac = spec->multiout.extra_out_nid[0];
+			else
+				dac = spec->multiout.dac_nids[0];
+		}
+		set_output_and_unmute(codec, pin, PIN_OUT, dac);
+	}
+}
+
+/* initialize multi-io paths */
+static void init_multi_io(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+
+	for (i = 0; i < spec->multi_ios; i++) {
+		hda_nid_t pin = spec->multi_io[i].pin;
+		struct nid_path *path;
+		path = snd_hda_get_nid_path(codec, spec->multi_io[i].dac, pin);
+		if (!path)
+			continue;
+		if (!spec->multi_io[i].ctl_in)
+			spec->multi_io[i].ctl_in =
+				snd_hda_codec_update_cache(codec, pin, 0,
+					   AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+		snd_hda_activate_path(codec, path, path->active, true);
+	}
+}
+
+/* set up the input pin config, depending on the given auto-pin type */
+static void set_input_pin(struct hda_codec *codec, hda_nid_t nid,
+			  int auto_pin_type)
+{
+	unsigned int val = PIN_IN;
+	if (auto_pin_type == AUTO_PIN_MIC)
+		val |= snd_hda_get_default_vref(codec, nid);
+	snd_hda_set_pin_ctl(codec, nid, val);
+}
+
+/* set up input pins and loopback paths */
+static void init_analog_input(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct auto_pin_cfg *cfg = &spec->autocfg;
+	int i;
+
+	for (i = 0; i < cfg->num_inputs; i++) {
+		hda_nid_t nid = cfg->inputs[i].pin;
+		if (is_input_pin(codec, nid))
+			set_input_pin(codec, nid, cfg->inputs[i].type);
+
+		/* init loopback inputs */
+		if (spec->mixer_nid) {
+			struct nid_path *path;
+			path = snd_hda_get_nid_path(codec, nid, spec->mixer_nid);
+			if (path)
+				snd_hda_activate_path(codec, path,
+						      path->active, false);
+		}
+	}
+}
+
+/* initialize ADC paths */
+static void init_input_src(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	struct hda_input_mux *imux = &spec->input_mux;
+	struct nid_path *path;
+	int i, c, nums;
 
-	info->name = "HDA Generic";
-	if (spec->dac_node[0]) {
-		info->stream[0] = generic_pcm_playback;
-		info->stream[0].nid = spec->dac_node[0]->nid;
-		if (spec->dac_node[1]) {
-			info->stream[0].ops.prepare = generic_pcm2_prepare;
-			info->stream[0].ops.cleanup = generic_pcm2_cleanup;
+	if (spec->dyn_adc_switch)
+		nums = 1;
+	else
+		nums = spec->num_adc_nids;
+
+	for (c = 0; c < nums; c++) {
+		for (i = 0; i < imux->num_items; i++) {
+			path = snd_hda_get_nid_path(codec, spec->imux_pins[i],
+						    get_adc_nid(codec, c, i));
+			if (path) {
+				bool active = path->active;
+				if (i == spec->cur_mux[c])
+					active = true;
+				snd_hda_activate_path(codec, path, active, false);
+			}
 		}
 	}
-	if (spec->adc_node) {
-		info->stream[1] = generic_pcm_playback;
-		info->stream[1].nid = spec->adc_node->nid;
+
+	if (spec->shared_mic_hp)
+		update_shared_mic_hp(codec, spec->cur_mux[0]);
+
+	if (spec->cap_sync_hook)
+		spec->cap_sync_hook(codec);
+}
+
+/* set right pin controls for digital I/O */
+static void init_digital(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+	int i;
+	hda_nid_t pin;
+
+	for (i = 0; i < spec->autocfg.dig_outs; i++) {
+		pin = spec->autocfg.dig_out_pins[i];
+		if (!pin)
+			continue;
+		set_output_and_unmute(codec, pin, PIN_OUT, 0);
 	}
+	pin = spec->autocfg.dig_in_pin;
+	if (pin)
+		snd_hda_set_pin_ctl(codec, pin, PIN_IN);
+}
+
+int snd_hda_gen_init(struct hda_codec *codec)
+{
+	struct hda_gen_spec *spec = codec->spec;
+
+	if (spec->init_hook)
+		spec->init_hook(codec);
+
+	snd_hda_apply_verbs(codec);
+
+	init_multi_out(codec);
+	init_extra_out(codec);
+	init_multi_io(codec);
+	init_analog_input(codec);
+	init_input_src(codec);
+	init_digital(codec);
 
+	/* call init functions of standard auto-mute helpers */
+	hp_automute(codec, NULL);
+	line_automute(codec, NULL);
+	mic_autoswitch(codec, NULL);
+
+	if (spec->vmaster_mute.sw_kctl && spec->vmaster_mute.hook)
+		snd_hda_sync_vmaster_hook(&spec->vmaster_mute);
+
+	hda_call_check_power_status(codec, 0x01);
 	return 0;
 }
+EXPORT_SYMBOL(snd_hda_gen_init);
+
+
+/*
+ * the generic codec support
+ */
 
 #ifdef CONFIG_PM
 static int generic_check_power_status(struct hda_codec *codec, hda_nid_t nid)
 {
-	struct hda_gspec *spec = codec->spec;
+	struct hda_gen_spec *spec = codec->spec;
 	return snd_hda_check_amp_list_power(codec, &spec->loopback, nid);
 }
 #endif
 
+static void generic_free(struct hda_codec *codec)
+{
+	snd_hda_gen_spec_free(codec->spec);
+	kfree(codec->spec);
+	codec->spec = NULL;
+}
 
-/*
- */
-static struct hda_codec_ops generic_patch_ops = {
-	.build_controls = build_generic_controls,
-	.build_pcms = build_generic_pcms,
-	.free = snd_hda_generic_free,
+static const struct hda_codec_ops generic_patch_ops = {
+	.build_controls = snd_hda_gen_build_controls,
+	.build_pcms = snd_hda_gen_build_pcms,
+	.init = snd_hda_gen_init,
+	.free = generic_free,
+	.unsol_event = snd_hda_jack_unsol_event,
 #ifdef CONFIG_PM
 	.check_power_status = generic_check_power_status,
 #endif
 };
 
-/*
- * the generic parser
- */
 int snd_hda_parse_generic_codec(struct hda_codec *codec)
 {
-	struct hda_gspec *spec;
+	struct hda_gen_spec *spec;
 	int err;
 
-	if(!codec->afg)
-		return 0;
-
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
-	if (spec == NULL) {
-		printk(KERN_ERR "hda_generic: can't allocate spec\n");
+	if (!spec)
 		return -ENOMEM;
-	}
+	snd_hda_gen_spec_init(spec);
 	codec->spec = spec;
-	INIT_LIST_HEAD(&spec->nid_list);
-
-	if ((err = build_afg_tree(codec)) < 0)
-		goto error;
 
-	if ((err = parse_input(codec)) < 0 ||
-	    (err = parse_output(codec)) < 0)
+	err = snd_hda_gen_parse_auto_config(codec, NULL);
+	if (err < 0)
 		goto error;
 
 	codec->patch_ops = generic_patch_ops;
-
 	return 0;
 
- error:
-	snd_hda_generic_free(codec);
+error:
+	generic_free(codec);
 	return err;
 }
 EXPORT_SYMBOL(snd_hda_parse_generic_codec);
diff --git a/sound/pci/hda/hda_generic.h b/sound/pci/hda/hda_generic.h
new file mode 100644
index 0000000..a9f4f63
--- /dev/null
+++ b/sound/pci/hda/hda_generic.h
@@ -0,0 +1,199 @@
+/*
+ * Generic BIOS auto-parser helper functions for HD-audio
+ *
+ * Copyright (c) 2012 Takashi Iwai <tiwai@suse.de>
+ *
+ * This driver is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __SOUND_HDA_GENERIC_H
+#define __SOUND_HDA_GENERIC_H
+
+/* unsol event tags */
+enum {
+	HDA_GEN_HP_EVENT, HDA_GEN_FRONT_EVENT, HDA_GEN_MIC_EVENT,
+	HDA_GEN_LAST_EVENT = HDA_GEN_MIC_EVENT
+};
+
+/* table entry for multi-io paths */
+struct hda_multi_io {
+	hda_nid_t pin;		/* multi-io widget pin NID */
+	hda_nid_t dac;		/* DAC to be connected */
+	unsigned int ctl_in;	/* cached input-pin control value */
+};
+
+/* Widget connection path
+ *
+ * For output, stored in the order of DAC -> ... -> pin,
+ * for input, pin -> ... -> ADC.
+ *
+ * idx[i] contains the source index number to select on of the widget path[i];
+ * e.g. idx[1] is the index of the DAC (path[0]) selected by path[1] widget
+ * multi[] indicates whether it's a selector widget with multi-connectors
+ * (i.e. the connection selection is mandatory)
+ * vol_ctl and mute_ctl contains the NIDs for the assigned mixers
+ */
+
+#define MAX_NID_PATH_DEPTH	5
+
+enum {
+	NID_PATH_VOL_CTL,
+	NID_PATH_MUTE_CTL,
+	NID_PATH_BOOST_CTL,
+	NID_PATH_NUM_CTLS
+};
+
+struct nid_path {
+	int depth;
+	hda_nid_t path[MAX_NID_PATH_DEPTH];
+	unsigned char idx[MAX_NID_PATH_DEPTH];
+	unsigned char multi[MAX_NID_PATH_DEPTH];
+	unsigned int ctls[NID_PATH_NUM_CTLS]; /* NID_PATH_XXX_CTL */
+	bool active;
+};
+
+/* mic/line-in auto switching entry */
+
+#define MAX_AUTO_MIC_PINS	3
+
+struct automic_entry {
+	hda_nid_t pin;		/* pin */
+	int idx;		/* imux index, -1 = invalid */
+	unsigned int attr;	/* pin attribute (INPUT_PIN_ATTR_*) */
+};
+
+struct hda_gen_spec {
+	char stream_name_analog[32];	/* analog PCM stream */
+	const struct hda_pcm_stream *stream_analog_playback;
+	const struct hda_pcm_stream *stream_analog_capture;
+	const struct hda_pcm_stream *stream_analog_alt_playback;
+	const struct hda_pcm_stream *stream_analog_alt_capture;
+
+	char stream_name_digital[32];	/* digital PCM stream */
+	const struct hda_pcm_stream *stream_digital_playback;
+	const struct hda_pcm_stream *stream_digital_capture;
+
+	/* playback */
+	struct hda_multi_out multiout;	/* playback set-up
+					 * max_channels, dacs must be set
+					 * dig_out_nid and hp_nid are optional
+					 */
+	hda_nid_t alt_dac_nid;
+	hda_nid_t slave_dig_outs[3];	/* optional - for auto-parsing */
+	int dig_out_type;
+
+	/* capture */
+	unsigned int num_adc_nids;
+	hda_nid_t adc_nids[AUTO_CFG_MAX_OUTS];
+	hda_nid_t dig_in_nid;		/* digital-in NID; optional */
+	hda_nid_t mixer_nid;		/* analog-mixer NID */
+
+	/* capture setup for dynamic dual-adc switch */
+	hda_nid_t cur_adc;
+	unsigned int cur_adc_stream_tag;
+	unsigned int cur_adc_format;
+
+	/* capture source */
+	struct hda_input_mux input_mux;
+	unsigned int cur_mux[3];
+
+	/* channel model */
+	const struct hda_channel_mode *channel_mode;
+	int num_channel_mode;
+	int const_channel_count;	/* min. channel count (for speakers) */
+	int ext_channel_count;		/* current channel count for multi-io */
+
+	/* PCM information */
+	struct hda_pcm pcm_rec[3];	/* used in build_pcms() */
+
+	/* dynamic controls, init_verbs and input_mux */
+	struct auto_pin_cfg autocfg;
+	struct snd_array kctls;
+	hda_nid_t private_dac_nids[AUTO_CFG_MAX_OUTS];
+	hda_nid_t imux_pins[HDA_MAX_NUM_INPUTS];
+	unsigned int dyn_adc_idx[HDA_MAX_NUM_INPUTS];
+	hda_nid_t shared_mic_vref_pin;
+
+	/* DAC list */
+	int num_all_dacs;
+	hda_nid_t all_dacs[16];
+
+	/* path list */
+	struct snd_array paths;
+
+	/* auto-mic stuff */
+	int am_num_entries;
+	struct automic_entry am_entry[MAX_AUTO_MIC_PINS];
+
+	/* for pin sensing */
+	unsigned int hp_jack_present:1;
+	unsigned int line_jack_present:1;
+	unsigned int master_mute:1;
+	unsigned int auto_mic:1;
+	unsigned int automute_speaker:1; /* automute speaker outputs */
+	unsigned int automute_lo:1; /* automute LO outputs */
+	unsigned int detect_hp:1;	/* Headphone detection enabled */
+	unsigned int detect_lo:1;	/* Line-out detection enabled */
+	unsigned int automute_speaker_possible:1; /* there are speakers and either LO or HP */
+	unsigned int automute_lo_possible:1;	  /* there are line outs and HP */
+	unsigned int keep_vref_in_automute:1; /* Don't clear VREF in automute */
+	unsigned int line_in_auto_switch:1; /* allow line-in auto switch */
+
+	/* other flags */
+	unsigned int need_dac_fix:1; /* need to limit DACs for multi channels */
+	unsigned int no_analog:1; /* digital I/O only */
+	unsigned int dyn_adc_switch:1; /* switch ADCs (for ALC275) */
+	unsigned int shared_mic_hp:1; /* HP/Mic-in sharing */
+	unsigned int no_primary_hp:1; /* Don't prefer HP pins to speaker pins */
+	unsigned int multi_cap_vol:1; /* allow multiple capture xxx volumes */
+	unsigned int inv_dmic_split:1; /* inverted dmic w/a for conexant */
+
+	unsigned int parse_flags; /* passed to snd_hda_parse_pin_defcfg() */
+
+	/* for virtual master */
+	hda_nid_t vmaster_nid;
+	struct hda_vmaster_mute_hook vmaster_mute;
+#ifdef CONFIG_PM
+	struct hda_loopback_check loopback;
+	int num_loopbacks;
+	struct hda_amp_list loopback_list[8];
+#endif
+
+	/* multi-io */
+	int multi_ios;
+	struct hda_multi_io multi_io[4];
+
+	/* bind volumes */
+	struct snd_array bind_ctls;
+
+	/* hooks */
+	void (*init_hook)(struct hda_codec *codec);
+	void (*automute_hook)(struct hda_codec *codec);
+	void (*cap_sync_hook)(struct hda_codec *codec);
+};
+
+int snd_hda_gen_spec_init(struct hda_gen_spec *spec);
+void snd_hda_gen_spec_free(struct hda_gen_spec *spec);
+
+int snd_hda_gen_init(struct hda_codec *codec);
+
+struct nid_path *snd_hda_get_nid_path(struct hda_codec *codec,
+				      hda_nid_t from_nid, hda_nid_t to_nid);
+bool snd_hda_parse_nid_path(struct hda_codec *codec, hda_nid_t from_nid,
+			    hda_nid_t to_nid, int with_aa_mix,
+			    struct nid_path *path);
+struct nid_path *
+snd_hda_add_new_path(struct hda_codec *codec, hda_nid_t from_nid,
+		     hda_nid_t to_nid, int with_aa_mix);
+void snd_hda_activate_path(struct hda_codec *codec, struct nid_path *path,
+			   bool enable, bool add_aamix);
+
+int snd_hda_gen_parse_auto_config(struct hda_codec *codec,
+				  const hda_nid_t *ignore_nids);
+int snd_hda_gen_build_controls(struct hda_codec *codec);
+int snd_hda_gen_build_pcms(struct hda_codec *codec);
+
+#endif /* __SOUND_HDA_GENERIC_H */
-- 
1.8.0.1
