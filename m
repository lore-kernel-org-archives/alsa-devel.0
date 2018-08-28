From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/1] Fix ADI axi-i2s + Xilinx AXI-DMA
	capture
Date: Tue, 28 Aug 2018 19:58:29 +0100
Message-ID: <20180828185829.GL2414@sirena.org.uk>
References: <20180824160430.10222-1-luca@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3764963769411457365=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C291D26779D
 for <alsa-devel@alsa-project.org>; Tue, 28 Aug 2018 20:58:34 +0200 (CEST)
In-Reply-To: <20180824160430.10222-1-luca@lucaceresoli.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Luca Ceresoli <luca@lucaceresoli.net>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============3764963769411457365==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4xmAKYnxoHNXa3WQ"
Content-Disposition: inline


--4xmAKYnxoHNXa3WQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 24, 2018 at 06:04:29PM +0200, Luca Ceresoli wrote:
> Hi,
>=20
> here is a fix for a nasty audio capture problem when the axi-i2s
> output stream is fed to a Xilinx AXI-DMA.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--4xmAKYnxoHNXa3WQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluFm1QACgkQJNaLcl1U
h9CD8Af6A3HHOBqGWXwdQhtR3ULS82h6fZeHIB/KL6AqTMQWIzcVqD6Fob0r3ES3
uTouAuKZX0rRfyu2SBC79q1HYowiezgLal8IAJkVkO0sqyY7QdiT2hJk98kq0k++
8iXapgy693LTv78mVdJ7XYen70ppGCFNP6uODFH6krwC1QqsfthCW/fcb+l4ApKe
YpFD5GNU5b5h4YWkpYBxjfIkA1tJ7WzX0NZADunoHxgoFcOrxgi8r2Gb8Jd/nb3X
qOJzsADS1zA3YxEqjHu9/HdaGZgM/t+2zOAfwAMdAvfZmUz7Tau+a11u473pBiFv
y4PP2CsC6h21DF7/bGtn7Jezbh+nTQ==
=IdRZ
-----END PGP SIGNATURE-----

--4xmAKYnxoHNXa3WQ--

--===============3764963769411457365==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3764963769411457365==--
