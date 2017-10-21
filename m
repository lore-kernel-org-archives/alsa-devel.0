From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 04/14] soundwire: Add MIPI DisCo property
	helpers
Date: Sat, 21 Oct 2017 10:20:46 +0100
Message-ID: <20171021092046.p6wsssjkonjjdidt@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-5-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3670903351988488920=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D7F4266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 11:20:52 +0200 (CEST)
In-Reply-To: <1508382211-3154-5-git-send-email-vinod.koul@intel.com>
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


--===============3670903351988488920==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yz5cdsez4hj7pnct"
Content-Disposition: inline


--yz5cdsez4hj7pnct
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:20AM +0530, Vinod Koul wrote:

> +	/* device is probed so let's read the properties now */
> +	if (slave->ops && slave->ops->read_prop)
> +		slave->ops->read_prop(slave);

Is it valid for us to not be able to read the properties?

> +		fwnode_property_read_u32(node, "mipi-sdw-port-max-wordlength",
> +						&dpn[i].max_word);
> +		fwnode_property_read_u32(node, "mipi-sdw-port-min-wordlength",
> +						&dpn[i].min_word);

Don't we know this stuff simply by virtue of knowing what device we're
talking to (given that there aren't class devices)?

--yz5cdsez4hj7pnct
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrEW0ACgkQJNaLcl1U
h9ChiQf/ec5tEGVRwkHDt2tbITiDlyM+GpMlksmIWsD/ar9cxWKyRIPtnWhBWdR/
QPGgE1YPspBDdV5OtgRf81AUE2Vj3l3uH9Z8ivdU6uJYchNBzWqG3UBT1SZ9Ollp
eD5wfgOzG77eQ9RUcTdkvL186+gc2yXALe4Yn4z3NZUg6+I+L2yxSScKt2AJYUNQ
+OYuvLkIIvQAlP0HUj0BKTIDcQfv+kIa0PM2EjzpILRYO+PLqrPqXmqxMXX8mZ0Y
icueDhVnCHb0NS5G08jOz6MjvvQggINW0BFGfufNG1QI11m34+yrABt7ZvqzqfXm
iYScc1W9DuZz/O2C/FZo/V40IWeavw==
=CJJD
-----END PGP SIGNATURE-----

--yz5cdsez4hj7pnct--

--===============3670903351988488920==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3670903351988488920==--
