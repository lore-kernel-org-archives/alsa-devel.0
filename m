From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: da732x: Mark DC offset control registers volatile
Date: Mon, 24 Feb 2014 21:42:30 +0900
Message-ID: <20140224124230.GF25940@sirena.org.uk>
References: <1393210853-32246-1-git-send-email-broonie@kernel.org>
 <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yZITfl9WLeKOcFOX"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A03376BAD3FC8@SW-EX-MBX01.diasemi.com>
Sender: stable-owner@vger.kernel.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org


--yZITfl9WLeKOcFOX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 11:31:25AM +0000, Opensource [Adam Thomson] wrote:
> On Mon, 24 Feb 2014 03:01:37 +0000, Mark Brown wrote:

> > but since the registers are marked as volatile and there is a register

> Guessing that should read 'not marked as volatile'.

Yes.

> Having looked over the driver again, can you include the following
> registers as well:=20

> DA732X_REG_HPL
> DA732X_REG_HPR

I did notice those.  However they are a bit more fun since they have
some non-volatile fields in them which are also used for control.  I
*suspect* that a lot of the time it'll be possible to get away with just
caching the first read but it needs further study - often with these
things the basic offset is constant in a given system so the sign may
well be right all the time.  That's just a guess, though, and may not
actually hold at which point a bit more attention might be needed.

> Also, if we're doing this then you can move to using snd_soc_read()
> instead of hw_read(), I guess.

Indeed, in fact it was while doing an audit of drivers to kill off
direct users of hw_read() that I noticed what was happening here.

--yZITfl9WLeKOcFOX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCz4yAAoJELSic+t+oim93DsQAIkKZndBhgKGpbnXaoCACnVb
TT0beaq6/o6eRhBRG6ixLt6jv91Ync3aHq0au/x8342J2fYHBd5R6bOeJIB1Ag7t
UHv96ifiPiYi7aiYu7Se/wR0r3bqTFEGUJrudBgFO7xBWYd9tx8cSTWq+uJ+nKaQ
GGELf9L4Our7eJ23jH6Ok4SmL7795Bs8/9tSo/UYG3FNh4Pot0/J+twBq3pvSHWX
/pjEIBtLb6alsfqcHNZCWeQ4Q49Y5mOlwQPqmN4u715ghm/7cMYRb3CeiZw1sZx2
nhM8mzprgj0XoD+D+TO4zcSIOFHYmTXZzcJKFl+Ncxs1XOImBpOkV/iAt9GszNSL
Zn4EwtFVDQwLf3oJl8KW6yE/9a97qzKO4TY0JrDyU/002hcdQd9ZF9BdLRfIzEf2
HfSiriinTus2azYhPUe8H7O6rVQN9nfDxASFKlYQS6HM5pmixAp4oB0gTRcMJexS
rg9IlE6nQCHdgttB5CZOFW8G5kOs7OBPAmwg3DUeMjPlr91MwhkbugO4pNjONfW0
Z7+3QPlqttuaK/31LhACk4+0LaSr+K6yUwtn+pSNHqq3+gJBdyBffe7oh0Da+mYm
ndwMxvAlDwM5DNHqaZ8FwdU4nyJuG6rmRWK0iQy6lMsOUqB9jaR/KrICHG+hHiLD
4JewPih9cPykw/UZPyCg
=FheQ
-----END PGP SIGNATURE-----

--yZITfl9WLeKOcFOX--
