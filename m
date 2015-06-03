From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Pass kcontrol pointer to bytes tlv callbacks
Date: Wed, 3 Jun 2015 12:59:51 +0100
Message-ID: <20150603115951.GG14071@sirena.org.uk>
References: <1433283843-33856-1-git-send-email-benzh@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4CI+obvDyVe27XRB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433283843-33856-1-git-send-email-benzh@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Zhang <benzh@chromium.org>
Cc: Omair Mohammed Abdullah <omair.m.abdullah@intel.com>, Vinod Koul <vinod.koul@intel.com>, Dylan Reid <dgreid@chromium.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--4CI+obvDyVe27XRB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 02, 2015 at 03:24:03PM -0700, Ben Zhang wrote:

> -	int (*get)(unsigned int __user *bytes, unsigned int size);
> -	int (*put)(const unsigned int __user *bytes, unsigned int size);
> +	int (*get)(struct snd_kcontrol *kcontrol,
> +		   unsigned int __user *bytes, unsigned int size);
> +	int (*put)(struct snd_kcontrol *kcontrol,
> +		   const unsigned int __user *bytes, unsigned int size);

This doesn't update any users and we do have some like the Haswell PCM
driver.

--4CI+obvDyVe27XRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbuw2AAoJECTWi3JdVIfQyXQH/RkJwAw4XgnPYkELc2TP//LM
Uqi2H4H4xnvJIQl88J5CnDCwwtVVAUyM+h9yddH8fptauMg9qEc5zAt+RmzwzChU
5e5Ss2p4m5bPsrF8t7A53ZlmRrWRdXZU5HwKHsUYi2EAu/SPPl7wk9g+g18++BqY
rJkprZNSmAFIzTU22amNTVs9oPKWdP4/yWCGqUN+nL/kk2scOQ+z0KurO77Vqs4u
RZErB2xvQ2jG1KROuhheq51AFMCKIzXa5oOZmNeoYj2p4jMzhV+jAf2zHx8ez0KI
0RVvoQWWblkCGYGiJwV2DoBdz8tl7e/uChgZjSaJFYJDANs5VbSpe77sIF0zEqs=
=4vSW
-----END PGP SIGNATURE-----

--4CI+obvDyVe27XRB--
