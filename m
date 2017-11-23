From: Mark Brown <broonie@kernel.org>
Subject: Re: Disable DAPM for click avoidance ?
Date: Thu, 23 Nov 2017 17:34:27 +0000
Message-ID: <20171123173427.p3vtifkpqjziifjr@sirena.org.uk>
References: <alpine.DEB.2.11.1711221315370.27895@lnxricardw1.se.axis.com>
 <20171122161315.vpahz77si5xgkmct@sirena.org.uk>
 <alpine.DEB.2.11.1711231024510.27895@lnxricardw1.se.axis.com>
 <20171123110403.cut6okmjxiithxsj@sirena.org.uk>
 <alpine.DEB.2.11.1711231512490.27895@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3946581751142106919=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A73826737A
 for <alsa-devel@alsa-project.org>; Thu, 23 Nov 2017 18:34:29 +0100 (CET)
In-Reply-To: <alpine.DEB.2.11.1711231512490.27895@lnxricardw1.se.axis.com>
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


--===============3946581751142106919==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ekuhcupnanszmenh"
Content-Disposition: inline


--ekuhcupnanszmenh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 03:32:26PM +0100, Ricard Wanderlof wrote:
> On Thu, 23 Nov 2017, Mark Brown wrote:

> > Yes, you'll need to do something like leave the outputs enabled.  Most
> > devices have some facility to keep VMID switched to the outputs, though
> > I did see a few where someone thought it was a good idea to power on
> > from cold always.  A device that old isn't going to be that competitive
> > power wise anyway even if it were well implemented which this one seems
> > to not have been.

> In my case the codec is only a couple of years old, so I'd say it=20
> qualifies as 'modern'. There's a table in the data sheet describing the=
=20

Wow, people are still designing new VMID based CODECs - what is this one?

> > That's what the digital mute handling is for - we're just throwing away
> > any garbage the CPU puts out before it's stable.  We're not expecting it
> > to work around any CODEC side issues.

> During which time period is the digital mute enabled? From the first=20
> stream startup until everything is up and running?

It should be enabled at all times that we're not actively playing
anything.  Though now that I think about it we need to go through and
mute everything during probe otherwise it won't be muted on first power
on.

> > If you're getting L/R swap issues on some startups leaving things
> > enabled all the time will mean that your random swap issue gets moved to
> > boot.

> Basically the situation I had was that it worked fine on first startup, i=
t=20
> was on subsequent startups/shutdowns that the problems occurred, as
> shutting down the audio streams seemed to leave the CPU DAI in some=20
> intermediate state, from which it could only recover if completely reset,=
=20
> which did not play well with the concept of for instance having a capture=
=20
> stream running continuously while a playback stream was started and=20
> stopped.

That's a new (and buggy) one...

--ekuhcupnanszmenh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloXBqMACgkQJNaLcl1U
h9B80Qf+MJLLFmqDl4ldIbRlrlR698GoWu4CKSeDM6Zm3OSZCRkQLTTmLEebMrr3
NTYi4baZoOMhbkkDRJs0KNKwE6tcnyLRu+xF45MuXQdANaTxCyLe7Xcfs1XjtvYE
vrDpfIn35ZofPWIze1jBlNQZ5y5FjRnuprTKkbY++s4NmsgqaJVBcOwdIQ5wv1l3
tPEr8o17Q5nh6dWIeKNGPpdQfHdVUVprsoMc9dYrOSEmFGYpjwKr05CGU61sZYJe
6UZ44egWDZde9PCUtEaiepbYfm5uETmADWePGV9E8Xwyvgy00DDAydO7fKMFGFgA
ikV/VSRLEKO5q3OCHGVyxcmf+dxpFQ==
=zSDm
-----END PGP SIGNATURE-----

--ekuhcupnanszmenh--

--===============3946581751142106919==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3946581751142106919==--
