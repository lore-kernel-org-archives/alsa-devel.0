From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] ASoC: wm9713: add binding for WM9713
	codec
Date: Sun, 21 Feb 2016 06:16:59 +0900
Message-ID: <20160220211659.GG18327@sirena.org.uk>
References: <1455979079-9030-1-git-send-email-robert.jarzmik@free.fr>
 <20160220171459.GA18327@sirena.org.uk>
 <871t87z1gz.fsf@belgarion.home>
 <20160220195925.GF18327@sirena.org.uk>
 <87twl3xgud.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4315189249178096608=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 49E2A26070E
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 22:17:21 +0100 (CET)
In-Reply-To: <87twl3xgud.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
List-Id: alsa-devel@alsa-project.org


--===============4315189249178096608==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BNd1cQq+8a6XQVk/"
Content-Disposition: inline


--BNd1cQq+8a6XQVk/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 20, 2016 at 09:32:58PM +0100, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Sat, Feb 20, 2016 at 07:22:04PM +0100, Robert Jarzmik wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> > There is a generic AC'97 PXA driver in sound/arm, if your system can us=
e that
> > that'd be a better route to DT integration for it I think.
> I'm open on the topic.

> Historically, I use sound/soc/pxa/pxa2xx-ac97.c since 2008. I know it wor=
ks, but
> if you think I should examine sound/arm/pxa2xx-ac97.c, let's do that.
>=20
> > Did you try that, if there are problems with that perhaps we can improv=
e that
> > driver, it should be simpler.

> I will. By now I fail to see how this will help in the wm9713 probing and
> detection ...

It will eumerate the AC'97 bus by itself and does not need the CODEC to
be described.

> Until I make the try, here is what I have as a device-tree extract in [1]=
, which
> is my candidate for sound/soc/pxa/zylonite.c replacement.. If we conclude=
 that
> wm9713 shouldn't be in device-tree, then I'm curious how the DAI bindings
> (simple-audio-card,dai-link*) should be handled.

They should be created as a function of enumerating the CODEC.  If you
use the genric AC'97 stuff it doesn't use ASoC at all and this happens
as a side effect.

--BNd1cQq+8a6XQVk/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyNfKAAoJECTWi3JdVIfQIecH/jXo6c0boFbb9/KR3GKhp76S
rF+WNMrymxR7neTfRQYau0N1WncmV994TW6Ut/JtrWG3+Q6hXaMr1r8eEYFgTGKm
0HmhfxAin9wmitApqpihp9fVYerVkiqYS1pm2y0IDLS1pM48g8k60nEB4lbbRkNP
vLnXnLNJCz4FYn8Ma5dy1rQNV5CzmihwtNOhI4QyjKn618tQe8DZHkdsKWGmj2gz
c1TZLVf55/6UiaQRjY+vBuiD5Hpey30USdXL+GVlpzI51nYd5w/8QS5Y1UWnGcKH
rPqJz5dJcaEe0+SWwPO3eXNq01Zig/OeHEXcNC4TyhIn5OzMfd/nWVyQcJ/ga0s=
=9bJc
-----END PGP SIGNATURE-----

--BNd1cQq+8a6XQVk/--

--===============4315189249178096608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4315189249178096608==--
