From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 1/8] ASoC: wm8731: add rates constraints
Date: Tue, 30 Jul 2013 12:28:16 +0100
Message-ID: <20130730112816.GO9858@sirena.org.uk>
References: <1375178392-26060-1-git-send-email-richard.genoud@gmail.com>
 <1375178392-26060-2-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oDAgBPM9EGlsVGM3"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1375178392-26060-2-git-send-email-richard.genoud@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--oDAgBPM9EGlsVGM3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 30, 2013 at 11:59:45AM +0200, Richard Genoud wrote:
> Depending on the mclk (or crystal) selected, the wm8731 codec have some
> constraints on its data sampling rates:
> e.g. with a 12.288MHz or 18.432MHz crystal, the authorized rates are
> 8KHz, 32KHz, 48KHz and 96KHz.

Applied, thanks.

--oDAgBPM9EGlsVGM3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR96NMAAoJELSic+t+oim9T2YP/0Sn+3UTvQIYDAuuIT4N6Xl+
hony3W8MhyVADSA6/0xgeYHrw7J1tBxsaZxo0bpxqIMcAjO7vA8WTr58ZmjhNfRb
zSiuCy8h7Zsdk1jbVCvqfJfkT7Lovzy5d4Z8evBq81Q3NWzCZJwg4FXgwo2uq/7s
AoouygyzQgNMujJythkoNIkxqoTBbBR1rsUiS9HioOcsXiG5h/ZI5Z66FpKnl8gg
xIKkJLEQxOIIievwQ9NYcUAAkNrsYEsKoOrkTzfqU0XIkLgJf9fgH7k7lr3v3bWJ
aEc6HWXdIvV5DiakX4b66nFqh6pd02SroPG+bEMiZpNRXxphbN8vlID5La3ohsdm
HIQnMiWMKEZd1lX8du7IZ1r5HaEobiiNcN0PugbRSoqupS7qd6rhzyxAv9ERXMDm
J4KxePbwEEgSv33d5GCcIn2PMagkCwvuTNlzHHLZb1QTV1EYaukL2ZWBw1cnNqEf
V9r9Qka8LS+dtAJG1cD43m/knqhFZrfDflMLHe4RjXnbZXhKcKwJDiiQQsbCEiLO
86Z6Qgbxsdq8kqmIyLlrKxBeRBZGzmtbUYW1yyGWaLpfAZw9exmSWGO/jzfkWY6p
lqmXHcAJ+yCZgT9FQXASi+6kwpAt8UPpqJ3k/ZJtAclehqShZ8ddUeXXwabBTmB8
3IXRmxOBqJXUWTMKY6fl
=Eln0
-----END PGP SIGNATURE-----

--oDAgBPM9EGlsVGM3--
