From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 3/3] ASoC: tas6424: Allow disabling auto
 diagnostics for faster power-on
Date: Wed, 2 May 2018 05:43:34 +0900
Message-ID: <20180501204334.GD2714@sirena.org.uk>
References: <1525077018-15863-1-git-send-email-jjhiblot@ti.com>
 <1525077018-15863-4-git-send-email-jjhiblot@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3000034683114810374=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E8EC266C1C
 for <alsa-devel@alsa-project.org>; Tue,  1 May 2018 22:43:39 +0200 (CEST)
In-Reply-To: <1525077018-15863-4-git-send-email-jjhiblot@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com, afd@ti.com, robh+dt@kernel.org, dannenberg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3000034683114810374==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wULyF7TL5taEdwHz"
Content-Disposition: inline


--wULyF7TL5taEdwHz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 30, 2018 at 10:30:18AM +0200, Jean-Jacques Hiblot wrote:

> +	SOC_SINGLE_STROBE("Auto Diagnostics switch", TAS6424_DC_DIAG_CTRL1,
> +			  TAS6424_LDGBYPASS_SHIFT, 1),

This should be "Auto Diagnostics Switch" with a capital on the Switch.
Otherwise this looks good!

--wULyF7TL5taEdwHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlro0XUACgkQJNaLcl1U
h9AMVQf/S1qlSoIDTPu+x4kDJz0jWfL9QIuRRefE1IknLjIvgUF89vQxe9JXmsE8
7S7jpISlPBktDaqieBQs5JDETcHJb7HTHeCLiGNJ0JEXtsVHbotpbfpLbL6W0Jnd
Zcr/Be27wRc6LhOHUceomVmjKy3zb1+PtEj8F2RqTtisQNtGEDgVdwFwNsf9Et7h
hZ8zf3ww69ceTVrzjtQ3YOs8sUDZXL6ncC53pwZhWTzoFZwcdYlhwZyO7yfRPkAP
JdkozvfpVBmRuUZEZZV6nUSVQt2oW4OWjFjab29DkiQAXfwZncubDVX6MKXy7Yi+
Iu5HN/dzjKxoWeMRxNZv89UZv2rCRA==
=cyd3
-----END PGP SIGNATURE-----

--wULyF7TL5taEdwHz--

--===============3000034683114810374==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3000034683114810374==--
