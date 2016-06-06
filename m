From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Mon, 6 Jun 2016 19:11:10 +0100
Message-ID: <20160606181110.GH7510@sirena.org.uk>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia>
 <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
 <20160531173505.GI29837@sirena.org.uk>
 <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
 <20160602171753.GQ2282@sirena.org.uk>
 <CAG5mAdwp2DEeFk6pwe6n65iQHHzzyiNPx1QTz3u2rUsQRUpNEA@mail.gmail.com>
 <20160602184014.GR2282@sirena.org.uk>
 <CAG5mAdw2kk1t7uSScX6pXUrw0Uzp9XtcENmAf_9rAySKSjgxNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2156632686568560450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 665702658E5
 for <alsa-devel@alsa-project.org>; Mon,  6 Jun 2016 20:11:21 +0200 (CEST)
In-Reply-To: <CAG5mAdw2kk1t7uSScX6pXUrw0Uzp9XtcENmAf_9rAySKSjgxNQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============2156632686568560450==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 05, 2016 at 09:48:36AM -0700, Caleb Crome wrote:
> On Thu, Jun 2, 2016 at 11:40 AM, Mark Brown <broonie@kernel.org> wrote:

> > TDM, at least in the sense Linux is using it, is multiple *unrelated*
> > audio streams on a single wire.  Any multi-channel audio stream is TDM
> > in some sense but the trivial extension to add two or more channels

>    Thanks for taking the time to describe this to me.  This definitely
> comes as a surprise to me.  I assumed that TDM mode simply means
> multi-channels on a single wire (which is what it means in all the
> datasheets).

It *really* depends on the datasheets you're looking at.  Things that
are doing generic programmable serial ports might have no concept of
channels and inflexible devices which just support configurable numbers
of channels are just as likely to refer to DSP mode or whatever as
anything else.

> Just so I have this straight, TDM in the linux sense is putting say,
> 6-channels on one wire where the channels are from logically different
> places? i.e. chanels 0-1 are from bluetooth, 2-3 from analog in, and
> 4-5 from somewhere else?

You also need some separation of devices for us to actually care - if
none of the hardware can tell this is going on it's not meaningfully
TDM.

> As far as I can see he's not trying to define *unrelated* streams in
> TDM mode, but very related streams, which is TDM in the
> datasheet-sense.  And there not only needs to be a mechanism of
> choosing the dual I2S mode, but also which TDM slots to drop the data
> in (which I think already exists, right?)

Yes.

> >> 'channels_max > 2'?  I was always under the assumption that's what TDM
> >> meant.

> > We don't particularly call it anything, it's such a trivial extension.

> That's not been my experience :-) Getting 16 channels onto a wire has
> been anything but trivial because of the lack of SoC driver support
> for it.  Perhaps I'm just using the wrong SoCs.

Yes, you're using the wrong SoCs - anything with a programmable serial
port should cope fine.

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVby9AAoJECTWi3JdVIfQviMH/jsG7pd+5l5z+j9+UPz/bK39
UmVzUC4eYWX0Fmlc7tp12NM/P+Ao4XRj6u219dNJKV4M09Z8wXlk9Wx0c/eSCme4
hqXV4UyqkgU49ma0lbYMrv9avZBk/5Y1Y0ON+/tO1YxmS3LA4Cv52hlbL1HO26BT
S8Wna96TFWgZJueOonWI0cSGjcZbSwfOsG9hzumpG2r8kc8T3z8YNVEo4u6q5/UX
hv3vaQjGKrKX1GaGLValENaM6EybiNOoMuCe285HtguwGnpil9NSWoXjYtelVmoH
ltOCWYmTQiBBxESY5LTU3KmGveuWsbk+hM8HcJbFUkWHqDJfKj+a/i4EauUfjXw=
=AnDx
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--

--===============2156632686568560450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2156632686568560450==--
