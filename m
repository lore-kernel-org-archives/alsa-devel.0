From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Tue, 10 Nov 2015 14:15:13 +0000
Message-ID: <20151110141513.GF12392@sirena.org.uk>
References: <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
 <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
 <20151109140225.GA26072@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CEA5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vKFfOv5t3oGVpiF+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CEA5@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--vKFfOv5t3oGVpiF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2015 at 01:55:30PM +0000, Opensource [Adam Thomson] wrote:
> On November 9, 2015 14:02, Mark Brown wrote:

> > The general userspace expectation is that the detection is always active
> > and consistent rather than varying at runtime - runtime variability
> > might be a bit surprising for it, and even then variability in what is
> > detected based on other settings is a bit surprising.  If the hardware
> > is that limited I guess it's about all that can be done but I'm still
> > not clear what the use cases are for configuring the levels (as opposed
> > ot the routing).

> How about the example of always on voice in Android, which can be enabled and
> disabled, depending on user settings, and routing will vary depending on which
> mic is in use at the time? For the levelling is it not plausible that a user
> could configure the level based on their current environment. You have
> moderately loud background noise, then your threshold would want to be
> higher, but in a quiet environment the likelihood is you would want to lower
> that threshold?

So this *isn't* a normal mic detection feature?  What's the userspace
interface for reporting then?

--vKFfOv5t3oGVpiF+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQfvwAAoJECTWi3JdVIfQfewH/3mOjWDQbcgdcdBqZlMirgjQ
ztPu/biyfDnojUEG6tARBWSkfAzE6PXHqVGiqoDYy8Q3WoGad/5sP40P1TLNR2ZS
GJtBncQINRp7HQPNcz2DwD0rVm5dGguo8V4ejbnIlQ00m8VzaV81L2qEf/Eb7tjN
fcje9YVbUIrRrO2JSBYkZQpcCwLQb4L6/yYewY5Emgg18DfWqUO+yFBfVQQbx2Q1
PbjDP0Mf/cIm8Gc9AAkzepbeE87CZdymvawg0fTZrt8BRm8Vnmqj28s+5YtD01an
Fmnw7vMGYjRmYyFxxcYzXgOZsZFDkpp6403Op0ybJJGRa+2iRC6rH7ugl//MhxI=
=GtpQ
-----END PGP SIGNATURE-----

--vKFfOv5t3oGVpiF+--
