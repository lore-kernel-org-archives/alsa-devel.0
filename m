From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: simple-card: Drop node->name
	checking
Date: Thu, 24 Apr 2014 14:03:41 +0100
Message-ID: <20140424130341.GX12304@sirena.org.uk>
References: <cover.1398337861.git.Guangyu.Chen@freescale.com>
 <ef6f96d375c8771c93469168790e0098610bd250.1398337861.git.Guangyu.Chen@freescale.com>
 <535907FF.3040303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8491412108581758577=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E03C62619E5
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 15:04:00 +0200 (CEST)
In-Reply-To: <535907FF.3040303@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jyri Sarha <jsarha@ti.com>
Cc: moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, tiwai@suse.de, lgirdwood@gmail.com, Nicolin Chen <Guangyu.Chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


--===============8491412108581758577==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wvTm4j+ONbkr72js"
Content-Disposition: inline


--wvTm4j+ONbkr72js
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 03:47:59PM +0300, Jyri Sarha wrote:
> On 04/24/2014 02:13 PM, Nicolin Chen wrote:

Please delete unneeded context from your mails...

> >-	if (!strcmp("sound", node->name))
> >-		prefix = "simple-audio-card,";
> >+	prefix = "simple-audio-card,";

> I think you have missed the point of selecting the prefix based on the node
> name.

...

> Maybe the implementation could have been more explicit, but I think the old
> behavior is more convenient. If we anyway decide to go with this change then
> at least the DT binding document should be updated.

Yes, the implementation needs to be *way* more explicit - I'd expect a
parameter/variable saying which level we're at depending on where we're
at in the parse rather than guessing based on the node name.

--wvTm4j+ONbkr72js
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWQupAAoJELSic+t+oim9+rYP+weEJLNEZUi/AMvpFpj1I2cK
oFU2KwytQ5YJHlIqAt8bwsBNAe3Kb6P5WofxhgfrIrfCpWt+IHRIkbHMSI392NcC
qvzoN5kJz6OPxHjBS7d2/4fs51fGagXPA9is/g9d5e1VLqPvkq+ss8G+xtY3ie9/
rT46gbNhi221/HIuESPD0W/eohnGLbEd2+pWzobNOYPE7Yki2j/ReSTiDnnznyqt
iiZrYGSOmAF7hu8iNN+ZNOEAYHF20BBqIbSfQqip1lsKmJtaTp8cCHk+0795fk6h
1Kq9GzYF0STO8nkgic0QP3fvx5NmGsI+wvLMjNBE8o9+rwLPJEnluULK8qj1Z8Mm
U1bwI7IqNxITMpt+MQPO2XoiEaJwbD5UEOQ6faO10Xa/Hb4t1/tsyAoeez436Z+M
8Wp0Agn8iO4uxgWixD6domW5/vXy9Do65N6rl0nR+AlI4cBRPnrWLjvH6F/wF8BJ
RIeIDnI2EhGJy5le5f/YHdf2ZxGJxJmOjr+TtvV8jWExpJB2Q5lJXbzd0X8x2y2E
lotzF3cMrr/nbw0O9vbCdmgHvRQ9A62W36jJh2SXxTxM7N4eSdVejha2Jo04DLx2
F+8AhIxuuqsx04OJ7JX0m/E+sFlFAa7xBCecGofWgBO+w9vK5bb1mnATng77XsbS
JtKPz4PUGsD76egFjkyg
=aidN
-----END PGP SIGNATURE-----

--wvTm4j+ONbkr72js--

--===============8491412108581758577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8491412108581758577==--
