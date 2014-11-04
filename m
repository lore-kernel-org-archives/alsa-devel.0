From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Consolidate CPU and CODEC DAI
	probe
Date: Tue, 4 Nov 2014 11:54:23 +0000
Message-ID: <20141104115423.GQ3815@sirena.org.uk>
References: <1415097059-14551-1-git-send-email-lars@metafoo.de>
 <1415097059-14551-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5898964804286563890=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A11926147E
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 12:55:38 +0100 (CET)
In-Reply-To: <1415097059-14551-2-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5898964804286563890==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yqOqvNXBwyh/FOL3"
Content-Disposition: inline


--yqOqvNXBwyh/FOL3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 04, 2014 at 11:30:59AM +0100, Lars-Peter Clausen wrote:
> CPU and CODEC DAI probe are performed in exactly the same way. Which means
> we can reuse the snd_soc_codec_dai_probe() for probing CPU DAIs as well.

Applied, thanks.

--yqOqvNXBwyh/FOL3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWL5uAAoJECTWi3JdVIfQby0H/02/Qs0uj3KEClq0pDVnCKQn
9LiR2yBClV5EJu1dAKA17RFHSrZqa0vx7+kfRD9vmKl/2xXSBbdT0N71pegq2rok
anH2CNFoUHb9eu9zE74XYntVACWmF/0/m+rmhhLGx2bxDJGPhs5jBhDO4pvNXpbD
lp9Tyv3SB9DI8EdXzexnFyhApBCLoui/lQP3WhkQpSrFfPDPom5E4EvTjdliolhZ
NNs19ZreOWYx2wGizvXB8GMTpX4J5RABxgnIqEmGOMU2qtm+zefALAJfFKp4dK1a
mnvTWXzHPtKvAcIYwC0X1vd8NQlR5n94NRN8D3mVtcgQV1vE28yDoX+6V8FtoOM=
=3C/7
-----END PGP SIGNATURE-----

--yqOqvNXBwyh/FOL3--

--===============5898964804286563890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5898964804286563890==--
