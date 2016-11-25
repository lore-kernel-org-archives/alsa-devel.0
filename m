From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/2] ASoC: topology: Allow a widget to have
	multiple enum controls
Date: Fri, 25 Nov 2016 16:09:10 +0800
Message-ID: <1480061350-7861-1-git-send-email-mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id A38D5266806
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 09:07:11 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

This patch can create multiple enumerated mixer controls for a widget.

Previously topology kernel driver assumes a widget can have only one
emumerated mixer control. We need to remove this restriction for Broxton.
Its firmware modules (widgets) may need multiple enum controls based on
the channel and MIC combination.

No ABI change is needed. The ABI allows a widget to embed multiple
controls.

Reported-by: G Kranthi <gudishax.kranthikumar@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 4dfdc65..63e1a50 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -486,21 +486,24 @@ static void remove_widget(struct snd_soc_component *comp,
 		dobj->ops->widget_unload(comp, dobj);
 
 	/*
-	 * Dynamic Widgets either have 1 enum kcontrol or 1..N mixers.
+	 * Dynamic Widgets either have 1..N enum kcontrols or mixers.
 	 * The enum may either have an array of values or strings.
 	 */
 	if (dobj->widget.kcontrol_enum) {
 		/* enumerated widget mixer */
-		struct soc_enum *se =
-			(struct soc_enum *)w->kcontrols[0]->private_value;
+		for (i = 0; i < w->num_kcontrols; i++) {
+			struct snd_kcontrol *kcontrol = w->kcontrols[i];
+			struct soc_enum *se =
+				(struct soc_enum *)kcontrol->private_value;
 
-		snd_ctl_remove(card, w->kcontrols[0]);
+			snd_ctl_remove(card, kcontrol);
 
-		kfree(se->dobj.control.dvalues);
-		for (i = 0; i < se->items; i++)
-			kfree(se->dobj.control.dtexts[i]);
+			kfree(se->dobj.control.dvalues);
+			for (i = 0; i < se->items; i++)
+				kfree(se->dobj.control.dtexts[i]);
 
-		kfree(se);
+			kfree(se);
+		}
 		kfree(w->kcontrol_news);
 	} else {
 		/* non enumerated widget mixer */
@@ -1256,98 +1259,105 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 }
 
 static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
-	struct soc_tplg *tplg)
+	struct soc_tplg *tplg, int num_kcontrols)
 {
 	struct snd_kcontrol_new *kc;
 	struct snd_soc_tplg_enum_control *ec;
 	struct soc_enum *se;
-	int i, err;
-
-	ec = (struct snd_soc_tplg_enum_control *)tplg->pos;
-	tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
-		ec->priv.size);
-
-	/* validate kcontrol */
-	if (strnlen(ec->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
-		SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
-		return NULL;
+	int i, j, err;
 
-	kc = kzalloc(sizeof(*kc), GFP_KERNEL);
+	kc = kcalloc(num_kcontrols, sizeof(*kc), GFP_KERNEL);
 	if (kc == NULL)
 		return NULL;
 
-	se = kzalloc(sizeof(*se), GFP_KERNEL);
-	if (se == NULL)
-		goto err;
+	for (i = 0; i < num_kcontrols; i++) {
+		ec = (struct snd_soc_tplg_enum_control *)tplg->pos;
+		/* validate kcontrol */
+		if (strnlen(ec->hdr.name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN) ==
+			    SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+			return NULL;
+
+		se = kzalloc(sizeof(*se), GFP_KERNEL);
+		if (se == NULL)
+			goto err;
 
-	dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
-		ec->hdr.name);
+		dev_dbg(tplg->dev, " adding DAPM widget enum control %s\n",
+			ec->hdr.name);
 
-	kc->name = ec->hdr.name;
-	kc->private_value = (long)se;
-	kc->iface = SNDRV_CTL_ELEM_IFACE_MIXER;
-	kc->access = ec->hdr.access;
+		kc[i].name = ec->hdr.name;
+		kc[i].private_value = (long)se;
+		kc[i].iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+		kc[i].access = ec->hdr.access;
 
-	/* we only support FL/FR channel mapping atm */
-	se->reg = tplc_chan_get_reg(tplg, ec->channel, SNDRV_CHMAP_FL);
-	se->shift_l = tplc_chan_get_shift(tplg, ec->channel, SNDRV_CHMAP_FL);
-	se->shift_r = tplc_chan_get_shift(tplg, ec->channel, SNDRV_CHMAP_FR);
+		/* we only support FL/FR channel mapping atm */
+		se->reg = tplc_chan_get_reg(tplg, ec->channel, SNDRV_CHMAP_FL);
+		se->shift_l = tplc_chan_get_shift(tplg, ec->channel,
+						  SNDRV_CHMAP_FL);
+		se->shift_r = tplc_chan_get_shift(tplg, ec->channel,
+						  SNDRV_CHMAP_FR);
 
-	se->items = ec->items;
-	se->mask = ec->mask;
-	se->dobj.index = tplg->index;
+		se->items = ec->items;
+		se->mask = ec->mask;
+		se->dobj.index = tplg->index;
 
-	switch (ec->hdr.ops.info) {
-	case SND_SOC_TPLG_CTL_ENUM_VALUE:
-	case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
-		err = soc_tplg_denum_create_values(se, ec);
-		if (err < 0) {
-			dev_err(tplg->dev, "ASoC: could not create values for %s\n",
-				ec->hdr.name);
+		switch (ec->hdr.ops.info) {
+		case SND_SOC_TPLG_CTL_ENUM_VALUE:
+		case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
+			err = soc_tplg_denum_create_values(se, ec);
+			if (err < 0) {
+				dev_err(tplg->dev, "ASoC: could not create values for %s\n",
+					ec->hdr.name);
+				goto err_se;
+			}
+			/* fall through to create texts */
+		case SND_SOC_TPLG_CTL_ENUM:
+		case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
+		case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
+			err = soc_tplg_denum_create_texts(se, ec);
+			if (err < 0) {
+				dev_err(tplg->dev, "ASoC: could not create texts for %s\n",
+					ec->hdr.name);
+				goto err_se;
+			}
+			break;
+		default:
+			dev_err(tplg->dev, "ASoC: invalid enum control type %d for %s\n",
+				ec->hdr.ops.info, ec->hdr.name);
 			goto err_se;
 		}
-		/* fall through to create texts */
-	case SND_SOC_TPLG_CTL_ENUM:
-	case SND_SOC_TPLG_DAPM_CTL_ENUM_DOUBLE:
-	case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
-		err = soc_tplg_denum_create_texts(se, ec);
+
+		/* map io handlers */
+		err = soc_tplg_kcontrol_bind_io(&ec->hdr, &kc[i], tplg);
+		if (err) {
+			soc_control_err(tplg, &ec->hdr, ec->hdr.name);
+			goto err_se;
+		}
+
+		/* pass control to driver for optional further init */
+		err = soc_tplg_init_kcontrol(tplg, &kc[i],
+			(struct snd_soc_tplg_ctl_hdr *)ec);
 		if (err < 0) {
-			dev_err(tplg->dev, "ASoC: could not create texts for %s\n",
+			dev_err(tplg->dev, "ASoC: failed to init %s\n",
 				ec->hdr.name);
 			goto err_se;
 		}
-		break;
-	default:
-		dev_err(tplg->dev, "ASoC: invalid enum control type %d for %s\n",
-			ec->hdr.ops.info, ec->hdr.name);
-		goto err_se;
-	}
 
-	/* map io handlers */
-	err = soc_tplg_kcontrol_bind_io(&ec->hdr, kc, tplg);
-	if (err) {
-		soc_control_err(tplg, &ec->hdr, ec->hdr.name);
-		goto err_se;
-	}
-
-	/* pass control to driver for optional further init */
-	err = soc_tplg_init_kcontrol(tplg, kc,
-		(struct snd_soc_tplg_ctl_hdr *)ec);
-	if (err < 0) {
-		dev_err(tplg->dev, "ASoC: failed to init %s\n",
-			ec->hdr.name);
-		goto err_se;
+		tplg->pos += (sizeof(struct snd_soc_tplg_enum_control) +
+				ec->priv.size);
 	}
 
 	return kc;
 
 err_se:
-	/* free values and texts */
-	kfree(se->dobj.control.dvalues);
-	for (i = 0; i < ec->items; i++)
-		kfree(se->dobj.control.dtexts[i]);
+	for (; i >= 0; i--) {
+		/* free values and texts */
+		se = (struct soc_enum *)kc[i].private_value;
+		kfree(se->dobj.control.dvalues);
+		for (j = 0; j < ec->items; j++)
+			kfree(se->dobj.control.dtexts[j]);
 
-	kfree(se);
+		kfree(se);
+	}
 err:
 	kfree(kc);
 
@@ -1499,9 +1509,10 @@ static int soc_tplg_dapm_widget_create(struct soc_tplg *tplg,
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_VIRT:
 	case SND_SOC_TPLG_DAPM_CTL_ENUM_VALUE:
 		template.dobj.widget.kcontrol_enum = 1;
-		template.num_kcontrols = 1;
+		template.num_kcontrols = w->num_kcontrols;
 		template.kcontrol_news =
-			soc_tplg_dapm_widget_denum_create(tplg);
+			soc_tplg_dapm_widget_denum_create(tplg,
+			template.num_kcontrols);
 		if (!template.kcontrol_news) {
 			ret = -ENOMEM;
 			goto hdr_err;
-- 
2.5.0
