From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Add driver for CX2092X I2S Audio
	DSP
Date: Tue, 21 Feb 2017 10:55:11 -0800
Message-ID: <20170221185511.wqbjs66g7rn5e7lp@sirena.org.uk>
References: <1487427991-18174-3-git-send-email-simon.ho@conexant.com>
 <20170219162717.kwbeapezjjpcp6br@sirena.org.uk>
 <20170220023332.GB24076@GMAIL.COM>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3071531029481047837=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D93C9266DB1
 for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2017 19:55:26 +0100 (CET)
In-Reply-To: <20170220023332.GB24076@GMAIL.COM>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Simon Ho <simon.ho.cnxt@gmail.com>
Cc: Simon Ho <simon.ho@conexant.com>, alsa-devel@alsa-project.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============3071531029481047837==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="us3t5fl7judhzmfk"
Content-Disposition: inline


--us3t5fl7judhzmfk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 10:33:32AM +0800, Simon Ho wrote:
> On Sun, Feb 19, 2017 at 04:27:17PM +0000, Mark Brown wrote:

> > through standard interfaces?  This tends to end up creating problems
> > with things like power management as for example userspace might not
> > figure out that things like suspend and resume are happening.

> This device is designed for virtual assisant application need to be always
> open, listening for users to summon it. There is no any power saving mode=
=20
> support on this device. The processed voice data will be sent to automati=
c=20

Power management is just one example of system integration, and frankly
even there it's entirely possible that someone will want to disable the
functionality some of the time and hence power down the device.

> So such as mute and volume gain control are not necessary. These tunnels=
=20
> commands are actucally for debugging purpose only, they won't be used on
> normal operation. =20

So are they even needed in mainline?  How will the device function
within the system, there's no visible interface for reading back
status...?  Right now it's hard to see how this device functions
usefully in a system.

--us3t5fl7judhzmfk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlisjQwACgkQJNaLcl1U
h9DeHQf+M974GJaFpBdOEuxPWLovmByVmgKgLcsXc8mGKIsH4mTY1oQiD1H6cgFN
zI2NfrUFdIcng66YsBJCRRxWvUoNmEQNt81F9LZx7MhVq04BKWBqE5TRpObjB3hO
nGL6iSQhAqkuorCWz80WfNp08wBDHktE23rY2XhVWr6Ssr5DrJbXE9fVDEzgw33M
Xp0hWSAu4apEB0wWai1IR4RdAA99rBQZpv9aWdyHwKV9H/M6uF+18f/cp2ZXseO7
LloRhxYD6MCTL2sBDOOkO7XsixQ0A4ltEB1TUeK5yh3Xd5csmdGDf3Xa6Ijptze0
o06E//iTL7fVYWhc2YxbebH5vTi4EA==
=1DvV
-----END PGP SIGNATURE-----

--us3t5fl7judhzmfk--

--===============3071531029481047837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3071531029481047837==--
