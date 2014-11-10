From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/6] ASoC: davinci-mcasp: Fix rx format
 when more bclk is used on the bus
Date: Mon, 10 Nov 2014 14:56:13 +0000
Message-ID: <20141110145613.GW3815@sirena.org.uk>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
 <1415615540-28981-6-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7145578518342534416=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 689322619D7
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 15:57:29 +0100 (CET)
In-Reply-To: <1415615540-28981-6-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, Jyri Sarha <jsarha@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7145578518342534416==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3KuOF28IUdRLDDb3"
Content-Disposition: inline


--3KuOF28IUdRLDDb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 10, 2014 at 12:32:19PM +0200, Peter Ujfalusi wrote:
> When the bus is configured to have more BCLK then the data type demands we
> need to use the rotation to move the data to correct place.

Applied, thanks.  These bug fixes should've been at the start of the
series.

--3KuOF28IUdRLDDb3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUYNINAAoJECTWi3JdVIfQVTcH/RxYi2BevgCQsi7OrBpJJMVB
lJ8aqRCE+e8ZBgAwGQU75p1dbqar7+BPF/faUsbb9XgpoUg+I8/pf2hOTTnHe8rP
5ImcNoo1BDSKLBOvQvjG18Zh1gFZsRFs4KtxCjihZAuOM9RfoDneCbxCGCdsk9Kh
hzpjAEmqVCcU2I8U4/uD4OzxV3yCCOmj32nxuSEj8UjqZxDMloZaFCqZtO8U5GuB
My5JiMM3H5gapZlVUca4PaB5BaUtlhTqVdRUMCkpDZmpWHOsYgbfA+YBTyVZ56Ci
AprTEU0jM490/dl92RjvMMAAx3ydzJl4nDFKeoQZbknveM7GIan3uRmoXDMmN5E=
=fYbm
-----END PGP SIGNATURE-----

--3KuOF28IUdRLDDb3--

--===============7145578518342534416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7145578518342534416==--
