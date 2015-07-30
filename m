From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/6] ASoC: Intel: Skylake: Add functions
 for DSP module configuration
Date: Thu, 30 Jul 2015 20:01:04 +0100
Message-ID: <20150730190104.GA20873@sirena.org.uk>
References: <1437503040-7392-4-git-send-email-vinod.koul@intel.com>
 <20150729123323.GC20130@sirena.org.uk>
 <20150729165029.GG29916@localhost>
 <20150729175631.GK11162@sirena.org.uk>
 <20150730031507.GI29916@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2850822080784074700=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 26E4226071A
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 22:37:40 +0200 (CEST)
In-Reply-To: <20150730031507.GI29916@localhost>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============2850822080784074700==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 30, 2015 at 08:45:07AM +0530, Vinod Koul wrote:
> On Wed, Jul 29, 2015 at 06:56:31PM +0100, Mark Brown wrote:

> > But isn't this also protecting against attempts to use the resource
> > multiple times within the configuration (or shouldn't we be doing that)?

> In case of static since a module pin is allocated while designing
> topology we shouldn't have clash as per design of topology

> For example I have a Gain module connected to Mixer. Gain module pin 0 will
> be allocated to connect to Mixer Pin0. I wont assign Pin0 to any other
> module if I am doing static mapping.

> Whereas in dynamic we will check for first free pin and allocate.

> If all the pins has same meaning then dynamic would make sense, but non
> linear modules need reference signals so they have special pins so we need
> both approaches here

I'm not sure where I see the thing in here that controls the routing?  I
thought this might be something to do with it.

> > Please bear in mind that this stuff has basically zero documentation or
> > explanation so I'm kind of guessing as to what this is supposed to do.

> I did try to add explanation where I felt was missing, but yes this is good
> feedback, I will add more bits in next rev. Also please do point out where
> you feel we missed.

So, the summary for the series was:

| This series adds NHLT table support in the driver. This also adds support
| for dsp init, modules configuration and messaging support

and the description for this patch was:

| This adds helper functions to configure DSP FW modules and to be used when
| the modules is initialized, or when modules have to be bind/unbind.

so there's a *little* room for more detail.  I don't have any kind of
big picture of what the firmware does, what it needs from the kernel,
how this fits in with the bigger picture of the driver or anything.
Some more of that where this is going direction stuff would be helpful,
right now I'm not 100% sure where this is going or anything.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVunRsAAoJECTWi3JdVIfQWVgH/Ro9S4Ij46am/c4EwJDcQrs9
Dn6eLMs5MK3WVX3+e/L52iiwU+aN6UR3QSL45CjPZAWWEciNicRkxn+5ZzmePJFX
urd9Z6xENmW787aAZ1MO6OliAC7CawI+dpy5f4L1h1N2R+pA6By5Rzz6e740Zm+y
QxQ6UDd9F3XJfl2eFCgBWktiPV4/6+Mr9cX05DyDJIhpOffWMDxYVLwksVSmerxG
GCfGNvb7omVusINzHPTfm8adaUk+8LeR1RiyFh+6AaeZGziM3xRfwZyrXZYzdJnR
PFMQrqJH2MxVI+L2RMTYqmw9aTo2BHDEY7uWuKyi7hgV7PSIDM+o1sbCjoV7RPQ=
=9G5W
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--

--===============2850822080784074700==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2850822080784074700==--
