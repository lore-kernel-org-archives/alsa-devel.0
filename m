From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH v2 3/3] topology: A API calls to directly
 build	topology data from templates
Date: Tue, 11 Aug 2015 15:37:51 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480BB8AC@SHSMSX101.ccr.corp.intel.com>
References: <1439230429-6173-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1439230429-6173-4-git-send-email-liam.r.girdwood@linux.intel.com>
 <s5htws62r6d.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D3767260542
 for <alsa-devel@alsa-project.org>; Tue, 11 Aug 2015 17:37:58 +0200 (CEST)
In-Reply-To: <s5htws62r6d.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, August 11, 2015 3:58 PM

> On Mon, 10 Aug 2015 20:13:49 +0200,
> Liam Girdwood wrote:
> > +int tplg_add_bytes(snd_tplg_t *tplg, struct snd_tplg_bytes_template
> *bytes_ctl,
> > +	struct tplg_elem **e)
> > +{
> > +	struct snd_soc_tplg_bytes_control *be;
> > +	struct tplg_elem *elem;
> > +	int ret;
> > +
> > +	tplg_dbg(" Control Bytes: %s\n", bytes_ctl->hdr.name);
> > +
> > +	if (bytes_ctl->hdr.type != SND_SOC_TPLG_TYPE_BYTES) {
> > +		SNDERR("error: invalid bytes type %d\n", bytes_ctl->hdr.type);
> > +		return -EINVAL;
> > +	}
> > +
> > +	elem = tplg_elem_new_common(tplg, NULL, bytes_ctl->hdr.name,
> > +		SND_TPLG_TYPE_BYTES);
> > +	if (!elem)
> > +		return -ENOMEM;
> > +
> > +	be = elem->bytes_ext;
> > +	be->size = elem->size;
> > +	ret = init_ctl_hdr(&be->hdr, &bytes_ctl->hdr);
> > +	if (ret < 0) {
> > +		tplg_elem_free(elem);
> > +		return ret;
> > +	}
> > +
> > +	be->max = bytes_ctl->max;
> > +	be->mask = bytes_ctl->mask;
> > +	be->base = bytes_ctl->base;
> > +	be->num_regs = bytes_ctl->num_regs;
> > +	be->ext_ops.put = bytes_ctl->ext_ops.put;
> > +	be->ext_ops.get = bytes_ctl->ext_ops.get;
> > +
> > +	if (bytes_ctl->priv != NULL) {
> > +		be = realloc(be,
> > +			elem->size + bytes_ctl->priv->size);
> > +		if (!be) {
> > +			tplg_elem_free(elem);
> > +			return -ENOMEM;
> > +		}
> > +		elem->bytes_ext = be;
> > +		elem->size += bytes_ctl->priv->size;
> > +
> > +		memcpy(be->priv.data, bytes_ctl->priv->data,
> > +			bytes_ctl->priv->size);
> > +
> > +		be->priv.size = bytes_ctl->priv->size;
> > +	}
> > +
> > +	/* check on TLV bytes control */
> > +	if (be->hdr.access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
> > +		if (be->hdr.access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
> > +			!= SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE) {
> > +			SNDERR("error: Invalid TLV bytes control access 0x%x\n",
> > +				be->hdr.access);
> > +			return -EINVAL;
> 
> Missing tplg_elem_free()?

tplg_elem_free() is not needed here. 
tplg_elem_new_common() has inserted the element into a specific list according to the element type.
And snd_tplg_free() will be called at last even on error, and it will scan all lists and free the elements.

> 
> > +struct tplg_elem* tplg_elem_new_route(snd_tplg_t *tplg) {
> > +	struct tplg_elem *elem;
> > +	struct snd_soc_tplg_dapm_graph_elem *line;
> > +
> > +	elem = tplg_elem_new();
> > +	if (!elem)
> > +		return NULL;
> > +
> > +	list_add_tail(&elem->list, &tplg->route_list);
> > +	strcpy(elem->id, "line");
> > +	elem->type = SND_TPLG_TYPE_DAPM_GRAPH;
> > +	elem->size = sizeof(*line);
> > +
> > +	line = calloc(1, sizeof(*line));
> > +	if (!line)
> > +		return NULL;
> 
> Missing free of elem in the error path.
> Also, tplg->route_list still contains the stray elem.

> I guess this was a bug in the original code, so you can address it before this
> patch.

Same as above. snd_tplg_free() is expected to do the final cleanup.

> > +int tplg_add_widget_object(snd_tplg_t *tplg, snd_tplg_obj_template_t
> > +*t) {
> > +	struct snd_tplg_widget_template *wt = t->widget;
> > +	struct snd_soc_tplg_dapm_widget *w;
> > +	struct tplg_elem *elem;
> > +	int i, ret = 0;
> > +
> > +	tplg_dbg("Widget: %s\n", wt->name);
> > +
> > +	elem = tplg_elem_new_common(tplg, NULL, wt->name,
> > +		SND_TPLG_TYPE_DAPM_WIDGET);
> > +	if (!elem)
> > +		return -ENOMEM;
> > +
> > +	/* init new widget */
> > +	w = elem->widget;
> > +	w->size = elem->size;
> > +
> > +	w->id = wt->id;
> > +	elem_copy_text(w->name, wt->name,
> SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> > +	if (wt->sname)
> > +		elem_copy_text(w->sname, wt->sname,
> > +		SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
> 
> Indentation problem.
> 
> > +	/* add controls to the widget's reference list */
> > +	for (i = 0 ; i < wt->num_ctls; i++) {
> > +		struct snd_tplg_ctl_template *ct = wt->ctl[i];
> > +		struct tplg_elem *elem_ctl;
> > +		struct snd_tplg_mixer_template *mt;
> > +		struct snd_tplg_bytes_template *bt;
> > +		struct snd_tplg_enum_template *et;
> > +
> > +		if (!ct) {
> > +			tplg_elem_free(elem);
> > +			return -EINVAL;
> > +		}
> > +
> > +		switch (ct->type) {
> > +		case SND_SOC_TPLG_TYPE_MIXER:
> > +			mt = container_of(ct, struct snd_tplg_mixer_template, hdr);
> > +			ret = tplg_add_mixer(tplg, mt, &elem_ctl);
> > +			break;
> > +
> > +		case SND_SOC_TPLG_TYPE_BYTES:
> > +			bt = container_of(ct, struct snd_tplg_bytes_template, hdr);
> > +			ret = tplg_add_bytes(tplg, bt, &elem_ctl);
> > +			break;
> > +
> > +		case SND_SOC_TPLG_TYPE_ENUM:
> > +			et = container_of(ct, struct snd_tplg_enum_template, hdr);
> > +			ret = tplg_add_enum(tplg, bt, &elem_ctl);
> 
> et instead of bt?

Yes. It should be et here.

Thanks
Mengdong
