From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: rt5677: make ACPI property names match _DSD
Date: Tue, 2 Apr 2019 12:06:37 +0700
Message-ID: <20190402050637.GW2059@sirena.org.uk>
References: <20190401205519.34023-1-fletcherw@chromium.org>
 <20190401205519.34023-2-fletcherw@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WjpOG6URjntW8FAF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401205519.34023-2-fletcherw@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Fletcher Woodruff <fletcherw@chromium.org>
Cc: linux-kernel@vger.kernel.org, Bard Liao <bardliao@realtek.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Oder Chiou <oder_chiou@realtek.com>, Takashi Iwai <tiwai@suse.com>, Curtis Malainey <cujomalainey@chromium.org>, Ross Zwisler <zwisler@google.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--WjpOG6URjntW8FAF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 01, 2019 at 02:55:19PM -0600, Fletcher Woodruff wrote:
> The rt5677 driver is using the wrong property names to read from ACPI.
> Update the property names to match those from _DSD, so that the correct
> GPIO pin numbers are read and that plug-detection works.

> With this patch, plugging and unplugging the headphone jack switches
> between headphones and speakers automatically.

What makes you say that these properties are wrong?  Are you sure that
this isn't just some other systems using different ACPI properties given
the poor standardization for ACPI?  Your new ones look like they're DT
properties pulled into ACPI while the existing ones look more idiomatic
for ACPI.  It'd be fine to add your new DT style properties but this
might break existing systems.

--WjpOG6URjntW8FAF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyi7dwACgkQJNaLcl1U
h9CbkQf/WC82vZ3PuZsyK74xvMhdBVp6PxhIpzNuTmt+ht69FlN/+2xENh/moPyL
v1kwMLY6DhnTURZTyYahB7MEC2uoeI07UigvX7q/JNCf/idJjPVB0LmO1oqXtw54
R6muFakxkBTz3eryzP73WUtlQzvL2vp4TrEjkC3S6uZtw4U1+NVWQf4lUoM6zQoV
VDqE5CAp/SqXvI0Gusbs6RvQ96U5mbm4aMP7s9Ci4OEpkgkyjUyt3Bhz+ht2Uk3K
hEtDx5MUWBMvmzN9/elsmNokV8eARhrmZhAT9590WT2DXj2eqarILImsZ4INCa+q
iVWQJB7qfBgF9rEhsZ2dFKcVhPxmwQ==
=wY0t
-----END PGP SIGNATURE-----

--WjpOG6URjntW8FAF--
