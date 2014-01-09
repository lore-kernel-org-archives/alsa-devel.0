From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 10/11] ASoC: ux500: Don't set unused
 struct snd_pcm_hardware fields
Date: Thu, 9 Jan 2014 14:30:53 +0000
Message-ID: <20140109143053.GB31886@sirena.org.uk>
References: <1389014356-7014-1-git-send-email-lars@metafoo.de>
 <1389014356-7014-10-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1962142613338586642=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A9023265463
 for <alsa-devel@alsa-project.org>; Thu,  9 Jan 2014 15:31:02 +0100 (CET)
In-Reply-To: <1389014356-7014-10-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1962142613338586642==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b4xLOZqem4/iQGQ4"
Content-Disposition: inline


--b4xLOZqem4/iQGQ4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 06, 2014 at 02:19:15PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--b4xLOZqem4/iQGQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzrKaAAoJELSic+t+oim9lhYP/jeig0R/v9U3/33FxJWrcN+S
B6etzSIYhoj5CdcTdOqw8MyoAAxcOpj+wYtQ0QCkXF+b0N82/3f/UwVtleB7+JpF
jBAxhaUhXkLnYL90lXM0zcPv3BjNOzXCNHBG8cl5JHFbvVxIXd25c89WTJBHqwsr
igfiKSu1rRTIMCIU1YQXYP/MuABCXvB78Qj5EWIHoxBV+qpkiaQJKYZ7BIggTZ6a
QgO9Qsk3K0TUslUxBWzellvtrGdxgilX8KOOy9aytsfdKtD2nb7rIg8vPTZawUDz
/lR152cZqEagIP5WDsbIIoqhH8UV+RHMBcK7eWDWqB43i1cjjxUxolldp7E96CNr
4zEzt3eEWuB4BK0P2NTog7IiJtJcdDYOvZcKTHESIxpBXxbXzTMBLtOUll63IqPC
heY3Ei2vvX/I7/LCkRojfDB3KaNWanUFPJ7wqOLMX8BQenIDUAGLSx27f1CtlKLV
f2hDJfQqGRy3VCYoTHxMuDJs0tN/HTABobU4TAX2HyDGtoeDdghrGREJ1gWbwSMV
Y08nfgEXjvvnIalGS57CHDXV78O8ndGFBuICJP716Hvjv4za9QZef+DxOBSb82/R
2+CMivG1G9e3gvoRfIDgYcOAD5Nw2sKGXWiolA129Qjkc/HgNKZlZlzz3iBdi8tA
tCsq2LQKf35yErdk1dre
=px3Z
-----END PGP SIGNATURE-----

--b4xLOZqem4/iQGQ4--

--===============1962142613338586642==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1962142613338586642==--
