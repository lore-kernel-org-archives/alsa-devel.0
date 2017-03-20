From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/5] ARM: dts: sun8i: Update
 audio-routing with renamed widgets
Date: Mon, 20 Mar 2017 11:38:17 +0000
Message-ID: <20170320113817.rcphcvrizi4yphhe@sirena.org.uk>
References: <20170318075509.3836-1-mylene.josserand@free-electrons.com>
 <20170318075509.3836-6-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1767729686774295048=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 475E0266D9D
 for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2017 12:38:45 +0100 (CET)
In-Reply-To: <20170318075509.3836-6-mylene.josserand@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@free-electrons.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com, wens@csie.org, robh+dt@kernel.org, alexandre.belloni@free-electrons.com, maxime.ripard@free-electrons.com, thomas.petazzoni@free-electrons.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1767729686774295048==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="khoz5vzgjobswrzf"
Content-Disposition: inline


--khoz5vzgjobswrzf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2017 at 08:55:09AM +0100, Myl=E8ne Josserand wrote:
> The digital AIF interfaces has been renamed in the sun8i audio codec
> driver so the audio-routing in the device tree must be renamed too.

Given that these are fixes it probably makes sense that they all go in
together, can I get some acks for this and I'll apply it?

--khoz5vzgjobswrzf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljPvygACgkQJNaLcl1U
h9Bv4gf7B4+sEK92GchYSfvw5VGG1Gw8FC0alTWe9dtwPNTMDvX6nesBOi/TYuVR
OAust7EDvCyRv256cA1wPbYUfpW7h5aL+45hXKHnAa6rPH8A/kRTSmiB1wyd2mIC
fWZMPwRcVbAHb+6VinDSUqSw+R8V9/niYNkvEs2KZKZxnG5DwxPY2a5vQu/fGlqx
zQsCKz6DbvLueKN/h7QAhga23vfuYtva7y9wjci8Klit347MXFcabmA7Q61AipUz
M7zKD8JxziaKgNgbK8FTfxjpJiZozbe+zMTU1rj3ACHyqsRNBcPMuPbSr0lCKInl
2zw/tgN5pJfUcmkwDh/BqjA3DHtydg==
=HYYF
-----END PGP SIGNATURE-----

--khoz5vzgjobswrzf--

--===============1767729686774295048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1767729686774295048==--
