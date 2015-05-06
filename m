From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: bt-sco: Add devicetree support for bt-sco codec
Date: Wed, 6 May 2015 13:13:11 +0100
Message-ID: <20150506121311.GP22845@sirena.org.uk>
References: <1430856941-3938-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lSMnNQgKosWEEuky"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1430856941-3938-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, hns@goldelico.com
List-Id: alsa-devel@alsa-project.org


--lSMnNQgKosWEEuky
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 05, 2015 at 10:15:41PM +0200, Marek Belisko wrote:

> +static const struct of_device_id bt_sco_codec_of_match[] = {
> +	{ .compatible = "delta,dfbmcs320", },
> +	{ .compatible = "linux,bt-sco", },

Is there any burning reason for adding the linux,bt-sco compatible?

--lSMnNQgKosWEEuky
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSgVWAAoJECTWi3JdVIfQb2oH/j0vdyRU3yfYXdR14YhTiDjX
QgfNgov7nxWrlEdOTfcHbyeijldQsPUfur4Wdks/kAxhAelNAqrgcXj3DcXj4hWm
xRGXTG//cIxGKHYhO3CpS3yVMT2t1f2aLkLH1KgT/7uPjMQdLGstza122fZ8rgpK
dAfSy5Tyc7+AW5Nl46ou2cxbGV+4eR56tpMbdBIc1AIiAqZA+2XKjeyJEJopYhoA
n2Vz7xV9R1rV0l1nGMs/Y2OT4jTyX2Etpl0haasJ8gcyxUjbe9ZaimqHE9cnkchd
Z5UIlhDkU+q/MxnL4hktjjVkyuTHrnCaGR/MqNrHmuu9TUqgQrFEyuTZrWSELtA=
=lfws
-----END PGP SIGNATURE-----

--lSMnNQgKosWEEuky--
