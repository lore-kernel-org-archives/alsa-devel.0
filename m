From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] sound: fix MODULE_LICENSE typos
Date: Sat, 23 Jun 2012 11:51:18 +0100
Message-ID: <20120623105118.GR4037@opensource.wolfsonmicro.com>
References: <20120622232149.GA29819@www.outflux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CgyvWwj/llZsteoZ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120622232149.GA29819@www.outflux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Ola Lilja <ola.o.lilja@stericsson.com>, alsa-devel@alsa-project.org, Joshua Kroll <joshkroll@google.com>
List-Id: alsa-devel@alsa-project.org


--CgyvWwj/llZsteoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 22, 2012 at 04:21:49PM -0700, Kees Cook wrote:
> include/linux/license.h does not recognize "GPLv2", so adjust these
> declarations to add the needed space before the version.

This patch isn't against current -next which doesn't have this issue,
I've no idea what you generated against as a version with this has never
even been in -next.  Please do also use subject lines that resemble
those used in the rest of the subsystem, having to hand edit commit logs
is tedious.

It seems more sensible to fix license.h, GPLv2 is a pretty common way of
writing the license name in the wider community.

--CgyvWwj/llZsteoZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP5Z+ZAAoJEBus8iNuMP3drasP/3Gla6S0lk/I+hnjaZSjuV/k
7ViReikJ8I4npwDez88ijvpmY+T88GE4bAe8uzqluzraVjLmLWykxG3eilvLrjRs
xB2eSo6kCL50dNUeja+qCtx57iwE1sA09RBDz+OhX7G1e4Xc8JV/cp7lYIYVbSp8
WaaoxGyst2JYfwdKZCeS4wJSmQynC+7zdy1QEgJ++RnU3YCW1UQ/Vzb0cqaQ+SOT
lTwRNQ3uK9N3PHodBoQa4koxAfXT5Kyne0rIl/q3RRFft9xXac5Ahiy4jBdtoBd0
aWhlQN7rpdkhovbdt6uJNjQPBiugHuo+K8ZLPfXSjdSFmrga4CDwSwZNQ1FueBjY
o3tDngw8a3jmHrn40jkVBbnJ5BlzPYySPMsSIpmJYxz5/MsfqAh1dUpo1C3IuQJs
ABJzfE3TQEtRMo9X39u5JnuV2t0/9z0asBB0ahYQhfM7VsUw3dfhFzPXXam1I7Jn
/fHUzt1H1zWz73pPVI7mZ8PhToTFvEJusswiCrdD/lIt+yzWTL1Zkzgoxd1O6htp
L2R7oVxOPMsh5x6nLPLTF8pTDYZFf1gHtw2z0sAYSDzX1DHy8IR+J/TgHzrLIRBC
otNIyvpXBr0HRnhTzcEshxMGCRL9mNNIalMqiorAUklYNf536m9eq9YKR+yX3TBR
uh5AgzDWan790ablu9Bm
=U2Zf
-----END PGP SIGNATURE-----

--CgyvWwj/llZsteoZ--
