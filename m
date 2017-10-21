From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 03/14] soundwire: Add Master registration
Date: Sat, 21 Oct 2017 10:12:30 +0100
Message-ID: <20171021091230.pwevgreloynqe7nu@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7342986047883179071=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A14A1266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 11:12:40 +0200 (CEST)
In-Reply-To: <1508382211-3154-4-git-send-email-vinod.koul@intel.com>
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


--===============7342986047883179071==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rvjvopyyczgw635m"
Content-Disposition: inline


--rvjvopyyczgw635m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:19AM +0530, Vinod Koul wrote:

> +	/*
> +	 * SDW is an enumerable bus, but devices can be powered off. So,
> +	 * they won't be able to report as present.
> +	 *
> +	 * Create Slave devices based on Slaves described in
> +	 * the respective firmware (ACPI/DT)
> +	 */
> +
> +	if (IS_ENABLED(CONFIG_ACPI) && bus->dev && ACPI_HANDLE(bus->dev))
> +		ret = sdw_acpi_find_slaves(bus);
> +	else if (IS_ENABLED(CONFIG_OF) && bus->dev && bus->dev->of_node)
> +		ret = sdw_of_find_slaves(bus);
> +	else
> +		ret = -ENOTSUPP; /* No ACPI/DT so error out */

Devices *can* be powered off but is there any reason that a system
couldn't be designed with them always powered?  Also given that we don't
actually have any DT support the stubs for it are at best misleading,
it's not going to be hard for someone to add them later.

> +	mutex_lock(&bus->bus_lock);
> +	if (!list_empty(&bus->slaves))
> +		list_del(&slave->node);

Shouldn't that be a while?  Or at least warn if there's anything extra
there.  The code just looks very wrong as is.

--rvjvopyyczgw635m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrD30ACgkQJNaLcl1U
h9Bcjwf/ccaEjkb4OOR5+y/8Y+odeGT2cr+wdOikOGyTtRXGn7oxBFDIeWSQWCfF
FEIEhf0tOrLfXz3xMl0dEf/sjZf9NFm+VnC+5giKW+BwLCDpHJJUucxTrw5XAuH3
tQnd1QTp4Llz62WA83PiOBkiF9WnbpzsfaTGEy6XQtm4tpnUTdov1UFzaPNGfvjE
nxx4CkIMXTyIOHf09srwS07GRE6UHuYZuFtBOhHJZDG/DBHebpRqqpfkH12sd0J5
kJipQt+/CnQ5RCX+zsm7iQzFpY/bEtkxw0/E+vwqm5Vm1S6lzreoqxhgdJWlfHEU
jRDYoLoHlo9WZBislBV9xJrfWPEP9g==
=Wicq
-----END PGP SIGNATURE-----

--rvjvopyyczgw635m--

--===============7342986047883179071==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7342986047883179071==--
