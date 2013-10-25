From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: simple-card: add Device Tree
	support
Date: Fri, 25 Oct 2013 14:13:57 +0100
Message-ID: <20131025131357.GB12932@sirena.org.uk>
References: <87eh97sqw7.wl%kuninori.morimoto.gx@renesas.com>
 <87txharb3o.wl%kuninori.morimoto.gx@renesas.com>
 <8738oiog00.wl%kuninori.morimoto.gx@renesas.com>
 <20131003104248.GI27287@sirena.org.uk>
 <87fvsh2966.wl%kuninori.morimoto.gx@renesas.com>
 <20131024171758.GA2461@kartoffel>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2623602753469100519=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 5EA6D265581
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 15:14:08 +0200 (CEST)
In-Reply-To: <20131024171758.GA2461@kartoffel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2623602753469100519==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 24, 2013 at 06:17:59PM +0100, Mark Rutland wrote:
> On Fri, Oct 04, 2013 at 01:04:41AM +0100, Kuninori Morimoto wrote:

> > +- simple-audio,card-name		: simple-audio card name

> What's this used for?

This serves two useful functions.  One is that this is used for display
to users so they have a friendly name for the sound card (it is
relatively common to have multiple sound cards in the system).  The
other is that it is essentially a compatibility string for configuration
- you get a lot of sound devices that are electrically identical and
hence look the same from a driver point of view but due different
physical form factors should be configured differently.

> > +- format				: specific format if needed, see below
> > +- frame-master				: frame master
> > +- bitclock-master			: bitclock master
> > +- bitclock-inversion			: clock inversion
> > +- frame-inversion			: frame inversion

> What do these mean? Repeating the name without a dash is completely unhelpful.
> Describe what these imply.

These are all boolean propeties.  The meanings should be obvious or at
least very easily discoverable to anyone with any familiarity with audio
hardware; if you can understand what to do with them they should be OK.

> > +- clocks				: phandle for system clock rate

> Just one clock?

This is a limitation from the simple card, anything that needs more
complex clocking should be using a different binding.

> > +- system-clock-frequency		: system clock rate
> > +					  it will overwrite clocks's rate

> This seems very odd.

> Why do you want to overwrite a clock's rate?

It's relatively common to derive the audio clock from a general purpose
programmable clock which needs to be configured appropriately for use.

> > +simple-audio,format
> > +	"i2s"
> > +	"right_j"
> > +	"left_j"
> > +	"dsp_a"
> > +	"dsp_b"
> > +	"ac97"
> > +	"pdm"
> > +	"msb"
> > +	"lsb"

> What do these mean? Why are they not described when the property was defined above?

This is another one where the names should be clear for people familiar
with the hardware, they're well known terms.

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSam6SAAoJELSic+t+oim9kbUP/i9UZFzEHTlTwPcHD89ccSqt
nxCiEWOBzHyG/iR9+PoYrKQ6zXqn576UKt3Sw5rnqSz9cHSnlklYLab9c9DRmbI7
swFlAxJhhbUB2SFMPdWfVaz5xFMY2n0gQDh5HB8UebZXIRcPRZOBkqev9FXuqvJy
gVDGs6FU+042woi/F+6MNQXx9mt3BGOkw8VX+v6d/S2IW6yK6MnIEQjT9Q5BQpq/
s6xYtMsgq+VW51tbJEYmeUMpPI4OSNSitFiq31+KV9IMm6Xu3nHBLRTD9py8WCcc
hS37zqg03M7gKE36cfgwT+N5juLHr4Z7NpfCa/Ptqmm+buIBArlD9LsAfjX9FxXa
YxISUCGUxeT/d/whEwzXV7R0+8h6v3QOg1PrKK9otLbe3D90LxTpaR5DHyYat2Kf
/c8a3DgSjlQbH7N77ykXbKHkouM+Opk50uTBG16wkS+e1iLsTihmqVCfUeHv1xMV
fRLF6x08W3EXrWskC8DQP+BrQ2v+/SIToWiKLnH/uxwb9peTmeh3apU+j+pAsjel
fuSaF7j2fouz1NKQHQItag7KNJfP11sMYSB+2gpHZ434SE/ALhQa/lZH3MIeKKuw
PI5hm13ootKwArG1EITcGU2dxq2najcDf0sUo5VyODYcMqY3CIHmXtSGdL7mkBkg
Pl3vPB8RKn5fDs5/FUQh
=08yX
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--

--===============2623602753469100519==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2623602753469100519==--
