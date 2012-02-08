From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: core: Convert single bit wide
 bitfields into bools
Date: Wed, 8 Feb 2012 19:13:08 +0000
Message-ID: <20120208191308.GA28103@opensource.wolfsonmicro.com>
References: <1328727486-923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<CA+7tXihEOP0a-JwEw7LGEhtj3WFR30M0t9PJZ1Ykwq+G5PLE1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0405867254312662081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 647DE103EA2
	for <alsa-devel@alsa-project.org>; Wed,  8 Feb 2012 20:13:10 +0100 (CET)
In-Reply-To: <CA+7tXihEOP0a-JwEw7LGEhtj3WFR30M0t9PJZ1Ykwq+G5PLE1Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============0405867254312662081==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UugvWAfsgieZRqgk"
Content-Disposition: inline


--UugvWAfsgieZRqgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 08, 2012 at 02:08:05PM -0500, Trent Piepho wrote:

Don't top post and trim the context from your replies.  This is basic
stuff...

> Aren't you increasing the size of some of these structs considerably?

Hrm, possibly.  I'd rather have hoped that the bool type would work a
bit more sanely here.

--UugvWAfsgieZRqgk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPMsk8AAoJEBus8iNuMP3dSsUP/2ueF7stgFQGBTEgPdcDNLSA
X+R0TxvpdsCsx4meYjOQ5Fv2xelOmb7Qnd+vCvwqBEurp57Q+eKyGYm03hj/vDFY
/uKUNTBrWcmbuqzovsOJ0mjEzYHlcS2//7jK54SljcAeazIG/zevPJJROJtqgW3V
VLJDLDlHNT9DdYlFlw2ccDmbr9jWE9LnKMRDVTyORKNA/BGutnX2ECyq6ZfkHyH6
Tl2Fdw2AjR7oxFlIvN8hHWQ26kg9XehWDrb2CuuN9JPp7vBMw1DUGOSE/mH9m3vy
EqqghZhKWLtg+KTD6Vy/CTg3yZm5ZTWr/u6uDRV7y5cfE5PbD/Has3BlISc/Vj86
mShlCji7OCQv04U2WNW17k+PSX8L3RTonh2q6Mz/OGrieblcLA7ZvLNpol7gTBjh
lcXdBaIEv9xZajwUOrH8gP8Xfc4Bb2isEsZuopxrJjlAmeF0jq8/t4i0OpkZMomi
KrRhup2JUHDMKQILrbACHnfEav3UmWGl7RBcpvVQJn5hM9uJOf5rbXHRb97yzZb9
Ui5rB4NG6MkgsIcvS5JflFjOBAb/EPM/W9eKAPS1/dgqIdRLEzRpO35GNFap1Vez
j47yS9kt9didlfmB3ugZqwEP4YSjCaf4ns5HI2TSIEMW2SU5kkCVPyv0ZGrLWf+I
dMdCWEv/+87c8hcN+qdk
=QKD1
-----END PGP SIGNATURE-----

--UugvWAfsgieZRqgk--

--===============0405867254312662081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0405867254312662081==--
