From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2] ASoC: cs35l33: Initial commit of
 the cs35l33 CODEC driver.
Date: Mon, 16 May 2016 18:06:14 +0100
Message-ID: <20160516170614.GA8104@sirena.org.uk>
References: <1463172629-559-1-git-send-email-Paul.Handrigan@cirrus.com>
 <20160513222848.GW22038@sirena.org.uk>
 <alpine.DEB.2.10.1605161013100.5521@phandrigan>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4633784476572764922=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C786C2657B4
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2016 19:06:21 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.10.1605161013100.5521@phandrigan>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Paul Handrigan <paul.handrigan@cirrus.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============4633784476572764922==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 16, 2016 at 10:20:24AM -0500, Paul Handrigan wrote:
> On Fri, 13 May 2016, Mark Brown wrote:
> > On Fri, May 13, 2016 at 03:50:28PM -0500, Paul.Handrigan@cirrus.com wrote:

> > > +	for (i = 0; i < CS35L33_INT_ATTEMPTS; i++) {
> > > +		/* ack the irq by reading both status registers */

> > Why do we need this...?

> The we need to keep handling the unmasked interrupts until they are
> all cleared.  We could get another interrupt while handling the first
> triggered interrupt, but the interrupt line could be de-asserted due to
> the read-to-clear nature of the interrupt status registers.

This doesn't follow?  Clear to read shouldn't be affected by reading
repeatedly, or at least I don't see that helps any problems in a
non-racy fashion, and the interrupt subsystem will happily call the
handler again if the interrupt reasserts during handling so new
interrupts shouldn't be an issue either.  New interrupts are an issue
for most devices so we really ought to have handling for that in the
interrupt subsystem if it's needed, or possibly the usage of the
subsystem needs to change to take advantage of preexisting handling...

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXOf4AAAoJECTWi3JdVIfQCucH/ir4P8S7QBGVHVk1aKzfKQr9
lOT9e46drCmFQFPQCNyxjhZIXTNnqzYDoisAGLO9O51jZ1Ikphl+kvMdZuoWre75
+WIwxtDueM6d4S8NaVRSGp3fsirByWogkWsP3UMzX6p+6jUV84Bwba+9bez+VG/r
5uiDiWuDt5pM1IBiaLWb6Vjif6YXKsz47ZeOJPqDy/6g1Co1mrSs0/XOgW8bIfGk
jL6f6MDcMMr/CtUiBvTC+mTYnjY3Fk2NqwNeYiV0Saz4Y2TZHhmTAj+cL6usSBYB
2AgWQyHyEF8t18U/v8tBSk+YVIV8ok9R/+YLyBmPk5O3vRqJ3xqt98EytdV+ioM=
=3/Ac
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--

--===============4633784476572764922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4633784476572764922==--
