From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] ASoC: mmp: add audio dma support
Date: Tue, 29 May 2012 10:02:15 +0100
Message-ID: <20120529090215.GA3954@opensource.wolfsonmicro.com>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
	<1337932416.1580.2.camel@vkoul-udesk3>
	<20120525080500.GB24149@n2100.arm.linux.org.uk>
	<CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
	<20120525094231.GC24149@n2100.arm.linux.org.uk>
	<CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
	<1338268734.1580.26.camel@vkoul-udesk3>
	<20120529073334.GA12217@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0912357551997404471=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8501B103E82
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2012 11:02:17 +0200 (CEST)
In-Reply-To: <20120529073334.GA12217@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0912357551997404471==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h31gzZEtNLTqOjlF"
Content-Disposition: inline


--h31gzZEtNLTqOjlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 29, 2012 at 08:33:34AM +0100, Russell King - ARM Linux wrote:

> But, as I pointed out earlier, there's the issue of using the wrong
> struct device to allocate memory for the DMA engine.  That's something
> that my soc-dmaengine.c got _right_, and soc-dmaengine-pcm.c gets _wrong_.

What is the issue with the current code - it *looks* like you want to
use the component device for the DMA as the struct device with dmaengine
but I don't understand the issue that's created if we don't (and why
things appear to be working for people as they are).

--h31gzZEtNLTqOjlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxJB9AAoJEBus8iNuMP3dcJ0P/i7bueBg+s3n8F16aO9KAJWa
5ubaP8sXgT8YC+jPaJYcY4v5NGetOVUSC3F9Q9GgllvXyGpCvWyDoEtKLcm9l+At
Hfrcdc2pciFh5R/rpatlntVAbgeNCD7pEZaW7rDVDFb3bW0wcs6PI3eGoqt136iX
kgwvIviscOkFiCPdqiT4fwT/D1RCSvwTeULsVqU80eGTFoqadDcFU5eAB48CJZOx
VhLghpBoOucXrKJFS0/5DuZ0kemagghRbGjhSgTqYqTAhiDW3A1T6j/6Pr3KBh1O
Z81FfluIUihyrc16mTGFBUvJ164XPjFhlH1Yz8jZFXTDj83L9rpf5ftPF4MMNr8W
+MtLG/lEDPqsrwvYisypyRQ8mZGrFmvcjWDVpk5Zw8bMJvhSG9HD1+FxhFhwB0/p
cFGe/Q1XSjLuB+55bESqbWkH0/3faUhuApowVPghVKJnuecxKGMYifqMBIudiUNy
7W3KsANd5vTUYt3WuMgCMF88Y3TmAHImPQT0/BnDxrDorhnQWGxa5oAV3qLQ61or
nlUcfEOs31qIUDB+NXVkOw14qSutNrVwgI0BOrFS36FISWg7otL0X0D9kX5u9LX6
Q9bhtilvBkNANE5fb2OZxsq7qFjMKlqLgPoN0pA/uRm+ymU/X4MXSi5U6fn8OAQX
/eUVeEgPUiTFqrCS912n
=rkwO
-----END PGP SIGNATURE-----

--h31gzZEtNLTqOjlF--

--===============0912357551997404471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0912357551997404471==--
