From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/12] ASoC: dapm: Only mark paths dirty
 when the connection status changed
Date: Wed, 22 Oct 2014 12:00:12 +0100
Message-ID: <20141022110012.GQ2344@sirena.org.uk>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-4-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9027491291095194752=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2EDE261B11
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 13:00:39 +0200 (CEST)
In-Reply-To: <1413826604-3212-4-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9027491291095194752==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OxDG9cJJSSQMUzGF"
Content-Disposition: inline


--OxDG9cJJSSQMUzGF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2014 at 07:36:35PM +0200, Lars-Peter Clausen wrote:

> +static bool soc_dapm_connect_path(struct snd_soc_dapm_path *path,
> +	bool connect, const char *reason)

Why is this returning a value which is then ignored?

--OxDG9cJJSSQMUzGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUR448AAoJECTWi3JdVIfQXqMH/2n81aMKSzIcz+DudWxkGfTw
ArxXJDlYp+o3B9Zu2djYa6/J6F44VyOMQM7rUAhS21aPJZVW2svp/yFeB/nmO/6Y
NJrY/eZ9yBsnWXWUe4VIzTwqELlTygmpYC1zfrBNJPQGRpvnaHA9TrkD2zCNAeke
MLJ0lzEuviILI+ZdFHja/QOfSm4GZMyHD7KLWoDwe/LO/yxZVbUUu0VUCAZcqrHd
vi+ywGuCjW92uB2rARnRjzjpLU5/zt+clVTn+G2i2OwbHYnW+8PV0CqDvRtsu277
mQwcMeu4PvAuAGgs8N+rFZ6PYDmEUfGWlOoJqXleKCM9Yh4+JvNP5WPVNd5EdUk=
=OlPC
-----END PGP SIGNATURE-----

--OxDG9cJJSSQMUzGF--

--===============9027491291095194752==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9027491291095194752==--
