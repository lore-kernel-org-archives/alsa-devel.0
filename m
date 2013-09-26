From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: imx-sgtl5000: do not use devres
 on a foreign device
Date: Thu, 26 Sep 2013 12:02:10 +0100
Message-ID: <20130926110210.GJ19304@sirena.org.uk>
References: <1380115268-32118-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3318743597589331482=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 64D2D2625FE
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2013 13:02:14 +0200 (CEST)
In-Reply-To: <1380115268-32118-1-git-send-email-p.zabel@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Sachin Kamat <sachin.kamat@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: alsa-devel@alsa-project.org


--===============3318743597589331482==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qD3brAgIG4LbUq6d"
Content-Disposition: inline


--qD3brAgIG4LbUq6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 25, 2013 at 03:21:08PM +0200, Philipp Zabel wrote:
> Calling devm_clk_get with any device pointer other than our own confuses
> devres. Use clk_get instead. This avoids hitting the following warning in
> the imx-sgtl5000 error path:

Applied, thanks.

--qD3brAgIG4LbUq6d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRBQvAAoJELSic+t+oim9YfEQAJFON7rVV8Jbz4VUb1lBQ1VM
bewKjcFnES3g3RjUkdZR+7X/pJVV4FkJfRWT1etQsm8g24nLWSB6eXcurBu3B3oQ
WHZ3om7+43iZ0IbhAcfLOLxOqJk9NlAbIJNxTpYMiNNOKOPFagH1Y1lXzpAmRvvD
ZhaMEFCDq9PP1HX2QbwrobVrFg8fA5RUZ0WvIc4639kF3AjwbiH5I8VomykICDW3
lbOt9eWPU/Qdkom3IRL/EOJAmyEjNy9rMGUDNNE0+ruG2MnKuEkwaFHNrtpoXwwE
8wyMXujSxv11N0GnTFwzOKjt4ErKtXQHnaT4+DopsO8V2hZswXrDFEzfqK+9Gg4x
GQ7uPkGAiYmiWsWxRtif0PPM5Be8sFlqtBG4ewt9ZcdzRKP+ZHBwCAOCn3PNEnzO
iSUMgPXxx27B9HTweRutsBywcLv+req32BMp4WgO1re7Nsp0V4jpgJA/LVLUFS1r
dBkVrcccK8X3HnCsgidmeJi4I7H0VmAJvvWuBy9nOV617XJWsykxWEczQb70wpqM
8ZhYQOSjvdi7ki3YIQ1sZujJTt0uC0OlPuDONIhV6VWMGGswugQ5AoQPSBe19UnM
4wmugroeo9xs+te4U4Eb1UP3PkVYs5FuBOnvfPofKa76UokRZYv/qg6G8j/O3kUf
hv2SUm6mch8Dog0ltuPi
=aWuJ
-----END PGP SIGNATURE-----

--qD3brAgIG4LbUq6d--

--===============3318743597589331482==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3318743597589331482==--
