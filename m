From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/8] sound: intel/sst: don't pass GFP_DMA32
 to	dma_alloc_coherent
Date: Mon, 15 Oct 2018 10:58:58 +0100
Message-ID: <20181015095858.GA6277@sirena.org.uk>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-6-hch@lst.de> <s5ho9bxn7ho.wl-tiwai@suse.de>
 <s5hefctm0m3.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7240967437031164033=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 53CBD2677CE
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 11:59:00 +0200 (CEST)
In-Reply-To: <s5hefctm0m3.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org


--===============7240967437031164033==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 14, 2018 at 09:46:44AM +0200, Takashi Iwai wrote:
> Takashi Iwai wrote:
> > Christoph Hellwig wrote:

> > > The DMA API does its own zone decisions based on the coherent_dma_mask.

> > > Signed-off-by: Christoph Hellwig <hch@lst.de>

> > Reviewed-by: Takashi Iwai <tiwai@suse.de>

> Mark, let me know whether you'd take this via your tree or may I take
> via mine (with a minor correction of the subject line).

I don't have the patch...  in fact, having found it in list archives I
see there's also a SPI patch I'll have to go hunting for so I guess I'll
apply this one when I find that :(  Christoph, please CC maintainers.

> FWIW, the driver sets the 31bit (!) DMA mask, and that's the likely
> reason of GFP_DMA passed there in the original code.

Likely, yes.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvEZOEACgkQJNaLcl1U
h9BFDAf/SpR42tFyp91pGXNGYro6/PenNv4A3vKAbeeJ3gOtycjDoY27MEJ/9sus
3Ei73g/CmMXM7TewCg2sW8AaNI3Pu/7OhElAlRtpgEXD1QkxEHAPTfKgMIEoht9F
RyHEVDBMxdz8WgXob2BhAzySHdM81B1W6bJ233lX0W9xyBiFdKasqfHajPJcFuUV
nsaIvkezX6t8RWOXfPeH+oWUqhiFQBTqqlaGiV51pwRTrT9Cn2NSemVSEJQdTEYB
5DVSKkgQyFioVx4pM4UauV0mgYiE7Haien+SmTV6vBCkZuzAi+PMo0CruZeTWNeA
TprXIGr//lm5dl/Gsc8ZZ0IrkFfGkA==
=+9yJ
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

--===============7240967437031164033==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7240967437031164033==--
