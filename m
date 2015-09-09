From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Wed, 9 Sep 2015 15:51:58 +0100
Message-ID: <20150909145158.GK9751@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5512615644001155609=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F9A326129A
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 16:52:12 +0200 (CEST)
In-Reply-To: <s5hlhcfd5az.wl-tiwai@suse.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5512615644001155609==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UlsYxwg8UDQn+EKZ"
Content-Disposition: inline


--UlsYxwg8UDQn+EKZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 04:40:36PM +0200, Takashi Iwai wrote:

> I hoped that I wouldn't need to write this kind of post, but since
> nothing happened so far, so here we go:

Could you be more specific about nothing happening here...

> The following compile warnings are present for quite some time.  They
> are due to the lack of return check from of_property_read*().

> sound/soc/codecs/cs35l32.c: In function =E2=80=98cs35l32_i2c_probe=E2=80=
=99:
> sound/soc/codecs/cs35l32.c:278:2: warning: =E2=80=98val=E2=80=99 may be u=
sed uninitialized in this function [-Wmaybe-uninitialized]
>   switch (val) {
>   ^
> sound/soc/codecs/cs35l32.c:272:15: note: =E2=80=98val=E2=80=99 was declar=
ed here
>   unsigned int val;
>                ^

How are you generating these - what compiler and config?  None of the
build bots are reporting any of the warnings you have here.

--UlsYxwg8UDQn+EKZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8EeOAAoJECTWi3JdVIfQQ0wH/Rg94sWd1DGbl6MO819rr81N
uAxORdq0IRJX6n4AEp7ZI+LH6g4EukpVXP4uF5GNfkj4/U80TAicz7V12VEe3d3S
zwKHbyibPWkIisc5OYBUP+rr0GJthL9vF1ZaL1G0xVI7W7lsjXr+XocE/LyvKDfV
mUqv+xVp9WMuGESa4GwjRYCYyrHcp69zH6MvmJxRM4eZsh/o0yzNbPx38rQZjP6T
BPrkxYu44rWb3Wh4jFF/Srk6Yi51//1lao4YSC3Nf5r0uH3Hr0tiXuZ936px1MLa
Jn7K+DTE1+7Q9a1vJm22CQry09xBNjayQG1/RhK8ZUPvZPVm3mrEk5VAEzofffU=
=K7bG
-----END PGP SIGNATURE-----

--UlsYxwg8UDQn+EKZ--

--===============5512615644001155609==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5512615644001155609==--
