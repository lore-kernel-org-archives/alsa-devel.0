From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 30/32] ASoC: wm9090: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:43:00 +0000
Message-ID: <20141124184300.GX7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-30-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1377421557010278813=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A82AE2657E6
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:44:56 +0100 (CET)
In-Reply-To: <1416746269-4935-30-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1377421557010278813==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJ/whQCgo58Oj3Wa"
Content-Disposition: inline


--vJ/whQCgo58Oj3Wa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:46PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--vJ/whQCgo58Oj3Wa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3wzAAoJECTWi3JdVIfQPOoH/A8tpqtNtmxoMMTn728/WqVe
yLA87DCCc84hjCHcaUJfRpdE4QJ8Psd+lKtZNj0O0/rqYKUpitKJmkVGUsubVuiR
atg5yAWhO69GABI4A9T3mG2nchaD8rodnBZQwhYvnfb24dlQqsr1kCKvsJqa79bR
AL+7jxwdXS4qlObTQ4ZDUdy7y+0kKa0qdxAk7I1k6yKEIoiff3qeVjyBvVO1avkc
Q9Oz0yoGiIr9yI8HfSpGDFywjP4aGkklXNd8v4q49hqIbV1NUy7YUi5R0Bbjwuni
ya+arzc9t05Hpt+JaZrkdBe0jqgK2MDUWLnrfjXD33ngPsuBo659V5O+TkLyip4=
=koSU
-----END PGP SIGNATURE-----

--vJ/whQCgo58Oj3Wa--

--===============1377421557010278813==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1377421557010278813==--
