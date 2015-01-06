From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: sam9g20_wm8731: drop machine_is_xxx
Date: Tue, 6 Jan 2015 16:01:23 +0000
Message-ID: <20150106160123.GA2634@sirena.org.uk>
References: <1420542872-10015-1-git-send-email-alexandre.belloni@free-electrons.com>
 <20150106120049.GX2634@sirena.org.uk>
 <20150106122751.GO4194@piout.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2738946361762599424=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2BE6E2604F8
 for <alsa-devel@alsa-project.org>; Tue,  6 Jan 2015 17:01:53 +0100 (CET)
In-Reply-To: <20150106122751.GO4194@piout.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2738946361762599424==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BEfR2jmXRHrz4elx"
Content-Disposition: inline


--BEfR2jmXRHrz4elx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2015 at 01:27:51PM +0100, Alexandre Belloni wrote:
> On 06/01/2015 at 12:00:49 +0000, Mark Brown wrote :
> > On Tue, Jan 06, 2015 at 12:14:32PM +0100, Alexandre Belloni wrote:

> > > Atmel based boards can now only be used with device tree. Drop non DT
> > > initialization.

> > This doesn't apply against current code, please check and resend.

> It should apply after "sound: soc: atmel sam9g20_wm8731: remove useless
> include". I was based on 3.19-rc2.

So, one reason you should use subject lines matching the style for the
subsystem is that this is a big part of how people find patches to
review...  I'm not 100% sure I still have the patch, the volume is
rather high right now.

--BEfR2jmXRHrz4elx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUrAbSAAoJECTWi3JdVIfQYLIH/iXGi3OfHhlaLFOtrwN7sCnZ
QW4fUwjuCMJN+Cn3wkfrq+YpWnCyfycQXvyHV/t6R2XsEarS+DF87bxuffWlcNL4
nZFwaOjxVcRuRCGQB+7HsyQL2N8kMBWfpRJPpng4FZHzS1NsaxWC7Ijs9AHaZgsN
0Bh63FUw6HeO++Wnw7M3bbzSuJvP6je7ncsIK0e9yCrMDC8SeDnSvGf1TBtYCTdA
nBFnXwqUhGCyBiLEbjkHKzo9oF4AfBy+vzWN0YeTvdxbeEwUucQB+Tgc/pRs2BXT
Zd1+mQxe9cwCdgYyLlCYhj0cm+aEIWgWYDnIOGaT3W/MQKkSPKu0j8yPLKuLgjY=
=xw0i
-----END PGP SIGNATURE-----

--BEfR2jmXRHrz4elx--

--===============2738946361762599424==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2738946361762599424==--
