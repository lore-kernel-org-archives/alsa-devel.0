From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/5] ASoC : dwc : support dw i2s in AMD
	platform
Date: Mon, 5 Oct 2015 16:41:48 +0100
Message-ID: <20151005154148.GX12635@sirena.org.uk>
References: <1443217704-28814-1-git-send-email-alexander.deucher@amd.com>
 <1443217704-28814-3-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4533195002830659130=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D5BF261501
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 17:42:11 +0200 (CEST)
In-Reply-To: <1443217704-28814-3-git-send-email-alexander.deucher@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alsa-devel@alsa-project.org, maruthi.bayyavarapu@amd.com, tiwai@suse.de, lgirdwood@gmail.com, dri-devel@lists.freedesktop.org, rajeevkumar.linux@gmail.com, Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4533195002830659130==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jnHBos+GICmmswJV"
Content-Disposition: inline


--jnHBos+GICmmswJV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2015 at 05:48:23PM -0400, Alex Deucher wrote:
> From: Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>
>=20
> Vendor specific quirk was added to:
> 1. Support AMD platform which has two dwc controllers with different
>    base address for playback and capture. Also, I2S_COMP_PARAM_*
>    registers offsets differed.

> 2. Resume audio which was active before system suspend.
>    After 'resume', dwc need to be reconfigured with params
>    configured during 'hw_params' callback. With this, audio usecase
>    continues from where it got stopped because of 'suspend'.

This is hard to review since there are several different changes in
here, one change per commit is muuch more helpful.  As is I'm not 100%
sure exactly what each bit of the change is intended to do.  One example
here is that a separate patch splitting pbase and cbase would be really
helpful.

> --- a/include/sound/designware_i2s.h
> +++ b/include/sound/designware_i2s.h
> @@ -44,6 +44,9 @@ struct i2s_platform_data {
>  	int channel;
>  	u32 snd_fmts;
>  	u32 snd_rates;
> +	#define DW_I2S_VENDOR_AMD (1 << 0)
> +	unsigned int quirks;

I would expect to see a set of quirks with the AMD devices selecting
those that apply to them rather than just a per vendor define - this
is more generic and more maintainable long term.  AMD may require
different sets of quirks with some future device and systems from other
vendors may require some but not all of the quirks that AMD requires.

> +	if (dev->quirks & DW_I2S_VENDOR_AMD) {
> +		comp1 =3D i2s_read_reg(dev->i2s_pbase, 0x124);
> +		comp2 =3D i2s_read_reg(dev->i2s_pbase, 0x120);

Please add defines for these registers.  Rather than having the quirk
code throughout the driver it might be clearer to have the comp1 and
comp2 register offsets stored in the driver data so you can just do the
actual quirk once at probe time.

--jnHBos+GICmmswJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWEpo4AAoJECTWi3JdVIfQPhMH+gP8RWPCXNN1fXSjLqpjpUg8
J7g7DJmuljR1RBkVr+QR0kD3CpG4EYFF1jjtkRZY1EbyCTOa5da6Yed2iyGhc3zD
Y8yJlDKiLH3ZVTY8QYhrsPeWeJrutivEJSHdcW0ylZF/wl9hK6sL5PmOGjjFE4Xc
TQm4a9IFzeEmcXV86F50GLlBbcrFaztZuZNVpawf89aGuCn5mbREm4PHp41dy284
PRj6h8Ss+MttYl7cqpVNUOBfe796d+Al4vS47vzE2qWBuq4+E17iHApBGW5E2YRD
bak9tnOAa15SpYd5G9J+POg8vKJnIB1tY6wTZEsFIzwnm39IFviTiLUzTXjfbjM=
=wqQj
-----END PGP SIGNATURE-----

--jnHBos+GICmmswJV--

--===============4533195002830659130==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4533195002830659130==--
