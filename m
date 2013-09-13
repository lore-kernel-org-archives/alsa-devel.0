From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: Add ACPI probing support.
Date: Fri, 13 Sep 2013 18:30:35 +0100
Message-ID: <20130913173035.GQ29403@sirena.org.uk>
References: <1379091456-7223-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379091456-7223-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2441066664108637792=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 6AE2A2610D0
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:30:37 +0200 (CEST)
In-Reply-To: <1379091456-7223-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2441066664108637792==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWJ7C1SUOhSBllWh"
Content-Disposition: inline


--HWJ7C1SUOhSBllWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2013 at 05:57:36PM +0100, Liam Girdwood wrote:
> Allow the RT5640 to be probed as an ACPI I2C device.

Applied both, thanks.

> +static struct acpi_device_id rt5640_acpi_match[] = {
> +	{ "INT33CA", 0 },

Wow :)

--HWJ7C1SUOhSBllWh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM0u4AAoJELSic+t+oim9soUP/3RvIp4TZjiRTr1nGse/Yjia
F+G6nraZc8LW8VtHDd3dLjEhHBL6jrbQwuvBk0jeu+gDHC5WCae/TQC3rb4kiy8d
T+J6OrldQYB6Y9RWvPOKtz7a/CmK6OsPZ/MBqjp5N7WQyy8+dPJQYUg7B0xxNT3H
+cl6Ms/njHewshNpROU4iibo1AdEKFGAQJIQAHpT0I1ybMeu7g5+1QC39+RDtnrf
owicj+JLM3xt58Er1IBZ8+hkIhBYB89aUevK81Y0S7JVkEwBl+EyOoG7E9hUThHl
2BQJyaCvU9WgPMvx5e+0tyj/Om031jjjkKc5INw8RbV7J82yfSNmtWKRSuK5XzWB
BdyWgLBiiboZvIbzXya/hxbIa9GRGWS2vhxal0kn6sXo30Oww2sdN1iMj9wQcDRw
Yy69LskH2IMxL/tjIl4LIZfV3D/KQGe2QZO/Ow3EAM+SDkEWLjm+9MFBOtc/xuXV
rvknUoSejfvg2kCy9bEWT9/BW3ijQUMMzaHG/whqpKX/ddMFUjsXWgBFGHk0BIHi
E9DjfL6c6NilA3pNVlvj6Ud5JQxXewOvSXpj2Ijx15sYhlKi4saXlWYGzKAcWFOd
Ingir4Hvi4eFdDq2k4azLVXh311Kv7j6VL9A+2k0gOoFAE7JewlJquJf4iTYX89c
fpC4Y6tYWvEsWSrUK2v5
=RAbK
-----END PGP SIGNATURE-----

--HWJ7C1SUOhSBllWh--

--===============2441066664108637792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2441066664108637792==--
