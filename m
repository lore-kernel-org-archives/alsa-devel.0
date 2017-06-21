From: Mark Brown <broonie@kernel.org>
Subject: Re: ASoC: nau8825: default value for property
Date: Wed, 21 Jun 2017 11:56:31 +0100
Message-ID: <20170621105631.7snp3eeebngkda4n@sirena.org.uk>
References: <1498027446-10807-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1138355709285631347=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 32143266A0C
 for <alsa-devel@alsa-project.org>; Wed, 21 Jun 2017 12:56:46 +0200 (CEST)
In-Reply-To: <1498027446-10807-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============1138355709285631347==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="o3nxv2uze4kmiyxm"
Content-Disposition: inline


--o3nxv2uze4kmiyxm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 21, 2017 at 02:44:06PM +0800, John Hsu wrote:

> +	if (nau8825->jkdet_enable != true &&
> +		nau8825->jkdet_enable != false)
> +		nau8825->jkdet_enable = 1;

Won't jack detection require specific wiring on the board (if only
connection of the interupt line)?

> +	if (nau8825->jkdet_pull_enable != true &&
> +		nau8825->jkdet_pull_enable != false)
> +		nau8825->jkdet_pull_enable = 1;

Usually we'd just use the chip defaults...

--o3nxv2uze4kmiyxm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllKUN4ACgkQJNaLcl1U
h9Bkqwf8Dg0L/jEsJeRAxY8pKPP8nvzKwc1debB/NFeWavuL0hIHL7N4Jdwu0QYU
sMNtriAO1Toc7cq4Wv64Pmld7h75Rk1qm6WJs1saeXiJc8eZSEB1cP05RXRw+Vsb
rN91Eph9JRyxXzgR0ASqUCUbmXxFmBOLNMgYrtMRjsevuULKHmZcLxdgFyOWmNq2
hBEJ2CIP66GH4QHqK4BEi6j8pPnYcGiO0uZoY+Ooe9Z29pP7KA8gM2N53UkcDH3B
Ftv5QL6N4lyTqlRBhacu7vba7lXJVxu+Sc6E3GLcuu0n3lVkuDvpgG6ocdVITbFN
VDqGujVsHaixnE/jT1g/SjMtYZsJDA==
=76aN
-----END PGP SIGNATURE-----

--o3nxv2uze4kmiyxm--

--===============1138355709285631347==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1138355709285631347==--
