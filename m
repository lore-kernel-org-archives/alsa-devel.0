From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Fri, 17 Feb 2017 10:40:47 +0000
Message-ID: <20170217104047.vhrcehhojpkdeksu@sirena.org.uk>
References: <1487296533-20893-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6815052219497371416=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 42A452668B2
 for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2017 11:40:58 +0100 (CET)
In-Reply-To: <1487296533-20893-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, WTLI@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============6815052219497371416==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ilkbycesqy7cfxq7"
Content-Disposition: inline


--ilkbycesqy7cfxq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 17, 2017 at 09:55:33AM +0800, John Hsu wrote:
> configurable LRC and BCLK divide. The driver
> will make configurations of LRC and BCLK automatically according to
> BCLK and FS information in master mode.

> -       unsigned int val_len = 0, osr;
> +       unsigned int val_len = 0, osr, ctrl_val, bclk_fs, bclk_div;

This is still broken, the above has tabs replaced by spaces.  I think
I'll try to fix up by hand but it's going to be fiddly and that's a one
time thing...

--ilkbycesqy7cfxq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlim0y8ACgkQJNaLcl1U
h9B0lAf+INF8MZfQ/aN3uVBzv6jwe0B+pI9xSTYAC90TeOSuk10FtEPrgITstKGk
rfrS5bBVr8vOc09C8WG8/XRnCQ8MOqMAKnY0Vov2i7XTx0i+G7cCT1KUIZbRbKxV
bIu6dHZHYgfzY8AcSS9cHZUvPcmu84ODrjjW6HGdQNao0p3zA28DpfPgZ8Ztl5SF
KvaHulayAQixnbIX6h3Cyx95dv8ASOp9x3Gee/gslWAKVlPO6CY/l2hAC/JkqBty
6Y+1Vin3eWech0ArYH7AbtQJRmrNrnyJDjNg3cdhLY8uJS3S1V91qiRq4hJKrjts
0d4kVJvIP4jCRlTHC08jqDPWOSGXtg==
=jUMq
-----END PGP SIGNATURE-----

--ilkbycesqy7cfxq7--

--===============6815052219497371416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6815052219497371416==--
