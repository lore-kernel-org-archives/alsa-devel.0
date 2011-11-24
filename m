From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 8/8] ASoC: SigmaDSP: Add regmap support
Date: Thu, 24 Nov 2011 12:30:39 -0500
Message-ID: <201111241230.41331.vapier@gentoo.org>
References: <1322138908-32127-1-git-send-email-lars@metafoo.de> <1322138908-32127-8-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3691578.OYq3FtEnBR";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322138908-32127-8-git-send-email-lars@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, drivers@analog.com
List-Id: alsa-devel@alsa-project.org

--nextPart3691578.OYq3FtEnBR
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit

On Thursday 24 November 2011 07:48:27 Lars-Peter Clausen wrote:
> Add support for loading the SigmaDSP firmware using regmap. This allows us
> to transparently use SPI or I2C as the transport protocol on devices which
> support them.

Acked-by: Mike Frysinger <vapier@gentoo.org>

> For now we keep the old I2C support since we have one user of this which is
> not straight forward to convert to regmap, due to variable length
> registers.

add a Kconfig knob so it's disabled by default except for the old codec ?
-mike

--nextPart3691578.OYq3FtEnBR
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOzn9BAAoJEEFjO5/oN/WB390P/2IncVzoq7EjB6HXXt22LZFE
m8Y+cEUQoz4ZWBeNqg3jryc+u4O+dw82t5KXre33ZYoQ9xGtD1S47j8+w15aiubc
B5B34LcZaQ8LK8fvekxWSwmk8Q4/N/268OvevGGSsDYVFkZnYhIqyIgDfYOlxEz6
g6QL3crmNvxwKg3/NA1GUr89UkL2YEiDgwKm9yZJSKM/yCbtmlltTMNLsDpuJJac
LawqoHSRCxQzvqNsScmdvwnu6CZP6BMwIlmXXAY6PV+ypjcMuDJA/r6pk1AzmZn9
105LQUMkGyzMQdyaQ2gRKKoe6EgNqaJleogBbHed0cQuGBmmgO5Tj1PWd1A586vW
3GP56DMkghItz/yw+3W8LuQDYeKrVf4TQr1uRGyb094H0mvjLFlCFFBN6Tc1cpky
na7S5bxubpSzptEkBNhnx3r48XyMx7Myk319hiJt4KMru7v2DdAB7NhNTgDVU6Y/
PkZgJZKo77k9gq0JY/jCenqh/1NpgOFTaMOYgMHlfC9QFsQZG5FqhC1X3OcFMuU5
+pkv7SD4Y+rZ04/RagBItSQUNk2Ic0n5p71xmnJGwNznSx5eSnteG7UTrt6lzHtb
d+bcRjkfEHoV7dYuQXU+hVTeKvLFCT2CBkRooMXR+AV9qjO+j0o6QLSRpUjQJhAk
SUvY3qQ+oZWBfZlNscFM
=goWU
-----END PGP SIGNATURE-----

--nextPart3691578.OYq3FtEnBR--
