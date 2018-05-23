From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [RFC/RFT PATCH] ASoC: topology: Improve backwards
 compatibility with v4 topology files
Date: Wed, 23 May 2018 16:52:44 +0100
Message-ID: <20180523155243.GM4828@sirena.org.uk>
References: <20180522165842.233949-1-groeck@google.com>
 <fb9aebba-919a-2e80-aec7-2fd44e5e1861@linux.intel.com>
 <20180523082424.GA4828@sirena.org.uk>
 <521b23cd-f083-6a19-1374-fde7057c869b@linux.intel.com>
 <s5hlgcapjaf.wl-tiwai@suse.de>
 <CABXOdTdGyfBdZUzG-DzGgfr0Afrh9dtgdXibQreOZm7nb4z3=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j3zO+32zXj6UcJCE"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABXOdTdGyfBdZUzG-DzGgfr0Afrh9dtgdXibQreOZm7nb4z3=w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <groeck@google.com>
Cc: Takashi Iwai <tiwai@suse.de>, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org, Guenter Roeck <groeck@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, "Patel, Chintan M" <chintan.m.patel@intel.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--j3zO+32zXj6UcJCE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 23, 2018 at 07:49:35AM -0700, Guenter Roeck wrote:

> I want to be able to swap kernel versions without having to update the root
> file system. That doesn't work if I have to use v4 configuration files for
> v4.4 and older kernels, and v5 configuration files for v4.9 and later
> kernels (besides, as I mentioned, that the v5 configuration files I found
> were all incomplete). In my opinion, thre should be exactly one
> configuration file for a given device, and there should be no need for
> users (or distributions) to hunt for the correct version of the file.

I think it's fine for there to be new firmwares with corresponding new
configs, and that it's fine for those to have some minimum kernel
version requirement (though desirable to avoid it).  The firmwares could
be enabling completely new or different features, that's one of the
advantages of making the firmwares replaceable, and it's reasonable for
that to result in config changes.  What's not fine is for a new kernel
to require that you change anything about the firmware and config setup
on your system.

--j3zO+32zXj6UcJCE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsFjksACgkQJNaLcl1U
h9DzAAf+OK2Ulc/FqxIqascYkLk/XRahUs9ncw/Pcc782Qp2Up65ImFqA7uhI/7d
0CqXdp16ZnsTnfreKFNg0ZMgh4QSus9jluijwi+9G0BOEn4oCiMf2TSgrqh1LFiU
CQmvtUWHIL6GEpB6Aczm148YMp1w8qAiYaYYdsxZ7zaHrvWNPtSJCUh/EVQbUv1E
vJjgZuOhdot6bCFR/Q2Fmozid8mlj6Plo/Cj2CjALYyqMEgjnF3p69aKmWy9Ld+D
rAOcdveVK6i5r0J76/PohCZCoq7SanadaHo49tmBpAgoiD1gVgmFdO5ztqz74p5X
CFzVj8PCTM5XD/J1ZPtbkjAFpkX3Zw==
=I92F
-----END PGP SIGNATURE-----

--j3zO+32zXj6UcJCE--
