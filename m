From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/14] soundwire: Add sysfs for SoundWire
	DisCo properties
Date: Sat, 21 Oct 2017 10:42:53 +0100
Message-ID: <20171021094253.45qbp6wzyhifw5vc@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-11-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8797592867175546756=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id BD51A266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 11:42:58 +0200 (CEST)
In-Reply-To: <1508382211-3154-11-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: ALSA <alsa-devel@alsa-project.org>, Charles Keepax <ckeepax@opensource.cirrus.com>, Sudheer Papothi <spapothi@codeaurora.org>, Takashi <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, plai@codeaurora.org, LKML <linux-kernel@vger.kernel.org>, Pierre <pierre-louis.bossart@linux.intel.com>, patches.audio@intel.com, srinivas.kandagatla@linaro.org, Shreyas NC <shreyas.nc@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>, Sagar Dharia <sdharia@codeaurora.org>, alan@linux.intel.com
List-Id: alsa-devel@alsa-project.org


--===============8797592867175546756==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qpyui4plsyem24go"
Content-Disposition: inline


--qpyui4plsyem24go
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:26AM +0530, Vinod Koul wrote:

> +static ssize_t clock_frequencies_show(struct sdw_bus *bus,
> +			struct sdw_prop_attribute *attr, char *buf)
> +{
> +	ssize_t size = 0;
> +	int i;
> +
> +	for (i = 0; i < bus->prop.num_freq; i++)
> +		size += sprintf(buf + size, "%8d\n", bus->prop.freq[i]);
> +
> +	return size;
> +}

sysfs is supposed to be one value per file...

> +int sdw_sysfs_slave_init(struct sdw_slave *slave)
> +{
> +	/* TODO: Initialize dp0 and dpn kobject and attribute */
> +	return 0;
> +}
> +
> +void sdw_sysfs_slave_exit(struct sdw_slave *slave)
> +{
> +}

Seems like an important TODO?

--qpyui4plsyem24go
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrFpwACgkQJNaLcl1U
h9B85Qf/SFvCyFGVyYxIIm81d0UMnW+J7II2QK98Y9lMJn08y8dKHSCxydAUWxux
wtXbVa+4BVKKMdwHlVpi0HNk86BdQSWvrClEZnmZ6M3JcCiPVmew5MLae37G+f3X
ODXwpdp2uINqyfBjFfOC1PjXci9KUkXqYRHc3rrIgjvY8QiW0qiX8wHVEiw+v8OI
ZGMrZ1NQQ0oJzsQJQkq712jRNOX69d6FNa8vsg955MatNVMKBO5F6WqH8JVu9nyx
rKwHnF4ZEgf8e69U6oF8NfACpKOVpvUlO1t+R2vi4bAGE3kN5TJH7rcec8DXyCdJ
xGN43AEqHv4byq3smSt9ulNVofuX3Q==
=V34F
-----END PGP SIGNATURE-----

--qpyui4plsyem24go--

--===============8797592867175546756==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8797592867175546756==--
