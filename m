From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/9] ASoC: amd: modifications in dma stop
	sequence
Date: Mon, 19 Feb 2018 16:50:56 +0000
Message-ID: <20180219165055.GK32761@sirena.org.uk>
References: <1518766434-7911-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1518766434-7911-8-git-send-email-Vijendar.Mukunda@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6353949889381749944=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B31FF266E78
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 17:50:58 +0100 (CET)
In-Reply-To: <1518766434-7911-8-git-send-email-Vijendar.Mukunda@amd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6353949889381749944==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sU4rRG038CsJurvk"
Content-Disposition: inline


--sU4rRG038CsJurvk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2018 at 01:03:52PM +0530, Vijendar Mukunda wrote:
> As per design, non-circular dma also need to be
> stopped explicitly for both playback and capture
> scenarios.
>=20
> Added condition checks to stop non-circular dma for
> both the I2S controller instances.

Shouldn't this have been going in as a bugfix at the start of the
series?

--sU4rRG038CsJurvk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqLAG8ACgkQJNaLcl1U
h9Crbwf/UnTUctcDtxaIIkeA6ZgdNI6y5RA9O6wq+hW9RzqxNYMMxRHx1T43vzvX
SvhJYRPnoTVpw6M/8FlNbP59ywgkSISYnOMrJMtEM9ti7qDm3Ult4WPlYLPYTbib
5MDsXEeXj8a5joZPjXuJITDDRVsdHvXNiCj2nuCTUhaVdXhQVFagFeP23Vf8VlBx
ZMc1gcZdNLQxdYoc9xXxFrmUctK0fkoytQKDWbVfrKRejF+synOjlx2RZ2PbE0oT
kCsMlIrFBcswLTMfRsPZY093ofqEtBqViwfnPDw9LuyGxzd3D7gWr6pbQywdD0g2
BrIbKEUAAdQJEd27WhaQgaFYGjNBVA==
=Xw4x
-----END PGP SIGNATURE-----

--sU4rRG038CsJurvk--

--===============6353949889381749944==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6353949889381749944==--
