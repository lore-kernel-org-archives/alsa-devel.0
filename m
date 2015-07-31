From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Fri, 31 Jul 2015 10:23:50 +0530
Message-ID: <20150731045350.GJ29916@localhost>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
 <20150729165029.GG29916@localhost>
 <20150729175631.GK11162@sirena.org.uk>
 <20150730031507.GI29916@localhost>
 <20150730190104.GA20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3647494802211031780=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 817872614CA
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2015 06:52:48 +0200 (CEST)
In-Reply-To: <20150730190104.GA20873@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============3647494802211031780==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Content-Disposition: inline


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 08:01:04PM +0100, Mark Brown wrote:
> On Thu, Jul 30, 2015 at 08:45:07AM +0530, Vinod Koul wrote:
> > On Wed, Jul 29, 2015 at 06:56:31PM +0100, Mark Brown wrote:
>=20
> > > But isn't this also protecting against attempts to use the resource
> > > multiple times within the configuration (or shouldn't we be doing tha=
t)?
>=20
> > In case of static since a module pin is allocated while designing
> > topology we shouldn't have clash as per design of topology
>=20
> > For example I have a Gain module connected to Mixer. Gain module pin 0 =
will
> > be allocated to connect to Mixer Pin0. I wont assign Pin0 to any other
> > module if I am doing static mapping.
>=20
> > Whereas in dynamic we will check for first free pin and allocate.
>=20
> > If all the pins has same meaning then dynamic would make sense, but non
> > linear modules need reference signals so they have special pins so we n=
eed
> > both approaches here
>=20
> I'm not sure where I see the thing in here that controls the routing?  I
> thought this might be something to do with it.
>=20
> > > Please bear in mind that this stuff has basically zero documentation =
or
> > > explanation so I'm kind of guessing as to what this is supposed to do.
>=20
> > I did try to add explanation where I felt was missing, but yes this is =
good
> > feedback, I will add more bits in next rev. Also please do point out wh=
ere
> > you feel we missed.
>=20
> So, the summary for the series was:
>=20
> | This series adds NHLT table support in the driver. This also adds suppo=
rt
> | for dsp init, modules configuration and messaging support
>=20
> and the description for this patch was:
>=20
> | This adds helper functions to configure DSP FW modules and to be used w=
hen
> | the modules is initialized, or when modules have to be bind/unbind.
>=20
> so there's a *little* room for more detail.  I don't have any kind of
> big picture of what the firmware does, what it needs from the kernel,
> how this fits in with the bigger picture of the driver or anything.
> Some more of that where this is going direction stuff would be helpful,
> right now I'm not 100% sure where this is going or anything.
Fair enough.

I am adding more text and comments in the updated patchset to explain.
That should help :)

On your questions above, one thing I would like to point that typically we
have alsa controls and dapm widgets to model the DSP, but now with topology
core, we have moved these into the usermode.
In driver we have handlers for the topology events, so yes it becomes little
difficult to visualize but we can do better by adding comments.
This series is mostly helper code for getting topology created in DSP and
next (last series in current SKL driver work) series will add topology
handlers which will use these helpers, so the big picture will be clear
easily and complete flow can be visualized when these helpers are invoked.

--=20
~Vinod

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVuv9eAAoJEHwUBw8lI4NHoVUP/jqkNnJH0BR1s8yKrVysrIej
7S2l0bRPBJXNw5LxCL+WBQarWktcT0tAoBt39Bkpa1seoZeNNH4xQayWJcLco1T2
7x2fEkFmgFJdmQBmQJfOiosSVF1X6Da87SW6bZe+6OZUea+GOMCChCjo1onj/99S
USO7z2eSAelF+2+Dmg26tnQU3UYclIqjZtDM59iOYa2VEJymc/7Ef+WFGp8Bdnns
NWLIrqRzbQBuOohE4o/fuibCqWQgFKpfhihaaWzv5G0bUko8AFc8VcMTPxi1w9Jz
Hl28KZ9I/FMkQRswzaLm+4ZKfq0sqP5DGkJbuHLNFFacNEMfQEwQv7zFC9e3jYDq
ob7teGFExYPZCyRtsm2VzljfyPwtf08v3QpJkBOVO09ZJPugRcYSD2wwUbJzX6Mu
LvKWKdIafus2dN6ggrFesc1XEZK8ini4IRBw+4kp5Llefu653CHcXD7O72l2o3er
VNBhZGFo5cyMIfLihlPCbN/tN6+Qgv7fYyc7cArW7/8pvKGYZ3TmoOa+B+aliF1D
OyAGWU8Op5Y2Hk/4kl30vn25qnxTyiFTWc8cDPaWr7+Ipe7RJ8/mrRqF9DAWJxZs
3IbTZDWZbtqqj6dxcSAqNoNvVtaD1eXJuTGJ0HNoGArPWBz0Rp1bxyqsGTH5OoWV
y/qfoV3o3SNPzHLIQZAz
=sUov
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--

--===============3647494802211031780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3647494802211031780==--
