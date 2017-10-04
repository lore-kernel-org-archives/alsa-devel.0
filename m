From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: img-i2s-in: Add suspend / resume
	handling
Date: Wed, 4 Oct 2017 11:37:22 +0100
Message-ID: <20171004103722.4bzjimc74cupnuto@sirena.co.uk>
References: <1506938333-550-1-git-send-email-ed.blake@sondrel.com>
 <1506938333-550-2-git-send-email-ed.blake@sondrel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6027218295538142945=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 40349266B20
 for <alsa-devel@alsa-project.org>; Wed,  4 Oct 2017 12:37:24 +0200 (CEST)
In-Reply-To: <1506938333-550-2-git-send-email-ed.blake@sondrel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ed Blake <ed.blake@sondrel.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============6027218295538142945==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bxjmfrg4jteit5fo"
Content-Disposition: inline


--bxjmfrg4jteit5fo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2017 at 10:58:52AM +0100, Ed Blake wrote:

>  	i2s->dai_driver.probe = img_i2s_in_dai_probe;
> +	i2s->dai_driver.suspend = img_i2s_in_dai_suspend;
> +	i2s->dai_driver.resume = img_i2s_in_dai_resume;

Why use the ASoC specific power management callbacks and not the system
ones?  It does also look a bit like there's a case for converting the
driver to regmap and using the regmap cache code.

--bxjmfrg4jteit5fo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnUueIACgkQJNaLcl1U
h9ABWAf/d7Yc0jedRAmGLJUq2aPztBg+emLhT8ND0bzxWoek1XDK+PQf2IJhiyKA
8wxFw8z0B7jOXVitBpB+VDHCxeIuWu+0jFXCxEC14KNsurtBPlFnd+Nz69Im0mJU
BAZh/9NXTB3L+cYrgmRHDYHVm6dbMaRT0w9ndlP+4bifWi0qlJa4rm33KXVpTnXd
jBQ5uPKS8yMWjvSTd7wFSSvyoSntL6uKCSsGjt7pj5MpdyB+Amj54KXJYKJi16+y
i0Wl2JkDZvZEkV6I8ScRpKxi8eusuPtppD+mE8x2N822sedLD4gm+yipVORz0wZ4
k3p7O4L7Y4PMni1kHIpzYE4s3mTOxA==
=Z9iU
-----END PGP SIGNATURE-----

--bxjmfrg4jteit5fo--

--===============6027218295538142945==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6027218295538142945==--
