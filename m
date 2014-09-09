From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/6] ASoC: cs42l52: Cleanup manual bias
	level transitions
Date: Tue, 9 Sep 2014 21:09:03 +0100
Message-ID: <20140909200903.GK2601@sirena.org.uk>
References: <1410288165-32127-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4048715885104977825=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 153A92652F1
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 22:09:33 +0200 (CEST)
In-Reply-To: <1410288165-32127-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============4048715885104977825==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zFjDrgRWvOv91yyn"
Content-Disposition: inline


--zFjDrgRWvOv91yyn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 09, 2014 at 08:42:40PM +0200, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied all, thanks.

--zFjDrgRWvOv91yyn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUD15cAAoJECTWi3JdVIfQ4EYH/026V/+LtZP+DVZ4QUOkHdLa
ocertswEMHPY9SJwF+pqSLS+a1mVeLG1wZRmn2yE33qzMbUXxdR4YflKAcFHRMMo
wOdK/e+xlcBCnlCOvqzGtD3t61zB+EqHFiBnshJnltuXa8oVpMcOAKM/E0bL9gou
X4Uux1Um0lM0WdSGIRKhhiZC1vtKvq7D5Fd5om7Qc8MxO7FqD8BTBfmoy6Ese9Sh
lp+65tD53M2Q/i8qqhAcSpY9OopddU+bt/MoB70NZJQzaUpVNnvDhNxfZckMQwNG
N0AgfMsCjmH7hMZVSl4sHvkDFI7WuxlrZ6cZ/otQlsyEVEnAngibpdSZPLjcRqw=
=XuRg
-----END PGP SIGNATURE-----

--zFjDrgRWvOv91yyn--

--===============4048715885104977825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4048715885104977825==--
