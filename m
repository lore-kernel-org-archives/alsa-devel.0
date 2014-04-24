From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sgtl5000: Use
	devm_regulator_bulk_get()
Date: Thu, 24 Apr 2014 18:32:55 +0100
Message-ID: <20140424173255.GF12304@sirena.org.uk>
References: <1398359588-4200-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1340582810385542685=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EE95A2652E2
 for <alsa-devel@alsa-project.org>; Thu, 24 Apr 2014 19:33:06 +0200 (CEST)
In-Reply-To: <1398359588-4200-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1340582810385542685==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8tlh5Aq3jm8a5gL+"
Content-Disposition: inline


--8tlh5Aq3jm8a5gL+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 24, 2014 at 02:13:08PM -0300, Fabio Estevam wrote:
> Using devm_regulator_bulk_get() can make the code cleaner and smaller as we
> do not need to call regulator_bulk_free() in the error and remove paths.

Applied, thanks.

--8tlh5Aq3jm8a5gL+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWUrDAAoJELSic+t+oim9LF4P/jQ0hoK5GcpZ1QGEYbZ/hbkk
hhpK1LnRFXlQ/TtkklKuaCFJ41U/w9u+DCYVVQV4dOg6RSW/3UXh2q3Dbzy0xre1
vcstpO9pUdlYqK1ugM5xdMuj5p3HWajf8aXRYWtE7kQExCFVFWOkBCye9A4Msz6r
mEA/OLsl3HcOVVgc/KKpi8yYhAxkKYgCeXXhjwFQ63ualqXZSRjenU6CZpcd8kTh
o3HYuXDcuJp3lph5cwEL5KoD8yUujzPR6peBKqJI5EkcPquBDSAhaTaXwXA/Fuky
cafPvHmCMyBec5NFOlvaCjmEdh68T3croaau7eYKVyEwUogxtz0hnXx+jZLY5G9p
XfPtkpZypSa1LzoWGH4tlR6sTYyuFwO3e2SYM6gDrVbcC5pnfiZuPBsj27IEHc4p
mpIzztEn10ESs0OKjchFLC/gxfCNT5cAJi8Pt7qXky9ux4Kf4F3z10sEMNBlFUu9
sa/FPUPWX3HySUkaDsvqMNSKkxIVNxKqJbZNIf/SdkbTydO1TvR6fCahre8o5hSi
235QIPTdNoIS4zOQ2Fsbgihqg8UlRG8UHJZkFlq8jp6mS0y3k9/ZDM1OwHDcfwOH
BvXSOHD52MoOxEEEXjA6Bu/hYuMmVa4IVFid4e7UWGSTW8n3jVx9AnaeeXUjzxi8
VC/xleNvjKpQQWFfAT8X
=7XMC
-----END PGP SIGNATURE-----

--8tlh5Aq3jm8a5gL+--

--===============1340582810385542685==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1340582810385542685==--
