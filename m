From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT
	support.
Date: Wed, 30 Oct 2013 18:28:30 -0700
Message-ID: <20131031012830.GZ2493@sirena.org.uk>
References: <1382616832-23593-1-git-send-email-denis@eukrea.com>
 <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0564469522488188100=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 447992619DA
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2013 02:29:50 +0100 (CET)
In-Reply-To: <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Sealey <neko@bakuhatsu.net>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Shawn Guo <shawn.guo@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============0564469522488188100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lKbk9CFItQTD29wm"
Content-Disposition: inline


--lKbk9CFItQTD29wm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 30, 2013 at 05:29:31PM -0500, Matt Sealey wrote:
> On Wed, Oct 30, 2013 at 4:29 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Oct 29, 2013 at 10:05:40PM -0500, Matt Sealey wrote:

> >> 1) saif-controllers and ssi-controller could be a single property -
> >> controllers - which list the controller. It will be obvious which kind
> >> of controller it is by delving into that node referenced by the
> >> phandle.

> > Picking a consistent name for this might be nice, yes.  Feel free to
> > send patches...

> When - if - I have time.

Please consider prioritising this over writing e-mails; talking about
device tree does often seem more popular than solving the harder
problems.

> > To repeat yet again, if this concerns you please work with Morimoto-san
> > on his generic card driver.  There are some code differences with clock
> > setup for the devices which are encoded in the board definitions as
> > well, plus the external connections.

> Well the main crux of the problem here is that there's been a node
> defined with a special compatible property that requires a special
> device driver to marshall and collect nodes referenced within it - and
> most of these drivers do exactly the same thing, which is why generic
> card drivers seem like a good idea.

The missing bit with generic card drivers has been anyone other than
Morimoto-san working on it; I don't think anyone thinks that is a bad
idea for the simple cases.

> Where those things are generic it is not only a problem of code
> duplication but a bad idea in "creating a special node" to marshall
> it. The "sound" node here, with this special compatible property,
> doesn't really exist in real hardware design, it exists within the
> Linux kernel to allow it to construct a "card" out of a controller,

Please, as I have repeatedly asked you, go back and look at the previous
discussions on this topic and familiarise yourself with the needs of
advanced audio subsystems.  This has been covered ad nauseum in the
past, there's no need to go through it all over again.

> > That's not what's going on here, let me once again ask you to review the
> > previous discussion on device tree bindings and make sure that you
> > understand the needs of advanced audio hardware.

> There's no existing example of this advanced audio hardware, no
> discussion about what would be required, only a vague assertion that
> to build this abstract card structure in Linux, this is the only way
> to do it.

That is a rather strongly worded statement which doesn't appear to
correspond to reality; for example there are a number of Linux based
smartphones in production many if not most of which have complex audio
needs and components with lots of flexibility.

Please do the research I have been asking you to do and/or contribute
code, this will be less time consuming for all of us.

> > That's not going to scale well to boards that have inter CODEC analogue
> > links, we'd need a node for every single thing that could be a source
> > and sink on every device which seems tedious.

> Yes, but I am not sure having a single property with pairs of strings
> makes any more sense - sure, you require a node for each, but how does
> just requiring a static string for each do this any better? Now you
> need a string for each, which has to match a driver in Linux.. what
> about another OS?

Look at where the names come from...

> > We can't, one of the problems with this stuff is that clocking design
> > (especially for the advanced use cases) is not as simple or general as
> > one might desire for a bunch of totally sensible electrical engineering
> > and system design reasons.  When we get to the point of deploying simple
> > card widely it's just typing to define a standard constant that everyone
> > can use for whatever the default sensible clocks are, and of course
> > people working on simple card can do that as they're going.

> I would have thought using the clock bindings, and judicious use of
> clkdev internal to the codec or controller driver, would fix this.

The clock configuration bindings don't currently exist, won't cover the
dynamic cases and won't help non-DT platforms.  Remember also that we
don't even have a clock API of any kind on a good proportion at the
minute and don't have the common clock API on some of the rest.

> this all ends up at the codec level by dereference.. so why would it
> need to *be* defined at the card level in any of these cases? In all

This is the sort of information that you should be able to discover if
you review the previous discussions.

> of these cases, maybe not for all cases forever and ever, but the ones
> we're looking at here where we have a goodly selection of codecs and
> maybe 4 or 5 controllers and 2 or 3 implementations of each, there's
> no reason for it.

One of the devices you're looking at here is WM8962 - it does actually
have the ability to do a bunch of the things that make decisions about
clocking interesting.

--lKbk9CFItQTD29wm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJScbI7AAoJELSic+t+oim9uiQP/j2eWBuQweDCjkORyBdDq0Wl
KH+5+FNtsJjHHxC6lnt5h0+dH1ybTZsjms4hmGZIwha/BxobDpJf9D1Z/c0N+tw/
KgDmL5JuEAEUuvMR410i3mFifyNJf9pmsTBVkyAGP3ix9LPyzYbGf97SKRFyRrXJ
qdA+MSBV6Qyz2vAEiCUHyWGhJ/pUozUyQYUw0lalvVRKh3Fg2a39e6sMArd8E6ZL
zQvvs2EiW8bUXQtlAEbWE7PitDBY+plZulc853Vk5sLuHRbUlllaf4PuWedPVnJK
YtShWL1jKy5B9n03xj/bsBMawIxZUvrXafq9nezEFsMsq6hIFe4zj1rigeH4ZC+9
eVD5RWelW6tXdJjXwtjWJtVWlafCFN+h8rOWiWmkwkNN+p2JjMn0ANgNPh87qDp5
ZayE3g7aadJrbCCzuNjkWX3iXi5CsASGiUd7pkEmliskJfqQ78rLQXkmYS1t+713
2NMbEsCR4fDmpA9sJKNG9xaFXbAaAQdoqOmlkRqYTSezZ5gBm5n1ymKZjVPIEqsk
ClJrBKaJNsTiXoZTBX8aniF+J44O+ckNwgqAg1ItIY6jX9wORBEMpviU1bm8pbgD
1O83VKdx3ufZMAr+RCEpZELVAXJ15JXBVjXsh8l/56w6j6acXAj522d2A9qGtCEr
9lium9+VEDz0+B+8YjQb
=8xF9
-----END PGP SIGNATURE-----

--lKbk9CFItQTD29wm--

--===============0564469522488188100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0564469522488188100==--
