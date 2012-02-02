From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 6/9] ARM: mx31ads: add audmux device
Date: Thu, 2 Feb 2012 12:09:01 +0000
Message-ID: <20120202120900.GC7428@opensource.wolfsonmicro.com>
References: <1328148728-32258-1-git-send-email-richard.zhao@linaro.org>
 <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1328148728-32258-7-git-send-email-richard.zhao@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Richard Zhao <richard.zhao@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, kernel@pengutronix.de, eric.miao@linaro.org, patches@linaro.org, devicetree-discuss@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-doc@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 02, 2012 at 10:12:05AM +0800, Richard Zhao wrote:

>  static void __init mxc_init_audio(void)
>  {
>  	imx31_add_imx_ssi(0, NULL);
>  	mxc_iomux_setup_multiple_pins(ssi_pins, ARRAY_SIZE(ssi_pins), "ssi");
> +	imx_add_platform_device("audmux-v2", 0,
> +				audmux_res, ARRAY_SIZE(audmux_res), NULL, 0);

Since the audmux is a part of the SoC silicon shouldn't the SoC just
register the device without individual boards having to do anything
(possibly conditional on ASoC being selected in Kconfig or something)?
It's going to be connected in exactly the same fashion on any system
using the SoC.

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPKnzVAAoJEBus8iNuMP3dhSwQAJhYDCjxADdsI13lRT2DdEgn
+y1XXlJH1dBySH2yw+N9CSmv6iJbBjZc81J5PiuPlPVShmKFV6lE9hUPEArW/XD3
7wyzxyr14bHhmM1AuVuwbmCiLgfUc8J4P6dgc/Dew59fVn47hn/wzSGfArkN9sNP
pZdmcYSeWReHJlGZee6Sa7ghW7glm13IJxJeEgmh04s6hVcWO9NlTe3od7ReI75v
WPQOIk2KMf7aC5LluaHUtUT9qLbhcjlnjgN1Z7QsiALbojGeRVMeBePcDqZ0j34/
W2Sd/S7gdLiNUr759SWGaBy3orxlzckJrawegmO+B+RW4ltjPwRgMqR4szmJV7kx
p3ia8UxLVg/bV6siL2nEvQu6omvLqOmanQHnP2GAP9qJ62gX1YqIC1jjdmlOKiFr
+6+rJ01yGOzyQuVFUdA4VNHEJPEflfKtJQAmKar66s2JVo9rOypMRaquY7wqq3OS
A3PjyOu4AQ65ZYQl+BYcKJxBiBDr0WNjFQmY/RAVuY4s/2jJclVlZdvp1yNdlSKh
kdN6y794GoMLRvPLaGljrrzG60qaNaDuVjFmdMA74oU1mpJ9iiI08LbhHS7yKh8x
hUs7LClfgXeh3wwRoGHGeHLmrCmePE6xKihlfnuyYdIgdY9fftpPUKF0UXmtmbCA
B1mKa201pgVYwRNmedHK
=GtHt
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--
