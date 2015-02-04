From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8731: let codec to manage clock by itself
Date: Wed, 4 Feb 2015 11:13:49 +0000
Message-ID: <20150204111349.GV21293@sirena.org.uk>
References: <1422934415-24957-1-git-send-email-voice.shen@atmel.com>
 <CAOLZvyE6W8-X2_M+-KQNry2VPwLzwbBLuxr5Z5EdBQo7Skv2RQ@mail.gmail.com>
 <20150203124441.GK21293@sirena.org.uk>
 <CAOLZvyEVQmqg9Jn5Kt_2m5K0-taJcGf6mweK4T=fwKOwn-Ovxg@mail.gmail.com>
 <20150203162128.GP21293@sirena.org.uk>
 <54D195D9.4090101@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tcbuYGquQqxJVSbR"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54D195D9.4090101@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>, Manuel Lauss <manuel.lauss@googlemail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Richard Purdie <richard@openedhand.com>, patches@opensource.wolfsonmicro.com, linux-sound@vger.kernel.org, alsa-devel <alsa-devel@alsa-project.org>, linux-arm-kernel@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--tcbuYGquQqxJVSbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 04, 2015 at 11:45:29AM +0800, Bo Shen wrote:

> Do you mean I send my RFC patch as the formal patch, and let other boards
> which use the wm8731 to add clk object, am I right?

No, we need to keep the boards working so we either need patches adding
the fixed clocks for existing boards or we need to have the handling of
missing clocks that Manuel suggested.

--tcbuYGquQqxJVSbR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0f7sAAoJECTWi3JdVIfQe7EH/RZaE9j/j+swdOfwTrwfHyvN
7q8bsCAv3dV6R621LkQuaALKrywcpGNFeFkARrSa9IcohQy//SHygQrlJAR4Esue
KCm+xnWjK1ljMuGp+dZag/d+GBEsQcQl4rev4N1ztDCF2LG/WfRYD1WJ5+C+/qci
CZ+GUf/k/VgCfA8Dx67jqxrwGQOfezv3UCUbrm1O2TfnIO31zZ2OrxGcoLu8EnAJ
esO8Llatk7LhXYTT1QQpO6ZpqALQMg4h0MsZOP4mfBlhD8NMh8b8ASeemMiDxsVT
kTgzUIh4YbIV7S3DgtfuqUfZZcwDWN9oTPlEwzDdof5Pqt32+WQNUJ6EfpJwk5c=
=VgsT
-----END PGP SIGNATURE-----

--tcbuYGquQqxJVSbR--
