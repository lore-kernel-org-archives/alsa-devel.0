From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/4] ASoC: fix saif record unwork issue
Date: Tue, 24 Jul 2012 20:21:25 +0100
Message-ID: <20120724192125.GF3099@opensource.wolfsonmicro.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <500E992E.6090900@bluegiga.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3326428339883342396=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 515242652A2
 for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2012 21:21:24 +0200 (CEST)
In-Reply-To: <500E992E.6090900@bluegiga.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Cc: alsa-devel@alsa-project.org, w.sang@pengutronix.de, linux-arm-kernel@lists.infradead.org, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============3326428339883342396==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AH+kv8CCoFf6qPuz"
Content-Disposition: inline


--AH+kv8CCoFf6qPuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 24, 2012 at 03:46:38PM +0300, Lauri Hintsala wrote:

> 1. Recorded audio file is totally silent. Hexdump shows zeros.

This one is commonly due to devices powering up muted by default and
requiring that you set some controls to route the audio through - are
you sure you've not missed anything there?

--AH+kv8CCoFf6qPuz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQDvWhAAoJEBus8iNuMP3daRYQAIXBj4tnkgLyjV6Q2SUp5vay
klSM8kXsMXOXDx/KLq6aVWHRhHM2XkXJzAdvZYiQUD1rt0vjbUihagga6pHjbwpF
pPPWu1ub1fPhCfKwDGlgNU796Cj/YIHAbsP2K85tHk0v09lVPZIS+5lCGWLMkfbI
mzTW74xKPtO5c31QmJ0UcW80AoLyfz//0/Lmz8/ztO+JJCXllznL2WhstPb3yzqs
S74QFQEF1rt61qM7UO1bjFzma9Uy4M2UNE4bhzu830usOOrsDFSKKhMPBjebi2vi
OuvIL8gl1oavDO08CAPxXsK8U/aC6OjVZcbCGq2ZbYjf2CZdyCZlNy4AkyPN7/RU
m5aXdaPijnZPZLOXU8nWffC019CkbAGKzo4xKp0Okqn6aXng31K3d0mJVBD17/Jj
QLDQ6d/nQb0qDt1mgXljtaFzWfw5fIIcezWTJvK8c1R90zikmO9Cj6H728obUtHb
liaNlFqSb5jetPnws03AqZh9aTSLhfXrHpyqNZW0zyGmOxgy14SIHLJ22G1ZgQIq
uwGxpGzmoi7QYxKjUk23f3OFMPIR8cYLQVHbN/vfcYzbI8kth+NyUzIMMublK1au
1SPyxFA24yZ4ngDkdIQaggMtHjOnkRzhdPVcXn2+aeE/kfmfHv4IrW5AmAmx4R6D
B8Dz7ZmP3AmJNmt6uJaR
=uCt5
-----END PGP SIGNATURE-----

--AH+kv8CCoFf6qPuz--

--===============3326428339883342396==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3326428339883342396==--
