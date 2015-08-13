From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ASoC: topology: Add support for TLV bytes
	control
Date: Thu, 13 Aug 2015 01:41:02 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8480CA0BF@SHSMSX101.ccr.corp.intel.com>
References: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id A34AB2612AE
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 03:41:43 +0200 (CEST)
In-Reply-To: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
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
To: "broonie@kernel.org" <broonie@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

If convenient, would you please review this patch before my another series:
"[PATCH v2 00/10] ASoC: support adding PCM dynamically from topology"?

This patch is more like a fix for TLV bytes control in topology kernel.
The user space part has been merged in alsa-lib now. We want to avoid mismatch between the kernel and user space.

That v2 series for dynamic PCM support in topology is actually still in RFC phase. We hope to get your feedback to adjust the direction and go ahead.

Thanks
Mengdong  

> -----Original Message-----
> From: Lin, Mengdong
> Sent: Wednesday, August 12, 2015 10:11 AM
> To: alsa-devel@alsa-project.org
> Cc: tiwai@suse.de; broonie@kernel.org; Girdwood, Liam R; Lin, Mengdong
> Subject: [PATCH] ASoC: topology: Add support for TLV bytes control
> 
> From: Mengdong Lin <mengdong.lin@intel.com>
> 
> Allow vendor drivers to define bespoke bytes ext handlers and IDs for TLV
> bytes controls. And the topology core will bind these handlers by matching
> IDs defined by the vendor driver and user space topology data file.
> 
> Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
> 
> diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
> index 865a141..3e412c6 100644
> --- a/include/sound/soc-topology.h
> +++ b/include/sound/soc-topology.h
> @@ -89,6 +89,13 @@ struct snd_soc_tplg_kcontrol_ops {
>  		struct snd_ctl_elem_info *uinfo);
>  };
> 
> +/* Bytes ext operations, for TLV byte controls */ struct
> +snd_soc_tplg_bytes_ext_ops {
> +	u32 id;
> +	int (*get)(unsigned int __user *bytes, unsigned int size);
> +	int (*put)(const unsigned int __user *bytes, unsigned int size); };
> +
>  /*
>   * DAPM widget event handlers - used to map handlers onto widgets.
>   */
> @@ -139,6 +146,10 @@ struct snd_soc_tplg_ops {
>  	/* bespoke kcontrol handlers available for binding */
>  	const struct snd_soc_tplg_kcontrol_ops *io_ops;
>  	int io_ops_count;
> +
> +	/* bespoke bytes ext handlers available for binding */
> +	const struct snd_soc_tplg_bytes_ext_ops *bytes_ext_ops;
> +	int bytes_ext_ops_count;
>  };
> 
>  /* gets a pointer to data from the firmware block header */ diff --git
> a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c index
> 607f98b..b5a2868 100644
> --- a/sound/soc/soc-topology.c
> +++ b/sound/soc/soc-topology.c
> @@ -70,6 +70,10 @@ struct soc_tplg {
>  	const struct snd_soc_tplg_kcontrol_ops *io_ops;
>  	int io_ops_count;
> 
> +	/* bespoke bytes ext handlers, for TLV bytes controls */
> +	const struct snd_soc_tplg_bytes_ext_ops *bytes_ext_ops;
> +	int bytes_ext_ops_count;
> +
>  	/* optional fw loading callbacks to component drivers */
>  	struct snd_soc_tplg_ops *ops;
>  };
> @@ -513,6 +517,15 @@ static int soc_tplg_kcontrol_bind_io(struct
> snd_soc_tplg_ctl_hdr *hdr,  {
>  	int i;
> 
> +	/* TLV bytes controls don't need get/put ops */
> +	if (k->iface & SNDRV_CTL_ELEM_IFACE_MIXER
> +		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
> +		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK
> +		&& hdr->ops.info == SND_SOC_TPLG_CTL_BYTES) {
> +			k->info = snd_soc_bytes_info_ext;
> +			return 0;
> +	}
> +
>  	/* try and map standard kcontrols handler first */
>  	for (i = 0; i < num_ops; i++) {
> 
> @@ -547,6 +560,32 @@ static int soc_tplg_kcontrol_bind_io(struct
> snd_soc_tplg_ctl_hdr *hdr,
>  	return -EINVAL;
>  }
> 
> +/* bind bytes ext get/put handlers for TLV bytes controls */ static int
> +soc_tplg_bytes_ext_bind_io(struct soc_tplg *tplg,
> +	struct snd_soc_tplg_io_ops *ops_id,
> +	struct soc_bytes_ext *sbe)
> +{
> +	const struct snd_soc_tplg_bytes_ext_ops *ops = tplg->bytes_ext_ops;
> +	int num_ops = tplg->bytes_ext_ops_count;
> +	int i;
> +
> +	/* try bespoke handlers */
> +	for (i = 0; i < num_ops; i++) {
> +
> +		if (sbe->put == NULL && ops[i].id == ops_id->put)
> +			sbe->put = ops[i].put;
> +		if (sbe->get == NULL && ops[i].id == ops_id->get)
> +			sbe->get = ops[i].get;
> +	}
> +
> +	/* bespoke handlers found ? */
> +	if (sbe->put && sbe->get)
> +		return 0;
> +
> +	/* nothing to bind */
> +	return -EINVAL;
> +}
> +
>  /* bind a widgets to it's evnt handlers */  int
> snd_soc_tplg_widget_bind_event(struct snd_soc_dapm_widget *w,
>  		const struct snd_soc_tplg_widget_events *events, @@ -690,6
> +729,14 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, unsigned
> int count,
>  			continue;
>  		}
> 
> +		/* create any TLV data */
> +		soc_tplg_create_tlv(tplg, &kc, &be->hdr);
> +		/* map bytes ext io handlers for TLV bytes controls */
> +		if (kc.access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
> +			soc_tplg_bytes_ext_bind_io(tplg,
> +					&be->ext_ops, sbe);
> +		}
> +
>  		/* pass control to driver for optional further init */
>  		err = soc_tplg_init_kcontrol(tplg, &kc,
>  			(struct snd_soc_tplg_ctl_hdr *)be);
> @@ -1315,6 +1362,14 @@ static struct snd_kcontrol_new
> *soc_tplg_dapm_widget_dbytes_create(
>  			continue;
>  		}
> 
> +		/* create any TLV data */
> +		soc_tplg_create_tlv(tplg, &kc[i], &be->hdr);
> +		/* map bytes ext io handlers for TLV bytes controls */
> +		if (kc[i].access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK) {
> +			soc_tplg_bytes_ext_bind_io(tplg,
> +					&be->ext_ops, sbe);
> +		}
> +
>  		/* pass control to driver for optional further init */
>  		err = soc_tplg_init_kcontrol(tplg, &kc[i],
>  			(struct snd_soc_tplg_ctl_hdr *)be);
> @@ -1736,6 +1791,8 @@ int snd_soc_tplg_component_load(struct
> snd_soc_component *comp,
>  	tplg.req_index = id;
>  	tplg.io_ops = ops->io_ops;
>  	tplg.io_ops_count = ops->io_ops_count;
> +	tplg.bytes_ext_ops = ops->bytes_ext_ops;
> +	tplg.bytes_ext_ops_count = ops->bytes_ext_ops_count;
> 
>  	return soc_tplg_load(&tplg);
>  }
> --
> 1.9.1
