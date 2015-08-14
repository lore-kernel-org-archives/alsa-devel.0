From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: topology: Add support for TLV bytes
	control
Date: Fri, 14 Aug 2015 20:17:42 +0100
Message-ID: <20150814191742.GJ10748@sirena.org.uk>
References: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3583143873455410270=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66D96266488
 for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2015 04:12:16 +0200 (CEST)
In-Reply-To: <2758b949231d10b23f1c8285fb3923db06fb1a46.1439345293.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@intel.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org


--===============3583143873455410270==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U4Pv8ouM+6WX/UB7"
Content-Disposition: inline


--U4Pv8ouM+6WX/UB7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 10:10:51AM +0800, mengdong.lin@intel.com wrote:

> Allow vendor drivers to define bespoke bytes ext handlers and IDs for
> TLV bytes controls. And the topology core will bind these handlers by
> matching IDs defined by the vendor driver and user space topology
> data file.

> @@ -513,6 +517,15 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_=
tplg_ctl_hdr *hdr,
>  {
>  	int i;
> =20
> +	/* TLV bytes controls don't need get/put ops */

AFAICT it's actually the case that we're binding them later rather than
that the ops aren't needed.  Isn't that what soc_tplg_bytes_ext_bind_io()
does?

> +	if (k->iface & SNDRV_CTL_ELEM_IFACE_MIXER
> +		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE
> +		&& k->access & SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK
> +		&& hdr->ops.info =3D=3D SND_SOC_TPLG_CTL_BYTES) {
> +			k->info =3D snd_soc_bytes_info_ext;
> +			return 0;
> +	}
> +

I'm confused.  What's special about TLV controls compared to other
controls, why are the existing bespoke handlers which get bound in this
function not sufficient and why don't we bind the TLV bespoke handlers
here?

Having two different classes of bespoke handlers like this both called
bespoke handlers seems like it's going to lead to problems - either
bringing the interfaces closer together or naming them in a way that
clarifies their meaning seems better.  Instead of just calling them
"bespoke handlers" we should probably just call them handlers for
whatever kind of control they're for and probably bind them first rather
than second so we're doing more specific to less specific handling.
That way drivers can also have specific handling for things the topology
data didn't anticipate they'd need it for which seems like it might come
in handy.

--U4Pv8ouM+6WX/UB7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzj7WAAoJECTWi3JdVIfQbaAH/2c/Ae9/RMsJhQ0aq6KggkIL
K3ScDmKtkBcyE7LVoTlEydPp0FZxsZwUDGm/lgUlaSFETXLgPdkyLp2FJrui5Bjf
zjKYgjVgaJL7BhWSqnTMTVXhh3oGkDJfwCck6VxaOH/TGe5bMPfbNhxq7n6ba9lR
gWgLmEZnR/Ehv763gkScysVU0awl6BcclqWjYyAIJ5HeIGClAatuXyhRlOnjKXEQ
2HFt3PutAU7u4VGNwXFbD3JyhbKBWlZ8Varjw/MK9YWWZFICgPqdQM3n75y/4o87
UawDD9gT35p0JYiVFboogMoEXUrGeytRGClHtXmfHOADk/p6/Z0Wv8asyv8TWvE=
=oUhl
-----END PGP SIGNATURE-----

--U4Pv8ouM+6WX/UB7--

--===============3583143873455410270==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3583143873455410270==--
