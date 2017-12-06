From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 17:29:24 +0000
Message-ID: <20171206172924.mrd233uipzorrymc@sirena.org.uk>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com>
 <20171206123908.GB1827@finisterre>
 <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6129548978247947894=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 325882679C7
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 18:29:26 +0100 (CET)
In-Reply-To: <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============6129548978247947894==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2fmbmlxp44sgxt7t"
Content-Disposition: inline


--2fmbmlxp44sgxt7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 10:06:34AM -0600, Andrew F. Davis wrote:

> Your wording seems a bit inconsistent to me, what do you mean by "IP
> drivers", CODEC or SoC internal IP? For clarity I'll try to use only the
> three driver type labels: codec, platform, and machine. This is all in
> Documentation/sound/soc/overview.rst which I'm sure you are familiar
> with as you seem to have had a hand in writing it.

IPs in SoCs.

> Anyway, I'm working under the assumption that we should try to enforce a
> logical separation between component drivers: codec drivers should be
> agnostic to what machine they are placed, platform drivers should do the
> same and not make special arrangements to work with one machine in
> particular. Machine drivers on the other hand will need to dig into
> specifics of the codec and platform drivers that they use and connect.

Machine and drivers for SoC internal stuff tend to be bound fairly
closely together, simiarly the various drivers for an IP on a SoC often
know things about each other for various reasons.

> With this in mind I do not see any reason not to have platform drivers
> in a platforms/ directory just like we do with codecs/. In case there
> was any confusion, I still want to keep the platform drivers' files all
> grouped in directories by IP holder, just moved under this platforms/.

Moving everything around is at the very least going to be a pain for
anyone doing backports and anyone actively working on patches, splitting
the machine drivers from the rest of the drivers for systems based on
that SoC means it's going to be a little harder for people to find
relevant system specific machine drivers.  Generic machine drivers are
already split out.

Any benefits seem very weak here and it's an awfully disruptive change.

> This has the benefit of reducing exactly what you are talking about,
> platform drivers working in concert with machine drivers, instead of the
> other way around.

What I am saying is that they go together very closely.  Moving the code
around isn't going to change that.

> This isn't only confusing to me, but other first time ASoC devs:
> https://stackoverflow.com/questions/20110801/asoc-drivers-which-files-are-platform-machine-and-codec-drivers

I rather suspect the confusion they're having is more to do with the
fact that the documentation isn't very good than it is to do with where
the files are.

> even the answerer seems to assume there is a
> sound/soc/platforms/, for the same reason we have sound/soc/codecs/.

Or possibly just because they're not very familiar with what they're
talking about here.

> > If you want to make a common directory for TI stuff do that, there's no
> > need to mess up all the other platforms to do that though.

> Do you mean sounds/soc/ti/{platforms,machines}/ ? I could do this, but I
> don't see how what I've done in my example patches has any effect on
> other IP holders, they are free to migrate as the please.

Oh, right.  Your commit message sounded like you wanted to dump
everything into a single directory for all SoC side drivers which
doesn't seem like an obviously useful thing, my best guess had been that
you were trying to get all the TI drivers into one directory.  I don't
see a pressing need to do that, but I can see it might potentially be
causing issues for people.

If we were going to do this reshuffling then we *really* shouldn't be
doing it randomly for only a few vendors.  Doing it inconsistently is
not going to make anything clearer.

--2fmbmlxp44sgxt7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooKPQACgkQJNaLcl1U
h9CNXAf+N6BFgnQnhgZgfSTRJRU51di4yw/4RaeIteAwKzz7H8ozQBaldYJzzOy+
sxYxrDMI1sJN5K/OqsunICWCUZEThqEEv+VZV5vWa/+2GEYjM5F9GKT5ky4ctxQ2
PHH7XvFfM7vuaBJ3T2U6cJMWNkXQF8QbPSfr5hlaRWKMkGAjIDTFiPeZz2sC2DXt
FZ0lcyfF09cc69ULUoIJG/tjvBY7E0Fw3WJCYV4XwV9Lu1m7pC+VcOUI7MCO/psz
Tg79k10J4B/8+WNRjoLLXmTMUmkPnttF0ihNmS7uYP8AJorpaP5r7ka6BWMReQIl
WIJmKpM3pmNYPoAyB8XNHlYUC7im1A==
=qLk/
-----END PGP SIGNATURE-----

--2fmbmlxp44sgxt7t--

--===============6129548978247947894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6129548978247947894==--
