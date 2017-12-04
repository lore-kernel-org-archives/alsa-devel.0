From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: amd: added error checks in dma driver
Date: Mon, 4 Dec 2017 17:54:19 +0000
Message-ID: <20171204175419.kejdshqwqgg6lswv@sirena.org.uk>
References: <1512400584-28170-1-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8723422601833480947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FB51266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 18:54:21 +0100 (CET)
In-Reply-To: <1512400584-28170-1-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, Alexander.Deucher@amd.com
List-Id: alsa-devel@alsa-project.org


--===============8723422601833480947==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6gocbygrhhvlmexq"
Content-Disposition: inline


--6gocbygrhhvlmexq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 04, 2017 at 08:46:24PM +0530, Vijendar Mukunda wrote:
> added additional error checks in acp dma driver
> v2: printed error codes for acp init & acp deinit
> failure cases.

Don't include noise like inter-version changelogs in commit messages,
add them after the --- if they're important as covered in
SubmittingPatches.

--6gocbygrhhvlmexq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloli8oACgkQJNaLcl1U
h9AvUAf9GrLg1v5hzqCydKkFJpJMuLylqleff63JtohGe9NmT9nTsst+jUpbDPvl
HBQapGecyEsSMau4rMfLetoIH6O53QWpk0aBT3mmi+R9jp5vy3USZZxdReH7NnRP
8nh7JXO8ZSMo8rj0NvO1zMtToIhPod0SOoDXMlEqpmWrijmi9rq/6sB3y/pd8CWf
yQRpFqJTr+Yos5omz4+IttrzOeUeGkGJv7o1kETJnXcbkYnI1NCHzmalAnV5+Yzu
GgKg7aEv/3UDLaLSM7q8qukjpqIeMxa8YPMJvNnzM0jC1qV+p0zeuudk4mY+7ewF
NRNjq1yaPlJ2OATt6Ab5DwPv8pIqfw==
=E854
-----END PGP SIGNATURE-----

--6gocbygrhhvlmexq--

--===============8723422601833480947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8723422601833480947==--
