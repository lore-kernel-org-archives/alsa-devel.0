From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 013/102] ASoC: wm8978: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:57:44 +0900
Message-ID: <20140220015744.GB2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-11-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6616607158448540961=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9676526569F
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:57:57 +0100 (CET)
In-Reply-To: <1392723148-12597-11-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6616607158448540961==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ColOLhxjmJSclmsQ"
Content-Disposition: inline


--ColOLhxjmJSclmsQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:25PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--ColOLhxjmJSclmsQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWEVAAoJELSic+t+oim9aJwP/i8wK11lympvyqe70QlXafvY
zXso3FrKAwGla65JngOMAtV28Q2rQRougZil/Tt21Jtcv5lry2dT2VazNiZ3YkBb
ThbBWom/7tZMLCpUUb2MLMyNWTcuWMCnO/6quHDdnZ2qX4cjnnI2Ee+EbJ4Lm2IQ
jSECstyRER3aZHEWnL0L9iusGlPq+KQzLDojcdMkDecUJig8W153EWHT+l3Qql/8
esJHfZRkCYod52eGNFC2GR2n78alK10cVY12j10nn7uuOs2OZjsW/LwUXNO8b5oq
SZhWa3L4UbxGmSA4T8aEcvTi3XwV/ofwI07PHV1c2NYpOJurPvJjdCDCdW2fhdEv
XQ3P7FUgYNClqGPK7HuHofzl0v3j/24VWjUayik3hqVlXIl4CA4S2mJOo9NMMg1Z
hKVkAGzYkDsNX/s7n5olNSd4lswm1W4klXYOIRK2FKQXlpLQqeyAJlYeakqxB79m
lkBqnO43mdQU1KpX7slFVpNFSzS3IgnMYeOrnl8gmekx33u8rAoTvb95AmdTiyrR
yygi9+beohNLGl1CyiX+97r+bQPkNEE4gFkx1B9V/w12Ysg3Tk9ZxdcUsFA0oBHe
G8zlq8O1XIdCxTuj/WzxF7j4KVCCRLSG6VkU7+LTErNp13qV4dZDaUbbbSQn0kPo
ned276gpVOB3JaJrmV5p
=Pa3M
-----END PGP SIGNATURE-----

--ColOLhxjmJSclmsQ--

--===============6616607158448540961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6616607158448540961==--
