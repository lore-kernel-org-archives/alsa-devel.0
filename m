From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: soundwire: add slave bindings
Date: Thu, 8 Aug 2019 20:52:16 +0100
Message-ID: <20190808195216.GM3795@sirena.co.uk>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-2-srinivas.kandagatla@linaro.org>
 <d346b2af-f285-4c53-b706-46a129ab7951@linux.intel.com>
 <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kunpHVz1op/+13PW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cdd2bded-551c-65f5-ca29-d2bb825bdaba@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org, bgoswami@codeaurora.org, plai@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--kunpHVz1op/+13PW
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 05:48:56PM +0100, Srinivas Kandagatla wrote:
> On 08/08/2019 16:58, Pierre-Louis Bossart wrote:

> > > +- sdw-instance-id: Should be ('Instance ID') from SoundWire
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 Enumeration Address. Instance ID is for =
the cases
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 where multiple Devices of the same type =
or Class
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0 are attached to the bus.

> > so it is actually required if you have a single Slave device? Or is it
> > only required when you have more than 1 device of the same type?

> This is mandatory for any slave device!

If it's mandatory the wording is a bit unclear.  How about something
like:

	Should be ('Instance ID') from the SoundWire Enumeration
	Address.  This must always be provided, if multiple devices
	with the same type or class or attached to the bus each
	instance must have a distinct value.

--kunpHVz1op/+13PW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1MfW8ACgkQJNaLcl1U
h9BC6Qf+MpoIdX8BiE+fy8vg1a5ZsWCGWK/V6LMgyk7vx2P8oWJylUyIG9xTvecn
zrFjIwW5t44x8P5ycsmXZCqG8JCU0/qPSQ9Aw4qC1jesy3Ue4Lwtmu0qH5gvFsSg
CKW/bidKNFSCg3t39fddxeawm+GiutGVwnCgnVtkH9tmcONusdDfnDdOLQiQUQa1
CsmQIbGs/BEuF6LF11Ho58rf7UHvuu4oF9mrKszQWdZKTkhNPfjgqy4n8/scVObd
TAbUUo0uixBk2YmmcxrwtF1V9QGPyifPM8LsHlXlxO3ZSH+/fARzkRoBYQlbwRju
aGWXSh12SOwhelEkD1Q19DG25zsCsQ==
=Nsvw
-----END PGP SIGNATURE-----

--kunpHVz1op/+13PW--
