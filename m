From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off setting
Date: Tue, 4 Sep 2018 17:21:01 +0100
Message-ID: <20180904162101.GK12993@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
 <20180903112656.GF10302@sirena.org.uk>
 <701a066c-33e1-4476-7403-fdb9a3c366d8@ti.com>
 <20180904144159.GC12993@sirena.org.uk>
 <7163381a-ae09-ad3b-064d-990c98f13ccb@ti.com>
 <20180904145503.GD12993@sirena.org.uk>
 <85973bf4-1acb-1731-d93e-29c8141a3c53@ti.com>
 <20180904155655.GJ12993@sirena.org.uk>
 <5e7fdb87-651d-6056-9323-7a29573b6300@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e7fdb87-651d-6056-9323-7a29573b6300@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 04, 2018 at 11:02:14AM -0500, Andrew F. Davis wrote:
> On 09/04/2018 10:56 AM, Mark Brown wrote:

> > I'm really having a lot of trouble seeing MICBIAS_OFF as a useful
> > voltage to specify in DT in the first place.

> I don't see the usefulness in specifying any bias voltage in DT at all,
> it is a configuration and can be made at runtime, it has no place in DT.
> But it is already here, so lets allow all available voltages a board may
> need and the CODEC can supply, even 0.

It is very rare for it to be useful to select the bias voltage at
runtime - it's usually something that's decided by the electrical
engineering at system design time and linked to selection of passive
components rather than something that a user could usefully vary.  I
suspect in the situations where it is useful to vary it you'd want a
layer of indirection mapping it onto some user observable behaviour (or
the system should just do this autonomously as with the various low
power mic detect solutions out there).  What situations are you aware of
where runtime configuration is useful?

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluOsOwACgkQJNaLcl1U
h9DYmAf+LCT+vhBXxyGDhabEyFRP6oDBpr/gdW0VYGmGA6gmmSyRJ/FpyQptNoaq
yIpEeS137gVaflEf50GOe4ir99A2BEm/9bDM/GfWiqVXxVEj7DJJErUbDD/U5GVc
tmTZRprqQE7mtLDXcabHWZ36NvJDPYSsW4nWY/lECWM/n7WhF6Uj8doy/aB7M4um
9+IoV+5K72uid4PEJXQW2I4aqJGnGIx8OKe7+0028gC4Rz+P9zpM+e7R/Z7jEpzO
4ERfDasO9WhLSu+4dqCqSu0eA3yAAkgDaZqbhRmRzgMozN9jHdkEB3aQdL2qf52V
5NHHRm6HOcIHW2PXOwC7Lwbl9Aad4w==
=rGwn
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--
