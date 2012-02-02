From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Thu, 2 Feb 2012 14:16:36 +0000
Message-ID: <20120202141636.GB22048@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
 <20120202120900.GC7428@opensource.wolfsonmicro.com>
 <20120202131716.GF9773@S2101-09.ap.freescale.net>
 <20120202132618.GL7428@opensource.wolfsonmicro.com>
 <20120202141124.GG9773@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120202141124.GG9773@S2101-09.ap.freescale.net>
Sender: linux-doc-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Richard Zhao <richard.zhao@linaro.org>, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, eric.miao@linaro.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 10:11:26PM +0800, Shawn Guo wrote:
> On Thu, Feb 02, 2012 at 01:26:18PM +0000, Mark Brown wrote:

> > That's why I'm saying perhaps make it conditional on having ASoC built
> > (or even on having the AUDMUX driver built).

> Do you mean by having the below in some place like function
> imx31_soc_init()?

> #ifdef CONFIG_SND_MXC_SOC_AUDMUXV2
> 	imx_add_platform_device("audmux-v2", 0,
> 		audmux_res, ARRAY_SIZE(audmux_res), NULL, 0);
> #endif

Yes (you need to check for module too, there's a macro for that the name
of which escapes me right now).

> I do not think it's nice and consistent to the way that imx
> sub-architecture adds platform device.

Well, the i.MX thus far has had relatively few of these always present
type devices - it makes sense to make things conditional for devices
with external signals but for things entirely within the SoC the above
is less work.

> Furthermore, when a DT based board boots here, the code is broken.
> Explicitly adding the device by individual board as needed can easily
> align with DT based boards.  By default, the audmux node in <soc>.dtsi
> file has status = "disabled", and any board that needs audmux device
> only need to overwrite status property of audmux node as 'okay' in its
> <board>.dts.  Then DT core will add the audmux device when the board
> boots.

That seems like more work than is needed for boards, same issue applies.

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKpqRAAoJEBus8iNuMP3dcbYP/REuhnMHtMcn4y+kNXls8dyF
vpLiZKeLgODNMPLJ3X9zot3x0L+wANA1EZpTNcn6jD6mIEgnezEIv5VcJ1mRwAAP
8Up8lKUF/7bqaeUfaUQS/3Spn1HC2LO3o05cKiYqeZClzoNyOdrLg8KeJeYm3GHY
o+b81k5Fl1cM9ge1WMtBlnRnL7QLoTk84Szyw+NZemuJqcWoaALFHSCOCNaprnRR
328zP7vWCSCxls8dgbBzq0m7vrsVTfKQCjUQo57DTSRqkl4cuCCZvensKv9Aruoz
WTr2IDJZ0+NzX7lScBw11cT3mq7mpN4FzW513UkK94dS0INvJrYD7hxps+3NhLlB
b6RefrEXiHab9hawTvM1gpqTywyNH1nYJxE/+Rtg0WFvxD/yOlEla+vWcAomy4qc
UPx2mIUZKRZAmRcnhwhHldMWniaAPlvqYTnZx0aPsGika7vIsr/Jx/uoGK6YO5eT
MNTACXQSb66Vgu5ERni4cldAoVSiiMWtib9mZ2HM4odzV1AaWXmyMNl3JyK1oEcv
0B9oaJZeivLvmFeuYXqV4EAp5UCoBA7Op1ibO3mkhPhcw1qESVjkRbz8aZmvWnB0
cM3bBd10J64Z4HmqOgZcIfUmZDmm7tTbFDA3VsKkmWZc25nC0Iwf6vMtn99VA9dj
exsUe6ZQqT51vWzbPrAQ
=o7Zy
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
