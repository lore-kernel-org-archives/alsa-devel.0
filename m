From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: core: Add API for configuration of
	DAI FS
Date: Fri, 13 Sep 2013 18:26:04 +0100
Message-ID: <20130913172604.GM29403@sirena.org.uk>
References: <1379092188-7385-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1379092188-7385-4-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1454642135983158901=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 9FB8E2608EC
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2013 19:26:08 +0200 (CEST)
In-Reply-To: <1379092188-7385-4-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1454642135983158901==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5oxqo70nJj2c7aYG"
Content-Disposition: inline


--5oxqo70nJj2c7aYG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2013 at 06:09:48PM +0100, Liam Girdwood wrote:
> Some codec drivers when running in slave mode require that FS is explicit=
ly
> set by the machine driver as it may not be exactly BCLK/rate.
>=20
> Extend the DAI API by adding :-
>=20
> int snd_soc_dai_set_fs(struct snd_soc_dai *dai, unsigned int fs);

I'm struggling to think of a better name for this right now but the _fs
name is making me think of the MCLK/SYSCLK rate rather than the BCLK
rate - lots of clocks get specified as a multiple of the sample rate so
it's not jumping out which clock.  The best I can come up with is
_bclk_fs() but perhaps there are better ideas?  Or should we pass in a
clock ID (and provide standard defines for things like BCLK) so it can
apply to any clock?

Though looking at your ACPI ID patch perhaps pwgen can give us some good
ideas :)

--5oxqo70nJj2c7aYG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSM0qpAAoJELSic+t+oim9UbMP/3+J1Vy0qWDTemlSru0YpvtX
IK8pPR3ckBaEZ0gUUvb4IggIOBHMCCJKExoh/4EGHXSeNWK3tluDIUEEe7YIBS6/
gWjrZ/ygK7Q5kijj3d44nazUgHm84DF6nThArUS6t3tEnoufzzu0NtKi2+oMpch4
pQbRXXOy0RoNrqSethIW9UuzQ90xaEez+fTYaMU08OopOyhgn42TuJWK6e3ii6Zr
vX4SYxQ9Tt7WYkdYfhyi+0fHG/qERDQBVig6KNntZVBWQxjOonGczJTfF5H8qEPU
Zc0evbiXSMp34IFp5c/orPmHdevBLTGO/FpSrUjoB0qSEvVkJTTD+u/s9Ky55H9U
UUYFWx4wxe63GH4BZ4JbWu40xNoR7Wc2j+VxLKo9ja8ZouJejlXOdFfvd9asM5+l
VA9bK4poeyGIT/v96jatKCVprfNnQJ2nrBkSaTy+LuV8fgqKkeciXUk2xfhHTyNm
2x5hWyZVEv3eoDoSjmmGK2IkVq+TsGxNc+FRr8rjQ4CPr6W2XF/HyMqlX8HzkBOs
/CQlRIzq2mt0ijI/Knt+KH2gZrjqOU3R6UyVDzOblaS0OK6HFaCL0ttv0Fl8w2Qw
5ut0LbhBSv0qlkpUNe/76rchQuRGUGyNAEDhkYp/ubq6Ffy0hlC7ug1qA5Au/v79
jP7AaFwfQcB9g470FOW4
=x3zf
-----END PGP SIGNATURE-----

--5oxqo70nJj2c7aYG--

--===============1454642135983158901==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1454642135983158901==--
