From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: wm0010: Fix resource leak
Date: Wed, 31 Jul 2013 12:23:31 +0100
Message-ID: <20130731112331.GL9858@sirena.org.uk>
References: <1375262118-9183-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4046889437802258067=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B12B2615E7
 for <alsa-devel@alsa-project.org>; Wed, 31 Jul 2013 13:23:33 +0200 (CEST)
In-Reply-To: <1375262118-9183-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============4046889437802258067==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3lXfO+92YUB+uPVX"
Content-Disposition: inline


--3lXfO+92YUB+uPVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 31, 2013 at 10:15:18AM +0100, Dimitris Papastamos wrote:

> +		xfer = kzalloc(sizeof(*xfer), GFP_KERNEL | GFP_DMA);
> +		if (!xfer) {
> +			dev_err(codec->dev, "Failed to allocate xfer\n");
> +			ret = -ENOMEM;
> +			goto abort1;
> +		}
> +

Why is this being allocated with GFP_DMA?  It's an internal data
structure, it's not going to be DMAed from.

Please also provide a changelog, a link to some address on the web isn't
a useful description.

--3lXfO+92YUB+uPVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+POwAAoJELSic+t+oim9pVgP/3yLantWW4M53SbRsrdUaHHR
U6RHAj+NDwPY2L62K+pqPSCy955sJiJkeU4gXf1nr3T6nC7m4bCzascUvHQ73P5M
vQBSedhQjN1zDYYB2yNAoVxWlTCeWCqBwgFAoIYkeK1n85Ya8rTIHVWlGg66SnzP
5xMST60uVmLOUFKP9pLBgymOLwDN7HvJKrVgXqCsvjnC1MLJND2Eh9RzbvPkwbcI
ypu7gYIgn+1skPCaIx1KTIwWrJQULMqwePotOnLYYW6l/Fob7ZmbDVGZm330U5/n
U4svNV3I7SWkKyg57FS1t3f2/ZSKRuqC1XwCfgeHqRAKQS3lhU2wwJdJnZWlyc6f
lr8xvYyDKQBgvw2veJol8f0SpALkJeHiykrcBvhzPhWF4bS50KoU/PKIVKvRQQca
U8Ppss+S5JoAj391cmWlIabyYB41LFO4L4a0afRAAf3QOP/NQNfBLxvxLMImzr9a
4Ot0izuZXRzfXJ8otVf1vJrqEJ3oTgnOfwLCCdy6wiQDycQT45tITjI3FtnDZkkR
60JiUBbl75PRuvvkPxT+puLPkhXznEVdiN/5R04kfI0qi09xqhoGeynyI29odb0V
jRgLqs4hCKht1+btYOWlrTEioLLNCvBL0SRe2AwFzXLZktrw+hFymnErqKsTsZ2M
+ra5+7An1vE8YgO7JwR3
=0+Rn
-----END PGP SIGNATURE-----

--3lXfO+92YUB+uPVX--

--===============4046889437802258067==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4046889437802258067==--
