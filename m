From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
Date: Thu, 5 May 2016 20:17:28 +0100
Message-ID: <20160505191728.GK6292@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
 <87y47roski.fsf@belgarion.home>
 <20160504090702.GV6292@sirena.org.uk>
 <87pot0pbnf.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wSq95SjGPZBE6hCW"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87pot0pbnf.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--wSq95SjGPZBE6hCW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2016 at 09:06:44PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > I see that, I just don't know why that helps.

> Ok, so let me explain.

> As you already understood, AC97_VENDOR* is needed in bus.c for the
> autoscanning. The remaining is the reason why I don't want to include
> ac97_codec.h in bus.c, which follows.

> In order to have a clean split between former ac97 bus implementation and this
> new one, I didn't want to include any former ac97 includes, excepting in
> sound/ac97/compat.c.

It's probably a good idea to articulate some of this in the commit log
then!

> This transition will be easier if the new ac97 code is isolated as much as
> possible from the former code while providing backward compatibility ... hence
> this patch.

It'd probably have been clearer to me if it were splitting out all the
register definitions rather than just some of them.

--wSq95SjGPZBE6hCW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXK5xHAAoJECTWi3JdVIfQwn4H+QF563nk3RYAJh6ml4TeDEew
XPKGXeJvOi0goDwBIK97UhioEAwcJTA8rdrzuVSorgGyIkvHtqssrMSvciWucYXV
DOw7E9SVKzBjvFhDVpUXI7vPGgXeCkotuvDRmjPoTIjId+nOTGJzJwQ9d7OCeBWX
B5i8dAKBT/W724ewHUEJhbKyJEgnztxGmh8bYLu5gzMA97djK3HtaOSQckolcbi3
s1AcNMH+tUhUuKLxTeOEJWBOXxot9aP6PKgLyNKcIC1m+sXLuDiSPP9O+trfCXf1
7ONN9W1Hh4tJGQq0uK1L7jIPe6i6BetgM2pzdxidEnhGrmlhzjFlFyTLWKR8olE=
=znYF
-----END PGP SIGNATURE-----

--wSq95SjGPZBE6hCW--
