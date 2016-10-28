From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 02/11] ASoC: topology: Make PCM backward
 compatible from ABI v4
Date: Fri, 28 Oct 2016 19:51:05 +0100
Message-ID: <20161028185105.xvxvf5tmekivpa4n@sirena.org.uk>
References: <cover.1476166990.git.mengdong.lin@linux.intel.com>
 <84e2ad13cc7ac401b62e421352b7af49fd7876a5.1476166990.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1998289311774249724=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6ED265D93
 for <alsa-devel@alsa-project.org>; Fri, 28 Oct 2016 20:51:27 +0200 (CEST)
In-Reply-To: <84e2ad13cc7ac401b62e421352b7af49fd7876a5.1476166990.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1998289311774249724==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kgciuzgtkvg4753m"
Content-Disposition: inline


--kgciuzgtkvg4753m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 11, 2016 at 02:36:49PM +0800, mengdong.lin@linux.intel.com wrot=
e:

> @@ -508,6 +541,10 @@ static void remove_link(struct snd_soc_component *co=
mp,
>  	if (dobj->ops && dobj->ops->link_unload)
>  		dobj->ops->link_unload(comp, dobj);
> =20
> +	kfree(link->name);
> +	kfree(link->stream_name);
> +	kfree(link->cpu_dai_name);
> +
>  	list_del(&dobj->list);
>  	snd_soc_remove_dai_link(comp->card, link);
>  	kfree(link);
> @@ -1606,7 +1643,8 @@ static int soc_tplg_dai_create(struct soc_tplg *tpl=
g,
>  	if (dai_drv =3D=3D NULL)
>  		return -ENOMEM;
> =20
> -	dai_drv->name =3D pcm->dai_name;
> +	if (strlen(pcm->dai_name))
> +		dai_drv->name =3D kstrdup(pcm->dai_name, GFP_KERNEL);
>  	dai_drv->id =3D pcm->dai_id;
> =20
>  	if (pcm->playback) {

These appear to be fixes unrelated to the ABI handling?

--kgciuzgtkvg4753m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE54YAAoJECTWi3JdVIfQrWMH/0Xjzbe42uk1980NveTvHiPQ
pmr92JRZ6x52RcaYsMtRfEix+vWW67xFavcA2QoXNC4YUNrpwO3XnY1/0Vl2lNS6
dK/P8NmHQePesmcmVWtQlN/yYtyxj9nAzuPol3Mo85hQ4UQBqUvXkdiHvlUfyOCJ
XjduS+n2UqP/3lbblkXgjWpEyJNxQLbYZgamobRJWAU40admekQ+os/AHMui+/nG
XLRMyhZJi7kn6wQhZbwhzyZNe40FdUIxYGDrN+VTkmKg2+a4RhKIoDvggeXJcM2M
DQnmr5syE+fMJ8lvc82d0b9qcOkcKu0UUf5Cn1NSYOJMaulRsxL5yUvB5zQhEq4=
=da5j
-----END PGP SIGNATURE-----

--kgciuzgtkvg4753m--

--===============1998289311774249724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1998289311774249724==--
