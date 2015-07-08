From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/4] ASoC: Intel - add Skylake HDA audio
	driver
Date: Wed, 8 Jul 2015 20:01:14 +0100
Message-ID: <20150708190114.GE11162@sirena.org.uk>
References: <1436153066-23962-1-git-send-email-vinod.koul@intel.com>
 <1436153066-23962-3-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5386902809511907248=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EFA92650DB
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:01:19 +0200 (CEST)
In-Reply-To: <1436153066-23962-3-git-send-email-vinod.koul@intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Jeeja KP <jeeja.kp@intel.com>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5386902809511907248==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rq18dCD+oSRtyKma"
Content-Disposition: inline


--rq18dCD+oSRtyKma
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 06, 2015 at 08:54:24AM +0530, Vinod Koul wrote:

> +static irqreturn_t skl_interrupt(int irq, void *dev_id)
> +{
> +	struct hdac_ext_bus *ebus = dev_id;
> +	struct hdac_bus *bus = ebus_to_hbus(ebus);
> +	u32 status;
> +
> +#ifdef CONFIG_PM
> +	if (!pm_runtime_active(bus->dev))
> +		return IRQ_NONE;
> +#endif

There's a stub for pm_runtime_active for !PM which does the right thing
here, no need for ifdefs.

> +	/*configure PM */
> +	pm_runtime_set_autosuspend_delay(bus->dev, SKL_SUSPEND_DELAY);
> +	pm_runtime_use_autosuspend(bus->dev);
> +	pm_runtime_put_noidle(bus->dev);
> +	pm_runtime_allow(bus->dev);
> +
> +	pci_set_drvdata(skl->pci, ebus);

Shouldn't you be setting the driver data before you register the device
and enable PM?  Otherwise the PM callbacks might run without it being
set.

> +out_free:
> +	skl->init_failed = 1;
> +	skl_free(ebus);
> +	pci_set_drvdata(skl->pci, NULL);

No need to set the driver data to NULL, the driver core will do it.

--rq18dCD+oSRtyKma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVnXN6AAoJECTWi3JdVIfQ8dIH/08jU6siijWKQRfdozwyJeKd
jsnxqSOiV5v9LKSQ8yw5OAm3MOGISYYtgbuD1b6BQ8qWXM24iymHDxK2tF+u9QtM
NpQyf/ozBssyv0rUa61Pf4q0258w5iFTfFzoWeOA1A9k9l1bLCf0TuNI3T42HRfk
XwQ5hHF/dh/Phdino0elH7pox1zVHuBfT83bUM6N1FsD7R1jga8++tzQZEAOzPPm
c1cLyGOd/KilI8c2/oq0FS+k6V26b2bhZXmzNgTWRvAcFGzELgi1V0J4qm1B8M0I
7lqO9Rn0t4NXz53WGBT9Jl/6OV/jOChqf/PZq1Yiq8yCaxe8RZZwdTvpESVmD9g=
=AUHc
-----END PGP SIGNATURE-----

--rq18dCD+oSRtyKma--

--===============5386902809511907248==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5386902809511907248==--
