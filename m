From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: davinci-mcasp: Consolidate
 pm_runtime_get/put() use in the driver
Date: Fri, 31 Jan 2014 16:20:03 +0000
Message-ID: <20140131162003.GM22609@sirena.org.uk>
References: <1391088092-4157-1-git-send-email-peter.ujfalusi@ti.com>
 <1391088092-4157-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5945546767508419410=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 74371261B19
 for <alsa-devel@alsa-project.org>; Fri, 31 Jan 2014 17:20:10 +0100 (CET)
In-Reply-To: <1391088092-4157-2-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, Liam Girdwood <lgirdwood@gmail.com>, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5945546767508419410==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="90wTzOiXAbbhNsuN"
Content-Disposition: inline


--90wTzOiXAbbhNsuN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 30, 2014 at 03:21:30PM +0200, Peter Ujfalusi wrote:
> The use of pm_runtime in trigger() callback is not correct and it will lead
> to unbalanced power.usage_count.
> The only place which might need to call pm_runtime is the set_fmt callback.

Applied, thanks.

--90wTzOiXAbbhNsuN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS680wAAoJELSic+t+oim9We0P/AtC1UvOGtkPSAjJT00lfsvp
pHi/6108sPErbD+0S/9Mfq6Zjzym/Eez/VVUrjAQo7030nVtD4gyYDxZPQMCTpQQ
8QHsN6Xa0VnPkXZEczxfsRijLlkVx+tFqt9oObSONfD6xP52acwpCkdD2L6UVWBh
s2Dq2KW77aUPwXI+cy+X9oO2H05gv6RPOeJ28SnE7uKZBbrcKjBnaaXSUxmUbtsR
GmdV4q9FdBqtwJA8H/3xwxrCdc4syGzURl45y77aGaZcIkMOdu8gCai1SLs/mt9w
6lkFD1SVJ7m3B0kHPdA7a7y2merqUQ5TLA5Wp/sloQO9YhffzDKSEyc3IZ1MZjfY
AsuFDq3dNsqwpZwcsFQtofsPqjSvd1W2L4/KKBXSSwmp5bAKheP9M6Fbg+RDhQll
P4JlfB4g9lJc3fXAaGWoAaWIF76q1vuW86Z8duy9IDSbhberL2kePwcLRjJSgbTC
udYoOa6j0MDygju8J7jrw7p8n+hsL0ezqORiazzH75BomfS/KqT0c5XWnhWt3DIi
Q7+Z2gApl3Ms4otrodAdkkxeW7rsRmPuoSeajXulhrr6g0YvIW1d9C3kVtsw4DLD
z1mu5MYaQHpeaeiakmq+PHDHqyijGGRCF2oHdyuWozmbjgb5uhSSOItBzoid4kkQ
4G4rOStCTAft0gWbQiNf
=gP1E
-----END PGP SIGNATURE-----

--90wTzOiXAbbhNsuN--

--===============5945546767508419410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5945546767508419410==--
