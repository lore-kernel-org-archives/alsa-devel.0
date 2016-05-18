From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/1] ASoC: core: Do not print an actual
 error when deferring probe
Date: Wed, 18 May 2016 17:08:20 +0100
Message-ID: <20160518160820.GO8104@sirena.org.uk>
References: <1463584020-6085-1-git-send-email-alexander.stein@systec-electronic.com>
 <20160518152028.GM8104@sirena.org.uk> <2174266.52DIgyL9R9@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4461507145537515477=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EDA71260647
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 18:08:32 +0200 (CEST)
In-Reply-To: <2174266.52DIgyL9R9@ws-stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Ricard Wanderlof <ricard.wanderlof@axis.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4461507145537515477==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="da9oBGf5DLtF9ehv"
Content-Disposition: inline


--da9oBGf5DLtF9ehv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 18, 2016 at 05:53:49PM +0200, Alexander Stein wrote:
> On Wednesday 18 May 2016 16:20:28, Mark Brown wrote:

> > Oh, and the other thing about this which I should have mentioned is that
> > it applies to every single resource acquisition in the kernel - this
> > needs addressing at a global error rather than piecemeal.  Raphael was
> > intending to work on avoiding probe deferral in the first place by
> > sorting probe and there were also some proposals to have a helper for
> > printing error messages which would suppress the display of probe
> > deferral errors before the final run at late initcall.  Obviously the
> > second mechanism is substantially simpler to implement.

> I remember those patches a bit. But working with late initcall sound to m=
e=20
> this has no effect on probe deferral in drivers loaded by modules, no?

Correct, once you're using modules you're pretty much relying on
userspace sorting out the init ordering.

--da9oBGf5DLtF9ehv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXPJNzAAoJECTWi3JdVIfQfHoH+wYse166IxCOnuEUZTHwSee5
p+TqkoXn5aYvXEj1VRU0ezBBLbpOtfFag3kk3qWzzg08hoSjeASXPiJCAp+mPeOG
oGpON7db0U+MJvgd8IV3oLRv2rOovp85CJzLGB+BkuHgy4+ROWFLJ463Bkc8SXbx
FqXJoHfqFT1rR6jE/xRJ92nbsl8pb4SrNxr4wDm+kekqdOzvShkHzjEZw0EF4NhR
S9VvHl9nzvY2//i1B+lnyhcTZm7NhUgogFPibNAYnuYXOzO5p+/z1jzB0kF0Ta+X
RJeJbPnfOQqzbjjrUfd7SMTvA9JtBn9Ur3nacbAWLP0GgslGwNlrZnHEkiuMuxY=
=fZJJ
-----END PGP SIGNATURE-----

--da9oBGf5DLtF9ehv--

--===============4461507145537515477==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4461507145537515477==--
