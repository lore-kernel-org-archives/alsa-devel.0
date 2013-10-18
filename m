From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv1 6/8] ASoC: fsl: add SGT15000 based audio machine driver.
Date: Fri, 18 Oct 2013 18:33:31 +0100
Message-ID: <20131018173331.GV2443@sirena.org.uk>
References: <1382000477-17304-1-git-send-email-Li.Xiubo@freescale.com>
 <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9ss1VCek+7fjM2m0"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1382000477-17304-7-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: r65073@freescale.com, timur@tabi.org, lgirdwood@gmail.com, r64188@freescale.com, rob.herring@calxeda.com, pawel.moll@arm.com, mark.rutland@arm.com, swarren@wwwdotorg.org, ian.campbell@citrix.com, rob@landley.net, linux@arm.linux.org.uk, perex@perex.cz, tiwai@suse.de, grant.likely@linaro.org, fabio.estevam@freescale.com, LW@KARO-electronics.de, oskar@scara.com, shawn.guo@linaro.org, b42378@freescale.com, b18965@freescale.com, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org


--9ss1VCek+7fjM2m0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 17, 2013 at 05:01:15PM +0800, Xiubo Li wrote:

> +	ret = snd_soc_register_card(&fsl_sgt1500_card);
> +	if (ret) {
> +		dev_err(&pdev->dev, "register soc sound card failed :%d\n",
> +				ret);
> +		return ret;
> +	}

Use the newly added devm_snd_soc_register_card() (in -next).

--9ss1VCek+7fjM2m0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSYXDnAAoJELSic+t+oim9seMP/iiRnKDJNKcdrKFo60VsGo6M
qYoKvXuXS66QMJudg2iouuG9XhS3AklWnXhubsPCuUVddbmtGTUsliubs30YvXdo
0R6AAG3svmUvWfS776GCFpW8runhD4nmJNrPslOQ2TNRjdYNmI8PDyyykeeoD2SX
RfN2ZTWqrYgipBg/FXHgGNomYpCjnwmPh0onpXIi2A1LKEy1D65Np3aLgCBkXmqb
CXfoIUGc2t4FIHDXfwQ3PRCVmJ4mVsPb9ggylHPeZiHmIKUfSNVPAJn1pUA2SNKc
ZbdbsfxOVavbvYI3XYAVKyW3adjqNiOrYy/XhKcJvfEqD+Vgsv9JQyVM1YOenk/H
PaKBeoe9cmGJzU6lvmRLoXynZ82PrtGCuSM5mwZaM06rSgTkuRteJU6tctIugOdK
B2PtkCV14bpodixBuidOuSDyAewE2q+yLCDZIDSNju9n4M2tXacpnfSwMbRm/Cnv
9Np2xWsNXro1IwuYY4MzZwU+DAx4cF0nfzHfwmuRZUvvS14ujkcaRWrsoOCisDch
612ktvxCKAmzmNdkgaUi038QMqczxkfClpnHn3IDI0nxvdn4k1btF0WlVBbyo9zl
cuWEpjMpY/fPV94tXyj2m4LDz7bZf/tyZY8W/rD9hoeEXDJL83wNVpQPM72OcX6g
lSxz5AGiHxYtQqJS+PEJ
=+/EO
-----END PGP SIGNATURE-----

--9ss1VCek+7fjM2m0--
