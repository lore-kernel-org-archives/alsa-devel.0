From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: soc-core: Add missing NULL check
Date: Fri, 9 Mar 2018 20:22:42 +0000
Message-ID: <20180309202242.GA3073@sirena.org.uk>
References: <20180308200653.GA47801@beast>
 <20180309125050.GD5252@sirena.org.uk>
 <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1742291678415000602=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9B9FB267614
 for <alsa-devel@alsa-project.org>; Fri,  9 Mar 2018 21:22:44 +0100 (CET)
In-Reply-To: <CAGXu5jJo2JVXKV+nieGwzH0XOPpzzo4DmYy0L05iZD6wwO1vGg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kees Cook <keescook@chromium.org>
Cc: moderated for non-subscribers <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: alsa-devel@alsa-project.org


--===============1742291678415000602==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 09, 2018 at 10:45:16AM -0800, Kees Cook wrote:
> On Fri, Mar 9, 2018 at 4:50 AM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Mar 08, 2018 at 12:06:53PM -0800, Kees Cook wrote:

> >> If a codec is not attached to the sound soc, a NULL deref is possible as a
> >> regular user in /sys.

> > I can't parse this, sorry.  What is the "sound soc"?

> SoC's sound component? I'm not sure either. :) I was just sending the
> patch that I mentioned from the thread where Pavel mentioned this
> Oops.

Oh, Pavel's thing.  I didn't look at that yet.  I'm afraid your
description still isn't making much sense to me - I'm guessing that
you're just papering over an immediate crack rather than having
analyized the situation in any depth?

> >> +     if (!codec || !codec->driver)
> >> +             return 0;

> > How are we managing to create a sysfs file for a CODEC which doesn't
> > have a CODEC struct associated with it?  That is obviously nonsensical
> > and suggests we've got some more serious problem going on here - if
> > there's no CODEC those sysfs attributes simply shouldn't be there.

> No idea! Hopefully Pavel has more details...

That's where the fix should be, it implies that there's some larger data
corruption/confusion problem somewhere else.  If we've created the file
but left a NULL pointer I'd expect that there is a good chance that
there'll be other things that think we've got a CODEC and try to
defererence the pointer, it's an assumption that's present throughout
the code.

I think I might just remove the file though, it's been non-functional on
most systems for a while now as almost all the drivers migrated to
regmap and nobody complained so we should be safe.  There's still
something that ought to be investigated here.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqi7Q8ACgkQJNaLcl1U
h9CYZAf+K53chEJEJIFKe3drVXwRih5lTnPR9lTxs99mqHar35UrNENlZOmoVM+l
RUKDc0ZYS0F3/qWWfqblMASVOgMwKgwBpMKSwrSShSywugx54/Qh1MCAUu5NqwTP
gKDBy+bWOfGdTmZV5RxbtqvLJSPwIZ/TOugVSYAePbeg5nK7lobzf3LlWTA5R+Ec
wFzhjRRCe0tENi9tyZS5TD/Ifm+w7u3tpDI+6CmjJQMHw8hxLQhBHTm3lowsbt75
E15Rb/LmJ9jFJOZaOoJSuBbOhMaLrilwwgiFOoGB/k6t5COfgQbQPSoPqVOq9VR9
xcstNGNXYN0Y5ja6p4DvQU9poXlWbg==
=MeTa
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--===============1742291678415000602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1742291678415000602==--
