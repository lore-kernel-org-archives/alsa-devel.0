From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: pcm3168a: remove read-only status
 register from snd_kcontrol_new
Date: Wed, 17 Oct 2018 20:00:53 +0100
Message-ID: <20181017190053.GJ24097@sirena.org.uk>
References: <87murdz6nq.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6556705808732217812=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F39162675A4
 for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2018 21:00:54 +0200 (CEST)
In-Reply-To: <87murdz6nq.wl-kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============6556705808732217812==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="x+WOirvrtTKur1pg"
Content-Disposition: inline


--x+WOirvrtTKur1pg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 17, 2018 at 01:55:01AM +0000, Kuninori Morimoto wrote:

> +#if 0
> +	/* read-only status register needs clocks */
>  	SOC_DOUBLE_STS("DAC1 Zero Flag", PCM3168A_DAC_ZERO, 0, 1, 1, 0),
>  	SOC_DOUBLE_STS("DAC2 Zero Flag", PCM3168A_DAC_ZERO, 2, 3, 1, 0),
>  	SOC_DOUBLE_STS("DAC3 Zero Flag", PCM3168A_DAC_ZERO, 4, 5, 1, 0),
>  	SOC_DOUBLE_STS("DAC4 Zero Flag", PCM3168A_DAC_ZERO, 6, 7, 1, 0),
> +#endif

If you're removing these just delete them, no need to leave the
commented out stuff.  It would be good to understand why these break
though...

--x+WOirvrtTKur1pg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvHhuQACgkQJNaLcl1U
h9D7Bgf+PFneUp+Cjq/cJUMGuPfEwH/ltxzSclYe50DFghYwEV9i2OVPM0/B9jAH
l+lq7WxQGOLXw1xEtDH9U3LiVFRgkuHlFBnoJKtBI08IPbn7Vq4BNeI1mbaWbK2p
CHWb9TNnhZE6bynesuenaTZ83i0279a/9a3+nECHe4/b3F4ZxE/EpgcjoL2ouVzp
oiZ+yKgERn3uLwpVDZBN/G6v04Wt+g2Rf1iqULxaV/FrCNwJoUE4JwVVEiGUVccz
tbI1toe4mfs2v0hq9gGWaJ8nrai/kLcUWWP9+Z3CI3veF53eQDNBT/4ruBge4Uva
fxLay+oRsXshmTgEzbuaofEb4vcipg==
=5XsY
-----END PGP SIGNATURE-----

--x+WOirvrtTKur1pg--

--===============6556705808732217812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6556705808732217812==--
