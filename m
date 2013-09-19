From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple
	codec
Date: Thu, 19 Sep 2013 19:05:40 +0100
Message-ID: <20130919180540.GH21013@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf>
 <20130919104028.GI21013@sirena.org.uk>
 <20130919193403.30ac5764@armhf>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7843186696035458514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A8C26548D
 for <alsa-devel@alsa-project.org>; Thu, 19 Sep 2013 20:05:56 +0200 (CEST)
In-Reply-To: <20130919193403.30ac5764@armhf>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Francois Moine <moinejf@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7843186696035458514==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fXCyug6VAL2FbtaR"
Content-Disposition: inline


--fXCyug6VAL2FbtaR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 19, 2013 at 07:34:03PM +0200, Jean-Francois Moine wrote:

> Well, first, the codecs hdmi and dmic have no DT support.
> Then, from the Cubox point of vue, the codec hdmi offers playback
> and capture while the Cubox has only playback (via the tda998x HDMI
> transmitter), and, also, the codec spdif transmitter has a lot of
> sample rates while the Dove audio device supports only 44.1, 48 and 96
> kHz.

All those restrictions should be constrained by either the machine
binding or the driver for the SoC side though.  I do see why you might
want this, I'm just a bit ambivalent about the merits.

> So, instead of adding new hdmi and spdif_transmitter codecs,
> I thought it could be useful to have a generic codec with DT support.

> On the other hand, as the first use of this codec is for the Cubox,
> an other solution could be to have the codec included in the kirkwood
> driver (declared by DT as either i2s or s/pdif). This would simplify
> the use or not of s/pdif in this driver.

That'd work too.

> > > +Child 'capture' and 'playback' required properties:
> > > +- stream-name: name of the stream

> > What does this mean in the binding?

> Indeed, the stream name could be implicit (either "Playback" or
> "Capture"), but, as the users are aware of it, a more friendly
> name is nicer ("S/PDIF Playback").

So you need to say that it's for display purposes.

> I have no idea about which format is used or not, and there is no
> explanation about their meanings in the uapi (but I can search them..).

> Otherwise, for Dove, we need at least "s16_le", "s24_le" and "s32_le"
> and, perhaps, "iec958_subframe_le" and "iec958_subframe_be".

> So, what do you think should be the format set?

PCM plus IEC seems fine, it's more the more obscure formats that ring
alarm bells.

> > > +Rates:
> > > +	5512
> > > +	8000

> > This shouldn't be a list of defined rates, it should allow any number,
> > and it should support ranges since while some devices do enumerate
> > specific rates simpler devices often just support a continuous range of
> > rates.

> There cannot be any number because the rates are coded by discrete
> values in a bitmap.

Not quite - _KNOT and _CONTINUOUS are options in that bitmap...  in
any case this would be a Linux implementation thing.

> For the continuous range, I was thinking about the value '0' followed
> by the min and max rates. Have you any other syntax in mind?

That'd probably work, not sure if there's a more idiomatic way of doing
that in DT though.

--fXCyug6VAL2FbtaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOzzxAAoJELSic+t+oim9WEYP/jqBMOqKD1/wYse68ze2JwAN
gihGheQzxexASTGfQ9cu9opUbdyEo0uXoE0khrFOPmn/iCgrwajkRGkF6tYfoRbm
0SYUNnfrKPy4SgnLgKGZ2LERNGBbFFOu1Zo0uUOMq0DwJIC2nMJ64mpObJN5oDiE
oqWx0HVX5QLZFxuqacEL2XQ7+hfr8dHtkj1D9C+NlgJpTT4kRd9DqpXm9yy2G8Ig
dYtnmNhxGcFVOh/oaQM9P+Esk48ocsC6Wm8xFNkzHXVAlnd7BmvKGaoMBsv7lo1U
vnZanLGzXc84UiLDzEZWu/UnH6UNEQOeLyGjp9lvdECxYixlV+M0rdJYB/Dwg2wD
gCOeP/4fJZXw945SJ4N8tryPAUP0VFrgt/zqB/RNDMEco+uNx+JxODBhAJ6QpWMf
mUcwhJ64Y2rBNFZ1hkMaPqWzS2gXDrANTNn+sx3UuegAJKQZtyb+EL8NgSMwJ19E
+n0Wzfqg8rcKu4XPX7KDwAcvJT3SKBNZXvbYOQizaTA4hnt7sDoqPS+BeehR5xvt
4rZTSNR77zlk2u0/EedM0mg/JFHLA/MP8QV6iGDIq0eq8IDg9aow+rxX3u0O/hK9
dx02NejUqqOEUFAjZTRvFZjNf9VouDCmXRVMDLiLRNcZBxZTY4PKKuYXbqbDqvni
WBp8vmpsgQ6uR5zquGvs
=IGq/
-----END PGP SIGNATURE-----

--fXCyug6VAL2FbtaR--

--===============7843186696035458514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7843186696035458514==--
