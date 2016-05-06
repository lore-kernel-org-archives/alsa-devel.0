From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: da7219: Convert driver to use generic
 device/fwnode functions
Date: Fri, 6 May 2016 13:26:43 +0100
Message-ID: <20160506122643.GS6292@sirena.org.uk>
References: <cover.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
 <4783487c3caa1d66f0a1d5b25c9b341aee1118e4.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PpHgzJIASOO9qXt6"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4783487c3caa1d66f0a1d5b25c9b341aee1118e4.1462285398.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org


--PpHgzJIASOO9qXt6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2016 at 11:53:04AM +0100, Adam Thomson wrote:

> This change converts the driver from using the of_* functions to using
> the device_* and fwnode_* functions for accssing DT related data.
> This is in preparation for updates to support ACPI based initialisation.

Is this *really* sensible?  DT idioms don't always match up with ACPI
idioms well and this isn't a trivial DT binding.

> +static struct fwnode_handle *da7219_aad_of_named_fwhandle(struct device *dev,
> +							  const char *name)
> +{
> +	struct fwnode_handle *child;
> +	struct device_node *of_node;
> +
> +	/* Find first matching child node */
> +	device_for_each_child_node(dev, child) {
> +		if (is_of_node(child)) {
> +			of_node = to_of_node(child);
> +			if (of_node_cmp(of_node->name, name) == 0)
> +				return child;
> +		}
> +	}
> +
> +	return NULL;
> +}

There's nothing device specific about this, it should go in generic
code.

--PpHgzJIASOO9qXt6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLI2CAAoJECTWi3JdVIfQDCQH/2d3ic1jg8vaqwtSezoctNlo
7hdRO4gpcCvJ2IzRMD6a4M9aApgtHSljbaV0UYw2ZajWryXjDBUEryZ9vwe4kvVE
8lHywVns+suAYtXynCwFvcDxEogSVFMdqG2nVW0/gZa2lbw6a35sugRipd+T+UeY
Ap8R48RgXPlDOq0w/tpwMgrRzyAJwTt1Kdgfxt01rTMZYqSwpj53ZPniFJtH5Yc2
NoBjJzh8oCUwz5rHhMnQq2Xb6FeUh+j5wvViK8mZ6DXkac8NDHf3MgMGWqkGHZXa
535wJi3d5BxVMmNBwauaHROn+0Ccmm28pwO3+SQvMIhnBFBYOcOOBuXALtUuWWI=
=zU9k
-----END PGP SIGNATURE-----

--PpHgzJIASOO9qXt6--
