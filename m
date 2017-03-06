From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10] ALSA SoC MAX98927 driver - Initial
	release
Date: Mon, 6 Mar 2017 11:35:50 +0100
Message-ID: <20170306103550.wwxkbhvizbrgdthd@sirena.org.uk>
References: <1488552768-14901-1-git-send-email-ryans.lee@maximintegrated.com>
 <1488552768-14901-2-git-send-email-ryans.lee@maximintegrated.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3877185005444369442=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D5015261740
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 11:36:53 +0100 (CET)
In-Reply-To: <1488552768-14901-2-git-send-email-ryans.lee@maximintegrated.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ryan Lee <ryans.lee@maximintegrated.com>
Cc: mark.rutland@arm.com, oder_chiou@realtek.com, Damien.Horsley@imgtec.com, michael@amarulasolutions.com, kuninori.morimoto.gx@renesas.com, arnd@arndb.de, yesanishhere@gmail.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, tiwai@suse.com, nh6z@nh6z.net, lgirdwood@gmail.com, petr@barix.com, alsa-devel@alsa-project.org, jacob@teenage.engineering, robh+dt@kernel.org, bardliao@realtek.com, lars@metafoo.de, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============3877185005444369442==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ohltba6jdxnpkvzg"
Content-Disposition: inline


--ohltba6jdxnpkvzg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2017 at 11:52:39PM +0900, Ryan Lee wrote:
> From: Ryan Lee <RyanS.Lee@maximintegrated.com>
>=20
> Signed-off-by: Ryan Lee <ryans.lee@maximintegrated.com>
> ---
>=20
> Initial release of ALSA SoC MAX98927 driver.

The rest of this patch series appears to be bug fixes to this driver.
Please don't submit things like this, if there are problems with code
you're trying to add then squash those fixes into the initial patch.
Otherwise you're making it harder for people to review the series by
sending code with known problems in it.

--ohltba6jdxnpkvzg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli9O4UACgkQJNaLcl1U
h9C/0wf+LAR36MZR8HKNAffJtN2chCa2ckH8xcCG7W8COZDMjG2U1Xe1VeY2/5hn
msZFExtrBHqQiUpZ9mQh6HEq/Q4c0oxqT0LgbAQCxXjMeT8+dDGSsz9/UY4G3wsp
9NHXbrFLzn5vbPeVknyhqUh8zRLbzie2zX478XA5PpXib7wbL29tXDBPCCOIiEzi
8OLGrY5c8pGLPueASmkwzTu3LCvcjTNDPyIxAaIe3CxEK6d72FQNEHyaKDxGL1lV
RTN800cJ16vl0AQtCu7Yifq4zaxlhKKPra+lK+OS3Wc/rtqgF4MvspSCxZ4NrYeD
qbm20DylNiZEtjDkEkTpA/IVY3EPlQ==
=WWUL
-----END PGP SIGNATURE-----

--ohltba6jdxnpkvzg--

--===============3877185005444369442==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3877185005444369442==--
