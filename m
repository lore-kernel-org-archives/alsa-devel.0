From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Tue, 10 Nov 2015 15:44:34 +0000
Message-ID: <20151110154434.GG12392@sirena.org.uk>
References: <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
 <20151106115451.GG18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CAAD@SW-EX-MBX01.diasemi.com>
 <20151108103429.GC6746@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CC6C@SW-EX-MBX01.diasemi.com>
 <20151109140225.GA26072@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CEA5@SW-EX-MBX01.diasemi.com>
 <20151110141513.GF12392@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CED5@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PyMzGVE0NRonI6bs"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CED5@SW-EX-MBX01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Support Opensource <Support.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--PyMzGVE0NRonI6bs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 10, 2015 at 02:24:13PM +0000, Opensource [Adam Thomson] wrote:
> On November 10, 2015 14:15, Mark Brown wrote:

> > So this *isn't* a normal mic detection feature?  What's the userspace
> > interface for reporting then?

> By mic detection you thought this was to detect if a mic was present or not?

That and button detection.

> It's to detect the noise level on a mic and raise an event if the captured
> sound is above a specific threshold level. Apologies if that wasn't clear.

> In the driver code I'm using KEY_VOICECOMMAND, and simulating a press and
> release of this key, to indicate to user-space. This seemed like the obvious
> choice for this feature to me, although I'd happily get your opinion on this.

That seems like a particularly unfortunate choice given that
VOICECOMMAND is used in the standard Google headset mapping (see
ts3a227e for an example, that's a device specifically aimed at providing
accessory detection in Chromebooks).  There's also been some pushback
against using the input devices due to the difficulty in enabling apps
to access input devices - ALSA controls were preferred instead but
that's less helpful for tinyalsa.  Perhaps that can be added relatively
easily, or a uevent or something.

Not sure what the best way forward here is, the other implementations of
this that I'm aware of do more of the detection in offload and present
streams of detected audio to userspace via normal capture.

I would at least suggest moving this into a separate patch and doing
the integration separately.

--PyMzGVE0NRonI6bs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWQhDiAAoJECTWi3JdVIfQfIQH+wcvgWbd+D8nAGbZlmOEoLHw
WtMKSQvPT1gVIcj5gViSLtQMTiQAaa/WV1y4tOxWKkNZx8saTY0ZqTbNBAnhXxSY
ZSbMAiRvfpdUpGTEl1Lr+JkCYHKx8j3rNpRQgG6QVMaRCRzg6T+dAoNg7Mfx3JXq
46StUzBx5zqxx3ZOir/n91olwl5P4bxqfQ45aXvWeZs6Hq7G7gwkpiVICapHo9Pu
V3lExGWowVmvwWt1D4CfV4xiI8NfY5obLcpq+udvh8LGUzL1LWM1UPpT33SSLwCQ
hJXc98ZKjRCOmobqrA9bBDCFFHTiTUuIYVQmSjMhyhKcoLBPMLLlS8frBHP2csE=
=caOG
-----END PGP SIGNATURE-----

--PyMzGVE0NRonI6bs--
