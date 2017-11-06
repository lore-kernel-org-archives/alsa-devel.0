From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5663: Delay and retry reading
	rt5663 ID register
Date: Mon, 6 Nov 2017 11:30:14 +0000
Message-ID: <20171106113014.674htnbx2i2dk2as@sirena.co.uk>
References: <1509949082-21443-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6496842458163640389=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E44F526713F
 for <alsa-devel@alsa-project.org>; Mon,  6 Nov 2017 12:30:16 +0100 (CET)
In-Reply-To: <1509949082-21443-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============6496842458163640389==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s62xzyx6hq52mjuu"
Content-Disposition: inline


--s62xzyx6hq52mjuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 06, 2017 at 02:18:02PM +0800, Oder Chiou wrote:
> In the probe, the codec may not be ready for I2C reading. So if the value
> is not correct, it will read again after delay.

Why might this happen?  This sounds like papering over some other
problem.

--s62xzyx6hq52mjuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloAR8UACgkQJNaLcl1U
h9DFvgf/eqD6oxVuP+/4oA84mZ2lYIDtTx1vrm0ESQm7j0S94bGM1B5b/yyiPhyn
BteIqIqrXRpfagcAJb+C//3LKQsNLtATDETtDp8JUjLis+JMkYGEXjUEzbRUMGcj
9/w2B01Q+q0GQw05pEJPHngQTNlyjgjVhDTgz+g2qJyNwLIRMS074Kus9Hjgzgq+
ncjctxUeFR+9369O+3oHFeLPwzG1gi0JeHEby+s3uGD6WOAbrjc2jw9e1Xvp7IQU
81KzVyRw147mVlDsiiFXvrNMpmCvyr8EBTzeWbH6rVmrVAzT6ABVUyEy7iOHVIbN
L5gEtzSzA35uuIfC7M3RCyZoIKVuyg==
=xORs
-----END PGP SIGNATURE-----

--s62xzyx6hq52mjuu--

--===============6496842458163640389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6496842458163640389==--
