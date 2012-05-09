From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 10/11] ASoC: codecs: Add AB8500 codec-driver
Date: Wed, 9 May 2012 11:51:00 +0100
Message-ID: <20120509105059.GF3955@opensource.wolfsonmicro.com>
References: <1336485450-27405-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120508182751.GJ15893@opensource.wolfsonmicro.com>
	<4FAA2153.1090905@stericsson.com>
	<20120509083347.GA3928@opensource.wolfsonmicro.com>
	<4FAA3440.7070600@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0676002902142299958=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 293CC245B8
	for <alsa-devel@alsa-project.org>;
	Wed,  9 May 2012 15:56:05 +0200 (CEST)
In-Reply-To: <4FAA3440.7070600@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============0676002902142299958==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oFbHfjnMgUMsrGjO"
Content-Disposition: inline


--oFbHfjnMgUMsrGjO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2012 at 11:09:20AM +0200, Ola Lilja wrote:
> On 05/09/2012 10:33 AM, Mark Brown wrote:
> > On Wed, May 09, 2012 at 09:48:35AM +0200, Ola Lilja wrote:

> > Please don't just ignore review and continue to submit the same stuff
> > unless there's been clear discussion that what's happening is actually
> > OK.

> I wasn't aware of that the comment with | above was a show-stopper since I
> explained before why we need to do it. I wasn't either aware that you mea=
nt that
> I should just move it to the machine-driver. Furthermore, I didn't want t=
o spam
> to much comments each time.

At the very least this should go in the machine driver, though I have to
say I remain very much unsure that this needs to be directly controlled
=66rom the application layer at all.

> >> >> +int ab8500_audio_setup_if1(struct snd_soc_codec *codec,
> >> >> +			unsigned int fmt,
> >> >> +			unsigned int wl,
> >> >> +			unsigned int delay)

> >> > Why is this not static?

> >> Because it is called from the machine-driver.

> > Why?  No other driver does this...

> This is setting up an I2S-interface connected directly to another chip for
> FM-radio. It is not triggered by opening an ALSA-device. How/where do you=
 want
> me to do this?

Once again, work with the frameworks not against or around them.
Whenever you find yourself putting in a custom device specific API
that's externally visible this should be a warning sign.

In this case there's nothing unusual here, it's exactly the same as the
connection to a digital baseband or back to back link to another CODEC.
The CODEC driver should just provide a DAI and let the framework connect
it up, currently that should be with a CODEC<->CODEC link though older
systems use a bodge where the link is described as a normal PCM.

--oFbHfjnMgUMsrGjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPqkvyAAoJEBus8iNuMP3db50P/ikDzh3tKvfPJIb54jyEqQlG
+gQeak1m4hC1huHieTitlTWiz+riGYwGd+y3gzeffynzX+z1Bm5zZ14eQhZKToZz
GTSSpnmWMW6cVuImYsU90frk2jwMSAL9pluhlo++YalA+T+7smxN7Xh2m7sqgn01
MOh3CcynRqIpK0ymSuUyhFakg1oqaojr0SajcmOiX5FryxVjsyU888Vdti5snKJ1
LzZ0p9Nq9Fae4K9LCKZFj9OLnaThomqb7yaG1CoaYJb1vunXh+2hyp54PXnwRKKn
WZKFuSLP5mWaPyQopLHaZRvbcTiZxeu01sJAVn4057wv63XFKQV38yyi2Xi1cz6Y
CRWnVs12Jmr1FeZBvDg3ALkHObIWdP7SQ/id3TFnTSwA1/mCWH+wKUzN+7ALq2lL
wVWvalsdfHOKsajZlvRbdEzzYJ+fAfwKmOZe9Z+NcrmJb/LvPALrY1NvQhH7yBfG
aaZA8dh5WsKUlry3DxGF2jboDqEfi8g5n/4MG3T4QNmGXosKzGLVRmsf/jtKck+0
1L+9yVn/LOLHUnt+oKILJLiC6EAHvRhgDfJ73g6ltVosF6VeM7B5sXGjUhFNMdBM
0ca65KfygYW02d/CxQGVYvjEnojrxSvzPRcWWEKuRyFHEnnRPDHcq5A+uhKGDbMY
7WwXQWWXM6Ff/Mc/jF2r
=3dGN
-----END PGP SIGNATURE-----

--oFbHfjnMgUMsrGjO--

--===============0676002902142299958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0676002902142299958==--
