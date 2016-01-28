From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: wm5110: Add support for audio
	trace firmware
Date: Fri, 29 Jan 2016 00:34:22 +0100
Message-ID: <20160128233422.GI4130@sirena.org.uk>
References: <1453398782-32198-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1453398782-32198-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7143732844712415048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CB34C2606F3
 for <alsa-devel@alsa-project.org>; Fri, 29 Jan 2016 00:34:34 +0100 (CET)
In-Reply-To: <1453398782-32198-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7143732844712415048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hABqaeELJqnDDeDE"
Content-Disposition: inline


--hABqaeELJqnDDeDE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 05:53:00PM +0000, Charles Keepax wrote:

> @@ -2163,6 +2187,8 @@ static int wm5110_open(struct snd_compr_stream *str=
eam)
> =20
>  	if (strcmp(rtd->codec_dai->name, "wm5110-dsp-voicectrl") =3D=3D 0) {
>  		n_adsp =3D 2;
> +	} else if (strcmp(rtd->codec_dai->name, "wm5110-dsp-trace") =3D=3D 0) {
> +		n_adsp =3D 0;
>  	} else {
>  		dev_err(arizona->dev,
>  			"No suitable compressed stream for DAI '%s'\n",

I'm a bit unclear on how exactly we're ensuring that the relevant
firmware is loaded?

--hABqaeELJqnDDeDE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWqqV9AAoJECTWi3JdVIfQmbUH/3UBq24yb61q5cxs1xfGy/aD
HJqTLPVdtORJ9Aacri4/tCWEzibU8Jt9i8vPmBPWVMj5JfFUhrBiWwEPnHAXupbm
nqM5bUZ3zhDzD1/LAAm5DZeJ+NsIWw/YWcthU/jHjJYZ7QJ1EeG8HSgVGZNFd/Yq
66rUzHHoutOk7K7QUkIVSPuZaVjM1F9k/pAdavtBUh6615RhntWIboDn/Gtg3jop
FY1no9C75wFe4xrmB+wO+NeoPfCEj03VNGM7UyB4v47OLby647I2QpJ35dYOO4HO
bYRolTTDjSkoiXljrUG2H8KzUbMdYBR5tlJjqZyvEkd7QLEB4xTNMspD9ow4eRI=
=GYP9
-----END PGP SIGNATURE-----

--hABqaeELJqnDDeDE--

--===============7143732844712415048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7143732844712415048==--
