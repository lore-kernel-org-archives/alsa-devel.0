From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 2/2] ASoC: tlv320aic32x4: Add rstn gpio
 to platform data.
Date: Thu, 1 Nov 2012 14:35:15 +0000
Message-ID: <20121101143514.GJ4413@opensource.wolfsonmicro.com>
References: <1351680814-13714-1-git-send-email-javier.martin@vista-silicon.com>
 <1351680814-13714-2-git-send-email-javier.martin@vista-silicon.com>
 <50913851.6060003@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3016175642146605217=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 20436261794
 for <alsa-devel@alsa-project.org>; Thu,  1 Nov 2012 15:35:16 +0100 (CET)
In-Reply-To: <50913851.6060003@topic.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, Javier Martin <javier.martin@vista-silicon.com>, w.sang@pengutronix.de, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3016175642146605217==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AwgMNpd3VkAVXjS"
Content-Disposition: inline


--7AwgMNpd3VkAVXjS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 03:40:17PM +0100, Mike Looijmans wrote:

> is a very nice power saving feature. I just cache all the register
> settings up until that point (which required a bit of coding because
> of the "paging" of the I2C address space).

Probably easiest to just convert over to regmap, it handles paging fine.

> It was the best I could think off at the time, and it made me wonder
> why those reset lines aren't modelled this way more often.

This breaks down if any of the drivers actually uses the reset pin to
reset the chip - if the reset might not actually happen but the driver
wants it to happen then things are going to go wrong.

--7AwgMNpd3VkAVXjS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkoibAAoJELSic+t+oim9hOYP/iMTc88gKOBsfOhkeNd2dCfr
wpDkONCtDGEOEAjx5/uPiHhqllRiIHHyPlsHDnIxHO4e9AMYGHFL2+JNCOBybX3U
l8tEJDdUG1LmH6f2pbvvbk9eFZP6P0yuAQjlopfsxpNLAUP9vFeE9UTwLq/DlFMA
0EFemRS5z2PkUwU1/BlS9mrF6Tl5c4+Z/zM6/tUI4ie+yB76vLk9P66O80Ml2oTZ
CQCvY3KYKIIfcFZ9IadISONv3K1rT1LuRCj5jGjdWFnRubGaGrT5tdVr0928PiFI
kFG4cGSJEZknZMbsT0fQurEvXPyotDn8otmYOXGxgnDSp410TQ9kc8Ld+avUhC7a
zUAQuew/yszAWmCGwe73JXicmEaT4TjRvbPlpQiM9srrZNuMeT101mX7LCDFk2Fs
ZXP8KPqazUTM8HK+3LFOPa+LtJM8H7RSp21p0Gq3SzEk6XGFh1GTi9l2I7zjDn7t
Q2VenqvUjLa+GBLM2Trhr7ffEVaeBkBU6BZU6IQrOv+Xn31UnGX9T3299+0PpXQ6
MB30/xcI0lXMQeGkEDL9jc2uqKlrPwQ4o+vrJt4H+s+pwHPagu2372fX3SMi/auI
u9RkVL0iRStwSB6Azb86jz6Vvf1crk5J9WO0c5ci4UeiWYqFmnblNfzlq7mf3eiP
xeI4y2u8RNqT6aBCWX2e
=UuBn
-----END PGP SIGNATURE-----

--7AwgMNpd3VkAVXjS--

--===============3016175642146605217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3016175642146605217==--
