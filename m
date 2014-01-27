From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 7/7] ASoC: binding: for new properties documenting and
 usage
Date: Mon, 27 Jan 2014 19:58:48 +0000
Message-ID: <20140127195848.GB11841@sirena.org.uk>
References: <1390549386-4702-1-git-send-email-Li.Xiubo@freescale.com>
 <1390549386-4702-8-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0B3PZ1+h5f4cFxHi"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1390549386-4702-8-git-send-email-Li.Xiubo@freescale.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiubo Li <Li.Xiubo@freescale.com>
Cc: lgirdwood@gmail.com, kuninori.morimoto.gx@renesas.com, rob@landley.net, perex@perex.cz, moinejf@free.fr, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--0B3PZ1+h5f4cFxHi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2014 at 03:43:06PM +0800, Xiubo Li wrote:
> This add the following three new properties documenting and usage
> for simple card:
>=20
> 	"simple-audio-card,name",
> 	"simple-audio-card,widgets",
> 	"simple-audio-card,tdm-slot".

name and widgets are basically fine modulo the comment about "Hp".
tdm-slot needs further study, when resubmitting can you please split
that into a second patch so that the name and widgets properties can be
merged even if that needs more work?

For widgets it might be good to create a separate document widgets.txt
and refer to that - since the code in the kernel can be shared and
extended we should share the binding document too.

--0B3PZ1+h5f4cFxHi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5rp1AAoJELSic+t+oim9A3QP/A8aNVQD0h9sVM+VO3PtYxfG
e3dlncl3PhEd5xwgmyKJ62ZuRk/QsLgKjtd3DqPSd4jsUyPCGuFOh4s76b6LBcKw
tZqAbDqHJIJlDoZpDO/irdYjLg7Hw6ZYtKHi739GpzzuUAJRzL2zA6Qk+49CHfx+
y6InlZEE4nTDR6rcWFP4116QzWkQzIwTCDhk1+DbIwd8lWZ6H/BB9s2okm7Cp+2y
umMFiK6nf+9F9ON5b65FeY9866bgiAmKER9ic5v4JwhqwoBzZP7QRd8Ee16EvFVR
nnoMw/kJSiVjf6nzoCuNVuda8T4I8KxtIxz8cyeC74X8t8wEFpHFguQGYcR8y2CO
clGg8s6IK3R496C6y/VYcT2wAGwHAU8/x/28eauK67zufu+kyVL81hETovThXAD8
1PNHdRk40Y979cmIooXCKE0tMGugQu3aEPycStjDoGPYBbIE/NlJiUD7/b3Sf7/X
9Bkn2qpaXvcOt/NssdqqO6r3tIDjg+O7qo6ers22uVma6xMIld4eNW50g/GTA2pW
fxv6I7WCzUVE0E8t0hGZDqZW/Wi9/3cGVMIfOJquY6QvVKIj58PcLtItS/JXPhME
n3FAL53U96hkwG4nv19wULrLbeEUXdMICqJVe5nVeMAf6cAeeu4E+BQDZk8KQqyK
UgyHRqUmT0C4D1ZzbFan
=KWPr
-----END PGP SIGNATURE-----

--0B3PZ1+h5f4cFxHi--
