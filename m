From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5651: use msleep for large delays
Date: Thu, 12 Jan 2017 15:04:07 +0000
Message-ID: <20170112150406.wl24hryz3352wwwj@sirena.org.uk>
References: <1484135376-482-1-git-send-email-hofrat@osadl.org>
 <20170111145926.22jkebrb7ojemyhq@sirena.org.uk>
 <20170111150645.GB16045@osadl.at>
 <20170111180658.2yivagcwo4kgsp4e@sirena.org.uk>
 <20170111185952.GA17786@osadl.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tdyalmhpcqbsg63f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170111185952.GA17786@osadl.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicholas Mc Guire <der.herr@hofr.at>
Cc: Nicholas Mc Guire <hofrat@osadl.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--tdyalmhpcqbsg63f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 06:59:52PM +0000, Nicholas Mc Guire wrote:
> On Wed, Jan 11, 2017 at 06:06:58PM +0000, Mark Brown wrote:

> > Yes, but as fairly recently discussed somewhere on the lists (and IIRC
> > actually fixed) approximately no users expect or want that behaviour -

> True its an odd behavior - the point just was to change the actual behavi=
or
> as little from current state as one might expect. Anywa - will fix it up=
=20

Unfortunately the current state will often reflect a change from the
original or at least expected behaviour.

> then and resend - in this particular case it really makes little=20

Thanks.

> difference - assuming that both the minimum and maximum value were=20
> suitable to ensure that the writes had compled or it was actually a failu=
re.

It can create confusion where the delay comes from a datasheet or tech
note and people are left wondering why a different value is used by the
kernel, and in a lot of the paths with delays in them are pretty
sensitive to the overall time to run so there's a strong desire to keep
the delays as low as possible.

--tdyalmhpcqbsg63f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlh3muMACgkQJNaLcl1U
h9Cz+Qf+K9QXmRUGQoZPl7wFaYmXfLqBWSTYo4hwVunL/I0u9n21VimauLJhRpHj
R6FSsxWWpAOoP1fYwuse8m3PUuZW9YAt8uskyKQ8pGzOnQzw0xSWewQYMgGeKwGI
cnw3MbWzIlUZj9X0b/aVxF+o4sqGWBXlbt1lTQ3VjTbnIqfGeU7sTfBn8AjMmtGa
isbvV3vMZXwXqS0i/X//O0M62hdAew1T6BLlkgcZxRzbGgScIunyUYiLWki4cDmp
z+1+Tl7lid7U3917/ESkoSEBLIdVgRYA6pg8PD+LUNISXdJjvTcDqwPeH/5gmpBQ
1BtYtCafJg6rvpWm3WYwf6lkuazO6g==
=f8Vl
-----END PGP SIGNATURE-----

--tdyalmhpcqbsg63f--
