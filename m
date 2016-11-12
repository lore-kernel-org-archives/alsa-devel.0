From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] sound: soc-core: make kernel complaints on
 -EPROBE_DEFER dev_dbg
Date: Sat, 12 Nov 2016 10:00:14 +0000
Message-ID: <20161112100014.cwbwkls3kgphj5bz@sirena.org.uk>
References: <20161109140036.GB20859@localhost.localdomain>
 <20161109143642.7knvr63vwmcgunjf@sirena.org.uk>
 <20161109151426.GA21280@localhost.localdomain>
 <20161109152209.dzejborw53no26ew@sirena.org.uk>
 <20161109163658.GA21606@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1459904555033900324=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 362B72676B4
 for <alsa-devel@alsa-project.org>; Sat, 12 Nov 2016 11:00:29 +0100 (CET)
In-Reply-To: <20161109163658.GA21606@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1459904555033900324==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bnuockyhtcniyh7d"
Content-Disposition: inline


--bnuockyhtcniyh7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 09, 2016 at 05:36:58PM +0100, Ladislav Michl wrote:
> On Wed, Nov 09, 2016 at 03:22:09PM +0000, Mark Brown wrote:

> > How do we know that it's not a kernel misconfiguration?  It's common for
> > people to not build some of the component drivers they need.

> Is what you described really a misconfiguration? Enabling debug when
> something does not work seems obvious thing to do, but okay, perhaps
> anything bellow error level would make me happy enough.

Yes, it's something that's really common when people configure their own
kernels.

> > > > If you don't like deferred probing please contribute to the efforts
> > > > to order probing.

> As a side note, which efforts are you reffering to here?

Things like Raphael's device dependencies work.

> > > I just tried to make it consistend to other subsystems where patches to
> > > silence deferred probing warnings are accepted...

> > Which subsystems are these?  We should look at fixing them...

> tty and usb for example. I do not consider wise to looking at them until
> this very subsystem gets fixed first to not distract ourselves ;-)
> (Also I have admit, that accepted patches hide error message on deferred
> probe only, but above occurs _also_ on deferred probe and yes, it would be
> nice to have that fixed)

This really does make it harder to figure out what's going on when the
dependency is actually missing - it transforms things into a silent
failure.

--bnuockyhtcniyh7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYJugtAAoJECTWi3JdVIfQuPAH/1JgnkgzbZVT+8gT1ikr40B6
sZbwlA40thLBsddPapTk4pFS016qbFaB/qjWEacnqe22k0n0B8WKmrj7SE1tOHR3
yRKzqianuyq9xLf7XFx23Acm5eVsX3tyuVK466wTYeNfHS/BTw4L+YFkqjL+sLBk
Rfg53mWhjEGRaa+VrJHiU8w+Bd30cEFa6NsLpbDUNKddqhqW3/6ho+dAqFU5gsTT
B94mTJN9JSROrPkZTMAl4Wn0j7yOPg8BxONwqWrXEbNHLECP003mmhrHwFyQ3Jpi
HmA1bZ99DlNr9JUGQitPRAxrizRBBs3Aa52eN3mfIzsfozwlDmjCMFBVyF5ycX8=
=ORRr
-----END PGP SIGNATURE-----

--bnuockyhtcniyh7d--

--===============1459904555033900324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1459904555033900324==--
