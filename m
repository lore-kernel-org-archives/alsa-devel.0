From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: intel: Fix crash at suspend/resume
 after failed codec registration
Date: Mon, 25 Mar 2019 15:02:37 +0000
Message-ID: <20190325150237.GH7284@sirena.org.uk>
References: <1553294388-25293-1-git-send-email-linux@roeck-us.net>
 <5451ba5b-1a5d-41b0-2b39-772c326de785@linux.intel.com>
 <20190325121232.GF7284@sirena.org.uk>
 <b6d2bdc5-d0e8-dee7-52be-fa7f3a36fa9f@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oyqLL/JqMvClXZi1"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6d2bdc5-d0e8-dee7-52be-fa7f3a36fa9f@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Curtis Malainey <cujomalainey@chromium.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: alsa-devel@alsa-project.org


--oyqLL/JqMvClXZi1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 25, 2019 at 09:18:04AM -0400, Pierre-Louis Bossart wrote:
> On 3/25/19 8:12 AM, Mark Brown wrote:

> > These are driver specific issues not device model issues as far as I can
> > see?  The issue fixed by this as is that you're storing a pointer in the
> > ASoC level (not device model level) probe that you don't free when the
> > component is unbound, causing you to dereference it later during
> > suspend.  There is absolutely no problem with the machine driver not
> > being guaranteed to bind at the time it's initially registered, that's
> > perfectly normal and should cause no problems.

> Agree, what I was referring is that if the machine probe and card
> registration fails (not just deferred), the parent acpi/pci driver isn't
> notified - there is just no means to provide that information and that leads
> to all kinds of configuration issues.

If there are issues here they could happen via means other than a probe
failing so there's a problem whatever is going on - someone manually
unbinding a device for example.

--oyqLL/JqMvClXZi1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyY7YwACgkQJNaLcl1U
h9Clbwf/eSfum4OA4Z/gu9wTzkAEv/8I/lNUyM1bpru9/4lYtkZjjRh0V2P+Sms+
le3NjV1zK5HG777qhUGAX3iMbkFqbL0xBspUl6fjacleVYnXcUILPYmO4ppy9qia
fvvLZlHoP6WyMVcS2tTI9AlYvrJ84F+Y1b3dvtF7blfH9l08NyS/21l6VXNfu5Ss
YrOXb6ITRdJ392WPd+ASShXVlJoTQLpcMLlCJo9n9TaABaFBxVeeNFgptb4iN4aB
2rHX+Vgr5D9uKoESwPFV2HQZ7vkTO9Jnmc0M3uMr5KeCg+/YEl8BAOjvyB5Cwlr1
hOa3m6t6Dxdpzyna8cvXBdWkYexLfA==
=UHdW
-----END PGP SIGNATURE-----

--oyqLL/JqMvClXZi1--
