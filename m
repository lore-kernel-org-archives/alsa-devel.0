From: Mark Brown <broonie@kernel.org>
Subject: Re: query on upstream ASoC driver split across SOUND
 and DRM subsystems
Date: Mon, 3 Aug 2015 17:19:05 +0100
Message-ID: <20150803161905.GA20873@sirena.org.uk>
References: <8A8837939561D241AC8141C31522BA68291E33F9@SCYBEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7841438325949483903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 66E702652FB
 for <alsa-devel@alsa-project.org>; Mon,  3 Aug 2015 18:19:15 +0200 (CEST)
In-Reply-To: <8A8837939561D241AC8141C31522BA68291E33F9@SCYBEXDAG01.amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bayyavarapu, Maruthi" <Maruthi.Bayyavarapu@amd.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Vemuri,
 Murali-krishna" <Murali-krishna.Vemuri@amd.com>
List-Id: alsa-devel@alsa-project.org


--===============7841438325949483903==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iRomnA/8S0UoJbe2"
Content-Disposition: inline


--iRomnA/8S0UoJbe2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2015 at 06:07:51PM +0000, Bayyavarapu, Maruthi wrote:

Please fix your mailer to word wrap within paragraphs, it makes your
mails much easier to read and reply to.

> I want to send AMD ASoC driver for review. =20

Please just send the driver for review using the standard process
covered in SubmittingPatches.

> This driver has a dependency with AMD's 'DRM' subsystem components,
> which are not upstreamed yet.  Please suggest, whether this ASoC
> driver can be upstreamed via 'DRM' tree or any alternate approach is
> preferred.

When sending the code for the two subsystems please make it clear (eg,
in the covering letter) that there are dependencies, it may make sense
to send one patch series to both ASoC and DRM.  Exactly how this is
handled will depend on the nature of the dependencies and the code,
we'll work it out as part of the review.

--iRomnA/8S0UoJbe2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVv5R5AAoJECTWi3JdVIfQKFcH/3U4H71OxfY1PPt5K1cbBzo6
h/DsD9JxRpI+d491aeG1DX0g0N8m5AD/NSzRepVLmuJ5I9adrN1KpYE/nBv6xI0M
I2ljV5I/fYVSQ7ESA4YDkr5Lz9B6eyoarYLO/im5Du1Qcqdzfu864ZTcQPBjSjq1
z6eNKvm50Fy3v8SyHuHm3gqXUOPGO3FliXL3Cxv/PkfHfGDOVTnwnemJBByETr18
wfsd+AUbfWfYJQOQJoKbh6fZmXK06sDyYlOOoxr2fGpKkfzs0NKQTbUqaXYb5ieb
rGCUeDn+7ia5mA/zs9R6Ku6kVmU0kREGCuBhGthnsHvVNdzfRuTHFQHAgMJShEA=
=S3xG
-----END PGP SIGNATURE-----

--iRomnA/8S0UoJbe2--

--===============7841438325949483903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7841438325949483903==--
