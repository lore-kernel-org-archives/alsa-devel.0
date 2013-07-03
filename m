From: Mark Brown <broonie@kernel.org>
Subject: Re: Query on Audio DMA using DMAEngine
Date: Wed, 3 Jul 2013 10:43:07 +0100
Message-ID: <20130703094307.GE27646@sirena.org.uk>
References: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4F1488@DLEE08.ent.ti.com>
 <51D01F31.3010602@metafoo.de> <51D11D64.3070805@topic.nl>
 <51D24A01.2050709@ti.com> <51D26A18.8040903@topic.nl>
 <20130702121345.GL27646@sirena.org.uk>
 <51D3EA42.3040205@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8956539716426418176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id BB611265532
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 11:43:10 +0200 (CEST)
In-Reply-To: <51D3EA42.3040205@metafoo.de>
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
Cc: Mike Looijmans <mike.looijmans@topic.nl>, Joel Fernandes <joelf@ti.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============8956539716426418176==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MWfjFH3bvpv8QATL"
Content-Disposition: inline


--MWfjFH3bvpv8QATL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2013 at 11:09:22AM +0200, Lars-Peter Clausen wrote:
> On 07/02/2013 02:13 PM, Mark Brown wrote:

> > This sort of cyclic thing tends to be best, ideally you don't need
> > interrupts at all (other than a timer).

> Yes, this is usually how it is done. But I'm wondering maybe the EDMA
> controller only has a small total amount of slots available.

Well, you don't need particularly many slots so long as you can cope
with a large period size.

--MWfjFH3bvpv8QATL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0/InAAoJELSic+t+oim9WZEP/jqcsEDX8+rlTRJAcqMIN+Ag
uoWRleBX2Tu9reBOydH3IdSEVczVi7MbL8QaUtpR5Zf+bHsvUTtmOQioKAlsw3sf
+FtYNr5R34k0wUqXCPrWrOzreMAbknX1CEDe70qPA8kSnm3UvHCFVxC0NEkMpSnk
j15lzyD2azjpRy7mfhNHDnwEgMu7Mx0EEsZSyEiH5Lqz/CR/M+Br0aKjVj+3Kfrf
igXTinY/Z1Z/5SSJSc807iyVMICW63Q93DqQLRuGX4g/MFfOxDV1WAYGVRDq/J3q
pc4y6EMOq/tVcQgdBE3jsdYxs2ulo+UIqSaRPhl17RJ/xRYB8ftXodX5Z0CiCKbg
qRIMp6LDDKI6if+Nv0LmkLrLqWKOX4ep8ZDnJN8TPe+pwl2ws52I0DjShEvUV/de
+x48lXt3S3AQOPi6jQWJ+SkUKPB7ZyaLVElV4EhPPl0vA+30y3Sowmkhrz0pVRPX
LzPf8sF9AayhpOoeWJyehFfyBvfnClec6nRyuUX4YxZvRNP7Or5PmXqKDQYMotFD
kwxUChNlsFBTWUZv6NZMSrot8Ux/z2DxdrcjqVK70LXKJJicGu/61GRH4TGFrGh+
ii1bxCuub87FFj1LuBAuDXBcW/nJTTQthSLJ/RU6nyrpEv3q9/bnEAQ9jaIGV+21
g2zdM/CFYOklSsLCEF09
=Hi9t
-----END PGP SIGNATURE-----

--MWfjFH3bvpv8QATL--

--===============8956539716426418176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8956539716426418176==--
