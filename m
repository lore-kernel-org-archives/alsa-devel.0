From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH -next] ASoC: sun4i-spdif: drop unnessary
 snd_soc_unregister_component()
Date: Mon, 6 Feb 2017 16:32:55 +0100
Message-ID: <20170206153255.emowvun4nlssiyvs@lukather>
References: <20170206152224.7566-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6483132919071013805=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E86D266DB0
 for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2017 16:32:56 +0100 (CET)
In-Reply-To: <20170206152224.7566-1-weiyj.lk@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============6483132919071013805==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oxiextlhxr6nv5zu"
Content-Disposition: inline


--oxiextlhxr6nv5zu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 06, 2017 at 03:22:24PM +0000, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
>=20
> It's not necessary to unregister a component registered
> with devm_snd_soc_register_component(). Also removed
> pointness clk_disable_unprepare() from error path and
> snd_soc_unregister_platform() from the remove.
>=20
> Fixes: f8260afa444b ("ASoC: sunxi: Add support for the SPDIF block")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--oxiextlhxr6nv5zu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYmJcjAAoJEBx+YmzsjxAgFP8QAITSZ06hkN1E6Ga89VAMK/Of
WUXt7HUxkCLUWrApU9AAR3WaBoWQd8pc0ajzRJWsQwm1VZNEd//kQ+IpKdqwjkNx
ADXwZApUoqBL5SloPVV97qLSE74PhfUgVG22/0d0yqGXLgjOatObV5MQytXOWgJ4
b/4wm0AiUEdCfh+jxkuS4bvnP+tmPPGbB5cbT5xuI+hoHETI1cSyTloeIzUJDBQw
ANLD6TpeEGev/rrbd3JQu7cYp91ag//6CZM6EbaFiM5DiO/Ks4Qvi6mU1+V8UEh1
jWw7m7BDwt9qiB+7p9kxt9nsTOMUckYyc8w09wgPkc+8JcmbfK9NAdfje+G0OPT6
8uodAHQBiVeuant3G8UeH6jdhGnsM0RbXqBM6CfAUmZOg+qeo9Whjc7KIawnW3yG
7Ds8s1IrU4fjaJREtv8tbDaCR7jr0dE0GAoNJFkek8IXNKhtlFaojt1gYayjmzJC
fpRbL0xAqm6AoPT2Eu7OleYS2cMSPZIX6Uq0narc8FY+ZgusACrYchPpjuQbfH1a
UwZ4QSAc7B6xYK2/mlPLY47IYSt0oXzXhCW83IjTgNaHn68YsI9j5q3LmiM4DcIy
MLGg+AhZc2szWMtOvmpnoLwLJ/evx20wSpgOW9JIDPXlE53AaKz7vcaLtTOJ1aam
zx0laz0C3G3qQ6HV2VtW
=ucuQ
-----END PGP SIGNATURE-----

--oxiextlhxr6nv5zu--

--===============6483132919071013805==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6483132919071013805==--
