From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5663: Delay and retry reading
 rt5663 ID register
Date: Thu, 9 Nov 2017 11:21:38 +0000
Message-ID: <20171109112138.xz7qjrixlexv5qm6@sirena.co.uk>
References: <1510210091-10848-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4469357693394413166=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 328FD266B80
 for <alsa-devel@alsa-project.org>; Thu,  9 Nov 2017 12:21:40 +0100 (CET)
In-Reply-To: <1510210091-10848-1-git-send-email-oder_chiou@realtek.com>
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


--===============4469357693394413166==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kzkmdtenwpr3nf44"
Content-Disposition: inline


--kzkmdtenwpr3nf44
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 09, 2017 at 02:48:11PM +0800, Oder Chiou wrote:

> +		dev_err(&i2c->dev,
> +			"Device with ID register %#x is not rt5663,"
> +			" retry one time.\n", val);

This still splits the error message over two lines - like I said that'll
make it harder for someone to search the kernel source to find where the
error was generated and understand what it means.

--kzkmdtenwpr3nf44
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloEOkIACgkQJNaLcl1U
h9ArNgf+NEiERX/vyPqKu0aLDadztN+3e/ENBAW/q6hlfc6brYfJzXzGAfol2c3b
dh1tbi15TVR6RCQXKcy5wEtAZIWDdxfXNVrRF2dOLaq3o3cVZgXxEJ4q9ye9d7NE
2XrZSo8VrWgML6UogvYYyAhtR+bRAQyiJtHrRKATaX5KqqiaorzMbkT2Z8kR+FBP
/VtqPW3V3JJHkvAl5m18AWgz7N9w0D1dqupRsPbRG/gCpO34OY+mMrWMVLLK0+e9
03NXSt3kusiXliLw4RXK5ZCl0u85hwSBRDEQ891iZdAnBFQIUNB/NDS7dDm9WHJT
h6+ngeLeY6cW3S+Sep5vYHwfF+S1ww==
=liEI
-----END PGP SIGNATURE-----

--kzkmdtenwpr3nf44--

--===============4469357693394413166==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4469357693394413166==--
