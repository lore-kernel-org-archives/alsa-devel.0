From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: add generic dt-card support
Date: Sat, 7 Feb 2015 16:33:55 +0800
Message-ID: <20150207083355.GA8054@finisterre.sirena.org.uk>
References: <54C0088F.9070609@metafoo.de>
 <20150122090723.50ac0156@armhf>
 <54C14EB3.8080305@metafoo.de>
 <20150123131554.623003f9@armhf>
 <54C252F4.9000504@metafoo.de>
 <20150123193456.276ea512@armhf>
 <20150123191343.GW21293@sirena.org.uk>
 <20150124083027.3b3a018f@armhf>
 <20150203164748.GR21293@sirena.org.uk>
 <20150203203130.5d1cfc42@armhf>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150203203130.5d1cfc42@armhf>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2015 at 08:31:30PM +0100, Jean-Francois Moine wrote:
> Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > So how does the simple controller interact with a more complex one given
> > that it's somehow picking some controller node to start from?

> A way to solve this problem could be to create only one card builder.
> This creation could be explicit (created by the first active audio
> controller) or implicit by the audio subsystem on the first controller or
> CODEC creation.

> Then, the card builder could scan all the DT looking for the audio
> ports and create one or more cards according to the graph
> connectivity.

How is this going to work with dynamically instantiated hardware like DT
overlays?

> > If you have a device with any sort of speaker or microphone, or any sort
> > of external connector for interfacing with an external device like a
> > headphone jack, then you have something that could be a widget.

> I know what are the widgets and routes, I was just wondering why they
> (especially the widgets) need to appear at the card level instead of
> just being declared in the DAIs (from the platform or the DT).

As previously and repeatedly discussed DAIs have no special place in
a general audio system and we can't base the entire system off them.
Which DAI should have the headphone jack connected to the analogue only
headphone driver in my system (there may not even be a way to route
digital audio to it)?  How does this work for off-SoC audio hubs where
there is a device with multiple DAIs connected to both one or more other
digital devices and the analogue?

Please go and research this if you're intending to work on generic
bindings, it gets extremely repetitive to have to go over this again and
again.  We already have simple-card to provide a binding for trivial
systems and don't want to end up with a never ending series of slightly
more complicated bindings which each cover slightly different sets of
systems in ways that users struggle to differentiate between.

> And the same question may also be raised about the audio formats, clocks,
> tdm's...

Similar things here - which of the two or more devices on a digital
audio link (yes, they're buses not point to point links) has the
configuration and how do we stitch them together?  How do we figure out
when and how to do runtime reconfiguration of the clock tree (which is
needed by some systems)?

Again, please do some research on this.  If you are trying to define
generic device tree bindings it is really important that you understand
what you are trying to model with those bindings.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU1c3yAAoJECTWi3JdVIfQXqgH/1ywVBEroswu6tqEUJ30frry
lHFCs0pB971s168y4uZXH5U/3tFt7f7EcCOLM4/ySA4meG5hLi7lVru5N3+/tChK
DgbnYnAjLdKpGDBpMrJR3sQ0KtiYG1jbci7evGE73xoysifSUibEz70SZI4hs/++
h7nCWPjUY8jSzqpShacXzjWRUyR9sG7PI7HnrZchfSzYDPhs486a9o/HW59a47/Q
94xXdTr4Rm6vHl1rXvOKXGEbZwbuqF2q6A6CcFoxqpkhGatad7vFmyO/p582c9W/
SydNSBkmAkXjNyLHJLjg0TelmgfpObf6Pj7UYozFNKIgBIGoNQCkjnKbzrkYKBk=
=DGKe
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
