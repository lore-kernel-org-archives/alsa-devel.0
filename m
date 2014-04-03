From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Add support for multi register mux
Date: Thu, 3 Apr 2014 17:02:54 +0100
Message-ID: <20140403160254.GV14763@sirena.org.uk>
References: <1396494710-20944-1-git-send-email-aruns@nvidia.com>
 <s5h4n2asq1o.wl%tiwai@suse.de>
 <20140403095330.GS14763@sirena.org.uk>
 <533D62CE.5040907@metafoo.de>
 <s5hr45epi4r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A47bNRIYjYQgpFVi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hr45epi4r.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arun Shamanna Lakshmi <aruns@nvidia.com>, lgirdwood@gmail.com, swarren@wwwdotorg.org, perex@perex.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Songhee Baek <sbaek@nvidia.com>
List-Id: alsa-devel@alsa-project.org


--A47bNRIYjYQgpFVi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 03, 2014 at 05:06:28PM +0200, Takashi Iwai wrote:
> Lars-Peter Clausen wrote:

> > It would be nice, but it also requires some slight restructuring. The i=
ssue=20
> > we have right now is that there is  strictly speaking a bit of a layeri=
ng=20
> > violation. The DAPM widgets should not need to know how the kcontrols t=
hat=20
> > are attached to the widget do their IO. What we essentially do in=20
> > dapm_connect_mux() (and also dapm_connect_mixer) is an open-coded versi=
on of=20
> > the controls get handler. Replacing that by calling the get handler ins=
tead=20
> > should allow us to use different structs for enums and onehot enums.

Right, that's because DAPM has always just reimplemented everything and
the virtual controls were grafted on the side of the existing register
stuff rather than adding an abstraction layer.

> So, something like below?  It's totally untested, just a proof of
> concept.

Yes, that looks sensible to me but I didn't test it yet either.

> If the performance matters, we can optimize it by checking
> kcontrol->get =3D=3D snd_soc_dapm_get_enum_double or kcontrol->get =3D=3D
> snd_soc_dapm_get_volsw and bypass to the current open-code functions
> instead of the generic get/put callers.

Performance isn't that big a deal, probably avoiding the alloc/frees
by just keeping one around somewhere convenient would be useful too.

--A47bNRIYjYQgpFVi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTPYYqAAoJELSic+t+oim942gP/0cfOGPtl+SeM5sjve0R0uC7
lu8mdn1VC5YJZSV2qzIuv9AxQgf547ou4h3OImr309Y2HwA4P6dN5i3efqhQ1O7m
8le38Eh5Pmn/zR4FmSdmQeYCV9Ps/kI13mcCL6tnXn07idHWrgfsyV/vN4xUxCjZ
Rlx7J63u14d93F0JTt9nX8fp8rpIR9DzODGoXL8O/xm/ajP8APz/9DDeKWbkHXhd
g39NpDUEow575AIa9WNaQsRdLDhDm1c1oDeDK/pSyZ34JywP6DSABeiW2Gy1FuRP
f+CAsuyz7JSzojHD/2Dt/IbSHFhOoozqn7sJPVSQFrpSHubnQVg91QTmfnbIRAxg
VG79vPpHso5Nu4v4FlMXSs57w9S9o8yztDBnyrYgiY9oYEEuqwRawojQuwYd8SZW
2PJmDb51PTG8QgSeMnz8d9UXYdz/l9a2+VdsluXYRPNL9GnmliwAmnuziH5E7vIv
fYArotHVb88b0GGipdAidepd/YthU5Avvkjm+JKYnnTQnTaSN+vLkBsmeHc08Wuw
8jvsTbhWQ8Pfkhav1eqqcU9F3l4I3vjjRYtmhCYD4nLdz4d+7KF2UBEGcjUsrW8y
4nX6fdAlx2HrBNUJMreMOErv7m/TFHA4cPvjK/RX5aleoTcrlwuxB82PC43Qjz3j
oCbnUyWgSeATt5/duD3Z
=KeIg
-----END PGP SIGNATURE-----

--A47bNRIYjYQgpFVi--
