From: Mark Brown <broonie@kernel.org>
Subject: Re: [Patch v2 11/11] ARM: dts: Model IPQ LPASS audio hardware
Date: Tue, 9 Dec 2014 16:08:47 +0000
Message-ID: <20141209160847.GI1934@sirena.org.uk>
References: <1418076073-12623-1-git-send-email-kwestfie@codeaurora.org>
 <1418076073-12623-12-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l0l+eSofNeLXHSnY"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418076073-12623-12-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--l0l+eSofNeLXHSnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 08, 2014 at 02:01:13PM -0800, Kenneth Westfield wrote:

> +		max98357a_codec: max98357a-codec {
> +			compatible = "qcom,max98357a-codec";
> +			status = "disabled";
> +		};
> +
>  		qcom_pinmux: pinmux@800000 {

This appears to be adding an off-SoC CODEC driver to the .dtsi for the
SoC.  Don't do that, just let the relevant boards register the devices
on them.

--l0l+eSofNeLXHSnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUhx6OAAoJECTWi3JdVIfQBQ0H/3fati7yjW76dYnbjgqczhKA
QNRIurU2BOhg/QoOEXxlpmia8v8as2madlOttST3dXbDxUNz1x9OyMiGhPR+D1+3
hrh/s/PIAUynKCDylBRMK4B8vjm1cMypNK/B68ik3cb3jwhapJb5ZTm53TCFyC8j
rMh49ZH8mliXSYmfVdRZxfYPmy25Ci03Rj6zKJ1KgNQJ6yPpueURRVVjeZonGgV3
XMHPk+uSfAdmGvJkm+JOE7tSDh+G5lmo1kFopoO1CgA9hz6PkhaYEcxuR+ndZITX
00ByRMvcx9ikjx4jvtRalWSnWZGngJSgqLvES0Ogdx1K1ousio6gg5Du0SctCTI=
=HYwH
-----END PGP SIGNATURE-----

--l0l+eSofNeLXHSnY--
