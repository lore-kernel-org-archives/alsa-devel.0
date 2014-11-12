From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: davinci-mcasp: Add
 overrun/underrun event handling
Date: Wed, 12 Nov 2014 11:52:58 +0000
Message-ID: <20141112115258.GH3815@sirena.org.uk>
References: <1415781730-31271-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8766334990328356449=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9CBB8265342
 for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2014 12:54:24 +0100 (CET)
In-Reply-To: <1415781730-31271-1-git-send-email-peter.ujfalusi@ti.com>
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


--===============8766334990328356449==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gpD07/c6JxvXcqO5"
Content-Disposition: inline


--gpD07/c6JxvXcqO5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 12, 2014 at 10:42:10AM +0200, Peter Ujfalusi wrote:

> +	if (!handled_mask)
> +		dev_warn(mcasp->dev, "unhandled tx event. txstat: 0x%08x\n",
> +			 stat);
> +
> +	if (stat & XRERR)
> +		handled_mask |= XRERR;
> +
> +	/* Ack the handled event only */
> +	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, handled_mask);
> +
> +	return IRQ_HANDLED;

If nothing was handled the driver should be returning IRQ_NONE (I guess
saying we handled XRERR is OK, looks like it's an or of the other
sources).  Either unconditionally ack everything or return IRQ_NONE if
the driver doesn't handle anything - the latter option is better and
closer to what you have here.

--gpD07/c6JxvXcqO5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY0oZAAoJECTWi3JdVIfQusYH/iPLW0Qee9Yr42GT/JY5VRqz
awwgE6pORT5LcRoZi5/I8M1N0kZzu/fUKqzeCnEWqj4D1XIHazXB/QUErpBi8GSV
V4+urXCFvp6o/XIIriOxx1Y3+BhsLvTIGWu0nR4KpusDEVygfX8aP5NSGJQkO00c
ALlrxcKxo+nja11IsrECAJi+3DzuM24MWE+LoJ2mmSS/of869aRaafkbPNPZnMVm
zJz77VJuWmP8D88cc4aayh0usKlVlWJBvRkRdzri2wb6Oah124tHbJ7p5apkBLII
zH4SCOiIy/rwbuEo3LMBQSxwEAnFVMWOGxULHjngVoXgaXHkk5KJkoJnfd4CKMU=
=RbYf
-----END PGP SIGNATURE-----

--gpD07/c6JxvXcqO5--

--===============8766334990328356449==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8766334990328356449==--
