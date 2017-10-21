From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/14] Documentation: Add SoundWire summary
Date: Sat, 21 Oct 2017 09:57:44 +0100
Message-ID: <20171021085744.hpuvp34e4hckoisl@sirena.org.uk>
References: <1508382211-3154-1-git-send-email-vinod.koul@intel.com>
 <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8420998513550615700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D21E8266DF5
 for <alsa-devel@alsa-project.org>; Sat, 21 Oct 2017 10:58:01 +0200 (CEST)
In-Reply-To: <1508382211-3154-2-git-send-email-vinod.koul@intel.com>
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


--===============8420998513550615700==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbdxn3ktrayke2tj"
Content-Disposition: inline


--wbdxn3ktrayke2tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2017 at 08:33:17AM +0530, Vinod Koul wrote:

> +The SoundWire protocol supports up to eleven Slave interfaces. All the

There's lots of perfectly normal nouns in this document like Slave here
which are randomly capitalized.  Is there some great reason for this?
It makes the document pretty distracting to read.

> +Bus implements API to read standard Master MIPI properties and also provides
> +callback in Master ops for Master driver to implement own functions that

implement it's own functions.

> +provides capabilities information. DT support is not implemented at this
> +time but should be trivial to add since capabilities are enabled with the
> +device_property_ API.

Since we're making this up from whole cloth rather than following an
existing standard let's get a DT binding document together and review
the properties that are getting defined.

> +	/* Check ACPI for Slave devices */
> +        sdw_acpi_find_slaves(bus);

Tab/space issues here.

> +The MIPI specification requires each Slave interface to expose a unique
> +48-bit identifier, stored in 6 read only dev_id registers. This dev_id
> +identifier contains vendor and part information, as well as a field enabling
> +to differentiate between identical components. An additional class field is
> +currently unused. Slave driver is written for the specific 48-bit
> +identifier, Bus enumerates the Slave device based on the 48-bit identifier.

So this says that the instance identifer is part of the device
identifier but the driver should bind to the whole device identifer?
I'd expect the driver to bind to everything except the instance
identifer.

--wbdxn3ktrayke2tj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnrDAUACgkQJNaLcl1U
h9AJgAf/SIto1S95RxfEiRgnm2sT78VAOwzMOjwx7bEz/sc/Px8RtXsTaEPXWDZv
xSF5k2gYtk+TdVypNheni82wgvi6leHx8GaG33uybRn7XQO8D4+5ufoEkOspUOWZ
sQ71jwIXvImQVt7OfdxJeVW/SFk/zBHJh1i2MveBzNJM2dleKcGzTeKcwEliXVti
3NDeMuB+a+7Rg6gAKvWshGYC24dckoyW9f3BFYd+i864vv3MMxpBxZaA1Php0mkl
gr0WI+IjKSHqu968XVG18QFWS2jlpw9CCmev4O51udIF8o8bvh36h/KDiRUJs7Mp
Rnjv28M6KiK5Gs5e/SP4AbS8hA/0ug==
=VcKH
-----END PGP SIGNATURE-----

--wbdxn3ktrayke2tj--

--===============8420998513550615700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8420998513550615700==--
