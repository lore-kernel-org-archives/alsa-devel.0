From: Mark Brown <broonie@kernel.org>
Subject: Re: Missing return check of of_property_read_*()
Date: Wed, 9 Sep 2015 16:57:37 +0100
Message-ID: <20150909155737.GB20922@sirena.org.uk>
References: <s5hlhcfd5az.wl-tiwai@suse.de>
 <20150909145158.GK9751@sirena.org.uk>
 <alpine.DEB.2.10.1509090954430.3157@heelroid>
 <s5hfv2nd45t.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1632303799796124617=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 68FC3260536
 for <alsa-devel@alsa-project.org>; Wed,  9 Sep 2015 17:57:48 +0200 (CEST)
In-Reply-To: <s5hfv2nd45t.wl-tiwai@suse.de>
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
Cc: Brian Austin <brian.austin@cirrus.com>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============1632303799796124617==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i9LlY+UWpKt15+FH"
Content-Disposition: inline


--i9LlY+UWpKt15+FH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 09, 2015 at 05:05:18PM +0200, Takashi Iwai wrote:
> Brian Austin wrote:

> > Shouldn't that build server at Intel catch these? I usually get emails=
=20
> > about things like this from them.

> Maybe depending on gcc version.  But it's interesting if no other
> static analyzer hits this, too.

It'll be because nobody is checking !OF ASoC configurations and paying
attention to warnings - with !OF the functions are inline in the header
and the compiler can tell nothing happens.

> I'm considering whether adding __must_check to of_property_read*()
> would make sense.  Then it'll be caught no matter which gcc version is
> used.  But this would hit too many spots.

Well, if they're all buggy...

--i9LlY+UWpKt15+FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8FbwAAoJECTWi3JdVIfQzEEH/26lMrfsuqwXTuVznv9VXsqn
60ZhXkFFMT6FtN7ZDaVznBbpU9QtFugrwgsfkSw7+ccd3Cdz3qvFK0hwU29YKReL
dDY6eJAJL+ZI4l9quqCP52pEUrKbUuEuuZkYUdtYdIaO5RsbNayzPZf9HmNK6dFj
/cg+QPMRG70TIpWVdH2mEyFm4tXjy7owGEJ2oW76RugVmdeSKPKoB5sz7FEVgf76
HHuPrUuUm9ctG4TvvzWpitX7EQIvNGC0/o13wK0E+47Jp+ugDxDT0FAWCcCyqnY2
qjiGT4BZ1JCdbSbyjaSx0KyXwXxk7es+DGhgaaVLWPQDtiSGowS+X+qt6kfpt9Q=
=UbHh
-----END PGP SIGNATURE-----

--i9LlY+UWpKt15+FH--

--===============1632303799796124617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1632303799796124617==--
