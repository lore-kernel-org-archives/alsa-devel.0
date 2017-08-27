From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch 1/4] ASoC: dapm: fix error path in
	snd_soc_dapm_new_pcm
Date: Sun, 27 Aug 2017 13:43:05 +0100
Message-ID: <20170827124305.ux5jj3uzycf5eqm7@sirena.org.uk>
References: <20170826082925.35472-1-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7532623693645062903=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C76A266998
 for <alsa-devel@alsa-project.org>; Sun, 27 Aug 2017 14:43:09 +0200 (CEST)
In-Reply-To: <20170826082925.35472-1-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============7532623693645062903==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uygekdp76rlxnsu3"
Content-Disposition: inline


--uygekdp76rlxnsu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 26, 2017 at 01:29:25AM -0700, anish kumar wrote:
> Before freeing the memory, check if it was allcoated.

> -outfree_w_param:
>  	for (count = 0 ; count < num_params; count++)
> -		devm_kfree(card->dev, (void *)w_param_text[count]);
> +            if (w_param_text[count])
> +	        devm_kfree(card->dev, (void *)w_param_text[count]);

There's no need to do this, devm_kfree() will handle null pointers fine.

--uygekdp76rlxnsu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmivhoACgkQJNaLcl1U
h9AeNwf8DyJb15LHy7IO8LmznVZH9Dxb75EeV/U0XMuIYy0lKUjk8BSLcsOfDfNT
aVJg9fpjK7UsO3XPrTy0SIjqBGuFyeXaGvAHwqx6XpBs7O/efRyk7jWRd4seltxv
6FuN3KiU7A8D/2t/ovb0ii/gbXKF2Aq9+ZEzAwt69dmICAv8ZLSzfPtw7eFIeDBd
QOGzvctZ9oybEd6U+c+Gvk397pLZbSLyPNEpO5aR+QX7myOjiGIQGyJ14etNZJIM
Oz8LP3Z2Yn9uuEK1fQ3scxpKr3uto+pAvaEMajfOoN+prR/IP2Z/o/t+T6UD1/Yz
onU+mhd46PB+3Zpejs4MTOE3StzpwA==
=lfeS
-----END PGP SIGNATURE-----

--uygekdp76rlxnsu3--

--===============7532623693645062903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7532623693645062903==--
