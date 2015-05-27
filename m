From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] ASoC: topology: Add topology core
Date: Wed, 27 May 2015 20:00:21 +0100
Message-ID: <20150527190021.GO21577@sirena.org.uk>
References: <1432574570-7436-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8323260847346447980=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0267B260427
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 21:00:27 +0200 (CEST)
In-Reply-To: <1432574570-7436-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8323260847346447980==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4gNoFi8SKrkInYGX"
Content-Disposition: inline


--4gNoFi8SKrkInYGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2015 at 06:22:49PM +0100, Liam Girdwood wrote:

This looks really nice at a high level, obviously it's a lot of code so
there might be detail problems but I expect we can fix those up later.

> @@ -564,6 +565,7 @@ struct snd_soc_dapm_widget {
>  	int num_kcontrols;
>  	const struct snd_kcontrol_new *kcontrol_news;
>  	struct snd_kcontrol **kcontrols;
> +	struct snd_soc_dobj dobj;
> =20
>  	/* widget input and outputs */
>  	struct list_head sources;

This adds the dynamic object (which isn't enormous but isn't tiny) to
every widget which could add up a bit.  I don't know if it's worth
making it a pointer to a dobj and allocating that separately?  OTOH it's
really routes rather than widgets that are the big cost, and it depends
on allocators being friendly and not putting lots of padding round
dobjs.  Definitely fixable incrementally if it is an issue though.

> +	/* external kcontrol init - used to set ext funcs + private data */
> +	int (*control_load)(struct snd_soc_component *,
> +		struct snd_kcontrol_new *, struct snd_soc_tplg_ctl_hdr *);
> +	int (*control_unload)(struct snd_soc_component *,
> +		struct snd_soc_dobj *);

Do we have examples of all these external users yet?  Just thinking
about what happens if we need a load/unload function but the kernel
doesn't know about this particular firmware type - the file didn't say
code would be needed and perhaps the code is optional anyway (some
optimisation or something).  Is that something that was thought about
yet, what sort of uses are we expecting?

> +/* pass vendor data to component driver for processing */
> +static int soc_tplg_vendor_load_(struct soc_tplg *tplg,
> +	struct snd_soc_tplg_hdr *hdr)
> +{
> +	int ret =3D 0;
> +
> +	if (tplg->comp && tplg->ops && tplg->ops->vendor_load)
> +		ret =3D tplg->ops->vendor_load(tplg->comp, hdr);
> +
> +	if (ret < 0)
> +		dev_err(tplg->dev,
> +			"ASoC: vendor load failed at hdr offset %ld/0x%lx for type %d:%d\n",
> +			soc_tplg_get_hdr_offset(tplg),
> +			soc_tplg_get_hdr_offset(tplg),
> +			hdr->type, hdr->vendor_type);
> +	return ret;
> +}

For example I wonder if we should warn if we don't have a handler for
vendor data that we see?

--4gNoFi8SKrkInYGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZhREAAoJECTWi3JdVIfQFgIH/Av5Ml8WHSUIO9dSCM3f0ZLA
S+ECvdlDGhwaKPHBAiggXPIEsCqniLm4b0GsNwdipSF8rRbABRwq4R5VjLdKvi/X
yoMFBbs7/0KDDVMY7xuJ6FwvQXzIlF6csjVcxm14OzhjMvx8usgJIge972bH2Knb
MrJVpfdj0keMM27yGbFL7bKGZjCnB6dCfa51neeO2b7NSiPiW6F85e56iJK6TdMr
RK1UzTTEPS3fzU9aPyQynjAa+8z4R0lc1xsCj4QapGDddTc5VKr8sF/Iu/pc0EUd
aVcd6+R8hiaHFUcbvHjzlgYKpTukw1hyRdZUqeyVCXyLP0rRl66YzM2z2Vt5JN0=
=dsIC
-----END PGP SIGNATURE-----

--4gNoFi8SKrkInYGX--

--===============8323260847346447980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8323260847346447980==--
