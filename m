From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: topology: fix endianness issues
Date: Thu,  4 Apr 2019 14:13:57 -0500
Message-ID: <20190404191358.4235-2-pierre-louis.bossart@linux.intel.com>
References: <20190404191358.4235-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A831EF89633
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 21:14:12 +0200 (CEST)
In-Reply-To: <20190404191358.4235-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Use le16/32/64_to_cpu() as needed to make Sparse happy.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-topology.c | 291 +++++++++++++++++++++++----------------
 1 file changed, 170 insertions(+), 121 deletions(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 472f7705da93..03c4dbdfc584 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -197,8 +197,8 @@ static int tplc_chan_get_reg(struct soc_tplg *tplg,
 	int i;
 
 	for (i = 0; i < SND_SOC_TPLG_MAX_CHAN; i++) {
-		if (chan[i].id == map)
-			return chan[i].reg;
+		if (le32_to_cpu(chan[i].id) == map)
+			return le32_to_cpu(chan[i].reg);
 	}
 
 	return -EINVAL;
@@ -210,8 +210,8 @@ static int tplc_chan_get_shift(struct soc_tplg *tplg,
 	int i;
 
 	for (i = 0; i < SND_SOC_TPLG_MAX_CHAN; i++) {
-		if (chan[i].id == map)
-			return chan[i].shift;
+		if (le32_to_cpu(chan[i].id) == map)
+			return le32_to_cpu(chan[i].shift);
 	}
 
 	return -EINVAL;
@@ -592,7 +592,7 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	const struct snd_soc_tplg_bytes_ext_ops *ext_ops;
 	int num_ops, i;
 
-	if (hdr->ops.info == SND_SOC_TPLG_CTL_BYTES
+	if (le32_to_cpu(hdr->ops.info) == SND_SOC_TPLG_CTL_BYTES
 		&& k->iface & SNDRV_CTL_ELEM_IFACE_MIXER
 		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
 		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
@@ -708,9 +708,9 @@ static int soc_tplg_create_tlv_db_scale(struct soc_tplg *tplg,
 
 	p[0] = SNDRV_CTL_TLVT_DB_SCALE;
 	p[1] = item_len;
-	p[2] = scale->min;
-	p[3] = (scale->step & TLV_DB_SCALE_MASK)
-			| (scale->mute ? TLV_DB_SCALE_MUTE : 0);
+	p[2] = le32_to_cpu(scale->min);
+	p[3] = (le32_to_cpu(scale->step) & TLV_DB_SCALE_MASK)
+		| (le32_to_cpu(scale->mute) ? TLV_DB_SCALE_MUTE : 0);
 
 	kc->tlv.p = (void *)p;
 	return 0;
@@ -720,13 +720,14 @@ static int soc_tplg_create_tlv(struct soc_tplg *tplg,
 	struct snd_kcontrol_new *kc, struct snd_soc_tplg_ctl_hdr *tc)
 {
 	struct snd_soc_tplg_ctl_tlv *tplg_tlv;
+	u32 access = le32_to_cpu(tc->access);
 
-	if (!(tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE))
+	if (!(access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE))
 		return 0;
 
-	if (!(tc->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)) {
+	if (!(access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK)) {
 		tplg_tlv = &tc->tlv;
-		switch (tplg_tlv->type) {
+		switch (le32_to_cpu(tplg_tlv->type)) {
 		case SNDRV_CTL_TLVT_DB_SCALE:
 			return soc_tplg_create_tlv_db_scale(tplg, kc,
 					&tplg_tlv->scale);
@@ -777,7 +778,7 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, unsigned int count,
 			return -ENOMEM;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_bytes_control) +
-			be->priv.size);
+			      le32_to_cpu(be->priv.size));
 
 		dev_dbg(tplg->dev,
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
@@ -787,9 +788,9 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, unsigned int count,
 		kc.name = be->hdr.name;
 		kc.private_value = (long)sbe;
 		kc.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		kc.access = be->hdr.access;
+		kc.access = le32_to_cpu(be->hdr.access);
 
-		sbe->max = be->max;
+		sbe->max = le32_to_cpu(be->max);
 		sbe->dobj.type = SND_SOC_DOBJ_BYTES;
 		sbe->dobj.ops = tplg->ops;
 		INIT_LIST_HEAD(&sbe->dobj.list);
@@ -857,7 +858,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 		if (sm == NULL)
 			return -ENOMEM;
 		tplg->pos += (sizeof(struct snd_soc_tplg_mixer_control) +
-			mc->priv.size);
+			      le32_to_cpu(mc->priv.size));
 
 		dev_dbg(tplg->dev,
 			"ASoC: adding mixer kcontrol %s with access 0x%x\n",
@@ -867,7 +868,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 		kc.name = mc->hdr.name;
 		kc.private_value = (long)sm;
 		kc.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		kc.access = mc->hdr.access;
+		kc.access = le32_to_cpu(mc->hdr.access);
 
 		/* we only support FL/FR channel mapping atm */
 		sm->reg = tplc_chan_get_reg(tplg, mc->channel,
@@ -879,10 +880,10 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 		sm->rshift = tplc_chan_get_shift(tplg, mc->channel,
 			SNDRV_CHMAP_FR);
 
-		sm->max = mc->max;
-		sm->min = mc->min;
-		sm->invert = mc->invert;
-		sm->platform_max = mc->platform_max;
+		sm->max = le32_to_cpu(mc->max);
+		sm->min = le32_to_cpu(mc->min);
+		sm->invert = le32_to_cpu(mc->invert);
+		sm->platform_max = le32_to_cpu(mc->platform_max);
 		sm->dobj.index = tplg->index;
 		sm->dobj.ops = tplg->ops;
 		sm->dobj.type = SND_SOC_DOBJ_MIXER;
@@ -933,7 +934,7 @@ static int soc_tplg_denum_create_texts(struct soc_enum *se,
 	int i, ret;
 
 	se->dobj.control.dtexts =
-		kcalloc(ec->items, sizeof(char *), GFP_KERNEL);
+		kcalloc(le32_to_cpu(ec->items), sizeof(char *), GFP_KERNEL);
 	if (se->dobj.control.dtexts == NULL)
 		return -ENOMEM;
 
@@ -965,15 +966,22 @@ static int soc_tplg_denum_create_texts(struct soc_enum *se,
 static int soc_tplg_denum_create_values(struct soc_enum *se,
 	struct snd_soc_tplg_enum_control *ec)
 {
-	if (ec->items > sizeof(*ec->values))
+	int i;
+
+	if (le32_to_cpu(ec->items) > sizeof(*ec->values))
 		return -EINVAL;
 
-	se->dobj.control.dvalues = kmemdup(ec->values,
-					   ec->items * sizeof(u32),
+	se->dobj.control.dvalues = kzalloc(le32_to_cpu(ec->items) *
+					   sizeof(u32),
 					   GFP_KERNEL);
 	if (!se->dobj.control.dvalues)
 		return -ENOMEM;
 
+	/* convert from little-endian */
+	for (i = 0; i < le32_to_cpu(ec->items); i++) {
+		se->dobj.control.dvalues[i] = le32_to_cpu(ec->values[i]);
+	}
+
 	return 0;
 }
 
@@ -1007,7 +1015,7 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 			return -ENOMEM;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
-			ec->priv.size);
+			      le32_to_cpu(ec->priv.size));
 
 		dev_dbg(tplg->dev, "ASoC: adding enum kcontrol %s size %d\n",
 			ec->hdr.name, ec->items);
@@ -1016,7 +1024,7 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 		kc.name = ec->hdr.name;
 		kc.private_value = (long)se;
 		kc.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-		kc.access = ec->hdr.access;
+		kc.access = le32_to_cpu(ec->hdr.access);
 
 		se->reg = tplc_chan_get_reg(tplg, ec->channel, SNDRV_CHMAP_FL);
 		se->shift_l = tplc_chan_get_shift(tplg, ec->channel,
@@ -1024,14 +1032,14 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 		se->shift_r = tplc_chan_get_shift(tplg, ec->channel,
 			SNDRV_CHMAP_FL);
 
-		se->items = ec->items;
-		se->mask = ec->mask;
+		se->items = le32_to_cpu(ec->items);
+		se->mask = le32_to_cpu(ec->mask);
 		se->dobj.index = tplg->index;
 		se->dobj.type = SND_SOC_DOBJ_ENUM;
 		se->dobj.ops = tplg->ops;
 		INIT_LIST_HEAD(&se->dobj.list);
 
-		switch (ec->hdr.ops.info) {
+		switch (le32_to_cpu(ec->hdr.ops.info)) {
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
 		case SND_SOC_TPLG_CTL_ENUM_VALUE:
 			err = soc_tplg_denum_create_values(se, ec);
@@ -1104,23 +1112,24 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 	int i;
 
 	if (tplg->pass != SOC_TPLG_PASS_MIXER) {
-		tplg->pos += hdr->size + hdr->payload_size;
+		tplg->pos += le32_to_cpu(hdr->size) +
+			le32_to_cpu(hdr->payload_size);
 		return 0;
 	}
 
 	dev_dbg(tplg->dev, "ASoC: adding %d kcontrols at 0x%lx\n", hdr->count,
 		soc_tplg_get_offset(tplg));
 
-	for (i = 0; i < hdr->count; i++) {
+	for (i = 0; i < le32_to_cpu(hdr->count); i++) {
 
 		control_hdr = (struct snd_soc_tplg_ctl_hdr *)tplg->pos;
 
-		if (control_hdr->size != sizeof(*control_hdr)) {
+		if (le32_to_cpu(control_hdr->size) != sizeof(*control_hdr)) {
 			dev_err(tplg->dev, "ASoC: invalid control size\n");
 			return -EINVAL;
 		}
 
-		switch (control_hdr->ops.info) {
+		switch (le32_to_cpu(control_hdr->ops.info)) {
 		case SND_SOC_TPLG_CTL_VOLSW:
 		case SND_SOC_TPLG_CTL_STROBE:
 		case SND_SOC_TPLG_CTL_VOLSW_SX:
@@ -1128,17 +1137,20 @@ static int soc_tplg_kcontrol_elems_load(struct soc_tplg *tplg,
 		case SND_SOC_TPLG_CTL_RANGE:
 		case SND_SOC_TPLG_DAPM_CTL_VOLSW:
 		case SND_SOC_TPLG_DAPM_CTL_PIN:
-			soc_tplg_dmixer_create(tplg, 1, hdr->payload_size);
+			soc_tplg_dmixer_create(tplg, 1,
+					       le32_to_cpu(hdr->payload_size));
 			break;
 		case SND_SOC_TPLG_CTL_ENUM:
 		case SND_SOC_TPLG_CTL_ENUM_VALUE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
-			soc_tplg_denum_create(tplg, 1, hdr->payload_size);
+			soc_tplg_denum_create(tplg, 1,
+					      le32_to_cpu(hdr->payload_size));
 			break;
 		case SND_SOC_TPLG_CTL_BYTES:
-			soc_tplg_dbytes_create(tplg, 1, hdr->payload_size);
+			soc_tplg_dbytes_create(tplg, 1,
+					       le32_to_cpu(hdr->payload_size));
 			break;
 		default:
 			soc_bind_err(tplg, control_hdr, i);
@@ -1166,17 +1178,22 @@ static int soc_tplg_dapm_graph_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_dapm_context *dapm = &tplg->comp->dapm;
 	struct snd_soc_tplg_dapm_graph_elem *elem;
 	struct snd_soc_dapm_route **routes;
-	int count = hdr->count, i, j;
+	int count, i, j;
 	int ret = 0;
 
+	count = le32_to_cpu(hdr->count);
+
 	if (tplg->pass != SOC_TPLG_PASS_GRAPH) {
-		tplg->pos += hdr->size + hdr->payload_size;
+		tplg->pos +=
+			le32_to_cpu(hdr->size) +
+			le32_to_cpu(hdr->payload_size);
+
 		return 0;
 	}
 
 	if (soc_tplg_check_elem_count(tplg,
 		sizeof(struct snd_soc_tplg_dapm_graph_elem),
-		count, hdr->payload_size, "graph")) {
+		count, le32_to_cpu(hdr->payload_size), "graph")) {
 
 		dev_err(tplg->dev, "ASoC: invalid count %d for DAPM routes\n",
 			count);
@@ -1291,7 +1308,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 			goto err_str;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_mixer_control) +
-			mc->priv.size);
+			      le32_to_cpu(mc->priv.size));
 
 		dev_dbg(tplg->dev, " adding DAPM widget mixer control %s at %d\n",
 			mc->hdr.name, i);
@@ -1404,7 +1421,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 		se->mask = ec->mask;
 		se->dobj.index = tplg->index;
 
-		switch (ec->hdr.ops.info) {
+		switch (le32_to_cpu(ec->hdr.ops.info)) {
 		case SND_SOC_TPLG_CTL_ENUM_VALUE:
 		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
 			err = soc_tplg_denum_create_values(se, ec);
@@ -1495,7 +1512,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 			goto err;
 
 		tplg->pos += (sizeof(struct snd_soc_tplg_bytes_control) +
-			be->priv.size);
+			      le32_to_cpu(be->priv.size));
 
 		dev_dbg(tplg->dev,
 			"ASoC: adding bytes kcontrol %s with access 0x%x\n",
@@ -1567,7 +1584,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	memset(&template, 0, sizeof(template));
 
 	/* map user to kernel widget ID */
-	template.id = get_widget_id(w->id);
+	template.id = get_widget_id(le32_to_cpu(w->id));
 	if (template.id < 0)
 		return template.id;
 
@@ -1580,18 +1597,20 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 		ret = -ENOMEM;
 		goto err;
 	}
-	template.reg = w->reg;
-	template.shift = w->shift;
-	template.mask = w->mask;
-	template.subseq = w->subseq;
+	template.reg = le32_to_cpu(w->reg);
+	template.shift = le32_to_cpu(w->shift);
+	template.mask = le32_to_cpu(w->mask);
+	template.subseq = le32_to_cpu(w->subseq);
 	template.on_val = w->invert ? 0 : 1;
 	template.off_val = w->invert ? 1 : 0;
-	template.ignore_suspend = w->ignore_suspend;
-	template.event_flags = w->event_flags;
+	template.ignore_suspend = le32_to_cpu(w->ignore_suspend);
+	template.event_flags = le16_to_cpu(w->event_flags);
 	template.dobj.index = tplg->index;
 
 	tplg->pos +=
-		(sizeof(struct snd_soc_tplg_dapm_widget) + w->priv.size);
+		(sizeof(struct snd_soc_tplg_dapm_widget) +
+		 le32_to_cpu(w->priv.size));
+
 	if (w->num_kcontrols == 0) {
 		kcontrol_type = 0;
 		template.num_kcontrols = 0;
@@ -1602,7 +1621,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	dev_dbg(tplg->dev, "ASoC: template %s has %d controls of type %x\n",
 		w->name, w->num_kcontrols, control_hdr->type);
 
-	switch (control_hdr->ops.info) {
+	switch (le32_to_cpu(control_hdr->ops.info)) {
 	case SND_SOC_TPLG_CTL_VOLSW:
 	case SND_SOC_TPLG_CTL_STROBE:
 	case SND_SOC_TPLG_CTL_VOLSW_SX:
@@ -1610,7 +1629,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_CTL_RANGE:
 	case SND_SOC_TPLG_DAPM_CTL_VOLSW:
 		kcontrol_type = SND_SOC_TPLG_TYPE_MIXER;  /* volume mixer */
-		template.num_kcontrols = w->num_kcontrols;
+		template.num_kcontrols = le32_to_cpu(w->num_kcontrols);
 		template.kcontrol_news =
 			soc_tplg_dapm_widget_dmixer_create(tplg,
 			template.num_kcontrols);
@@ -1625,7 +1644,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
 		kcontrol_type = SND_SOC_TPLG_TYPE_ENUM;	/* enumerated mixer */
-		template.num_kcontrols = w->num_kcontrols;
+		template.num_kcontrols = le32_to_cpu(w->num_kcontrols);
 		template.kcontrol_news =
 			soc_tplg_dapm_widget_denum_create(tplg,
 			template.num_kcontrols);
@@ -1636,7 +1655,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 		break;
 	case SND_SOC_TPLG_CTL_BYTES:
 		kcontrol_type = SND_SOC_TPLG_TYPE_BYTES; /* bytes control */
-		template.num_kcontrols = w->num_kcontrols;
+		template.num_kcontrols = le32_to_cpu(w->num_kcontrols);
 		template.kcontrol_news =
 			soc_tplg_dapm_widget_dbytes_create(tplg,
 				template.num_kcontrols);
@@ -1648,7 +1667,7 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	default:
 		dev_err(tplg->dev, "ASoC: invalid widget control type %d:%d:%d\n",
 			control_hdr->ops.get, control_hdr->ops.put,
-			control_hdr->ops.info);
+			le32_to_cpu(control_hdr->ops.info));
 		ret = -EINVAL;
 		goto hdr_err;
 	}
@@ -1698,7 +1717,9 @@ static int soc_tplg_dapm_widget_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_dapm_widget *widget;
-	int ret, count = hdr->count, i;
+	int ret, count, i;
+
+	count = le32_to_cpu(hdr->count);
 
 	if (tplg->pass != SOC_TPLG_PASS_WIDGET)
 		return 0;
@@ -1707,7 +1728,7 @@ static int soc_tplg_dapm_widget_elems_load(struct soc_tplg *tplg,
 
 	for (i = 0; i < count; i++) {
 		widget = (struct snd_soc_tplg_dapm_widget *) tplg->pos;
-		if (widget->size != sizeof(*widget)) {
+		if (le32_to_cpu(widget->size) != sizeof(*widget)) {
 			dev_err(tplg->dev, "ASoC: invalid widget size\n");
 			return -EINVAL;
 		}
@@ -1749,13 +1770,13 @@ static void set_stream_info(struct snd_soc_pcm_stream *stream,
 	struct snd_soc_tplg_stream_caps *caps)
 {
 	stream->stream_name = kstrdup(caps->name, GFP_KERNEL);
-	stream->channels_min = caps->channels_min;
-	stream->channels_max = caps->channels_max;
-	stream->rates = caps->rates;
-	stream->rate_min = caps->rate_min;
-	stream->rate_max = caps->rate_max;
-	stream->formats = caps->formats;
-	stream->sig_bits = caps->sig_bits;
+	stream->channels_min = le32_to_cpu(caps->channels_min);
+	stream->channels_max = le32_to_cpu(caps->channels_max);
+	stream->rates = le32_to_cpu(caps->rates);
+	stream->rate_min = le32_to_cpu(caps->rate_min);
+	stream->rate_max = le32_to_cpu(caps->rate_max);
+	stream->formats = le64_to_cpu(caps->formats);
+	stream->sig_bits = le32_to_cpu(caps->sig_bits);
 }
 
 static void set_dai_flags(struct snd_soc_dai_driver *dai_drv,
@@ -1790,7 +1811,7 @@ static int soc_tplg_dai_create(struct soc_tplg *tplg,
 
 	if (strlen(pcm->dai_name))
 		dai_drv->name = kstrdup(pcm->dai_name, GFP_KERNEL);
-	dai_drv->id = pcm->dai_id;
+	dai_drv->id = le32_to_cpu(pcm->dai_id);
 
 	if (pcm->playback) {
 		stream = &dai_drv->playback;
@@ -1865,7 +1886,7 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 		link->name = kstrdup(pcm->pcm_name, GFP_KERNEL);
 		link->stream_name = kstrdup(pcm->pcm_name, GFP_KERNEL);
 	}
-	link->id = pcm->pcm_id;
+	link->id = le32_to_cpu(pcm->pcm_id);
 
 	if (strlen(pcm->dai_name))
 		link->cpu_dai_name = kstrdup(pcm->dai_name, GFP_KERNEL);
@@ -1875,10 +1896,12 @@ static int soc_tplg_fe_link_create(struct soc_tplg *tplg,
 
 	/* enable DPCM */
 	link->dynamic = 1;
-	link->dpcm_playback = pcm->playback;
-	link->dpcm_capture = pcm->capture;
+	link->dpcm_playback = le32_to_cpu(pcm->playback);
+	link->dpcm_capture = le32_to_cpu(pcm->capture);
 	if (pcm->flag_mask)
-		set_link_flags(link, pcm->flag_mask, pcm->flags);
+		set_link_flags(link,
+			       le32_to_cpu(pcm->flag_mask),
+			       le32_to_cpu(pcm->flags));
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link, NULL);
@@ -1917,7 +1940,7 @@ static int soc_tplg_pcm_create(struct soc_tplg *tplg,
 static void stream_caps_new_ver(struct snd_soc_tplg_stream_caps *dest,
 				struct snd_soc_tplg_stream_caps_v4 *src)
 {
-	dest->size = sizeof(*dest);
+	dest->size = cpu_to_le32(sizeof(*dest));
 	memcpy(dest->name, src->name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	dest->formats = src->formats;
 	dest->rates = src->rates;
@@ -1951,7 +1974,7 @@ static int pcm_new_ver(struct soc_tplg *tplg,
 
 	*pcm = NULL;
 
-	if (src->size != sizeof(*src_v4)) {
+	if (le32_to_cpu(src->size) != sizeof(*src_v4)) {
 		dev_err(tplg->dev, "ASoC: invalid PCM size\n");
 		return -EINVAL;
 	}
@@ -1962,7 +1985,7 @@ static int pcm_new_ver(struct soc_tplg *tplg,
 	if (!dest)
 		return -ENOMEM;
 
-	dest->size = sizeof(*dest);	/* size of latest abi version */
+	dest->size = cpu_to_le32(sizeof(*dest)); /* size of latest abi version */
 	memcpy(dest->pcm_name, src_v4->pcm_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	memcpy(dest->dai_name, src_v4->dai_name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
 	dest->pcm_id = src_v4->pcm_id;
@@ -1971,7 +1994,7 @@ static int pcm_new_ver(struct soc_tplg *tplg,
 	dest->capture = src_v4->capture;
 	dest->compress = src_v4->compress;
 	dest->num_streams = src_v4->num_streams;
-	for (i = 0; i < dest->num_streams; i++)
+	for (i = 0; i < le32_to_cpu(dest->num_streams); i++)
 		memcpy(&dest->stream[i], &src_v4->stream[i],
 		       sizeof(struct snd_soc_tplg_stream));
 
@@ -1986,25 +2009,30 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_pcm *pcm, *_pcm;
-	int count = hdr->count;
+	int count;
+	int size;
 	int i;
 	bool abi_match;
 
+	count = le32_to_cpu(hdr->count);
+
 	if (tplg->pass != SOC_TPLG_PASS_PCM_DAI)
 		return 0;
 
 	/* check the element size and count */
 	pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
-	if (pcm->size > sizeof(struct snd_soc_tplg_pcm)
-		|| pcm->size < sizeof(struct snd_soc_tplg_pcm_v4)) {
+	size = le32_to_cpu(pcm->size);
+	if (size > sizeof(struct snd_soc_tplg_pcm)
+		|| size < sizeof(struct snd_soc_tplg_pcm_v4)) {
 		dev_err(tplg->dev, "ASoC: invalid size %d for PCM elems\n",
-			pcm->size);
+			size);
 		return -EINVAL;
 	}
 
 	if (soc_tplg_check_elem_count(tplg,
-		pcm->size, count,
-		hdr->payload_size, "PCM DAI")) {
+				      size, count,
+				      le32_to_cpu(hdr->payload_size),
+				      "PCM DAI")) {
 		dev_err(tplg->dev, "ASoC: invalid count %d for PCM DAI elems\n",
 			count);
 		return -EINVAL;
@@ -2012,11 +2040,12 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 
 	for (i = 0; i < count; i++) {
 		pcm = (struct snd_soc_tplg_pcm *)tplg->pos;
+		size = le32_to_cpu(pcm->size);
 
 		/* check ABI version by size, create a new version of pcm
 		 * if abi not match.
 		 */
-		if (pcm->size == sizeof(*pcm)) {
+		if (size == sizeof(*pcm)) {
 			abi_match = true;
 			_pcm = pcm;
 		} else {
@@ -2030,7 +2059,7 @@ static int soc_tplg_pcm_elems_load(struct soc_tplg *tplg,
 		/* offset by version-specific struct size and
 		 * real priv data size
 		 */
-		tplg->pos += pcm->size + _pcm->priv.size;
+		tplg->pos += size + le32_to_cpu(_pcm->priv.size);
 
 		if (!abi_match)
 			kfree(_pcm); /* free the duplicated one */
@@ -2058,12 +2087,13 @@ static void set_link_hw_format(struct snd_soc_dai_link *link,
 	unsigned char invert_bclk, invert_fsync;
 	int i;
 
-	for (i = 0; i < cfg->num_hw_configs; i++) {
+	for (i = 0; i < le32_to_cpu(cfg->num_hw_configs); i++) {
 		hw_config = &cfg->hw_config[i];
 		if (hw_config->id != cfg->default_hw_config_id)
 			continue;
 
-		link->dai_fmt = hw_config->fmt & SND_SOC_DAIFMT_FORMAT_MASK;
+		link->dai_fmt = le32_to_cpu(hw_config->fmt) &
+			SND_SOC_DAIFMT_FORMAT_MASK;
 
 		/* clock gating */
 		switch (hw_config->clock_gated) {
@@ -2127,7 +2157,8 @@ static int link_new_ver(struct soc_tplg *tplg,
 
 	*link = NULL;
 
-	if (src->size != sizeof(struct snd_soc_tplg_link_config_v4)) {
+	if (le32_to_cpu(src->size) !=
+	    sizeof(struct snd_soc_tplg_link_config_v4)) {
 		dev_err(tplg->dev, "ASoC: invalid physical link config size\n");
 		return -EINVAL;
 	}
@@ -2139,10 +2170,10 @@ static int link_new_ver(struct soc_tplg *tplg,
 	if (!dest)
 		return -ENOMEM;
 
-	dest->size = sizeof(*dest);
+	dest->size = cpu_to_le32(sizeof(*dest));
 	dest->id = src_v4->id;
 	dest->num_streams = src_v4->num_streams;
-	for (i = 0; i < dest->num_streams; i++)
+	for (i = 0; i < le32_to_cpu(dest->num_streams); i++)
 		memcpy(&dest->stream[i], &src_v4->stream[i],
 		       sizeof(struct snd_soc_tplg_stream));
 
@@ -2175,7 +2206,7 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 	else
 		stream_name = NULL;
 
-	link = snd_soc_find_dai_link(tplg->comp->card, cfg->id,
+	link = snd_soc_find_dai_link(tplg->comp->card, le32_to_cpu(cfg->id),
 				     name, stream_name);
 	if (!link) {
 		dev_err(tplg->dev, "ASoC: physical link %s (id %d) not exist\n",
@@ -2189,7 +2220,9 @@ static int soc_tplg_link_config(struct soc_tplg *tplg,
 
 	/* flags */
 	if (cfg->flag_mask)
-		set_link_flags(link, cfg->flag_mask, cfg->flags);
+		set_link_flags(link,
+			       le32_to_cpu(cfg->flag_mask),
+			       le32_to_cpu(cfg->flags));
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_link_load(tplg, link, cfg);
@@ -2213,27 +2246,33 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 	struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_link_config *link, *_link;
-	int count = hdr->count;
+	int count;
+	int size;
 	int i, ret;
 	bool abi_match;
 
+	count = le32_to_cpu(hdr->count);
+
 	if (tplg->pass != SOC_TPLG_PASS_LINK) {
-		tplg->pos += hdr->size + hdr->payload_size;
+		tplg->pos += le32_to_cpu(hdr->size) +
+			le32_to_cpu(hdr->payload_size);
 		return 0;
 	};
 
 	/* check the element size and count */
 	link = (struct snd_soc_tplg_link_config *)tplg->pos;
-	if (link->size > sizeof(struct snd_soc_tplg_link_config)
-		|| link->size < sizeof(struct snd_soc_tplg_link_config_v4)) {
+	size = le32_to_cpu(link->size);
+	if (size > sizeof(struct snd_soc_tplg_link_config)
+		|| size < sizeof(struct snd_soc_tplg_link_config_v4)) {
 		dev_err(tplg->dev, "ASoC: invalid size %d for physical link elems\n",
-			link->size);
+			size);
 		return -EINVAL;
 	}
 
 	if (soc_tplg_check_elem_count(tplg,
-		link->size, count,
-		hdr->payload_size, "physical link config")) {
+				      size, count,
+				      le32_to_cpu(hdr->payload_size),
+				      "physical link config")) {
 		dev_err(tplg->dev, "ASoC: invalid count %d for physical link elems\n",
 			count);
 		return -EINVAL;
@@ -2242,7 +2281,8 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 	/* config physical DAI links */
 	for (i = 0; i < count; i++) {
 		link = (struct snd_soc_tplg_link_config *)tplg->pos;
-		if (link->size == sizeof(*link)) {
+		size = le32_to_cpu(link->size);
+		if (size == sizeof(*link)) {
 			abi_match = true;
 			_link = link;
 		} else {
@@ -2259,7 +2299,7 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 		/* offset by version-specific struct size and
 		 * real priv data size
 		 */
-		tplg->pos += link->size + _link->priv.size;
+		tplg->pos += size + le32_to_cpu(_link->priv.size);
 
 		if (!abi_match)
 			kfree(_link); /* free the duplicated one */
@@ -2279,13 +2319,15 @@ static int soc_tplg_link_elems_load(struct soc_tplg *tplg,
 static int soc_tplg_dai_config(struct soc_tplg *tplg,
 			       struct snd_soc_tplg_dai *d)
 {
-	struct snd_soc_dai_link_component dai_component = {0};
+	struct snd_soc_dai_link_component dai_component;
 	struct snd_soc_dai *dai;
 	struct snd_soc_dai_driver *dai_drv;
 	struct snd_soc_pcm_stream *stream;
 	struct snd_soc_tplg_stream_caps *caps;
 	int ret;
 
+	memset(&dai_component, 0, sizeof(dai_component));
+
 	dai_component.dai_name = d->dai_name;
 	dai = snd_soc_find_dai(&dai_component);
 	if (!dai) {
@@ -2294,7 +2336,7 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	if (d->dai_id != dai->id) {
+	if (le32_to_cpu(d->dai_id) != dai->id) {
 		dev_err(tplg->dev, "ASoC: physical DAI %s id mismatch\n",
 			d->dai_name);
 		return -EINVAL;
@@ -2317,7 +2359,9 @@ static int soc_tplg_dai_config(struct soc_tplg *tplg,
 	}
 
 	if (d->flag_mask)
-		set_dai_flags(dai_drv, d->flag_mask, d->flags);
+		set_dai_flags(dai_drv,
+			      le32_to_cpu(d->flag_mask),
+			      le32_to_cpu(d->flags));
 
 	/* pass control to component driver for optional further init */
 	ret = soc_tplg_dai_load(tplg, dai_drv, NULL, dai);
@@ -2334,22 +2378,24 @@ static int soc_tplg_dai_elems_load(struct soc_tplg *tplg,
 				   struct snd_soc_tplg_hdr *hdr)
 {
 	struct snd_soc_tplg_dai *dai;
-	int count = hdr->count;
+	int count;
 	int i;
 
+	count = le32_to_cpu(hdr->count);
+
 	if (tplg->pass != SOC_TPLG_PASS_BE_DAI)
 		return 0;
 
 	/* config the existing BE DAIs */
 	for (i = 0; i < count; i++) {
 		dai = (struct snd_soc_tplg_dai *)tplg->pos;
-		if (dai->size != sizeof(*dai)) {
+		if (le32_to_cpu(dai->size) != sizeof(*dai)) {
 			dev_err(tplg->dev, "ASoC: invalid physical DAI size\n");
 			return -EINVAL;
 		}
 
 		soc_tplg_dai_config(tplg, dai);
-		tplg->pos += (sizeof(*dai) + dai->priv.size);
+		tplg->pos += (sizeof(*dai) + le32_to_cpu(dai->priv.size));
 	}
 
 	dev_dbg(tplg->dev, "ASoC: Configure %d BE DAIs\n", count);
@@ -2371,25 +2417,28 @@ static int manifest_new_ver(struct soc_tplg *tplg,
 {
 	struct snd_soc_tplg_manifest *dest;
 	struct snd_soc_tplg_manifest_v4 *src_v4;
+	int size;
 
 	*manifest = NULL;
 
-	if (src->size != sizeof(*src_v4)) {
+	size = le32_to_cpu(src->size);
+	if (size != sizeof(*src_v4)) {
 		dev_warn(tplg->dev, "ASoC: invalid manifest size %d\n",
-			 src->size);
-		if (src->size)
+			 size);
+		if (size)
 			return -EINVAL;
-		src->size = sizeof(*src_v4);
+		src->size = cpu_to_le32(sizeof(*src_v4));
 	}
 
 	dev_warn(tplg->dev, "ASoC: old version of manifest\n");
 
 	src_v4 = (struct snd_soc_tplg_manifest_v4 *)src;
-	dest = kzalloc(sizeof(*dest) + src_v4->priv.size, GFP_KERNEL);
+	dest = kzalloc(sizeof(*dest) + le32_to_cpu(src_v4->priv.size),
+		       GFP_KERNEL);
 	if (!dest)
 		return -ENOMEM;
 
-	dest->size = sizeof(*dest);	/* size of latest abi version */
+	dest->size = cpu_to_le32(sizeof(*dest)); /* size of latest abi version */
 	dest->control_elems = src_v4->control_elems;
 	dest->widget_elems = src_v4->widget_elems;
 	dest->graph_elems = src_v4->graph_elems;
@@ -2398,7 +2447,7 @@ static int manifest_new_ver(struct soc_tplg *tplg,
 	dest->priv.size = src_v4->priv.size;
 	if (dest->priv.size)
 		memcpy(dest->priv.data, src_v4->priv.data,
-		       src_v4->priv.size);
+		       le32_to_cpu(src_v4->priv.size));
 
 	*manifest = dest;
 	return 0;
@@ -2417,7 +2466,7 @@ static int soc_tplg_manifest_load(struct soc_tplg *tplg,
 	manifest = (struct snd_soc_tplg_manifest *)tplg->pos;
 
 	/* check ABI version by size, create a new manifest if abi not match */
-	if (manifest->size == sizeof(*manifest)) {
+	if (le32_to_cpu(manifest->size) == sizeof(*manifest)) {
 		abi_match = true;
 		_manifest = manifest;
 	} else {
@@ -2444,10 +2493,10 @@ static int soc_valid_header(struct soc_tplg *tplg,
 	if (soc_tplg_get_hdr_offset(tplg) >= tplg->fw->size)
 		return 0;
 
-	if (hdr->size != sizeof(*hdr)) {
+	if (le32_to_cpu(hdr->size) != sizeof(*hdr)) {
 		dev_err(tplg->dev,
 			"ASoC: invalid header size for type %d at offset 0x%lx size 0x%zx.\n",
-			hdr->type, soc_tplg_get_hdr_offset(tplg),
+			le32_to_cpu(hdr->type), soc_tplg_get_hdr_offset(tplg),
 			tplg->fw->size);
 		return -EINVAL;
 	}
@@ -2461,7 +2510,7 @@ static int soc_valid_header(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	if (hdr->magic != SND_SOC_TPLG_MAGIC) {
+	if (le32_to_cpu(hdr->magic) != SND_SOC_TPLG_MAGIC) {
 		dev_err(tplg->dev,
 			"ASoC: pass %d does not have a valid header got %x at offset 0x%lx size 0x%zx.\n",
 			tplg->pass, hdr->magic,
@@ -2470,8 +2519,8 @@ static int soc_valid_header(struct soc_tplg *tplg,
 	}
 
 	/* Support ABI from version 4 */
-	if (hdr->abi > SND_SOC_TPLG_ABI_VERSION
-		|| hdr->abi < SND_SOC_TPLG_ABI_VERSION_MIN) {
+	if (le32_to_cpu(hdr->abi) > SND_SOC_TPLG_ABI_VERSION ||
+	    le32_to_cpu(hdr->abi) < SND_SOC_TPLG_ABI_VERSION_MIN) {
 		dev_err(tplg->dev,
 			"ASoC: pass %d invalid ABI version got 0x%x need 0x%x at offset 0x%lx size 0x%zx.\n",
 			tplg->pass, hdr->abi,
@@ -2486,7 +2535,7 @@ static int soc_valid_header(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	if (tplg->pass == hdr->type)
+	if (tplg->pass == le32_to_cpu(hdr->type))
 		dev_dbg(tplg->dev,
 			"ASoC: Got 0x%x bytes of type %d version %d vendor %d at pass %d\n",
 			hdr->payload_size, hdr->type, hdr->version,
@@ -2502,13 +2551,13 @@ static int soc_tplg_load_header(struct soc_tplg *tplg,
 	tplg->pos = tplg->hdr_pos + sizeof(struct snd_soc_tplg_hdr);
 
 	/* check for matching ID */
-	if (hdr->index != tplg->req_index &&
+	if (le32_to_cpu(hdr->index) != tplg->req_index &&
 		tplg->req_index != SND_SOC_TPLG_INDEX_ALL)
 		return 0;
 
-	tplg->index = hdr->index;
+	tplg->index = le32_to_cpu(hdr->index);
 
-	switch (hdr->type) {
+	switch (le32_to_cpu(hdr->type)) {
 	case SND_SOC_TPLG_TYPE_MIXER:
 	case SND_SOC_TPLG_TYPE_ENUM:
 	case SND_SOC_TPLG_TYPE_BYTES:
@@ -2564,7 +2613,7 @@ static int soc_tplg_process_headers(struct soc_tplg *tplg)
 				return ret;
 
 			/* goto next header */
-			tplg->hdr_pos += hdr->payload_size +
+			tplg->hdr_pos += le32_to_cpu(hdr->payload_size) +
 				sizeof(struct snd_soc_tplg_hdr);
 			hdr = (struct snd_soc_tplg_hdr *)tplg->hdr_pos;
 		}
-- 
2.17.1
