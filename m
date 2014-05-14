From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/6] ASoC: ak4642: Add support for extended
 sysclk frequencies of the ak4648
Date: Wed, 14 May 2014 12:34:14 +0100
Message-ID: <20140514113414.GV12304@sirena.org.uk>
References: <1400053058-1115-1-git-send-email-s.hauer@pengutronix.de>
 <1400053058-1115-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5338561053574911317=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 300C62652C6
 for <alsa-devel@alsa-project.org>; Wed, 14 May 2014 13:34:25 +0200 (CEST)
In-Reply-To: <1400053058-1115-5-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============5338561053574911317==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmjW4B30BOVDDQ/7"
Content-Disposition: inline


--tmjW4B30BOVDDQ/7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 14, 2014 at 09:37:36AM +0200, Sascha Hauer wrote:
> Additionally to the ak4642 pll frequencies the ak4648 also supports 13MHz,
> 19.2MHz and 26MHz. This adds support for these frequencies.

Applied, thanks.  However...

> +	case 19200000:
> +		pll = PLL3;
> +		extended_freq = 1;
> +		break;
> +	case 13000000:
> +		pll = PLL3 | PLL2 | PLL1;
> +		extended_freq = 1;
> +		break;
> +	case 26000000:

...the sorting here is a bit odd - we do 19.2MHz then 13MHz then 26MHz.

--tmjW4B30BOVDDQ/7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTc1SzAAoJELSic+t+oim9Ty8P/2eOm2liRGclKVaJ58k8ih3a
RkIXsk2ivLWdj8gTeeWwqJdNjmVFgXMCNdh32rhwlFVy0yeQ7f7B/GxiotOdrjeQ
SKomVO8HpGS4mWRtz4URaZyLwYlSRIMUKGxwi2nLqsFMltNp2/FaO3E1SLDBEiZb
0LoatD+ShfeiGfncDCs/V4pZlYHDJBF37hOQ5l68VLjIe4c92Bxc53vpssKMqNxi
81kKhOsc0zYU82PMIhOMfI7Ff7ok5trehmOenO+BBHWZ0bJ/Q2coR8+Apo8VAX3H
sccY5DAoeKe/NeHtT99/K9bbBWxefh47q8qAeFGssdu8EEwL68xXywG8ecu054WG
opRY/EfZTzko47mj7qH/32fJwfR73f/Ae3+BzAl1/L5+gOmp2TjV7h0mof37X+50
r2mgn0VYlHmbMqv6oHy/wrxbO7vBZP80azMEPoM4dl2LIdKyF1xv/h+NEzCBbQoC
l4+zu6DlI/8h8dI+U69GIgARNxLKArFO3X0GPXMjc1ye1I/DLzhvhGPCq1wJ4qgG
hgEosDU3UCE+cxjkdcSVqZiY8ENhvy0V0FMXJhjybkweEj3D7rOFaHz4KbafD//4
BZ8HYP6KmmfxXY8pt4vRVeF+UIoh7yAG1sI4opgJ8mnl/ZjPnVz/D6fNhEa/itWp
v2Cr7Pufjo4d82rQRqr8
=+0ZA
-----END PGP SIGNATURE-----

--tmjW4B30BOVDDQ/7--

--===============5338561053574911317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5338561053574911317==--
