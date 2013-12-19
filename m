From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv3 5/7] ASoC: fsl: Add SGTL5000 based audio machine driver.
Date: Thu, 19 Dec 2013 10:25:21 +0000
Message-ID: <20131219102521.GS31886@sirena.org.uk>
References: <1387250684-23406-1-git-send-email-Li.Xiubo@freescale.com>
 <1387250684-23406-6-git-send-email-Li.Xiubo@freescale.com>
 <20131218183743.GG31886@sirena.org.uk>
 <f9a19c59bfaf4844bbeaca1aeb91e305@DM2PR03MB509.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0975475668151318237=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <f9a19c59bfaf4844bbeaca1aeb91e305@DM2PR03MB509.namprd03.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "timur@tabi.org" <timur@tabi.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Huan Wang <Huan.Wang@freescale.com>, "LW@KARO-electronics.de" <LW@KARO-electronics.de>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>, "perex@perex.cz" <per>
List-Id: alsa-devel@alsa-project.org


--===============0975475668151318237==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3ig5MTpp3LwprTX9"
Content-Disposition: inline


--3ig5MTpp3LwprTX9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2013 at 05:19:26AM +0000, Li.Xiubo@freescale.com wrote:

> In this series of patches, the PATCH1~PATCH4 are about SAI only, and can be
> apart from VF610-twr sound driver, I will sent the SAI driver and VF610-twr
> sound driver separately. Could you apply the SAI's first if they are all fine?

What are you asking me to apply here?  I already applied your first
patch as I said, is that not everything?

--3ig5MTpp3LwprTX9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSssmOAAoJELSic+t+oim9IUIQAIHC0z/+jn9FBL0PhHHBxbIX
EzC6HLZcVf6q1mKLIGQ8AfJmQKrdYc3jeZ9F0yXyQ4Sqh9Jo0nhhhjNjzRI8CZfr
wZAyebAPhxNzUiBz29k3UZR3+spkZjZlfM1gL73o6f9QNUTKBVhYRHeyhOnfo9+n
2iRrw5bXy9T7gg0oRFSOiFCMPwNoNEhL4Kq84qFdT+Ptk2xjBIj1b/5qh5LTRZGf
8p+6kdd++szKtgOS+bhW4AYmukBt5YwpTI1fA+TgN6vvIA/O31UnKcMWYSmwyWig
tA5s4eF+PIKIrJ18uvgMbZAwBj9wyb+feGyPC9t4IUzy8Zt7lBoCdNXRTYb/JsQD
MyWuNvBe6EldA2DuYF7rWmXUJhRxslIzSeplGC5DRELZjtfJsIN8l4FtKNqC9wDa
b/EbNw9B5oBKBZYdpLOW0HN7bu5TNexRE/S9JR4crGv3M5pdBuGEBSQj2tbhuWzG
R1Tw1ogtomN6kGs+hSVruk08CftJAtLR3C9gEVMsnmoEa9QidJkSyYUjTihAUX6P
pueY0Akz8AUFqXzT21y4H7Gb8qnOZHObxmWcij0vkPMGyqko8Q6QA1rmd+iCsfQ5
4pX9EW7IJeJ7zNuN+P4ouMLoq5P6q9WIuXZtmLoUlGFr7rs5DXocjfwf89nHu5aj
VaDPSCfuymOK4KXQYaf+
=o2sq
-----END PGP SIGNATURE-----

--3ig5MTpp3LwprTX9--


--===============0975475668151318237==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0975475668151318237==--
