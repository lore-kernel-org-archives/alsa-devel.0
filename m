From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 12/14] regmap: SoundWire: Add regmap support for SoundWire
 bus
Date: Fri, 28 Oct 2016 19:03:55 +0100
Message-ID: <20161028180355.o7byx4llwurfpnut@sirena.org.uk>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
 <1477053673-16021-13-git-send-email-hardik.t.shah@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fkcotvwlbyebc3qq"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477053673-16021-13-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hardik Shah <hardik.t.shah@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org


--fkcotvwlbyebc3qq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 21, 2016 at 06:11:10PM +0530, Hardik Shah wrote:

> +static inline void get_t_size(size_t *t_val_size, size_t *t_size,
> +						int *reg_addr,
> +						int *offset,
> +						size_t *val_size)
> +{
> +
> +		*t_val_size += *t_size;
> +		*offset += *t_size;

So, I started by taking a look at this patch to get a sense of what the
API would look like and I see that we're not following CodingStyle with
everything indented twice :(

> +static int regmap_sdw_gather_write(void *context,
> +			   const void *reg, size_t reg_size,
> +			   const void *val, size_t val_size)
> +{

> +	if (!sdw)
> +		return 0;

Silently ignoring errors :(

> +	if (val_size > SDW_MAX_REG_ADDR)
> +		t_size = SDW_MAX_REG_ADDR - reg_command;
> +	else
> +		t_size = val_size;

This needs at least some kind of comment?

--fkcotvwlbyebc3qq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYE5MKAAoJECTWi3JdVIfQnMAH/ROdP3VRxUt/q9EMlMTMYYOk
O/z1STg3POmSst9Lp1GEQwZO5yQ/iDXbxmaQ2PPwqO+Uf6Dhbaaa/Fr6nxylbhku
SqmWp6fmbbe29rJ41t6E2v4wNTORTLcRVv/a4Ko++MFfPrjxbSbyvD7qgwduEI67
Xn09n2hD/SSLsS/ezLTIctCG0lE3gNs6AaB1uNZRoX9/W/efbmawIpW6QC1jz9Xz
ZG9lIU4RbRqQObsIfwPU9rqJu+2uqs2RrmA82gtCsO0uVAawrqeu7MA1gQpi46WY
E4cFvL9m3eEhmOLHNf6kA19DLkVrbmha/2lHjXLyGT6ZIEA4yloptfFdK7FP7Hw=
=L5yI
-----END PGP SIGNATURE-----

--fkcotvwlbyebc3qq--
