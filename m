From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: max98090: sync regcache on entering
	STANDBY
Date: Wed, 12 Feb 2014 19:56:38 +0000
Message-ID: <20140212195638.GN28112@sirena.org.uk>
References: <1392229494-29761-1-git-send-email-dgreid@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3893782425015829818=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BEEA926084D
 for <alsa-devel@alsa-project.org>; Wed, 12 Feb 2014 20:56:45 +0100 (CET)
In-Reply-To: <1392229494-29761-1-git-send-email-dgreid@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dylan Reid <dgreid@chromium.org>
Cc: sachin.kamat@linaro.org, alsa-devel@alsa-project.org, jerry.wong@maximintegrated.com
List-Id: alsa-devel@alsa-project.org


--===============3893782425015829818==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ukW6Wv09KNCUAh1u"
Content-Disposition: inline


--ukW6Wv09KNCUAh1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 12, 2014 at 10:24:54AM -0800, Dylan Reid wrote:
> Sync regcache when entering STANDBY from OFF.  ON isn't entered with
> OFF as the current state, so the registers were not being re-synced
> after suspend/resume.

Applied, thanks.

--ukW6Wv09KNCUAh1u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS+9HzAAoJELSic+t+oim9wYUQAJc3UXKbu0/eQjn+ntAeJ5lJ
WnvPe/rfk8uHTmFZ0FEDOA3hdQ41Y286cCz0FsIorwc+Ud2WaylYB6mYoZgCNjAV
pPqKE5DKP3TKlvhFfroiF8Htxx8O6wgM8PB7IK8n3yWRiaGnEoqAlu7/H7rjT2fC
ksEaIdSQLkbV417c2pn0HJHpgNjwigwqSajSZo1NgcW8FB8xA5oS6XxDK1Kp2X/T
G8Al0qZxJSWDXjeJQqHyfbN2f+s2xMN/WaBlrnF6HXIaidZ3prfUy7ntZi/Fh77h
AwuRP7o8NLMH4ZSZqotoTepgRNECXCmctC7AdL7GPDpAkb05+3J6EgNsdDz5MRnW
wr0r9G8tBon460MyzeYzk2ZnqUD4zvYDRTtjojZCju6c7Hs94kxvjt0MS9e8OTFy
LP15bV3elMHIfFnbRUZcFNuwc3V7aNuMkTDO7sY7VuXBt01B4kx9PvvDXvlzQrJ+
ArznIcxpySPsrLApSdQu95hK0PSxB41bZV4x0Vp9QgLFNfGpsj372pUYiXGf0Zif
sd/ROib8RPj5/HxEqBdUGocCl/qbUPzAg6IyX+RPaYjdCf24PSwMimbJFzUNpZV4
WVeVDK+kgcvyPRllTCE/qXNZp+W/fpEy10eqWe/10EYcIOZD/6mi+d4VOdcavHk2
NbYxe8EL+9gf+Rzoby+6
=42N0
-----END PGP SIGNATURE-----

--ukW6Wv09KNCUAh1u--

--===============3893782425015829818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3893782425015829818==--
