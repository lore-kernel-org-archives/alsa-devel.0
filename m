From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 22/27] sound/soc/cirrus: don't check
 resource with devm_ioremap_resource
Date: Wed, 24 Jul 2013 15:33:40 +0100
Message-ID: <20130724143340.GE9858@sirena.org.uk>
References: <1374602524-3398-1-git-send-email-wsa@the-dreams.de>
 <1374602524-3398-23-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4056501517651864627=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 64C842652E9
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 16:33:44 +0200 (CEST)
In-Reply-To: <1374602524-3398-23-git-send-email-wsa@the-dreams.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4056501517651864627==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GEvKNWSRjg+pdNz3"
Content-Disposition: inline


--GEvKNWSRjg+pdNz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 08:01:55PM +0200, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

Applied, thanks.

--GEvKNWSRjg+pdNz3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7+XAAAoJELSic+t+oim9B7AP/1V6qJDTu2FrInChS7/lLxDJ
CMxt5d8X8wWCa6VqkK5hGbLcFJ6H5UIgC5eiCMJeiO8Bi1mgf0Mh+Leeqv9HbnUm
zumLX4FrLoYHgHfVqcJH5aPhhyoS6atgdoHllVPO1qOhcfrzSY9Er0D64b9jINKp
QYx8/xERfcS7wQPv5bGYQsr3l0Kt/dI7hP/ERy9di6edPxht/HfGPmTJf9YyE9l5
86YxjT9SRZgTXWeZ3USjwmlQIVdzDMkg8/zxjgUMvuJteQzR9VlbXa86Fu3adcr6
3tfDykoiBHofe34Z5vRkkYmA/1k2CQ0Pp94BY0GVhKc5qeIVOowOKwj9Sjxj8BeQ
Igu+uKvCVGDZ3iBPtlRnfRu5lumnHNrPjWvBVeKn2N/muUuYrcogfiXvFUx1r0Br
V2py5jONaKBbU9Tkc8kI7T1m5G1H+Iy1cbKtpMrIC4ZXYqNfSMvnfh3ynMHKXc+V
NV8nl3zX9f77kjhS5kf2mxzYjuyopcsWOlxuVQjd482/3yo9rrEESEOvYm8V20Gz
qaHp2KSl2nHk0GKEqYYrtOsIQSx0+vcE1k7lpk5nOaNRsEYQf4tLbbpxDWN/uATb
31KsD85WX88vPSklqjs+2RpCBrmR41kAzNeiaUO8fHiZ+vuG4M4hVuprZwP6bSQM
ZsqU9JZJY7AmQLPBzzmD
=8Y1S
-----END PGP SIGNATURE-----

--GEvKNWSRjg+pdNz3--

--===============4056501517651864627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4056501517651864627==--
