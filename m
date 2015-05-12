From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_sai: Add tdm slots operation for SAI
 master mode
Date: Tue, 12 May 2015 19:42:37 +0100
Message-ID: <20150512184237.GP3066@sirena.org.uk>
References: <cover.1431337606.git.zidan.wang@freescale.com>
 <1431339894-4248-2-git-send-email-zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U+NfgObvpQT1Q9Yq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431339894-4248-2-git-send-email-zidan.wang@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, timur@tabi.org, Xiubo.Lee@gmail.com, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--U+NfgObvpQT1Q9Yq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 06:24:42PM +0800, Zidan Wang wrote:

>  	if (!sai->is_slave_mode) {
> +		slot_width = sai->slot_width;
>  		ret = fsl_sai_set_bclk(cpu_dai, tx,
> -			2 * word_width * params_rate(params));
> +				sai->slots * slot_width * params_rate(params));
>  		if (ret)

This seems to make TDM configuration mandatory which seems like a step
back - if it's been set up then of course we need to use it but if it's
not been configured we should be able to just infer something from
hw_params as we have been doing.  Checking to see if the relevant values
have been set and falling back to using hw_params seems better.

Otherwise this looks good.

--U+NfgObvpQT1Q9Yq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkmcAAoJECTWi3JdVIfQbUEH+waDqZMrjdtzAac3BmjexrV8
cs0n0GKMJhoSP3ZmB9turr1jqlB/Vr9rb5Ip4IXf2jvsD42kVTTeRyJxKmM2W+43
Tz9hR4ApJpZZi29TGhvOX14xaZ3wTpByoVxDkIOVHXFnZfZKjkX6nth+61LlwWWB
Tk+ihCpVIH5EgikqxQR9ggcBSy0Y2Yl7sVTVi0bI0JFCJzcpsgShVyMJrSzEb02R
qWIBT2CZKJP5WtET/tKHrwsgMiMUhBDBfMna7wXjiI6+nR1dR0KDWtIz5xnRMfX+
hoQxibzqG2ijvxR21/wdAezjNBTeAGPyZaOiSTGuYOi6F6BK9sLUDwyMUCcquSw=
=52TZ
-----END PGP SIGNATURE-----

--U+NfgObvpQT1Q9Yq--
