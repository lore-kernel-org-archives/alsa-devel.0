From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: automatic BCLK and LRC
 divde in master mode
Date: Thu, 16 Feb 2017 12:13:50 +0000
Message-ID: <20170216121349.q7fa3uwij3ki7t4j@sirena.org.uk>
References: <1487051073-2350-1-git-send-email-KCHSU0@nuvoton.com>
 <20170214110908.nhklqtcy5dohhned@sirena.org.uk>
 <58A509A6.1010304@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5083037833645758502=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8BDE0267014
 for <alsa-devel@alsa-project.org>; Thu, 16 Feb 2017 13:13:59 +0100 (CET)
In-Reply-To: <58A509A6.1010304@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, "anatol.pomozov@gmail.com" <anatol.pomozov@gmail.com>, AC30 YHChuang <YHCHuang@nuvoton.com>, AC30 WTLi <WTLI@nuvoton.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "benzh@chromium.org" <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, "yong.zhi@intel.com" <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============5083037833645758502==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="c4iocfkjqkx4alol"
Content-Disposition: inline


--c4iocfkjqkx4alol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 16, 2017 at 10:08:38AM +0800, John Hsu wrote:
> On 2/14/2017 7:09 PM, Mark Brown wrote:

> > This patch *still* does not apply.  Please, try sending to yourself and
> > applying with git am before you resend to me.  Check that the patch is
> > not being corrupted when you send it (things like space/tab conversion
> > for example).

> I have resent the patch to myself. And copy the mail content to a new
> patch. Then try the command as follows, and it seems work fine.
> git am --signoff < ASoC-nau8825-auto-BCLK-and-LRC-divide.patch

I looked again, you've got at least space/tab conversion problems in
there in the copy that ended up in my mailbox.  Perhaps there was some
temporary problem in the mail system your company uses, can you try
resending to me and see if it's sorted?

--c4iocfkjqkx4alol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlill30ACgkQJNaLcl1U
h9B/Egf+OncT0iKqqzGbBMq4H4Urkfoe6T9MdjkQyRxFQFBhR2IRvSC6f/2Ry6Wc
Ul58jpixWx34yCpsvgW9DVXnO60LCdVgNUElBNLf77wSasnTCdwYnPiA5gMrwsuV
m5PiB47uiJXVYkYjgPr61NBOfmdkM/8tsMi+LydSq2jeFvbn04db23lnIuDLCMju
2DrxI7jWIZeUuvdB9QVRYcCZa5De9FVsCNr2DcN+Rg6LTzUBweNPPsFxTh3AFHwI
f7I1T2dad38X7qpEz4mF2ePXXO9WrF89lNSCQoI/qVJ9PKgLHtg2SVwTaoRYOx04
+N+sp4l/AQlDhu16Iw2i7tsJlXr8Fw==
=wm16
-----END PGP SIGNATURE-----

--c4iocfkjqkx4alol--

--===============5083037833645758502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5083037833645758502==--
