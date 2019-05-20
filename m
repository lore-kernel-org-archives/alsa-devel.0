From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: Intel: sof-rt5682: Few minor
 fixes for AMP SSP and codec button
Date: Mon, 20 May 2019 13:31:14 +0100
Message-ID: <20190520123114.GA10827@sirena.org.uk>
References: <20190518183009.13359-1-pierre-louis.bossart@linux.intel.com>
 <20190518183009.13359-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1520501915821710657=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48881F89618
 for <alsa-devel@alsa-project.org>; Mon, 20 May 2019 14:31:25 +0200 (CEST)
In-Reply-To: <20190518183009.13359-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: tiwai@suse.de, Sathya Prakash M R <sathya.prakash.m.r@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1520501915821710657==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 18, 2019 at 01:30:07PM -0500, Pierre-Louis Bossart wrote:
> From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
>=20
>     This fixes:
>     1. BIT mask for AMP SSP was incorrect.
>     2. The RT5682 codec button mapping is corrected.

Indentation is a bit weird here, and these are really two changes that
should be split.

> @@ -519,6 +520,7 @@ static int sof_audio_probe(struct platform_device *pd=
ev)
> =20
>  	/* compute number of dai links */
>  	sof_audio_card_rt5682.num_links =3D 1 + dmic_num + hdmi_num;
> +
>  	if (sof_rt5682_quirk & SOF_SPEAKER_AMP_PRESENT)
>  		sof_audio_card_rt5682.num_links++;
> =20

and this is an unrelated indentation change.

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzinhEACgkQJNaLcl1U
h9BnYgf/bGq8I2zFlJlvsMY65l3WK4CtzIZPewElK8MjJyt6vFJdWUXozUsOuACJ
irLFbnpDssRTTUBL1mTQlWjPrRZLvbEtNukQBNBLTXUKItwZ1CVv9kuj4Lzxkir/
rjO4nBLTb2DYb6VgwvSyAkBiM/lzv9s9OEkdCPwETTU+xcrGAmkOiox+hb7P+obW
zVASvuKqha5Rr5Y/spjxUphgdtaw5TXJtPLLsgTrBE4OQUo+pohfN/vOvduYHp6e
6PWuNNJW1uu6AnUJC19NfLCpy5IodOSInzYw7BfK7kyZjgUmS2B931ZcuvCQnV4O
kjaREIylE53thMsI17oW6TEP24A1NQ==
=PBzd
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--

--===============1520501915821710657==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1520501915821710657==--
