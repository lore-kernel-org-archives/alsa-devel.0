From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RFC 0/6] ASoC: sgtl5000: fix use of
 regulators and internal LDO
Date: Sat, 7 Mar 2015 10:45:24 +0000
Message-ID: <20150307104524.GP21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <54FA2F03.2060804@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1111134173720398973=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C171B26062A
 for <alsa-devel@alsa-project.org>; Sat,  7 Mar 2015 11:45:32 +0100 (CET)
In-Reply-To: <54FA2F03.2060804@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============1111134173720398973==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f4clD4lIR7c7nGwg"
Content-Disposition: inline


--f4clD4lIR7c7nGwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 03:49:39PM -0700, Eric Nelson wrote:

> Based on your review, it seems like the following is needed for a
> V2 patch (set):

> - Move call to sgtl5000_fill_defaults() earlier in the
>   sgtl5000_i2c_probe routine, before adjusting ANA_POWER.
>   This will allow registers LINEREG_CTRL, CLK_CTRL, and even ANA_POWER
>   back into the default	register list.

I think that whole area of code also needs some revisions to make the
code look like it's doing what it's supposed to be doing - the fact that
it is described as register defaults at the minute but aren't really
what a driver would normally mean by register defaults seems to be a big
source of confusion.

> Let me know if you'd like to see this in multiple patches or a
> single patch.

Definitely multiple patches, the level of splitting you've got now is
pretty good.

--f4clD4lIR7c7nGwg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+tbEAAoJECTWi3JdVIfQx0oH/0M7dM/Vh/kqS1y87+T/QAkx
v2wPK0u1ncPeHFj8mtBMq2HA4pXNgZk8z3gy7xivrUvwHshjP23yP/Y79Y4jB5qO
bQNbnQUm9HLNpaFYevAtU/IJ9Vw3I1BDqgcFmAZOKPR73AW/gBJ6PwNro4A5BScl
455vO5F+aFibdB3lF3+EG4HMWsz2JimTdiyGcD0kjvwPXG1f6Fu2bitnNbBzrTKB
yFzU0JssPsIMuhiBuZTkKSeEOgdnmNIB1zM9jeRKG6Su3IqiziS+4lwhy027yDo/
uns+LICuIWY5oUy9kBrzW1Swn04kT/F2yUUOsOju/v1tJ9KdLf/y+9PHf1jgssM=
=ysOc
-----END PGP SIGNATURE-----

--f4clD4lIR7c7nGwg--

--===============1111134173720398973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1111134173720398973==--
