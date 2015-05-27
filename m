From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/7] ASoC: hda - add ASoC HDA codec
	match function
Date: Wed, 27 May 2015 19:34:06 +0100
Message-ID: <20150527183406.GM21577@sirena.org.uk>
References: <20150523055156.GZ3140@localhost>
 <20150525104828.GA21577@sirena.org.uk>
 <20150525112150.GE3140@localhost> <s5hbnh827n4.wl-tiwai@suse.de>
 <20150525135854.GV21391@sirena.org.uk>
 <s5h617f29os.wl-tiwai@suse.de>
 <20150526133256.GQ21577@sirena.org.uk>
 <s5hr3q3cv77.wl-tiwai@suse.de>
 <20150526194316.GY21577@sirena.org.uk>
 <s5hfv6ieero.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8861947798283206155=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A61260420
 for <alsa-devel@alsa-project.org>; Wed, 27 May 2015 20:34:13 +0200 (CEST)
In-Reply-To: <s5hfv6ieero.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Vinod Koul <vinod.koul@intel.com>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, Jeeja KP <jeeja.kp@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8861947798283206155==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5uEO6Px2SLrt2X9u"
Content-Disposition: inline


--5uEO6Px2SLrt2X9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 27, 2015 at 08:05:47AM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > This is still as clear as mud, sorry - why is the ID table not something
> > that the bus handles?  It seems like a core part of what a bus
> > abstracts.  Having two completely separate sets of controller and device
> > drivers that can't interact with each other (which seems like what we're
> > ending up with here) seems really worrying and I don't think I've seen
> > any plan for unification either.  It's not just the match function stuff
> > by the way, some of the later patches also made me wonder about the
> > mutiple implementations of the bus thing.

> HDA bus is the place for communication between a device and a
> controller.  This is common, no matter whether asoc or legacy.  That
> is, an ASoC HDA controller may communicate even with an HDA legacy
> codec device, if really wanted.  There is no distinction there.

I'm unclear how that would (practically speaking) be accomplished if
they're in two separate worlds for matching.  Come to think of it how
does this work if we have more than one matching system in use - how
does the driver model code cope with that, what happens if one match
function ends up looking at data for another match type?

> The fact you might be missing from the beginning of the story is that
> we need to implement two different driver sets for ASoC, both for
> controller and codec drivers.  They can't be unified with legacy HDA
> unless we merge ASoC core codes into ALSA core (e.g. DPCM or DAPM into
> ALSA core).  Also ASoC has the different ways of registration, too.

Wow, that's not what I'd have expected to be happening at all and really
should have been mentioned at some point.  I need to think about this
further.

What I had expected to see for ASoC/HDA integration was something where
ASoC devices were providing a standard HDA controller and then use the
same CODEC drivers as everything else.  Not doing that means that we
inveitably have some duplication for at least things like CODEC quirks
and device specific support which doesn't seem like the best idea.
There's also userspace interfaces for things like the HDA device graph
that'd need looking at.

Having HDA use ASoC doesn't seem like a terrible idea, there are aspects
of HDA that map quite well onto ASoC, but doesn't seem to be the
intention here and I'm ambivalent about it being worth the effort.  I
don't think it would need us to move ASoC into the core any more than
any other driver, it'd just make it much more widely used.

> > What you all seem to be saying is that the existing code for HDA is too
> > fragile to touch much so we don't want to move much of its functionality
> > to the new bus yet.  I can believe that but I think I'd be a lot happier
> > if we were handling that by having the existing HDA code override bus
> > functionality rather than by implementing key bus functionality in
> > random places.  It feels like trying to use the bus now is adding
> > technical debt.

> Well, the patchset looks more complicated because lots of codes you're
> seeing in this patchset are specific to SKL hardware extension, and it
> doesn't (maybe won't) exist in HDA legacy.  For example, patch 3
> contains many such codes, which is likely the point where you stopped
> reading the rest patches.

I'm too alarmed by what I'm seeing in the apparently generic code to
look at the platform specific code.

--5uEO6Px2SLrt2X9u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZg4eAAoJECTWi3JdVIfQnxwH/3xDBfVQCDzEMjQJ+QR4jpmR
I2Kll4ZjmgIVnG+Tv6zr9ju/pRTpRdoPtvBpxm0BtD/SI12voIi8oh4sQV1ZPj4N
f/EDF88/cpcUmvT8d1I6n79s00PC/ImKRvrrOKYpJ2PLfJ0X/v8xBRTXhBXSZZCZ
2ztgroCNySwn6uMxQqWvqws1Nn42vTDDcB/t+0U8rw/rGVPHIVUhz4ZCPOMC4mbx
Hk8a7J6gUwhGb1eWF27NCms3oQtFq56IRj3Lm71SZO/S2hCIYlAjrXdlifP4PfWm
ocYSFI0dL+Pv17dvYSLdaDo4U3TOred87PZ/A7hYkrJWhc+8aNtqBV0NYhRcKOs=
=qmx3
-----END PGP SIGNATURE-----

--5uEO6Px2SLrt2X9u--

--===============8861947798283206155==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8861947798283206155==--
