From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/5] topology: An element can refer to
 multipe data sections in text conf file
Date: Wed, 13 Jul 2016 18:56:42 +0900
Message-ID: <5786105A.5040500@sakamocchi.jp>
References: <cover.1468397702.git.mengdong.lin@linux.intel.com>
 <c2b1a79cfa9acf38b91e6a0549fb5164f1b77a6f.1468397702.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 0D024265957
 for <alsa-devel@alsa-project.org>; Wed, 13 Jul 2016 11:56:45 +0200 (CEST)
In-Reply-To: <c2b1a79cfa9acf38b91e6a0549fb5164f1b77a6f.1468397702.git.mengdong.lin@linux.intel.com>
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

On Jul 13 2016 17:44, mengdong.lin@linux.intel.com wrote:
> diff --git a/src/topology/data.c b/src/topology/data.c
> index 9f8d5d0..1db2e07 100644
> --- a/src/topology/data.c
> +++ b/src/topology/data.c
> @@ -20,6 +20,36 @@
>   #include "tplg_local.h"
>   #include <ctype.h>
>
> +/* Get private data buffer of an element */
> +struct snd_soc_tplg_private *get_priv_data(struct tplg_elem *elem)
> +{
> +	struct snd_soc_tplg_private *priv =3D NULL;
> +
> +	switch (elem->type) {
> +	case SND_TPLG_TYPE_MIXER:
> +		priv =3D &elem->mixer_ctrl->priv;
> +		break;
> +
> +	case SND_TPLG_TYPE_ENUM:
> +		priv =3D &elem->enum_ctrl->priv;
> +		break;
> +
> +	case SND_TPLG_TYPE_BYTES:
> +		priv =3D &elem->bytes_ext->priv;
> +		break;
> +
> +	case SND_TPLG_TYPE_DAPM_WIDGET:
> +		priv =3D &elem->widget->priv;
> +		break;
> +
> +	default:
> +		SNDERR("error: '%s': no support for private data for type %d\n",
> +			elem->id, elem->type);
> +	}
> +
> +	return priv;
> +}
> +
>   /* Get Private data from a file. */
>   static int tplg_parse_data_file(snd_config_t *cfg, struct tplg_elem *el=
em)
>   {
> @@ -614,6 +644,48 @@ static int parse_tuple_sets(snd_tplg_t *tplg, snd_co=
nfig_t *cfg,
>   	return 0;
>   }
>
> +/* Parse private data references for the element, either a single data s=
ection
> + * or a list of data sections.
> + */
> +int tplg_parse_data_refs(snd_tplg_t *tplg, snd_config_t *cfg,
> +	struct tplg_elem *elem)
> +{
> +	snd_config_type_t  type;
> +	snd_config_iterator_t i, next;
> +	snd_config_t *n;
> +	const char *id, *val =3D NULL;
> +
> +	type =3D snd_config_get_type(cfg);
> +
> +	/* refer to a single data section */
> +	if (type =3D=3D SND_CONFIG_TYPE_STRING) {
> +		if (snd_config_get_string(cfg, &val) < 0)
> +			return -EINVAL;
> +
> +		tplg_dbg("\tdata: %s\n", val);
> +		return tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
> +	}
> +
> +	if (type !=3D SND_CONFIG_TYPE_COMPOUND) {
> +		SNDERR("error: compound type expected for %s", id);

In file included from ../../include/local.h:165:0,
                  from tplg_local.h:17,
                  from data.c:20:
data.c: In function =91tplg_parse_data_refs=92:
../../include/error.h:64:21: warning: =91id=92 may be used uninitialized in =

this function [-Wmaybe-uninitialized]
  #define SNDERR(...) snd_lib_error(__FILE__, __LINE__, __FUNCTION__, 0, =

__VA_ARGS__) /**< Shows a sound error message. */
                      ^
data.c:697:14: note: =91id=92 was declared here
   const char *id, *val =3D NULL;
               ^

> +		return -EINVAL;
> +	}
> +
> +	/* refer to a list of data sections */
> +	snd_config_for_each(i, next, cfg) {
> +		const char *val;
> +
> +		n =3D snd_config_iterator_entry(i);
> +		if (snd_config_get_string(n, &val) < 0)
> +			continue;
> +
> +		tplg_dbg("\tdata: %s\n", val);
> +		tplg_ref_add(elem, SND_TPLG_TYPE_DATA, val);
> +	}
> +
> +	return 0;
> +}
> +
>   /* Parse vendor tokens
>    */
>   int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
> @@ -817,11 +889,15 @@ int tplg_parse_data(snd_tplg_t *tplg, snd_config_t =
*cfg,
>   	return err;
>   }
>
> -/* copy private data into the bytes extended control */
> +/* Merge data from a referenced data element to the parent element's
> + * private data buffer.
> + * An element can refer to multiple data sections. Data of these sections
> + * will be merged in the their reference order.
> + */
>   int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
>   {
> -	struct snd_soc_tplg_private *priv;
> -	int priv_data_size;
> +	struct snd_soc_tplg_private *priv, *old_priv;
> +	int priv_data_size, old_priv_data_size;
>   	void *obj;
>
>   	if (!ref)
> @@ -831,6 +907,11 @@ int tplg_copy_data(struct tplg_elem *elem, struct tp=
lg_elem *ref)
>   	if (!ref->data || !ref->data->size) /* overlook empty private data */
>   		return 0;

data.c: In function =91tplg_copy_data=92:
data.c:1051:15: warning: =91ref_elem=92 may be used uninitialized in this =

function [-Wmaybe-uninitialized]
   if (!ref_elem->data || !ref_elem->data->size)
                ^

Regards

Takashi Sakamoto
