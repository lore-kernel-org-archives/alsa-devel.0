From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: Add mc13783 codec
Date: Tue, 15 May 2012 19:27:41 +0100
Message-ID: <20120515182737.GF19592@opensource.wolfsonmicro.com>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
	<1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
	<1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1423797921817331002=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3283824DDA
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 20:27:44 +0200 (CEST)
In-Reply-To: <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>
Cc: alsa-devel@alsa-project.org, torbenh@linutronix.de, sameo@linux.intel.com, s.hauer@pengutronix.de, festevam@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============1423797921817331002==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="924gEkU1VlJlwnwX"
Content-Disposition: inline


--924gEkU1VlJlwnwX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2012 at 01:53:50PM +0200, Philippe R=E9tornaz wrote:
>=20
> Signed-off-by: Philippe R=E9tornaz <philippe.retornaz@epfl.ch>

This looks broadly good from a framework point of view but it's a bit
depressing that there are so many magic numbers even for register names
- it makes the code rather impenetrable and I wouldn't like to be
maintaining it.  I'll go ahead and apply it if Samuel is OK with patch 1
going via ASoC (there's a build dependency).

A few smallish things, please fix incrementally (or roll into a new
version if you're resubmitting for some reason):

> +	snd_soc_add_codec_controls(codec, mc13783_control_list,
> +					ARRAY_SIZE(mc13783_control_list));
> +
> +	snd_soc_dapm_new_controls(dapm, mc13783_dapm_widgets,
> +					ARRAY_SIZE(mc13783_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, mc13783_routes,
> +					ARRAY_SIZE(mc13783_routes));

These should all be assigned in the CODEC driver structure.

> +static __init int mc13783_init(void)
> +{
> +	return platform_driver_register(&mc13783_codec_driver);
> +}
> +
> +static __exit void mc13783_exit(void)
> +{
> +	platform_driver_unregister(&mc13783_codec_driver);
> +}
> +
> +module_init(mc13783_init);
> +module_exit(mc13783_exit);

module_platform_driver().

--924gEkU1VlJlwnwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPsqAPAAoJEBus8iNuMP3dy5QP/1GkNsvumQBMR8mwWlrchAtH
Br8mQrb6tp2/havQOFS6FAVvD19TjTJqIVqHLAtJUmhTGKg2C2MmPncN5SaFwlxI
go2u/B4WrNQ0BCuNT5lQ2g+IwxFA+KOESRzL+1r/8DKKXUlEWDiNEYwgM6hl8F/p
w+BEkTVR/CQmYRp7DOsT0bmFPzgLoyzqRrmipBHVQaKnhdkt0WmUT38Dh6+2bbTX
THkb63nXYsXoO75vZ56yX6o19msh4/Zz8torJqxaUibbSVB+l1gfEWEXsdT3XgoI
7Q5SOAefQuA4ooZ6CC22yoq+97S+UKJ/Qu0kLwnkkD5fGISFydQD2MyqLzxYnnhz
ZACZ0d1FZYq5G6Tb+z6eKtpzL3Lvg8isG93IOQoPU/8dIF+gQn9nadZNWPWo2OsW
SsNuQGp5y4NvvsxsmOdrloeDlGRLCJcfz4DleXYf1OB1n25pz5tNs7xhBKgmhTKG
Pq+YYXDoS0aFtyi+8+ySPnRWa1rDY7nOLRbNDCRV+Qrnsru/iH5Oa8mcuZBmofrg
QjhA5TH0PI0Xl0PWq86Si+aukzgxGztXkVHWfckgh/lkGL9GLdwh56BOizFUXLw5
44jfBTnxSzShvGOuIn7erkURPXIT43XlLb02Ds/WrM8pg6haHv+YBZ0oCr8KeR3G
6Bj7PopEfaqDgqDV+jDi
=htAU
-----END PGP SIGNATURE-----

--924gEkU1VlJlwnwX--

--===============1423797921817331002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1423797921817331002==--
