From: Mark Brown <broonie@kernel.org>
Subject: Re: DAPM over two regmaps (and a mailbox)
Date: Tue, 20 Sep 2016 11:46:22 +0100
Message-ID: <20160920104622.GP10189@sirena.org.uk>
References: <20160919105419.GK8719@lukather>
 <20160919111247.GL10189@sirena.org.uk>
 <20160919113415.GM8719@lukather>
 <CAGb2v67FSOKKREr49xkD6J6APs=sc=iVvmBJxQ4n9d2L9_oGjg@mail.gmail.com>
 <20160919191543.GU8719@lukather>
 <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4482194513583211370=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B662926155E
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 12:46:32 +0200 (CEST)
In-Reply-To: <CAGb2v65qARPr1cEL5oU6bsiwK61rFQx4Gma=Z0r8DK5WTBOnmA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Mylene Josserand <mylene.josserand@free-electrons.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============4482194513583211370==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
Content-Disposition: inline


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 20, 2016 at 08:32:50AM +0800, Chen-Yu Tsai wrote:

> > Ok. How would that work? Can you setup routes between widgets defined
> > in different components?

> Indeed you can. I think that is what the ASoC card is for, to stitch
> up various components. Not sure if you can directly use widgets from

Yes.

> aux components in the codec component driver though. I guess it depends
> on the probe/binding sequence.

You can't, you'd need to provide a table for the card to use.

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJX4RN9AAoJECTWi3JdVIfQYP0H/1GfaA9jUiE9WYynGkHwQsu5
p3Iai6wuvQkUVCFWkvt/Zy2V9oHgC4PdSceLirLjZueSXFpWfU0bKJrQYUXnZt8u
olBpFIxrYqciW13Son/Mwym9VbXnwZSLDz2fNsQGR2BxgoUfeV5sJTR34dPB0Nq8
NZBKj0KuwzvILbC+lAkjBDGA3IbujAKbwLc3SKpyvjma6OVD7GSchMxnqdPizMv6
JQnE7UxJuMRWgUcoZD+yb/MUOt4pBPot23QhaKiOmpR5Xk8k5W8YcdHvbzMW4ek6
YNtff1V2hjygALYm8d7xnTQPkwmek14jplAMXDwpAhz5NZqAA0NAQTSVj17RPBw=
=EnfW
-----END PGP SIGNATURE-----

--9pS2hy4/DrI8BQlq--

--===============4482194513583211370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4482194513583211370==--
