From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: generic: Add generic DT based simple
	codec
Date: Fri, 27 Sep 2013 10:55:15 +0100
Message-ID: <20130927095515.GZ19304@sirena.org.uk>
References: <20130919105437.75e0f0a3@armhf> <5240B07C.6080404@wwwdotorg.org>
 <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8604495239965521102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 587FA26507F
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2013 11:55:19 +0200 (CEST)
In-Reply-To: <CAL_JsqKmfurrCqEYRNqcLRZMU-VjPin2dvK1Q6CMcK4i=+x-8w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robherring2@gmail.com>
Cc: Jean-Francois Moine <moinejf@free.fr>, alsa-devel@alsa-project.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Stephen Warren <swarren@wwwdotorg.org>, Liam Girdwood <lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============8604495239965521102==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="i6UfSqW8aw8u8VxJ"
Content-Disposition: inline


--i6UfSqW8aw8u8VxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2013 at 09:57:30PM -0500, Rob Herring wrote:
> On Mon, Sep 23, 2013 at 4:19 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> > We shouldn't have any Linux-specific bindings. It might be reasonable to
> > define a binding for a "simple CODEC", but there's no reason it should
> > be Linux-specific.

> Further, just define the type of codec h/w. If linux can use its
> simple-codec driver for it, then add a match table entry for said
> codec. Then the DT is future proof when you decide the simple driver
> doesn't really work for that h/w.

So, this is what I keep telling people to do but lots of people don't
want to do this - it eliminates the need have this binding at all since
if you know which type of device you have there's no need to specify
fixed properties of the device via DT.

--i6UfSqW8aw8u8VxJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSRVX/AAoJELSic+t+oim9JC8P/0TWCOqxn6hrIRvfFnYcIM/H
wFasA1xhqEdAEhbQMpBTBGcuWSRzy2LPLM42amNOIakIb8OySOSKRv0Gul61WNwL
Btl0iUDrgeyrBOy4+iIJCO0KFseQVxSYHgqBMd/ubwrq6j6LwdI+d4M+uedOugrQ
M5heLRCebWyyX6gtbse8xqX78ovlMEcdnErfU17vAyobApa6sMzkEhNSt5o4DpXO
KfCxFnRLw0zd7M8a5yyAbAThJBzx4mnKqaQt59UfMrC03SSEgIzClPRPHQG8gYEI
szQb7/2o9oqg37xQZEAImPATxQ/syk9z76QfZEcIJFlTp8gGExJDQMR8occlYqRH
G7YCSsi3wXvo8Igvqyd/mHGNEjEVX2JtG68Hr6pVaiACAc6YrgD9+WMP7Yqfl4PU
qezUXlvC4ZcP9MG+HOrci7LfoX3lIq6UUB9tzW8VlkQ+q1X6Rzv7cychPlerxOeZ
X+MZxyLywTZs4YdCRRciQESO0wyWfsXKmrrb85feOSDYNl4X6aiWpfJi5ooPewf8
vO5qxsvouL/zwsEX4rP4njjyrtfoDPjybCZHnGxXRhjE/1UMQ9LZGxh/gmTR0gc3
TkZpDMSY2TXveVz1Bs3k+kch8ZYEimMKhh7HG9xd23G+mBpZTR8x4EWdk3bHbvcM
+jZSfslO9yGQSCV0zlmI
=haJP
-----END PGP SIGNATURE-----

--i6UfSqW8aw8u8VxJ--

--===============8604495239965521102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8604495239965521102==--
