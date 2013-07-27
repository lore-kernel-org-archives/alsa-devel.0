From: Mark Brown <broonie@kernel.org>
Subject: Re: Broken headphone and speaker amplifier supplies
 for the rt5640 driver
Date: Sat, 27 Jul 2013 18:35:09 +0100
Message-ID: <20130727173509.GJ9858@sirena.org.uk>
References: <51F29064.8080003@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3613825686418038278=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 591FF26167A
 for <alsa-devel@alsa-project.org>; Sat, 27 Jul 2013 19:35:16 +0200 (CEST)
In-Reply-To: <51F29064.8080003@metafoo.de>
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
Cc: Bard Liao <bardliao@realtek.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org


--===============3613825686418038278==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ad7a2iuroXS7l5SC"
Content-Disposition: inline


--Ad7a2iuroXS7l5SC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 26, 2013 at 05:06:12PM +0200, Lars-Peter Clausen wrote:

> I guess for the heaphone amplifier the right fix is to set the shift to
> RT5640_PWR_HA_BIT. For the speaker amplifier I'd assume that the right bit
> is RT5640_PWR_CLS_D_BIT. But the speaker amplifier widget also as an event
> callback in which it already seems to set/clear the bit. I think the right
> fix is to remove the register change from the event callback and set the
> shift to RT5640_PWR_CLS_D_BIT. But I neither have the hardware nor the
> datasheet, so this is all just an educated guess.

Or set the register to SND_SOC_NOPM allowing the manual sequencing which
is (I presume) needed?  If we're going to need an event to do the
sequencing we may as well have it do both writes.

--Ad7a2iuroXS7l5SC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR9ATJAAoJELSic+t+oim9uOsP/3bChCp2UxXKTX/GW1LN6zes
frPcmJf57u50iY16f5Hp2u6oMSvTLn1QWJXiH+hefIEKu4ZwnA9cnI4C5RYsjVII
NHeHeYBX1uDEZ8q0N/BJL0t/yfoWWTIXOyfPfQsPNe+HSK8iqF0yYcCePvNS5dH/
BnmB5QxjiKsYiVs2Xy22o90USHIRwe7ZVJB4iiPMk2bqUBD/I3T9ncu/Ym4n/UA5
dlYfn6z+6ZWvyzqGFXqE/3KIKbXHAtjaitYn1cod+C1x9SA9K+A74kVWg2ujA/xm
/eIPcCJ7vbZ0oMQ58h4LHyrWMgSKYaT06v5duUOAjhFmOB7xb0GEMYMnaMQ+Enzz
U/Ccf0X784OyCip/yvSvAO1til3xZs9LuQFGmGiZY5jZhpy6nRjhAEsbHJXrA9cS
SPE4nkigg+Dn9NVdgLWV2nBRc3oKEP3SXBY4szhVwlvEEIUdziHa2s9b7f/pTAA+
m+TXAAWZuppexcBve5XhM2mVj4jLONCqpLTvANfrXeDTjOEINO6Q2sL8p4txHhCl
07JKhaskJVNBtW7Hm9yI4UvyWpRRc0fJJ2R/x3GrPfOJ7IuS+ShIbrQrG2/r9Agu
ydMfc/ChBLRQOuSXlUkXhJVshRci0YL3jPX2tonOOWISX4+7TrDZ4gwsihaE9SYc
w4mo8S628khZZARuTe3m
=KG9R
-----END PGP SIGNATURE-----

--Ad7a2iuroXS7l5SC--

--===============3613825686418038278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3613825686418038278==--
