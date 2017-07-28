From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5514: Use the local variable to
 get the data from SPI device
Date: Fri, 28 Jul 2017 14:59:44 +0100
Message-ID: <20170728135944.dkii7b2ey56nuchs@sirena.org.uk>
References: <1500624047-21492-1-git-send-email-oder_chiou@realtek.com>
 <20170721105105.4lsehuw6an7oclqd@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D12694023B5FB9@RTITMBSV02.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5165975833561445102=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 17AED2676F1
 for <alsa-devel@alsa-project.org>; Fri, 28 Jul 2017 16:00:31 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D12694023B5FB9@RTITMBSV02.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Jack Yu <jack.yu@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "hychao@google.com" <hychao@google.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Albert Chen <albertchen@realtek.com>, Shuming =?utf-8?B?W+iMg+abuOmKmF0=?= <shumingf@realtek.com>, Bard Liao <bardliao@realtek.com>, "Flove(HsinFu)" <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============5165975833561445102==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="llunrpcv7wlsvyg2"
Content-Disposition: inline


--llunrpcv7wlsvyg2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 24, 2017 at 03:06:36AM +0000, Oder Chiou wrote:
> > On Fri, Jul 21, 2017 at 04:00:47PM +0800, Oder Chiou wrote:
> > > The patch uses the local variable to get the data from SPI device to
> > > prevent to get all zero data.

> > How do you end up with all zero data from reading directly into rxbuf?

> While the "runtime->dma_area" put into the rxbuf directly on the Intel
> platform, it seemed that had the limitation to let the memory cannot be
> written the data using the driver of the SPI controller. We verified the
> original code on the platforms of Nvidia and Rockchip, and these are
> working fine.

Do we understand why that is?  Note that IIRC you're not really supposed
to DMA to or from the stack, there are some platforms with restrictions
there so it's possible you're just moving the problem around here if
rxbuf can be on the stack.

--llunrpcv7wlsvyg2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll7Q08ACgkQJNaLcl1U
h9ByVAf/Qyuc46K28tgK81X9RyR/iFnxpvO2DUQGxdD+wGRsVKPFBC0JHp7B3lY4
3bkRRR/VGPq/xiubheLMarBr0gQkMfwWU2UbmmIVfkeAzzlD8C+8rC9xnktBhszF
w8MVabqn4i/sB1OOBZtPPB8NSNGV9MK5/64vTN/rW08GJ8aPcHW0w0Q/PkOHR1UI
7Ivv12Iy/+qFvLHHdiqONFCSTDbrAlmBTlVphj2G79EkImfHwUntWm2hbu1FNVfz
hapwt9ujuvZZdEMZ2C4GP3getvLg5BUeO2o0817lRxnZZlVsZV9TpaY+PjCWpMDz
bGGB06/gjAw01EAgSG2gi1qfAsRqFg==
=fh5V
-----END PGP SIGNATURE-----

--llunrpcv7wlsvyg2--

--===============5165975833561445102==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5165975833561445102==--
