From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: change widget sequence for
 depop
Date: Mon, 5 Aug 2013 18:58:04 +0100
Message-ID: <20130805175804.GY9858@sirena.org.uk>
References: <1375676343-13891-1-git-send-email-bardliao@realtek.com>
 <20130805144808.GG9858@sirena.org.uk> <51FFDF11.5020106@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8985473258627294253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A6A6265146
 for <alsa-devel@alsa-project.org>; Mon,  5 Aug 2013 19:58:09 +0200 (CEST)
In-Reply-To: <51FFDF11.5020106@metafoo.de>
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
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============8985473258627294253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dvMBd3vrkFFfaYcy"
Content-Disposition: inline


--dvMBd3vrkFFfaYcy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 05, 2013 at 07:21:21PM +0200, Lars-Peter Clausen wrote:
> On 08/05/2013 04:48 PM, Mark Brown wrote:

> > This looks like you should be using Lars-Peter's patch for controls that
> > are disabled while a widget isn't powered - as far as I can tell from a
> > quick read through all this does is keep the speaker/headphone muted
> > while the outputs are powered down.

> The driver is using stereo controls though. So either support for stereo
> controls needs to be added to DAPM (which shouldn't be too hard) or the
> control needs to be split into two mono controls.

Yes, I think we should get the stereo support done - this sort of thing
is the main use case I can see for it.

--dvMBd3vrkFFfaYcy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR/+epAAoJELSic+t+oim9G+EQAJ2UHhya0XKjlsZVczAm/k/q
7f9XknoYF56RE5pRmcLk/qiuH9G/PKxQrM/7/CPHMdFGgceENgRgmSl9hQOifFM8
e/jDeiWyQoxaY0/YuNrfTk3ov2w4mSz1PqFiXLfXH7LYboAF+XSdHOL/DUEBrMCb
pS3+PEHr+YMgoxuZmDy7jSkdw34KVY82GSpmB8xyk01E4FYZsFKqAK0oJz7M0UmZ
kM2HJE6v1RXn/vfrZaLT4doKAn2K4f1K3oBrFSiJm9EpW2hg8+4qOxO10DuEHLmv
nP7Tee9yAfhdi/xduMh0BImkAR1inQiCJiXXyauSjnTnRTQBH0fIeGWn2Ash6vn6
5Oa/TlYD4f9315UzYfzzXIwRuQR006IVnR6tsV9xQDc2o8+uRqA+/EViUUxozlMz
XJOAizPojOz1j9GiWER6+GsT152uCbzAI3qPmk3YAVV6NnNePjnMiKbn7sQlQDJx
PgZy6Ij3G/fJ0EHU1KvHnhWMROco4BYxf2KUeflbOj/O+0s2BLRgvEKONucY9Xhi
fPsM5rbm9tBM2RC4XLwCeN47dSYPA0Kv1Igc9u0PHL55AY+g7PwxFkBXB9IJIy2B
qabBWGV0ztgJr4jyI6ds27BnYUffQcnjg+JC15UW1XinvdhY01YLIHPe0ijIlOkw
uCZdvM+XOI8vkZv3BcoE
=WuR1
-----END PGP SIGNATURE-----

--dvMBd3vrkFFfaYcy--

--===============8985473258627294253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8985473258627294253==--
