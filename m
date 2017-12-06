From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/3] ASoC: Add platforms directory
Date: Wed, 6 Dec 2017 18:42:19 +0000
Message-ID: <20171206184219.fhhohxdihsm33kf6@sirena.org.uk>
References: <20171205181448.18513-1-afd@ti.com>
 <20171205181448.18513-2-afd@ti.com>
 <20171206123908.GB1827@finisterre>
 <561a6ebd-c978-c52a-a13a-3300be9a58bb@ti.com>
 <20171206172924.mrd233uipzorrymc@sirena.org.uk>
 <caea9bc4-94f3-41bc-5940-5769917962cf@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3167173839726472192=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C8CD8267048
 for <alsa-devel@alsa-project.org>; Wed,  6 Dec 2017 19:42:21 +0100 (CET)
In-Reply-To: <caea9bc4-94f3-41bc-5940-5769917962cf@ti.com>
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


--===============3167173839726472192==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e5zlrest3peigqcu"
Content-Disposition: inline


--e5zlrest3peigqcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 06, 2017 at 12:13:22PM -0600, Andrew F. Davis wrote:
> On 12/06/2017 11:29 AM, Mark Brown wrote:

> > Machine and drivers for SoC internal stuff tend to be bound fairly
> > closely together, simiarly the various drivers for an IP on a SoC often
> > know things about each other for various reasons.

> This is the problem, we don't want them to be so tightly bound, and
> luckily, for the most part they are not. Even a complex and history rich
> platform like OMAP was rather trivial to split from its various machine
> drivers.

Anything new that can is already getting pushed into using the existing
generic cards.  New machine drivers are only for things where that's not
possible.

> > What I am saying is that they go together very closely.  Moving the code
> > around isn't going to change that.

> Not at first, but this partition will discourage future machine-platform
> mash-ups (like omap-hdmi-audio.c, yuck).

It's not a pressing problem.

> My end-goal here is to start trimming the needed machine drivers and
> replacing them with generics, a couple OMAP machine drivers do nothing
> that couldn't be done with the "asoc-simple-card" driver. With the
> machine drivers split out form the platform drivers it becomes easier to
> target them.

We need to preserve old bindings to ensure DT compatiblity, the easiest
way to do that is to keep old machine drivers around.  There are plenty
of older drivers that wouldn't be accepted now but would at least need
replacing with a compatibility layer that adapts the bindings onto one
of the generic drivers.  That adaption layer would definitely be useful
(basically a big table of platform data) but it'd take time to implement
it.

> I don't have any need to group the TI platforms (Davinci / OMAP) right
> now, but I *have* been thinking about grouping the TI CODECs, they share
> a lot of code that could be factored out if they were stored in their
> own space sound/soc/codecs/ti/. Plus it would make it easy to add myself

You can share code easily enough without moving anything, just make a
library like the arizona drivers did.

> as a reviewer for them (I seem to be getting a lot of internal support
> requests for these drivers these days). That can be a re-org for another
> day, unless you would like me to post an RFC with what I had in mind?

Wouldn't a few regexps in the MAINTAINERS file cover it?  We've already
got a bunch of vendors doing this.

> > If we were going to do this reshuffling then we *really* shouldn't be
> > doing it randomly for only a few vendors.  Doing it inconsistently is
> > not going to make anything clearer.

> I can send patches for rest of the vendors if you would like to see that
> and what the end result would look like.

I'm not convinced this is a good idea.

--e5zlrest3peigqcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlooOgsACgkQJNaLcl1U
h9AP2Af/Ui866imMSJnEAR7poEJlI5TyXkuf2QCmHLbbVYdBpKo+gXlAbUp/7Y2S
1Iw0sAD7bf/BbP1RRim/OtsdEZO0MZ3DdMDTjZv4LkuxnTS27G3+2NrEO3i5Gy4W
gKSrNVap0W1h5rpOYJsiJ7aQtxvqxdiByyG2aVuPM7v4NOsOnTd2uTRfzRykXGDI
Eyh8kn9btlZImmWQRvbPGNM8mJPk1Ht8hcCdg0pBrm6HDm2l3G+NZbwQNd+Dgooy
DcWSIpOpkpGlBoMHlgBFOhAHsgo94/Ua1AVx7cak0lJvIg7RLAZu5WfEGMJnbMic
ItmlSSI5BE1FjOdiRfSuumF37XbWQg==
=6PNV
-----END PGP SIGNATURE-----

--e5zlrest3peigqcu--

--===============3167173839726472192==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3167173839726472192==--
