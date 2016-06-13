From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: rt298: Add jack suspend and resume
	functions.
Date: Mon, 13 Jun 2016 22:25:37 +0530
Message-ID: <20160613165537.GH16910@localhost>
References: <1465820919-6105-1-git-send-email-bardliao@realtek.com>
 <20160613140923.GH2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1159009215779927064=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 442F7261685
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 18:48:57 +0200 (CEST)
In-Reply-To: <20160613140923.GH2282@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, senthilnathanx.veppur@intel.com, Bard Liao <bardliao@realtek.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1159009215779927064==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZG+WKzXzVby2T9Ro"
Content-Disposition: inline


--ZG+WKzXzVby2T9Ro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 13, 2016 at 03:09:23PM +0100, Mark Brown wrote:
> On Mon, Jun 13, 2016 at 08:28:39PM +0800, Bard Liao wrote:
>=20
> > +void rt298_jack_suspend(struct snd_soc_codec *codec)
> > +{
> > +	struct rt298_priv *rt298 =3D snd_soc_codec_get_drvdata(codec);
> > +	struct snd_soc_dapm_context *dapm;
> > +
> > +	dapm =3D snd_soc_codec_get_dapm(rt298->codec);
> > +	snd_soc_dapm_disable_pin(dapm, "LDO1");
> > +	snd_soc_dapm_sync(dapm);
> > +}
> > +EXPORT_SYMBOL_GPL(rt298_jack_suspend);
> > +
> > +void rt298_jack_resume(struct snd_soc_codec *codec)
> > +{
> > +	struct rt298_priv *rt298 =3D snd_soc_codec_get_drvdata(codec);
> > +	bool hp =3D false;
> > +	bool mic =3D false;
> > +
> > +	rt298_jack_detect(rt298, &hp, &mic);
> > +}
> > +EXPORT_SYMBOL_GPL(rt298_jack_resume);
>=20
> This is usually done by having the _jack_detect() function take NULL as
> the jack to disable the detection.  Keeping in line with the existing
> pattern would be good, and would make it easier if we do start to get
> this more standardized.

This was based on existing pattern in rt5672.

But yes I agree with you that we can so this by calling rt298_mic_detect(),
will try that out

Thanks
--=20
~Vinod

--ZG+WKzXzVby2T9Ro
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXXuWJAAoJEHwUBw8lI4NHihgP/2rDV4Rcf2wXar1TJBHf9yEf
wDmUIEJvICBEWflJsVxBJsJOymobNrPDfG4h1wv/V2lIBr5uytYOwzjfUMGrXutD
22VRI5AKD/BMUeqy1xh6DMlHSXdXndq5zjhH0xdoobTVe9+pzMvkadSQxxNhOGOy
OIndci0keOi085difuvYXTs5fVLJ0pwR7Vp540KDH873Iw++F2mBJYThgG6PRPf+
X1dl8nxdUE2jSZ87189dudmjpEiVsdeky5TeMb5M+G7+9w+ovFD9RcXLWhEFSSl7
+CV58JuQNR5/ZrJcUvKLHUvGIfim2XLMi85IJAXSumGG9P6oZmD8slL0aXp89h+J
KS560tU4SL06I+sfcnRSchaQAoxTanHOCLJhPHMD2yktweHUVuPszcQOz2UYjWFx
7mpGrdM3sf792SnAqO57oWLlJ26YP/lVVdpaGDBVliA9kZy0vCyMDxRESmLeLW51
2uAWGLduZswurmSDKqsiz1I+2+zyuD9jceyrIMSE3nWdV3SS/YSrUDA7kzjZi7h4
BGbHnI3LzkO2YGixFrGbvPbilsvsFV6oallUUmHRrYkmZiVq6rGRhcHf45/9tTET
v6o3sTXIPWOK7tKy9iNpZtXAoacjxwcXI03dsWt3KNuQVAZo5r1Wo+knBvzZJOre
GWGTUYzH9pvGUujeItrj
=nWX4
-----END PGP SIGNATURE-----

--ZG+WKzXzVby2T9Ro--

--===============1159009215779927064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1159009215779927064==--
