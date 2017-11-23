From: Mark Brown <broonie@kernel.org>
Subject: Re: Disable DAPM for click avoidance ?
Date: Thu, 23 Nov 2017 11:04:03 +0000
Message-ID: <20171123110403.cut6okmjxiithxsj@sirena.org.uk>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1113773720012464742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 00566266DF5
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 12:04:05 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
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


--===============1113773720012464742==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="doaeiedsujzi35tp"
Content-Disposition: inline


--doaeiedsujzi35tp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 10:41:33AM +0100, Ricard Wanderlof wrote:
> On Wed, 22 Nov 2017, Mark Brown wrote:
> > On Wed, Nov 22, 2017 at 01:33:37PM +0100, Ricard Wanderlof wrote:

> > Always CC maintainers on postings if you want them to be reliably
> > seen...

> Ok. I thought it was more of a general question than a maintainer questio=
n=20
> but I'll keep it in mind in future.

If you don't copy any actual people the chances of getting a response
are vastly reduced.

> > The CODEC driver is broken, it shouldn't be powering off on idle if it
> > takes a second to ramp, it should be leaving VMID up while the system is
> > running - this is what the _STANDBY bias level is all about.  Look at
> > what older CODEC drivers like the wm8731 do.

> It actually does leave VMID on as soon as the codec is not at the=20
> _OFF level, the problem is really that the output buffer is not enabled=
=20
> until a playback stream is set up, and its not until the output buffer is=
=20
> enabled that the output attains its operating level.

> Of course, one solution would be to change the driver to enable the outpu=
t=20
> already at the _STANDBY level. It does seem to me that that would violate=
=20
> part of the whole point of DAPM, on the other hand, I would think that=20
> at some point power management must take a second seat to actually gettin=
g=20
> a good user experience.

Yes, you'll need to do something like leave the outputs enabled.  Most
devices have some facility to keep VMID switched to the outputs, though
I did see a few where someone thought it was a good idea to power on
=66rom cold always.  A device that old isn't going to be that competitive
power wise anyway even if it were well implemented which this one seems
to not have been.

> > This is why we've got the digital_mute() callback - the idea is that th=
e=20
> > output is just going to be discarded until the interface has had a=20
> > chance to settle down.

> The problems we've had have been on the CPU side, with I2S interfaces tha=
t=20
> have problems synchronizing to an ongoing I2S stream when the CPU AIF is=
=20

That's what the digital mute handling is for - we're just throwing away
any garbage the CPU puts out before it's stable.  We're not expecting it
to work around any CODEC side issues.

> in slave mode, to the extent that in some cases its impossible to=20
> determine if the first sample received by or sent from the I2S interface=
=20
> is the left or right channel. If the DAIs had been set up once and been=
=20
> allowed to run continuously even when there is no actual audio to=20
> transfer, it would have helped this situation. Agreed, I'd rather have a=
=20
> DAI that worked properly, but sometimes one doesn't have that luxery. :-(

If you're getting L/R swap issues on some startups leaving things
enabled all the time will mean that your random swap issue gets moved to
boot.

--doaeiedsujzi35tp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloWqyIACgkQJNaLcl1U
h9Cd3gf/SCiXA7lp4CwPLGKBryqFbBzUcY6W+jYX8KaitKJDaY2Zu5ypzc3W35xL
FacTwaW+BeewXB4d7U2dAjTUM9gDKM47Co530ftN1tAWFb4mmVBolGYUH/8kQu4h
AssQ34qmHLIXHp8iHuuoB0CtH+W9ym3IB/GH3X0gf4EJpB94xVd79D6z7c3SB6CW
Lhq2mhuir8fIy3pXdtL5ycTq8qv5dwaXHE5pRoOjQPQvruXdy4AHm2uTcdcJNUkb
75xQfuNLvaTbLeprmzD0LtJ620dW2CPt5mq7BSeek7aHL6X9W9XSMrM19OQRgTgP
ct3ur8PGqrp1cq6tNpbSuvMXh3a45w==
=MzFM
-----END PGP SIGNATURE-----

--doaeiedsujzi35tp--

--===============1113773720012464742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1113773720012464742==--
