From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: integration into ASoC
Date: Fri, 7 Mar 2014 17:53:35 +0100
Message-ID: <20140307165335.GT607@lukather>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4848337032420928951=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (top.free-electrons.com [176.31.233.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 546A52659F3
 for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2014 17:55:03 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: shuge@allwinnertech.com, alsa-devel@alsa-project.org, zhuzhenhua@allwinnertech.com, kevin.z.m.zh@gmail.com, sunny@allwinnertech.com
List-Id: alsa-devel@alsa-project.org


--===============4848337032420928951==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Pe/WPRK8yIcEP0xy"
Content-Disposition: inline


--Pe/WPRK8yIcEP0xy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liam, Mark,

I have a sound IP that is part of an SoC that I'm willing to write a
driver for.

This IP is made of a few registers to control the sampling rate, if
we're using mono/stereo, plus two fifos, one for playback, one for
capture, that can be seed with data. The data are then taken, go
through a DAC, and the outer interface of the IP are directly analog
signals (so the DAC/ADC are directly in the SoC, and the only
interface we have is plain registers).

=46rom what I understood from ASoC, you have mostly three components,
the DAI, the codec and the platform that plumbers the two first
together. Here, my understanding is that it's pretty much the whole
three in a single IP.=20

Should such a hardware block be handled into ASoC, and if yes, how?
If not, which other framework should be used?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Pe/WPRK8yIcEP0xy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTGfmOAAoJEBx+YmzsjxAgO3AP/1TUuek1cn7tkJcHvcRtCjaU
/Yq2FVAq8uJXQTIlLQb8NT/uotfG/JcXciNfyeeHxyXfBCxZB8QIf0NF54XmBZ/r
JCcGgUhjjJoDB5su6PLiNmQc16dKj+mrsTnoB/4rqiNQWBzkNxn3brjUXPo0SBmN
zBRap4rinY88Yx3uBNj76YwxcjOlbYkBUrOsBYUUmZeVaGTSxfaGbtJe4zLDvfa3
rRM1tA8Cb763VgbaoCdYdtUUpvBaYCWKzClmA9YIepnzfPPt10LAJsWjs/WZd/FJ
GXF262WVgCrkEzpwNJ8DTUJXKjmjedhnkX602R8/5clTNzHLAWVMjA5nWtb2RlFd
z3fMrb2aMbqrOtjXnIxmv1MaK17lkOcorUDxtKBNV9NaY2t6w1ZUxZvikPGY/LXk
IzdQJxU2Q/aL3I+Hs8i4244uF6vLKWDr23b5WdidxcKTbuAI+4f1d5pSoaEIJRxP
eGxpqRKeYZxNVR5oNa7qzklppIqJvqYJ30F6l+IiCUr/ZYMnJD7oFthcEGNmdaSa
+FubSEWqtN0t2u5rqU1TTlZYcH2o/uet59aVV62c5nRhvEld88R8hqBm+QwLpt29
pT805Emg9M1Y03eH2I9M8KRycJN38/KZbL62UhP2kbMmnchJIF3oj+sv5PSNvNvx
8jL2tPssl98WDJ1G2SRG
=oa0K
-----END PGP SIGNATURE-----

--Pe/WPRK8yIcEP0xy--

--===============4848337032420928951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4848337032420928951==--
