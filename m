From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: fix debugfs read using
 path->connected
Date: Mon, 5 Feb 2018 11:31:30 +0000
Message-ID: <20180205113130.GA12384@sirena.org.uk>
References: <1517555015-19080-1-git-send-email-kaichieh.chuang@mediatek.com>
 <20180202155340.GC7101@sirena.org.uk>
 <1517806580.27374.4.camel@mtkswgap22>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6724021663128929874=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D994267076
 for <alsa-devel@alsa-project.org>; Mon,  5 Feb 2018 12:31:33 +0100 (CET)
In-Reply-To: <1517806580.27374.4.camel@mtkswgap22>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: shane.chien@mediatek.com, alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, chipeng.chang@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============6724021663128929874==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 05, 2018 at 12:56:20PM +0800, KaiChieh Chuang wrote:
> On Fri, 2018-02-02 at 16:53 +0100, Mark Brown wrote:

> > This doesn't apply against my tree or Linus' tree, can you please check
> > and resend?  The change itself seems to make sense.

> Maybe its because the "Email Confidentiality Notice" at the end?

> Let me try to sent one without it.

Ah, that could be - or perhaps your mail system is mangling the patch so
that git and patch can't exactly understand it.  You looked to be
generating against a sensible tree based on your earlier mail so I'm
guessing it's something about it being damaged in transfer.

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlp4QHMACgkQJNaLcl1U
h9C00Af/c1naI14IIZSN04dK3n+RNLD2fbbez5tNK7xGY++UDBlZkCriZraR4S9z
KRlCsJpnzMExAGTchGTNSJbAq+fhG1zNjya8K1zbpODme4P00jB4im/72zkl1PTm
ITPMuGJRm1UTlrRJfvwmLtOegWsK9H1vCgEzQNKrQ/fHg669JgF6osw3qrfo/tKr
99YMwwof5X8RtnPU2CUxUqd1CdYEFWk6fZUz8w5sNuhnJzArzUSeMwhG9bx2uh9t
8/8o1q6yP9wtD3W5qINYxod1IUy8QrQIZENSEczf/AAsw4bow9McgwpIChtqhkda
MGPBtgf5qRfnjfe6cQohr6omV3TwrQ==
=whoT
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--

--===============6724021663128929874==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6724021663128929874==--
