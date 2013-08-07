From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] switch: arizona: Clear trig_sts bits on
	all paths
Date: Wed, 7 Aug 2013 11:03:13 +0100
Message-ID: <20130807100313.GW6427@sirena.org.uk>
References: <1375864122-6615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8571976123317664182=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CA37261B35
 for <alsa-devel@alsa-project.org>; Wed,  7 Aug 2013 12:03:17 +0200 (CEST)
In-Reply-To: <1375864122-6615-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: cw00.choi@samsung.com, alsa-devel@alsa-project.org, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============8571976123317664182==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="S5Rg6oz6PtEXgjQf"
Content-Disposition: inline


--S5Rg6oz6PtEXgjQf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 07, 2013 at 09:28:42AM +0100, Charles Keepax wrote:
> We want the trig_sts bits to be cleared in all cases where we consider
> the jack detection interrupt to have been handled. Specifically, if a
> duplicate detection event was suppressed these bits were not cleared
> causing the CODEC to not enter a low power state. This patch clears the
> bits on the duplicate detection code path.

This isn't an ASoC patch, it should be CCed to lkml.  Might want to
update the subject line too.

--S5Rg6oz6PtEXgjQf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSAhteAAoJELSic+t+oim9ZmsQAIn2NqUYP8wE8Ze235ftng04
W9LjrpR7QsQewee5MGL7HXZoChvvAvYo4j6VCiqpuVHuDyvE2TfdOKmSECwewgYf
gbReaTGc+GM7mhqZDhhrw8Ir9iRdI4sJdlyy/kTDmfwH0+fdVFB3G89TMUUQz1o6
mxnd/g54AB/7I3WSoPkTTIMX2cZk3rx6U+TgccT8PQ/DgMtFeaugDpIbI+mmG/pb
QkCFxwGKA7NVjJu6dWW4NYCfuckzkJ4FnVd1sNntEu7DuPKvza9+DkzBtfhspQf/
U2f4PsZEzJAVmYztnzAk652nipZyLz+MVFfusU4cV5fmACCdi+ZQSa3MCHGwldM+
EUCK6Zmu/o4LKSz1YfsKkIAzoEWE3Dmzb6G1jTQY8k+YL6N+YEKn/g2IZB2X/n+5
vNZy8gZouJWiSVqkvne7u3BYkXguP4dD5fhyVCcHhpUvUmotl9VGvSK+5Bl/cS8Q
s21WNj3ubNgdhfb9e0P4AL9f2yQtIW/VADKm1gzs6lZTtVsXS6dpEMCIBK3tftI7
X+exKqkrZx/7Drbt/YPEKbfZhQ4zfsnWSg7awQCoLUGmR1oK1Mph21xycEbHIm2g
iGQotR644dOCQ+EaKQJsl5wK+XEyKW1ios46wtnnh9Ki+WEqjdOURixzvPgGHd2m
Kjh0dfFmZ/Ck22akWXQo
=IYe1
-----END PGP SIGNATURE-----

--S5Rg6oz6PtEXgjQf--

--===============8571976123317664182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8571976123317664182==--
