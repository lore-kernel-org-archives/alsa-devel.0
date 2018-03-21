From: Mark Brown <broonie@kernel.org>
Subject: Re: Disable DAPM for click avoidance ?
Date: Wed, 21 Mar 2018 10:34:32 +0800
Message-ID: <20180321023432.GV2186@sirena.org.uk>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1803191641250.14045@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9196716222175272697=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 542BB267219
 for <alsa-devel@alsa-project.org>; Wed, 21 Mar 2018 03:34:37 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1803191641250.14045@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============9196716222175272697==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="P3ueQkFGL7LDwHzi"
Content-Disposition: inline


--P3ueQkFGL7LDwHzi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2018 at 04:53:23PM +0100, Ricard Wanderlof wrote:
> On Wed, 22 Nov 2017, Mark Brown wrote:

> > The CODEC driver is broken, it shouldn't be powering off on idle if it
> > takes a second to ramp, it should be leaving VMID up while the system is
> > running - this is what the _STANDBY bias level is all about.  Look at
> > what older CODEC drivers like the wm8731 do.

> I was tracing through what actually is called in the codec driver when a=
=20
> stream is started, and from what I can see ALSA sequences through the=20
> STANDBY, PREPARE and ON states when a stream is started, with no other=20
> calls to set_bias_level prior to that. So it would seem that the STANDBY=
=20
> level is reached during the process of starting the stream, in other=20
> words, VMID and the outputs would have to be enabled already in the OFF=
=20
> state.

To repeat if you're setting idle_bias_off for a CODEC like this you're
doing it wrong.  The device shouldn't be going to a bias level lower
than _STANDBY while the system is out of suspend.

> In our system, the power consumed by the codec is negligible compared to=
=20
> the rest of the system at all times, so it's not a problem to leave=20
> basically the whole codec up, but I am trying understand what is the=20
> Right Thing to do here.

Are you sure that the device doesn't have any facility for switching the
outputs to a lower power maintenance state while things are idle?  This
sounds like an extremely basic device, even by the standards of a decade
ago.  The reason for powering down the outputs isn't just a power one,
often especially with these older devices there's an audible noise floor
even when playing silence which is distracting for users in quiet
environments.  Powering down eliminates this noise floor.

The easiest thing to do if you just want to keep playing audio all the
time is to handle this in the sound server and have it keep playing.  If
the hardware really is as limited as it seems there's going to be no
good way to support it.  Without knowing how flexible it is or what
features it has it's difficult to be specific about the best way to
handle it but whatever gets done having a stream coming from the CPU all
the time will work.  The more control there is the more likely it is
that the driver is going to have to power it down on idle anyway to
allow configuration changes to be made without generating pops and
clicks.

--P3ueQkFGL7LDwHzi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqxxLcACgkQJNaLcl1U
h9D/WAf/YMmqISzYcr0hQa9v3tz2i+tdZcztBYRw5ZsnrR3FQ2Zi6AAURqo/d/iJ
/it9C7iCPBalIQlOD6Nl+6hlVRYTnUKc5aN3uk6GWscfy2lpc+dpmQ3QTrKoMCm6
Px6KdoTGynxw9LQB5rWXgpmPscxK+oEMknfFNfJbdMQbdzqtlpsxKarLD5M5pyEV
kDl0z5LGNPBUtwhUhxN0gG75Vj4XQiv7hr0DwbBfJFbY3TQg4SzLNgo2qO97ensd
apVgbjRwtOa2naFghht5+eGRNe/oFlMkFz79J3s9XEISQE1fxzk2QsunKYIYDys6
CzxoziEiwF1yxP1TUeWxGqFE/x+a6A==
=tmx9
-----END PGP SIGNATURE-----

--P3ueQkFGL7LDwHzi--

--===============9196716222175272697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9196716222175272697==--
