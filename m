From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/18] ASoC: fsl-ssi: Driver cleanup
Date: Tue, 29 Apr 2014 09:22:29 -0700
Message-ID: <20140429162229.GA16981@sirena.org.uk>
References: <1397482548-28463-1-git-send-email-mpa@pengutronix.de>
 <20140424114403.GN12304@sirena.org.uk>
 <20140428085453.GC15179@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9094430774963608908=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140428085453.GC15179@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Alexander Shiyan <shc_work@mail.ru>, Timur Tabi <timur@tabi.org>, "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============9094430774963608908==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 28, 2014 at 10:54:53AM +0200, Markus Pargmann wrote:

> What do you think of some framework function like
> of_regmap_parse_endianess()? This would offer a common devicetree
> binding and the driver would still be involved.

Something like that should be fine, Xiubo has been working on it.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTX9G8AAoJELSic+t+oim9eboP/3AIVIn9a+mwZ+4L1htEy2qZ
MHILMbrjZp2lzRhalFR491z9L9TaLiTrH6dnkmQReTs1e3Zgzd4bDAMRgM+gov50
fPmuZRDOemcmkPh9+oV5rJUFgX2Amz2I08qOteEZy8rlF/1X20W8TK0H/hLaiOiv
hDXgLVDbyaYmGWOlqlD8hPGtv9bkqgGEzUgj7plY1pzRO4wJCNQHGMmsnacHt5LH
iUcIz8lAC6TKNRFk0eOhYOi3Bk2bxzxwDPt3As5UEVimD9j1wQOsxCy1RGFHypMe
52z0aFvnaR5Qq9C65e40+WX5PszPFgkjNRzon+RFoE6whbD+KqJk36RAw6kPDavi
zGhTvogPkazXc0oP/2eEWljJcbOBXPdYAWdgfOL9liLDQNliwBsGC0sANUSqausL
9Ng01BQ10RqgdRtDyeQOHp/S5isvgUC6LqPRRe+1+Wr/Bfik5ZgkzG980AWgdmOK
U6433+CkbQSJV2vcUJyGhWjWcXMC8ZnanakPcTnp920RZUG4R0z9z9PULG7X4MkY
gKB9CpkLS7qCrDLSlJCQUX2odeJVzfjz+TMsh+8+NELNAl7vgAJVBnhudeyjAd2z
0ysnfp3yUXHwnRPoUjwoiil+KmCQHNF5Qzp4rMVV7XxJIUX8hIwcmJgXKuIiZk0A
FreBjIewTOfUnYeaapyi
=vW3I
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--


--===============9094430774963608908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============9094430774963608908==--
