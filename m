From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: The ACPI also should use the
 function rt5514_parse_dp()
Date: Thu, 2 Nov 2017 11:30:22 +0000
Message-ID: <20171102113022.nfhb2wfw7p4bl3am@sirena.co.uk>
References: <1509621676-14608-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8044478289504721874=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5DC13266DEA
 for <alsa-devel@alsa-project.org>; Thu,  2 Nov 2017 12:30:25 +0100 (CET)
In-Reply-To: <1509621676-14608-1-git-send-email-oder_chiou@realtek.com>
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


--===============8044478289504721874==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2vjzy47zxaeudtyq"
Content-Disposition: inline


--2vjzy47zxaeudtyq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 02, 2017 at 07:21:16PM +0800, Oder Chiou wrote:

> -	else if (i2c->dev.of_node)
> -		rt5514_parse_dt(rt5514, &i2c->dev);
> +	else
> +		rt5514_parse_dp(rt5514, &i2c->dev);

Should this be changed to i2c->dev.of_node || ACPI_HANDLE(&i2c->dev) or
will the function cope fine if there are no properties at all?

--2vjzy47zxaeudtyq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln7Ac4ACgkQJNaLcl1U
h9D8lAf7B5E7yXkP8c/FohNM+aVQodOBe6zl13OeDEFmH7DFcvImClyKTJ5AOLyb
MoVXPv5vJ0V1Brkl1PmPzD6jEm3QK1h/Obp6+t97C33wTOpBA4cRG+o2paehxDR7
m/uKlwujMs9w9yoXLJxeLTzyfBNM43uL6sDgas0isN1nEz9GjMCZ4T/1TO78fNJA
dO70KKOLzkWuxS6j9TBFtt+zoYX6a3m7FT2H+HjKV+/+Jeq0zT+NjiwjWJun5GIe
aCl2fxUQnEd5RMkHK7xRSkJnGImzKX/gt1gV/lEyfcdCoWquEa3mRgtDpXViicax
XONqc0ekJ/KqQY9FNEsTkzQpSyhjyg==
=Ifs+
-----END PGP SIGNATURE-----

--2vjzy47zxaeudtyq--

--===============8044478289504721874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8044478289504721874==--
