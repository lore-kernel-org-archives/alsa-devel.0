From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] ASoC: Intel: Use acpi_dev_present()
Date: Mon, 25 Jan 2016 15:48:46 +0000
Message-ID: <20160125154846.GV6588@sirena.org.uk>
References: <cover.1452787340.git.lukas@wunner.de>
 <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7240267644842670397=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BCBF260535
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2016 16:48:53 +0100 (CET)
In-Reply-To: <04b22878b2fa0a00bad68e1570502fe64f94fb25.1452787340.git.lukas@wunner.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lukas Wunner <lukas@wunner.de>
Cc: Vinod Koul <vinod.koul@intel.com>, "Fang, Yang A" <yang.a.fang@intel.com>, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7240267644842670397==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AtbDb7UtNxn9t/R3"
Content-Disposition: inline


--AtbDb7UtNxn9t/R3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 14, 2016 at 09:57:20PM +0100, Lukas Wunner wrote:
> Use shiny new acpi_dev_present() and remove all the boilerplate
> to search for a particular ACPI device. No functional change.
> Cf. 2d12b6b381ba ("ACPI / utils: Add acpi_dev_present()").
>=20
> v2: Rebase on commit 95f098014815 ("ASoC: Intel: Move apci find
>     machine routines").

As covered in SubmittingPatches don't include inter-version changelogs
in the body of your commit log, put them after the ---.  They are
meaningless once the change is applied without the rest of the history.=20

--AtbDb7UtNxn9t/R3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWpkPdAAoJECTWi3JdVIfQPK0H/jWDlIUVYnu5Wa5sKvFoW/Tl
nQuGecpCHOsXJ22ZNxaUmV+x3Lzg28koxNvVbsSE3//mDB808SMU+BxIGI79j/tZ
Wm6r/CNtj6GVjpsZ+6MTe7UuzFGt/OumchWLEDdpZyYO2yIFpN1/+K2wxYsAq3X9
Td8365wCg9ihf34uOMWz4OclrnFcmO3BKp9teByXlbipIj9wvarJIGjKUpqR8ey1
pn4S52reI5cgj/PwwGqdN6dEkbcyANYRWsjoLzcJsIZ2OA95hs/t9VZqc7sqkyEG
qJlzJwVE7Cy1KZwvw85VbM6pniJu8CVZhgY8InbKsQVpto4fbEuZNGUaZxT/0IM=
=FKW1
-----END PGP SIGNATURE-----

--AtbDb7UtNxn9t/R3--

--===============7240267644842670397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7240267644842670397==--
