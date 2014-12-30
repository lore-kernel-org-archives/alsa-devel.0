From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] ASoC: wm8962: Allow codec to work when
	CONFIG_PM=n
Date: Tue, 30 Dec 2014 16:22:03 +0000
Message-ID: <20141230162203.GF17800@sirena.org.uk>
References: <1419955096-18810-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2438130572854576077=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 798A7260672
 for <alsa-devel@alsa-project.org>; Tue, 30 Dec 2014 17:22:19 +0100 (CET)
In-Reply-To: <1419955096-18810-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b50113@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============2438130572854576077==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LVR+8coIF8rm+jIU"
Content-Disposition: inline


--LVR+8coIF8rm+jIU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 30, 2014 at 01:58:16PM -0200, Fabio Estevam wrote:

> +	if (!IS_ENABLED(CONFIG_PM))
> +		wm8962_runtime_resume(&i2c->dev);
> +

A much neater idiom for this is to have the probe() just default the
device to being runtime PM enabled, then if runtime PM is enabled it'll
work out that the device is idle and power it off but if runtime PM is
disabled it'll just stay powered.

--LVR+8coIF8rm+jIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUotEqAAoJECTWi3JdVIfQBcwH/jYsmUA4AhTfAFhTEUhBh5IW
sumz6Od17dbhjqBFdXJHiMpsa8gXHHXYxKoaGO6Mf/YNgzYB27mOTeGWpsUIV/+a
hgFGTaZz3aYytZnW/xEfn7MYVSKYYpswU2fg8MaA//emXLxB596cskfsyyeVqeCo
jMpQ5iH7vhxBuH/WsFAbgb+sLGbb3KY88LKbYcU3s0l821GCfoLmeHawl36zQ9w4
s1Omgsyno6M0babcx1iXbcc/R2Rg1Jjw7U9St23i2VfZgVYpM3a9FfWdFtyKyob/
aT4RS/BTJGAOY1YhqLZJ42rcIRJRC1tCg+RifLIit1ytzjWbqmzxb7nlVZ4DrRY=
=bpW1
-----END PGP SIGNATURE-----

--LVR+8coIF8rm+jIU--

--===============2438130572854576077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2438130572854576077==--
