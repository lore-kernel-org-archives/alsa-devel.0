From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Fri, 23 Jan 2015 17:40:13 +0000
Message-ID: <20150123174013.GV21293@sirena.org.uk>
References: <cover.1421868426.git.moinejf@free.fr>
 <d0c66c2e2f200119f9990fa52a503b1a4af6238f.1421868426.git.moinejf@free.fr>
 <54C0088F.9070609@metafoo.de>
 <20150122090723.50ac0156@armhf>
 <54C14EB3.8080305@metafoo.de>
 <20150123131554.623003f9@armhf>
 <54C252F4.9000504@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R9dSeJxMIUBTi9Do"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54C252F4.9000504@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean-Francois Moine <moinejf@free.fr>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-kernel@vger.kernel.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--R9dSeJxMIUBTi9Do
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 23, 2015 at 02:56:04PM +0100, Lars-Peter Clausen wrote:
> On 01/23/2015 01:15 PM, Jean-Francois Moine wrote:

> >>Your example is a relative simple one where you do not have any additio=
nal
> >>audio fabric on the board itself.

> >Right, and that's why I'd be glad to have quickly something in the
> >kernel. More properties could be added later as there would be requests.

> I'd agree if this was some kind of kernel internal stuff, but this is
> creating ABI and we have to maintain it forever. Rushing this in without
> proper discussion and consideration of the more complex use-cases is in my
> opinion not a good idea.

Just to repeat myself again: *please* try to provide more explanation
for your commits, the concerns Lars is raising above are among the
things that I'd have expected to be covered in a high quality changelog. =
=20
There is no explanation at all in the changelog regarding the goal here,
just statements that this is a graph based card without an actual card
node.

--R9dSeJxMIUBTi9Do
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUwod8AAoJECTWi3JdVIfQ1MMH+gMkwDNLlNqCI+AGUfu7VHU4
grl3CdjfAwThmj7dLL5ciTzfspxh/fB8+xxSexmeC522wF1QmNtSrnr5h+tSETYY
bTIuu39riAuuwmN7jdowIipaQdo3gp21xnbBxPLO1PnZUxj5CKt0gj46xNkTAkFH
sjOtF8JBJN1hdIQh6LYHqz7nnweWZDMR667TTw/45VmozrILzOPENrWLQo7/0B+y
SvvlNLsCJMUcnYeJP9+psXZnYul8bn5bWtSDhlo12BffsLVu43lztQxfkiokfSHs
PW76D+XNw+FMC+XPObMY532DaBNvFISQL53bKQghHgA1JMpbuh5MozX7RSkWNL4=
=8/iP
-----END PGP SIGNATURE-----

--R9dSeJxMIUBTi9Do--
