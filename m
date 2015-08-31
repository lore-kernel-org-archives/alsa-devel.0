From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v4.3
Date: Mon, 31 Aug 2015 14:38:19 +0100
Message-ID: <20150831133819.GL12027@sirena.org.uk>
References: <20150830151032.GE12027@sirena.org.uk>
 <s5hfv30li6l.wl-tiwai@suse.de>
 <20150831102007.GI12027@sirena.org.uk>
 <s5hd1y3wwky.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1766944546508388556=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A102E260412
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 15:38:39 +0200 (CEST)
In-Reply-To: <s5hd1y3wwky.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1766944546508388556==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HTx1z+94XwbBM7kl"
Content-Disposition: inline


--HTx1z+94XwbBM7kl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2015 at 01:01:33PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > On Sun, Aug 30, 2015 at 08:55:46PM +0200, Takashi Iwai wrote:
> >=20
> > > sound/soc/codecs/sti-sas.c:227:13: error: implicit declaration of fun=
ction =E2=80=98devm_reset_control_get=E2=80=99 [-Werror=3Dimplicit-function=
-declaration]
> > >   dac->rst =3D devm_reset_control_get(codec->dev, "dac_rst");

> > > So some changes for 4.3 are missing.  Could you postpone this branch
> > > until this new devm_* gets merged?  Or we may pull devm change as
> > > well.

> > What configuration do you see this in?  If the function was just not
> > there my tree wouldn't build...

> It was due to the missing dependency as Axel pointed.  My config is
> below.

Right, I figured that - I was just not sure how you were managing to
trigger it.  Given that it's something that doesn't happen with any of
the standard defconfigs or all*configs I'd rather leave the pull request
as-is then send a followup request with a fix later once things are
sorted out (either something in Kconfig or fixing the stubbing).

--HTx1z+94XwbBM7kl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV5FjHAAoJECTWi3JdVIfQ4Q4H/RnCEK4kJisGbO7IjVF9cAU/
EUkznG8my1wzyXHyfHjsq6gc2pWOxdux3Hp7bNS/2JNqYBvTXrPwD0lm2s5lgvyd
BjSM5KAl52out+Gasl0XuLbCIVwvFkDR961dpSIWylNdzG9c4hmfX5RlSzdduC7R
s2h9HLQMVuOp6riQRk2hy5E2iy80oNTXM/QgoJqepGNUdoyWxQctEHyFGbuPdh80
ZpGCDtteony1OmhLVqkQJ7HDvYgU90qOwV0sUTPqbdQcfTXpbKxd38Pj6kCcMoPE
5xH5Hn9lFkI1Bi6Bhk7P2jPxv7hK0mmNxpqppYkYq59EGBnewctnNN5fU/b5Lsg=
=4klY
-----END PGP SIGNATURE-----

--HTx1z+94XwbBM7kl--

--===============1766944546508388556==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1766944546508388556==--
