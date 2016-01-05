From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Tue, 5 Jan 2016 17:21:46 +0000
Message-ID: <20160105172146.GH6588@sirena.org.uk>
References: <1430be98728abfe543d9a1e245d9b80f6d8f3c44.1449567072.git.zidan.wang@freescale.com>
 <20151208124713.GQ5727@sirena.org.uk>
 <20151209033449.GA30401@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5955969343579404978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AF93E2605D3
 for <alsa-devel@alsa-project.org>; Tue,  5 Jan 2016 18:21:55 +0100 (CET)
In-Reply-To: <20151209033449.GA30401@shlinux2>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============5955969343579404978==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Bg2esWel0ueIH/G/"
Content-Disposition: inline


--Bg2esWel0ueIH/G/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 09, 2015 at 11:34:52AM +0800, Zidan Wang wrote:
> On Tue, Dec 08, 2015 at 12:47:13PM +0000, Mark Brown wrote:
> > On Tue, Dec 08, 2015 at 05:40:13PM +0800, Zidan Wang wrote:

> > > + - aifx-continuous-clock   : If present, bit clock will be continuous.
> > > +			     Otherwise, dai bit clocks can be be gated
> > > +			     (disabled) when the dai is not sending or
> > > +			     receiving PCM data in a frame.

> > Why are these selectable in the machine driver?

> I have tested and found that sai<->aif1 can support "i2s" "left_j"
> "dsp_a" "dsp_b" format, and can support cpu dai master and slave
> mode. But I haven't tested voice dai and bt dai because of hardware
> limitation. I just using sai<->aif2 to test aif2.

> So I want to configure the dai format from device tree. And there is
> a help function snd_soc_of_parse_daifmt for me to do this, so I add
> these selectable to the machine driver.

This really sounds like the best thing to do here is to just leave this
out of the upstream submission then add the support for the voice and BT
link when you've got the configuration worked out.  You'll most likely
find there's only one possible configuration anyway.

--Bg2esWel0ueIH/G/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWi/upAAoJECTWi3JdVIfQIQwH/2kSdyTx1UKWLe+gCauPN9w/
yNLHxePfmhqOUhcpvwrWxQaF52M77zYAsPpbOPGYI95fEIYmZ21CvzROOArvm8rv
exmu5ZoRNDWw5xE3krIvELqo5NpQQkWUN+0F5sV218Z1sbA7e/VSkPn1yzIIjcI9
/RV5bVO4LxM/Kxrqp3yqM5ZIzy/i0Ou9IuJ4QqyU9larKeydsiqdIz/6rMrXqIRM
ymKRPZHfZQNTihqAdCjlFKgkMQ7742GFVxphTV/+LB5a2Q/MokseUPr73lZU/C4C
rXYcQkBlea6YY1sanAc5tNb7wVCXV3ljfkf0iSTPNJAvDEj2EYbHQPeIjIonxJg=
=CVbB
-----END PGP SIGNATURE-----

--Bg2esWel0ueIH/G/--

--===============5955969343579404978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5955969343579404978==--
