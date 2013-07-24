From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: SoC: Added jack detection kcontrol
	support
Date: Wed, 24 Jul 2013 01:13:32 +0100
Message-ID: <20130724001332.GW9858@sirena.org.uk>
References: <1374281962-3786-1-git-send-email-eu@felipetonello.com>
 <20130722000157.GI9858@sirena.org.uk>
 <CAGrhNMyAofsnwKYMk+60GyvpaW9pMtoJf_2Q_Tc82G8QCFOiFA@mail.gmail.com>
 <20130723124023.GX9858@sirena.org.uk>
 <CAGrhNMyWXGcDUHxexgvQ2rusKTSbSjEbcEToKZZUudtP-pYxsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5011086085071541100=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 168552651E3
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 02:13:35 +0200 (CEST)
In-Reply-To: <CAGrhNMyWXGcDUHxexgvQ2rusKTSbSjEbcEToKZZUudtP-pYxsA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Tonello <eu@felipetonello.com>
Cc: alsa-devel@alsa-project.org, LiamGirdwoodlgirdwood@gmail.com, "Felipe F. Tonello" <ftonello@cercacor.com>, TakashiIwaitiwai@suse.de, linux-kernel@vger.kernel.org, JaroslavKyselaperex@perex.cz
List-Id: alsa-devel@alsa-project.org


--===============5011086085071541100==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XqOulWco09xrjj7X"
Content-Disposition: inline


--XqOulWco09xrjj7X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 23, 2013 at 05:10:29PM -0700, Felipe Tonello wrote:
> On Tue, Jul 23, 2013 at 5:40 AM, Mark Brown <broonie@kernel.org> wrote:

> > This was the existing kernel API at the time that the code was added -
> > I beleive people had been doing that for simple switches that detect the
> > physical presence of a jack since it looks exactly like a button from a
> > hardware point of view.  See the original commit adding the code.

> I saw it. I don't know what you think is the best way to go. I'm not
> sure if someone is using this input event API, since even PulseAudio
> even declined that implementation due KControl implementation.

It's used quite a bit in embedded systems, there are actually patches
for PulseAudio which were deployed for a while - I guess they might have
been removed or something.  The kcontrol stuff was actually implemented
after that was already in place.

> I'm thinking in re-implement core/jack.c using only kcontrol for
> reporting status and leaving input events only for keys (which is
> already implemented). This will break compatibility if any user-space
> checks for jack status using input events, but again, is anyone using
> this?

The jack core should be implementing all three methods of reporting
jacks (input, controls and extcon).

--XqOulWco09xrjj7X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR7xwoAAoJELSic+t+oim9i8EP/izZNeMOqmIDTN83yRbfPWH4
HPrIZD9EAMnmlf52inh8JJ96xf2liIl1xJuMTMbqRmzZdf+Y1IMQgABuDqiysfus
MfASZyDn1KFqQpLu50SuUGa1rOkSgpJb+uEwmM+W+bk0/kEnw2ZuXvquv45OQQaH
2kqdH9ib3JFu3poDwKgBunp4DcZgso/V0LisKDG2Jjr2O3CNDU+fprtzn+may+0O
x9NMmts4U2cNIVAeK5NvkHZOTBXuGpzc3sY1NKobQqk8dA0DiYbQK60Lc6khbkh4
x3HWyvBYMe5Mbs6Kgmxhna3/DXq76lTO51HVFyyurzsjOuraebpgUuCFsz5yU6u0
EAWSlwI3gJ5wJLxE6g0auZQvuUMIfKg/IZBqJPnN7KdXcSUfRa5LapdaCfLT0Xv1
Qi/kSWtL4ou7y0z7MsF7OKTXjyfE5VTCuDsCuF0OUm4gYVs9YYIqKcGqmjwFnEwc
aTqcVB12uegLqGNF2TRbXfJM5ROMpoDfLC818tLI4JIKAQOrX7lgFlnHXsJmvwyN
brA6v0TxDVQwzRBBTytx1obbsdaqwF3OABk6al5CeivXBNozua5Sz7XhNCSIdb0P
dpTOK3CKmmoIgmDjL64Fjdaa7g9iVBMnqzNzJKpH+Ec7rsG1/n9ppmyV9WAcRGyq
VXHktlImFAFtqQXD0mep
=9Xnz
-----END PGP SIGNATURE-----

--XqOulWco09xrjj7X--

--===============5011086085071541100==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5011086085071541100==--
