From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] ASoC: mc13783: Add devicetree support
Date: Mon, 6 Jan 2014 15:12:27 +0000
Message-ID: <20140106151227.GW31886@sirena.org.uk>
References: <1388907515-18975-1-git-send-email-shc_work@mail.ru>
 <1388907515-18975-5-git-send-email-shc_work@mail.ru>
 <20140106132841.GV31886@sirena.org.uk>
 <1389015981.978548720@f170.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3852349101691203492=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 186C02610B4
 for <alsa-devel@alsa-project.org>; Mon,  6 Jan 2014 16:12:35 +0100 (CET)
In-Reply-To: <1389015981.978548720@f170.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3852349101691203492==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8OOZPntID6Q9niAh"
Content-Disposition: inline


--8OOZPntID6Q9niAh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 06, 2014 at 05:46:21PM +0400, Alexander Shiyan wrote:
> =D0=9F=D0=BE=D0=BD=D0=B5=D0=B4=D0=B5=D0=BB=D1=8C=D0=BD=D0=B8=D0=BA,  6 =
=D1=8F=D0=BD=D0=B2=D0=B0=D1=80=D1=8F 2014, 13:28 UTC =D0=BE=D1=82 Mark Brow=
n <broonie@kernel.org>:

> > This is an incompatible binding change; deprecating is fine but it
> > should still be supported.  Is there not a default set of port
> > assignments that can be used?

> "fsl,mc13xxx-uses-codec" is not used anywhere and even if it was used,
> it would not usable, because we can not get to the codec phandle.
> So I think this change is safe.

Why would it prevent anything getting the CODEC phandle and what do you
mean by that anyway?  A lack of in tree users shouldn't mean anything,
we need to be compatible with DTs shipped with boards.

> > > +	pdev->dev.of_node =3D of_find_node_by_name(pdev->dev.parent->of_nod=
e,
> > > +						 "codec");

> > You shouldn't be messing with the of_node in the struct device, this is
> > managed by the driver model and setting one that wasn't added in sync
> > with everything else can introduce breakage.

> Hmm, probably you are right, but I cannot imagine other way to set of_nod=
e...
> Have you other ideas?

The whole problem is that you're trying to set of_node.  Don't do that.

> > > +	if (priv->adc_ssi_port !=3D MC13783_SSI1_PORT &&
> > > +	    priv->adc_ssi_port !=3D MC13783_SSI2_PORT)
> > > +		return -EINVAL;
> > > +	if (priv->dac_ssi_port !=3D MC13783_SSI1_PORT &&
> > > +	    priv->dac_ssi_port !=3D MC13783_SSI2_PORT)
> > > +		return -EINVAL;

> > What about DAC or ADC only systems?

> In this case we should rewrite this codec driver completely from scratch.

What makes you say that?

--8OOZPntID6Q9niAh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSysfYAAoJELSic+t+oim9m6UP/R7s+yfchV/PrWwzvjZUgQtr
S2t7nNSS5RfBLFoFOG3gBYrCybjTVBllfaQ7L142awk1+xrmwipspiwI9CvWnPYs
m4U1nQljBwupvz7xNoNQKMsxc8KXDIbaQzkO/+7rwJx3/cWwt0MTwdnBQXhPwkC7
bOliCSuh6GWu9gIIvj4escC0uhNPfBoygLju8tNcSbzDyModdRVO0WJ2QcTnI60o
tg6uvT6Cn33hpmpmpIFJHMRgo4EV1xzPFAVMao6C/xg9yAgnKgj4T+WUsKdFoDyH
97/JSe1bIuC/i+Q4k0xXd+ldCrhCX2w9RDjfyC6G7w6Z683Pn3r0Mdb2DVZ4MB9v
KmxopLGhX4R+hb2yagQzSKzl5ZuI5F2q4rdNfvI5eaEB0Ab3y5BoKhFvLesLXUqR
ygxBXV4vldh8YFDuT9ojmo4mC8/E3YMh5ugOqB147GVu2tLWdHLX3wbwEBkDVVfH
axgHZhUfv5fzr52E6ABAkUX2ug90rU0Uj7QcaL1Lukz1w/p7rlzNFYrjhEOJanEt
MgEKQlod0jsjlLmejTWI7tJuqg8xOkTUZfT5cp3ny/2yCXb0d74St84yJEwPPLj6
yXxNu6W+GjNP69HW6v41q4N2ob//wB9yZ0yuKlbaR8V4kn4b9MKT3pDSsHmbgKLt
nHL8XhWA47huAUlFqkzc
=MfgA
-----END PGP SIGNATURE-----

--8OOZPntID6Q9niAh--

--===============3852349101691203492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3852349101691203492==--
