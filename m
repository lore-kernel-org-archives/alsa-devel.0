From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] dt: binding: sound cs42l52 driver
Date: Wed, 13 Nov 2013 19:49:15 +0000
Message-ID: <20131113194915.GF878@sirena.org.uk>
References: <1384357474-28653-1-git-send-email-brian.austin@cirrus.com>
 <1783157.vhfWvslFgW@flatron> <20131113181622.GZ878@sirena.org.uk>
 <1799362.QSDMu6GHtU@flatron>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0078566276078532656=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E092D260323
 for <alsa-devel@alsa-project.org>; Wed, 13 Nov 2013 20:49:23 +0100 (CET)
In-Reply-To: <1799362.QSDMu6GHtU@flatron>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, rob.herring@calxeda.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============0078566276078532656==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="czsrKamv0OtYjSMr"
Content-Disposition: inline


--czsrKamv0OtYjSMr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 13, 2013 at 07:24:04PM +0100, Tomasz Figa wrote:

> Well, the label is just for the parser and it does not get into the DTB.
> This is where the DTS author can make things up just for their own
> convenience (like main_codec, aux_codec or even cs42l52).=20

If only we could have comments :)

> I know this is really more bikeshedding than anything useful, but I'd
> rather try to follow the written rules in ePAPR, instead of nothing at
> all. At least just to make things more consistent.

My feeling here is that we should be looking more critically at ePAPR -
if we're picking people up for having what's essentially a comment
that's too specific we're probably doing something wrong especially
since the corrected example would look something like:

	codec: codec@12 {

which is a bit redundant.

--czsrKamv0OtYjSMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg9e4AAoJELSic+t+oim95BYP/iY/IhQOQcn1BaCcOWbxo7R2
16qfIGKflNtpY3wQfeR/Rnaz6NEKbnHEXhl+BnUVpoluqX0BmJRYOsu1hpjB0tJD
bjbPSdELdCVIl+/tmnpp0lyNnDERU6XkdGUl4wZxgrOf7EBVhTrMA9jSr9d1AqbX
/WGskc34HAzyzaTkw8C2VTIY9sXfA9O4XvfmrwYqeCKyt1CM+Z4k3WzPhznM7DK5
cxE7HZrf+IT8fXMhovV8e2+Ie1GSKlbotmuOob8hhRRfWuci/R9fy0cY7qNTbeI8
vhXFKon0hCPCJ5Yhwdeucuf1lwNwLG/7zSgYJZafTw9xItja2PMmAR+qEhKksPD1
jWJbPPU2QsuNyY4uDG/wmXHz1e79NfJ8ef17IqyqMKrFWldHY9L19RDslRQVQ5UF
Vt3ZU+P1YV6ZSSIrQb9PI+6vytJAX/1HrZLFGg5E37Co+74L4P7vsJaCd/4RuR5r
CJ0GfkfcHH0Gmgo39/VsK3sZdP+FVh3MzhIjldbtoaGIgmlc7m75ENB3k0LIivi7
YKmGFoWvKcZRGpeqg9jFytRXM30FzqNdZfe3yqaoEl9/sxqt09PKBjsyua2vmF5a
p2EipuTHB/Rf2n/VbVh1YYpBLKv4RNZYXROIhMqayE0qCzpBHCPHTSFW8eoF/oOk
njfuFk//Z3JojUQMH5Nx
=1QEd
-----END PGP SIGNATURE-----

--czsrKamv0OtYjSMr--

--===============0078566276078532656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0078566276078532656==--
