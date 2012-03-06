From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Query about regmap SPI
Date: Tue, 6 Mar 2012 12:10:48 +0000
Message-ID: <20120306121048.GJ19635@opensource.wolfsonmicro.com>
References: <CAH4H7mPZtJqwYN=ZMp1N9MP0GM0hZhnW+5z1V2-ZwqYba9jAWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8266535923314987324=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4796A24361
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 13:10:51 +0100 (CET)
In-Reply-To: <CAH4H7mPZtJqwYN=ZMp1N9MP0GM0hZhnW+5z1V2-ZwqYba9jAWQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@gmail.com>
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============8266535923314987324==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tAmVnWIZ6lqEAvSf"
Content-Disposition: inline


--tAmVnWIZ6lqEAvSf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2012 at 12:53:51PM +0500, Ashish Chavan wrote:

>   I am planning to add SPI support for da7210 codec driver. SPI for this
> codec has slightly different format than others. It has 8 bit register

Please always CC the relevant mailing lists on postings.  I shouldn't
need to remind you about this stuff.

> Is there any other way to achieve this using regmap? The only other way
> I can think of is providing a wrapper function to read and write in
> codec driver and doing the shifting job inside that wrapper.

No, implementing stuff like this in individual device drivers rather
defeats the point of having frameworks.  It sounds like it should be
trivial to add support for this to regmap.

--tAmVnWIZ6lqEAvSf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPVf7CAAoJEBus8iNuMP3dDF8QAIU+FsDrm8+tuXzsQTUcSTUE
/xr1oTJwhRj3E4rE064vwzfJwv2X7Xs8dQxDdT0X7mgUD01vWKopMPvcbQx+GGfx
l2ffiFSa6IEtsg7dYaCf9QXcFOWq+2i3wwXRtBApt9uYE3PUCMuHaEugH22ipuJd
6R7bdp3rqAxNlAN3w41r4h0Ss/TnCK/InrULvvELeJmlOQrapOeoyHtO2TgeHLtu
65GwErwI05jYaRmNemNI1TGv9qlUGxAqD+xz4kHeHX3QUxsPvMdqE6/yQdAVdkch
sobuPNhJEsnN9d3jOVy0VZTE19SbcEA2oID2Bm01Z6AENr+n6UNnjAUQ+OnMHBdt
roIvnr7xuXxceHOBBL00FzPOJ0f8OxKI3A6G4UDhqSWhrXxdNjE/HVe/VVEhcWcv
DkYgnWm9P4x0BgTKF32XOv4LzZKc25EwtzsyJ/GG1/ec0LOKdVFEJLFI8AYwQRtD
7RzxZBPKTV2cOOSFoSL+1RcNemh/x3kMZ0r3EbDPM5V9gEWY2cvL7Utdal0ph0+J
JDvz5XLfMLqOsq4ywmQyeq03B0ulmj+w/zBR27go6lK1udz4EJaaBC0I7bqk3s2S
zt9/7MGCfL+D29csaV6haPzkhaTdQ3USYsyUXRYLy2MIKCbBq14yQGSOCSppgkdr
8iuMY5ohRmHoj5q+OmMX
=e6e9
-----END PGP SIGNATURE-----

--tAmVnWIZ6lqEAvSf--

--===============8266535923314987324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8266535923314987324==--
