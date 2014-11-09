From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Forward calls to
 snd_soc_cache_sync() to regcache_sync()
Date: Sun, 9 Nov 2014 09:07:34 +0000
Message-ID: <20141109090734.GI2722@sirena.org.uk>
References: <1415461087-31162-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2820582233761481949=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0C1542604DE
 for <alsa-devel@alsa-project.org>; Sun,  9 Nov 2014 10:08:58 +0100 (CET)
In-Reply-To: <1415461087-31162-1-git-send-email-lars@metafoo.de>
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


--===============2820582233761481949==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MPkR1dXiUZqK+927"
Content-Disposition: inline


--MPkR1dXiUZqK+927
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 08, 2014 at 04:38:06PM +0100, Lars-Peter Clausen wrote:
> For convenience for drivers that do not want to keep their own pointer to
> regmap struct around forward calls to snd_soc_cache_sync() to
> regcache_sync() if the driver is using regmap. This is similar to what we do
> for snd_soc_read()/snd_soc_write().

Applied both, thanks.

--MPkR1dXiUZqK+927
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUXy7RAAoJECTWi3JdVIfQ5BEH/R3ojrp/x1ntT2bgQ5LZLb7Y
qxlwCMFYGv5NjtD1ueGyoHm1QW7lXvJGiG9ipgrvEKhh8Z7Y8UhvOuP0ByfRa77F
JE72ItE9ZBJVcyVaofirt9k7PH+8QYFfosY22ntLXIWpqyL+V4X2oAY4VVL9arsu
Ge9U+Up7uIA3dyTCuIi4yZ/IVbuyO3k9reYFMljH/w10yn8Z2bb/p3J7Jz14LhDW
4RN3mE/3hbk/e0hYxbv+Sa9020eHaQQr0EwsmwbZFjgDazjWToYYALgwBZvgsy4y
tp2bYosbZY29RodiefUxXJk91Uu5wNpHocY/v67F+IuUtcjBBpFoM6qlcnVDrUI=
=hOaN
-----END PGP SIGNATURE-----

--MPkR1dXiUZqK+927--

--===============2820582233761481949==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2820582233761481949==--
