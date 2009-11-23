From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 06/12] imx-ssi sound driver
Date: Mon, 23 Nov 2009 13:10:55 +0100
Message-ID: <20091123121055.GE30179@pengutronix.de>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fmmailgate01.web.de (fmmailgate01.web.de [217.72.192.221])
	by alsa0.perex.cz (Postfix) with ESMTP id 79081103807
	for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2009 13:10:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 21, 2009 at 08:12:34PM -0600, Timur Tabi wrote:
> On Thu, Nov 19, 2009 at 9:48 AM, Sascha Hauer <s.hauer@pengutronix.de> wr=
ote:
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> > =A0arch/arm/plat-mxc/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A01 +
> > =A0arch/arm/plat-mxc/include/mach/ssi.h | =A0 17 +
> > =A0arch/arm/plat-mxc/ssi-fiq.S =A0 =A0 =A0 =A0 =A0| =A0134 ++++
> > =A0sound/soc/imx/devdma.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 80 ++
> > =A0sound/soc/imx/devdma.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A03 +
> > =A0sound/soc/imx/imx-ssi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| 1349 ++++++++++=
++++++++++++++++++++++++
> > =A0sound/soc/imx/imx-ssi.h =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +
> =

> Why did you write a new SSI driver when there already is one in sound/soc=
/fsl?

Mainly because I wasn't aware of the fact that the fsl driver is the
same :(

I'm currently looking if and how the code can be merged. I don't know if
it's worth it though since the common code doesn't seem to be very big.

There will have to be some changes in the fsl-ssi driver. For example I
need the irq handler for my fiq handler which means that the fsl-ssi
driver is not allowed to request the irq for it's statistic. The other
thing is the hardware accesses as we do not have in_be*, out_be* and
setbits/clrbits. Of course all these things are doable and shouldn't be
a showstopper.

Sascha

-- =

Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
