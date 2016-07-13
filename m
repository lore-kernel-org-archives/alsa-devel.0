From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 4/5] topology: Parse vendor private data
	for manifest
Date: Wed, 13 Jul 2016 18:56:13 +0900
Message-ID: <5786103C.8030509@sakamocchi.jp>
References: <cover.1468397702.git.mengdong.lin@linux.intel.com>
 <5e5337dd75d6291b6f12e678adc9c5ea0f62138f.1468397702.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy004.phy.lolipop.jp (smtp-proxy004.phy.lolipop.jp
 [157.7.104.45]) by alsa0.perex.cz (Postfix) with ESMTP id D352A260851
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 11:56:15 +0200 (CEST)
In-Reply-To: <5e5337dd75d6291b6f12e678adc9c5ea0f62138f.1468397702.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

On Jul 13 2016 17:45, mengdong.lin@linux.intel.com wrote:
> diff --git a/src/topology/data.c b/src/topology/data.c
> index 65054d7..f04544b 100644
> --- a/src/topology/data.c
> +++ b/src/topology/data.c
> @@ -26,6 +26,10 @@ struct snd_soc_tplg_private *get_priv_data(struct tplg=
_elem *elem)
>   	struct snd_soc_tplg_private *priv =3D NULL;
>
>   	switch (elem->type) {
> +	case SND_TPLG_TYPE_MANIFEST:
> +		priv =3D &elem->manifest->priv;
> +		break;
> +
>   	case SND_TPLG_TYPE_MIXER:
>   		priv =3D &elem->mixer_ctrl->priv;
>   		break;
> @@ -835,6 +839,101 @@ void tplg_free_tuples(void *obj)
>   	free(tuples->set);
>   }
>
> +/* Parse manifest's data references
> + */
> +int tplg_parse_manifest_data(snd_tplg_t *tplg, snd_config_t *cfg,
> +	void *private ATTRIBUTE_UNUSED)
> +{
> +	struct snd_soc_tplg_manifest *manifest;
> +	struct tplg_elem *elem;
> +	snd_config_iterator_t i, next;
> +	snd_config_t *n;
> +	const char *id, *val =3D NULL;

data.c: In function =91tplg_parse_manifest_data=92:
data.c:851:19: warning: unused variable =91val=92 [-Wunused-variable]
   const char *id, *val =3D NULL;
                    ^

> +	int err;
> +
> +	if (!list_empty(&tplg->manifest_list)) {
> +		SNDERR("error: already has manifest data\n");
> +		return -EINVAL;
> +	}
> +
> +	elem =3D tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_MANIFEST);
> +	if (!elem)
> +		return -ENOMEM;
> +
> +	manifest =3D elem->manifest;
> +	manifest->size =3D elem->size;
> +
> +	tplg_dbg(" Manifest: %s\n", elem->id);
> +
> +	snd_config_for_each(i, next, cfg) {
> +		n =3D snd_config_iterator_entry(i);
> +		if (snd_config_get_id(n, &id) < 0)
> +			continue;
> +
> +		/* skip comments */
> +		if (strcmp(id, "comment") =3D=3D 0)
> +			continue;
> +		if (id[0] =3D=3D '#')
> +			continue;
> +
> +
> +		if (strcmp(id, "data") =3D=3D 0) {
> +			err =3D tplg_parse_data_refs(tplg, n, elem);
> +			if (err < 0)
> +				return err;
> +			continue;
> +		}
> +	}
> +}

data.c:887:1: warning: control reaches end of non-void function =

[-Wreturn-type]
  }
  ^

Regards

Takashi Sakamoto
