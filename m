From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/4] Add Wolfson Microelectronics WM8776
 codec ALSA driver
Date: Wed, 18 Apr 2012 11:34:30 +0100
Message-ID: <20120418103430.GG3021@opensource.wolfsonmicro.com>
References: <20120417170431.GT6652@opensource.wolfsonmicro.com>
	<s5h3982p71g.wl%tiwai@suse.de>
	<201204172015.14582.linux@rainbow-software.org>
	<20120417182204.GV6652@opensource.wolfsonmicro.com>
	<s5hwr5enpau.wl%tiwai@suse.de>
	<20120417194341.GX6652@opensource.wolfsonmicro.com>
	<4F8DCF81.4080508@ivitera.com>
	<20120417212914.GZ6652@opensource.wolfsonmicro.com>
	<20120418090620.GA21844@sirena.org.uk>
	<4F8E88E9.4060007@ivitera.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1724732248474356315=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E6752434E
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Apr 2012 12:34:33 +0200 (CEST)
In-Reply-To: <4F8E88E9.4060007@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Ondrej Zary <linux@rainbow-software.org>
List-Id: alsa-devel@alsa-project.org


--===============1724732248474356315==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oOB74oR0WcNeq9Zb"
Content-Disposition: inline


--oOB74oR0WcNeq9Zb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18, 2012 at 11:27:05AM +0200, Pavel Hofman wrote:
> Dne 18.4.2012 11:06, Mark Brown napsal(a):

> > BTW, this probably deserves picking up a bit more: there's really no
> > distinction between commercial and non-commercial contributors, if
> > anything I'd say that on average the hobbyist contributors tend to be
> > working to a higher standard on average.

> Mark, my whole point is most nonASoC alsa developers have no idea they
> are supposed to use stuff in the asoc subdir for the drivers outside of
> the asoc subtree. And I guess they mostly do not follow mailinglist
> messages prefixed ASoC either.

You're not engaging with my core point here - the simple fact that
there is an existing driver for the device ought to be enough of a clue
to allow someone to figure out that there's a problem here.  This
doesn't really need understanding of the code.

> If sound/asoc/codecs was in sound/codecs, they would certainly take a
> look. But right now to them asoc really feels like a separate world.

To be honest if you're at the point where you're familiar enough with
development to be ignoring bits of the tree you don't normally work on
then not noticing the duplicate driver is in many ways even more
surprising.

If we're going to reorganise the tree then there's a whole bunch of
other things that could usefully be cleaned up like moving to drivers/
and cleaning up all the legacy embedded platforms.  This wouldn't be a
bad thing, I'm sure it's actually been discussed before.  I'd expect
we'd probably still end up with all these devices grouped together
though as organising by subframework does seem sensible, the issue is
more that we've got some things that are duplicating effort.

In fact I'm actually tempted to create a legacy subdirectory as a first
step...

> I understand you would like to change that (or IOW - it would be
> beneficial to whole alsa to change that), very good. That is why I am
> talking about some guidelines for the non-asoc developers. I cannot
> write them, I am one of those having lived in the old-ages dark so far :)

Well, it's pretty simple really - anything where the audio CODEC is a
distinct piece of hardware connected with I2S or similar format
interfaces ought to be using ASoC.

Aside from legacy drivers like this, and the few in media/ it's really
where we're at already.  We do from time to time get vendors trying to
submit their own custom stacks but they get just the same sort of
pushback for exactly the same reason.

--oOB74oR0WcNeq9Zb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPjpivAAoJEBus8iNuMP3dtS0QAJkSkHUXT40ytlJ+PCD5/Zmx
9WoZN07Nh/Ex0PVPD47qD16hu4x/fQ/OVgfNxawKfn8FC3zMOORvTMm3xGF3Ak0o
9/MSwhPeqbUMkKJzWybWFFaQuctQsnZLPVE56va+Rq8Xj5KQoIanBhvwpDnF8jpy
+2OBnp/UbpsNlvEFJjro1Xm4L+bpQ+pR4ZsVbewNlshjvuCfH71hcSe0pCloRXFd
Kjo3tM380kbXzvsZENh5G1/gkfI+1968gSdKVcB0YFa3exN6Ghrowb+weneB0a6+
0ojtwad1JLw34pbD1Aed0vIY7OnA5oTnbCE/TVHlufSbnSPaeGkgb3a5z3shl/yu
2Xjs956zApsqOI7lh5JrtJWzQ0srO1fQ/JzSiv47cMxN2hVlqO1tUupFW0UJz848
setmEcfuRH7WYyNyBeBYN1ZkfxtO0P0ZF1HimfACtS6HXDX5NAVlnBgeNTRdqFr5
atqwTnyogXWY6CvzmNLMdbX4zitUeBVdv2J1AKhl+NYzGjoETApGtezNpkn/Bxn2
6FXZ0x+Z8PWAMibrW8Ok23bh+AW+7i0Tmz+Wi3RcQltpjEmjyB9FWidnEU21/PMs
8VtS9IXMvvuDerqK0DiBz5RCHqCn2YI6h/S1WQ3WQXMgCJpW45BSr9KlU7RlFOxH
nux1HUVd6m1zIzuSgj6t
=1tHC
-----END PGP SIGNATURE-----

--oOB74oR0WcNeq9Zb--

--===============1724732248474356315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1724732248474356315==--
