From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: mxs: add some error messages to
 help identifying problems
Date: Thu, 1 Aug 2013 11:22:19 +0100
Message-ID: <20130801102219.GN9858@sirena.org.uk>
References: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
 <1375281871-28128-3-git-send-email-LW@KARO-electronics.de>
 <CAOMZO5BeFq+PxDtJ12H=d8Y=qu8Gyd4wAn=7+mzbx+_OyaUg2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1287104178025036356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id ADE6D260309
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 12:22:22 +0200 (CEST)
In-Reply-To: <CAOMZO5BeFq+PxDtJ12H=d8Y=qu8Gyd4wAn=7+mzbx+_OyaUg2g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@karo-electronics.de>
List-Id: alsa-devel@alsa-project.org


--===============1287104178025036356==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VCtV4SxmcRQdPlhI"
Content-Disposition: inline


--VCtV4SxmcRQdPlhI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 07:11:48PM -0300, Fabio Estevam wrote:
> On Wed, Jul 31, 2013 at 11:44 AM, Lothar Wa=DFmann <LW@karo-electronics.d=
e> wrote:

> >         /* Set SGTL5000's SYSCLK (provided by SAIF MCLK) */
> >         ret =3D snd_soc_dai_set_sysclk(codec_dai, SGTL5000_SYSCLK, mclk=
, 0);
> > -       if (ret)
> > +       if (ret) {
> > +               dev_err(codec_dai->dev, "Failed to set sysclk to %u kHz=
\n",
> > +                       mclk / 1000);

> Wouldn't it make more sense to express it in MHz instead of kHz?

Well, ideally it'd be fractional MHz (ie, 24.576MHz).  I'd either leave
it as Hz or do the proper pretty print.  Also if we're nitpicking the
format then there's usually no space between the number and units.

Personally I think the bike shed would be most attractive if it were
pink with yellow spots.

--VCtV4SxmcRQdPlhI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+jbXAAoJELSic+t+oim9cdkP/AtA1qKUrXIxAnBDFjlyePVN
EKY+NKvbcS8ZguqylWhP65JucEQl3Y8CBvPWbx4wLSIc3wImeKt+/tq8dMp3sn2i
YDG4192yVEDXYafMJJ3ODGlG31fCh92H1ChM7aM1/ULbc1dZuIOITOxbBC/99vnq
50XMy4RW4l5clCpCzmNyeGCXHFtFALjiKhYQWAHw99irnYK7tp6fplo9I+bCpzME
GOnBeicuD5REhv5Z0HjPYJ4zi3ItWAjfKjm2YwDn69gN9ZWJIw43/yNAb7LeoIM6
HnDbtOF13qkmnbD6GLml8i7tH2PkseintnNo8qkK8bkOWgvFs3dHtTM39Ixyi2n3
ufVaLKFHfudRQi8K1PK0qt6L1jEreEDzzp8eNYFyT1toTQPnYBUzhOmyxo7gP18C
OiCFYoOW05fx+VVmybMc5nkQExyxNQyqthB1erK8teznoCPe3Y9oJdg2KlibJK0D
4XCqARL2NVKg5lYkxeaV1y+F+tRiM71ysqkSh6teiI3Ci24p033JpHAaKoTL58ob
2SGbr5ptslnPNtlAWcm78wrB+e1fs9YfCFb6OX5KypQ0oXyiP1b61XA+oEij7uvA
YJDOyOix5cdu0Z+BK17bBpQ+a2KjZOXp6BalFJt+r6UXjsBuzaZE1SxIvWy+yGw2
eoDIM5Jh/0jcL3N2jEFf
=xajV
-----END PGP SIGNATURE-----

--VCtV4SxmcRQdPlhI--

--===============1287104178025036356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1287104178025036356==--
