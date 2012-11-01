From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Patch v2 3/4] ASoC: atmel-ssc-dai: register platform from DAIs
Date: Thu, 1 Nov 2012 14:43:15 +0000
Message-ID: <20121101144315.GM4413@opensource.wolfsonmicro.com>
References: <1351668420-18447-1-git-send-email-voice.shen@atmel.com>
 <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mI5TpPl/qDRoXxBg"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351668420-18447-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org, plagnioj@jcrosoft.com, jm.lin@atmel.com
List-Id: alsa-devel@alsa-project.org


--mI5TpPl/qDRoXxBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 31, 2012 at 03:26:59PM +0800, Bo Shen wrote:

> +Required properties:
> +  - compatible: "atmel,atmel-ssc-dai"
> +  - atmel,dai-master: this dai base on which ssc controller

> +Example:
> +dai: dai {
> +	compatible = "atmel,atmel-ssc-dai";
> +	atmel,dai-master = <&ssc0>;
> +};

This seems to be a purely virtual device which remaps the SSC onto the
Linux audio subsystem?  If that is the case then it shouldn't appear in
the device tree, the machine driver should just directly reference the
SSC and instantiate any devices required in Linux directly.

--mI5TpPl/qDRoXxBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQkop6AAoJELSic+t+oim97ZMQAJrZaTZvT5ZLJT0GFtbpWxBJ
hwb1Z6VqNcsy4gDhRGZsKF7KqdByjbkLzEkfVpQWZzkpyYRZh55xwvzpTQL+82KI
NA9QnYtcFu3NbYJtkGU/pyHWSnW+8lw6SFkP4ZW8jtejfQzaesTyJaeXjPo/xRFI
930/gHH6EowVPWKnFkyG4JLLEHMT2bxDQ/ymDNHRpaq8Dfd0iZ+NwmOmm8zb/QOB
Su1OW6RBJyUWOyaTMFdv9D/+PIlRhikK1kxLsu/QDf2KW7arZtm38cTx+TTjxdnk
RhOERpK5QHHGEKD4ivEI1zxtaVAboCEQBd824eL3LoEnUo9uOFkWDaPzK018k27V
ZT98fOikjTdFNDccWnyI0ZglRa/hGKIeBijVhbhGapmhWfnRfGRh0yLUlKO/YCNR
5hNXfqw69u3Dxn7fPB+aHnvYkkm+8vKwPIrDil7LGxS5JUvuDH5JqxBpO3dGf0LI
CYTwa9T3MWqcQs9VcHVLXvowR/5PoeQnI52Ley2H4hGGV0SDJmqPzXFQstUy4l1x
XtHN9SmV2DxDTXMb2p9dea5pAM875ntRE1+iMHCcGgiSz2u03Nmc1NEqNnQcFN1U
OLXCp1TT/GWp2yAYMEkYUDHjW6gHEGOjiPz6wRP3KBntsXSM+czaOR9+Bt0dZTLL
KmK4TwhPg5+ih+kubyfw
=Q8vq
-----END PGP SIGNATURE-----

--mI5TpPl/qDRoXxBg--
