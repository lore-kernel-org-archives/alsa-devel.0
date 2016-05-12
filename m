From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: MAX9860: new driver
Date: Thu, 12 May 2016 12:04:06 +0100
Message-ID: <20160512110406.GC6261@sirena.org.uk>
References: <1462892797-1147-1-git-send-email-peda@axentia.se>
 <20160511150937.GK6261@sirena.org.uk>
 <65bdbaea-fe4e-bbd5-335d-a8d594936cbe@axentia.se>
 <20160511205052.GU6261@sirena.org.uk>
 <5e9b7d83-95ac-256a-a1e6-ca69da141c3a@axentia.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Dy3pjCZLf6+6NySR"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5e9b7d83-95ac-256a-a1e6-ca69da141c3a@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Dy3pjCZLf6+6NySR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 12, 2016 at 09:54:18AM +0200, Peter Rosin wrote:
> On 2016-05-11 22:50, Mark Brown wrote:

> >> http://www.spinics.net/lists/alsa-devel/msg49675.html

> > If you don't CC maintainers the chances are your mails just won't get
> > seen...

> To me, it feels rude to single out people when asking general questions.

It's not a general question, it's a question about the ASoC APIs.

> I my world, these kind of questions are exactly what mailing lists are
> for. But ok, lesson learned, noone actually reads alsa-devel...

People do read the lists but it's very easy for things to get missed and
they won't always check them so often as their inbox, if you're looking
for a quick reply you're likely to be disappointed.

> > You should change DAPM so that it understands what your control is
> > doing, possibly by using custom accessors though it seems like something
> > in the vein of the invert flag ought to do the trick.  You don't want to
> > actually use the invert flag since increasing values do mean increasing
> > volume but something along those lines.  Possibly doing it by parsing
> > the TLV for a mute value at probe time might make sense?

> It seems nicest to do the runtime scan of the TLV for the mute value when
> the control is attached (or thereabouts), i.e. your last suggestion, and
> then in snd_soc_dapm_put_volsw() change the line

That's definitely the nicest if it isn't too horrible to implemenent,
yes.

> However, I don't see where to add the runtime scan of the TLV, and I don't
> see what "something" in the above should be, i.e. where I should store the
> result of the TLV scan?

In the mixer control data where the invert and so on are at the minute.

> Also, fixing DAPM to understand this problematic field will probably not
> make any difference for the confusion seen in alsamixer. This, coupled with
> the fact that the sidetone is not a function that I need makes me less than
> eager to take this on...

If alsamixer is failing to parse the TLV properly that needs fixing
anyway.  You could just leave that bit for someone else who cares if
it's mostly cosmetic though.

--Dy3pjCZLf6+6NySR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNGMlAAoJECTWi3JdVIfQ+9kH/j6YF+bVB8bYcojC06GixRm8
NUm2XihYo0l/1i01M9/ZFYVk9lCX4Wc7FyWcZgx9q+vD/9rTXJnl6HuhmU90xmlP
PJBf8fRkunBWHlGGao+J169IpudxLeaXlcrXH6b/DMN2dXklhPLcXZ/SB6CQ5RM9
VQOhVcSxUxxxxTPXOQFHUJZKnVpOrA/TvvBP0425kmx0HQms7RjT8vevQEsTz9ha
QEH+aouFcSXO5elXGufWD8VQgZ+pnHHLSPO1Z7PaIFD5XgSzvX14N76QNfUgOgWq
uERII1uCDi9Bt3FvWNOG/KFM38Ld98ObqDQnX7V93GNqQreUmwaySwKBSF9UB78=
=XU2H
-----END PGP SIGNATURE-----

--Dy3pjCZLf6+6NySR--
