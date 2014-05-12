From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6] ASoC: add RT286 CODEC driver
Date: Mon, 12 May 2014 21:29:18 +0100
Message-ID: <20140512202918.GG12304@sirena.org.uk>
References: <536B4708.8080203@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1673060179781340696=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 416BC2650D4
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 22:29:34 +0200 (CEST)
In-Reply-To: <536B4708.8080203@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Bard Liao <bardliao@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============1673060179781340696==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b75zxLgdvbUilXow"
Content-Disposition: inline


--b75zxLgdvbUilXow
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 10:57:44AM +0200, Lars-Peter Clausen wrote:

> There is still structure, the mapping function does not have to understand
> each register it only has to understand each verb and the driver uses may=
be
> 6-7 different verbs, so it is not that bad. The code would basically look
> like this:

> write_reg(addr, val)
> {
> 	verb =3D EXTRACT_VERB(addr);
> 	nid =3D EXTRACT_NID(addr);
> 	pid =3D EXTRACT_PID(addr);
>=20
> 	switch (verb) {
> 	case VERB1:
> 		return write_verb1(nid, pid, val):
> 	case VERB2:
> 		return write_verb2(nid, pid, val):
> 	....
> 	}
> }

> Where pid is verb specific additional addressing information that is used=
 in
> the verbs payload.

Yeah, it's not exactly a model of niceness though.  It's looking an
awful lot like we didn't manage to abstract things properly and setting
off alarm bells as a result.

> >So how does HDA handle this?  We can obviously keep recording settings
> >in the same way as we do for virtual enums, writing them out shouldn't
> >be so hard.   The cache code isn't going to buy us much if we have to
> >write things out control by control anyway, it essentially just boils
> >down to a fancy list walk.

> It's not just the DAPM stuff, but also the normal controls, for which we =
do
> not have per control caching.

That seems like a simple matter of programming to resolve.

> >If you really want to reuse regmap having a write only regmap internal
> >to the driver (not presented to ASoC) which just remembers the last
> >value written to every NID/VID combination might work and at least
> >avoids the ugly bits with trying to convince ASoC there are registers
> >since you don't need to worry about reading the data back and can just
> >pretend that read values match written values since we never look at
> >them except to write them back out.

> Yes kind of.

Kind of?  It solves the cache sync case and if it's write only then we
won't need to go to the register map for reads anyway (outside of
interrupt handling and so on).

--b75zxLgdvbUilXow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcS8bAAoJELSic+t+oim9PQ0P/jZT00JBcat4ozK4EAbl2fu8
KlLJ5D9XGCrba7GqoX0ShL0PjHLTYBWOq51U0lL8MUmliVZG83HX/c74o+MdiEAH
GIVMt4zbOUyJHpSm9gyUUASl4xemCBW7zcmMAjyVmfknFiCnB3BeySKGkuPry9HV
CpcFmwl9F57qjlLQe7a7bgihVxTH4Ze4hTQYjgQBF865BTZoNRsbPo6LpWpL1n6b
zIco9Xj8CYYfRAY0kku+qNVPAnm9dShfqH+lL1Cted+qhiEyBMlGIjwYKYsZy64C
M38u/WZGqVi1Risd3V+a2Xg7nsHxFofmay5yN/oSL3aUbdA4vPRGLMaxYmGuIjNu
p2x4TGAAq1xpn5DLAkbmyfZaanJpgTik4nXCmN7SIQnaHUWbHmLlkC5K6hMnB4in
aio99oRATgrpdnxhC9PPxu5YnYkJr1F9vNcShIdvltk3NiCCuyaWrHv/TC5dPfYJ
niI8i9wxQh5VfuPIn0AxKyyY1Hq7tNGS8DMZqV8ZCc38x4GKkn85xWonsVgwboT9
SfxbxmWQHwYMWw390GXuNRWVypIF52dpvF8DRiwSOzHSH3tqZ3GoZFUOoQ5WjyG3
dtjvRxcq0vtOfB0dTh+zZ8Q7HddxSn+cLfcnTq9HS9BvD5NVSwWf/0/oYs7EVmZk
gvn0O1j0ltZbUFifiRP8
=9dB4
-----END PGP SIGNATURE-----

--b75zxLgdvbUilXow--

--===============1673060179781340696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1673060179781340696==--
