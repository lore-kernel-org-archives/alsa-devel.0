From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/7] ALSA: ac97: split out the generic ac97 registers
Date: Fri, 6 May 2016 18:17:04 +0100
Message-ID: <20160506171704.GY6292@sirena.org.uk>
References: <1462050939-27940-1-git-send-email-robert.jarzmik@free.fr>
 <1462050939-27940-2-git-send-email-robert.jarzmik@free.fr>
 <20160503115159.GP6292@sirena.org.uk>
 <87y47roski.fsf@belgarion.home>
 <20160504090702.GV6292@sirena.org.uk>
 <87pot0pbnf.fsf@belgarion.home>
 <20160505191728.GK6292@sirena.org.uk>
 <87h9ecp9tp.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nRkE97iIlkj7lnZ0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87h9ecp9tp.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--nRkE97iIlkj7lnZ0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 05, 2016 at 09:46:10PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:
> > On Thu, May 05, 2016 at 09:06:44PM +0200, Robert Jarzmik wrote:
> >> Mark Brown <broonie@kernel.org> writes:

> >> This transition will be easier if the new ac97 code is isolated as much as
> >> possible from the former code while providing backward compatibility ... hence
> >> this patch.

> > It'd probably have been clearer to me if it were splitting out all the
> > register definitions rather than just some of them.

> Euh unless I'm missing something I have splitted out all the ac97 generic
> registers AFAIK. The only remaining ones are chip specific which I didn't take
> as they should be in codec specific code and not ac97 generic one.

The changelog read like it was trying to split things used by the
controller vs things used by CODEC drivers, I didn't get as far as
checking all the registers TBH.

--nRkE97iIlkj7lnZ0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXLNGPAAoJECTWi3JdVIfQxWgH/3sJ1J4JI3kBqku4OHfoc2jm
uXlCYfzb/brOfmZFoP2x6eis4K5ut1xvMN5OecypKWLFpS4dZApd7Kt/Yg7M+Fk7
NAcotCFJ3MV/BJ2v3L6NzFBXGrZGtKD0KN/1I16Oda7O9CzbJyO8O7vhTi2+hOfL
vVad8MksGIsBzPgqr3W6yuS42YvUsd+AqeRuHt1UZBcb1CRWbzFbGnmn53ec0awy
FRyVW2DpygRKY3tIvAtVIF7KE1VnIeMCH7ZfMp1pYMWpECKJoiL2iuhtTAbQBwUr
AfWR4s8vfuS4VDpbK+AdAiXzeLUjdl1jSU0UcNp6FE+kVSKzMFYWSBq2azTI23Q=
=B8s+
-----END PGP SIGNATURE-----

--nRkE97iIlkj7lnZ0--
