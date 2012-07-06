From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: dapm: Make sure all dapm contexts
	are updated
Date: Fri, 6 Jul 2012 19:02:49 +0100
Message-ID: <20120706180248.GB5437@opensource.wolfsonmicro.com>
References: <1341590176-20780-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2624751596191825697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D1A01045B3
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2012 20:02:54 +0200 (CEST)
In-Reply-To: <1341590176-20780-1-git-send-email-lrg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2624751596191825697==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 06, 2012 at 04:56:16PM +0100, Liam Girdwood wrote:
> Make sure we set the bias level for all DAPM contexts when
> changing level.

Applied, thanks.

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP9yg7AAoJEBus8iNuMP3dfegQAISr4TEno1gz/KvgeuChdiPB
SA9OT5uHUbhq4xWHVpQIe3xW9/8Pt47L9acEf8JX1QUqHzu+orwg4eRuXxhfPZZ7
TPOthwfSEfTWwcXNPjHGyBgIdjUbFuAWe4OTrNJEpWLqZsCRMZmSc6vQnt5oFH9l
Vua3eqAO5iMTDRhFffO+vHhX5qeGoKMCBpKKEBUD7La4CYumErcPU52+J6goK2Ph
z1rgH5ajyIoaAiBq4xt3URnx41GkpnpNRWp1tSVspbeSml0TpasrJapmVbZe6yNs
HhobSRkBCaaAMduGl9BTCQ6fqt37ak5XYEeBaORSh7az0EfPAyGOG+VCerx+2dzJ
3Y15Ge6LB5IaDGRoVBngclwcnQgbiXS4mu4DcxmblaEbZkXrnOUKQlpZQkkdS+kt
fZ+44Nd6MbBi81IDMP46uAZmEowBsc2kDHDpTyRpb4nedf2AS0dVeynNVYH0/Hnh
n974msQiViOUftVUvS3J5EaKLCT6ETAr2/Byn6pfAhR4fK7RSyrm0xdRTA3ogdIB
zug+rXjOJR6NY/Op65AYZgVxgSL1gg6cMpZGQO5tRgG5qejoQM8FEm92xMZFBXW8
DoJ+2mW0poAfwTd49m5MEKZrDcJC0h5yyuRPSlE+q3CZdUa8uLo7ehqBUUSMSBgM
mcH8/dYNU0mZ7whO2XzF
=fCHm
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--

--===============2624751596191825697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2624751596191825697==--
