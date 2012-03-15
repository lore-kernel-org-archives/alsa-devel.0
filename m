From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4] ASoC: add imx-sgtl5000 machine driver
 working with fsl_ssi
Date: Thu, 15 Mar 2012 10:52:31 +0100
Message-ID: <20120315095230.GZ3852@pengutronix.de>
References: <1331553537-19789-1-git-send-email-shawn.guo@linaro.org>
	<20120314090115.GN3852@pengutronix.de>
	<4F612394.4060703@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 7C1AC10B8D1
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 10:52:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4F612394.4060703@freescale.com>
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
Cc: alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 14, 2012 at 06:02:44PM -0500, Timur Tabi wrote:
> Sascha Hauer wrote:
> > What are the next steps here? Now we have fsl_ssi.c and imx-ssi.c, one
> > for dt bindings and the other one for platform bindings and also AC97
> > support. They should probably get merged some day which might be a bit
> > difficult since currently I don't see the platform users moving over
> > to devicetree and the seem to be no AC97 users in powerpc.
> 
> I don't have any problem with adding AC97 support to fsl_ssi.c, assuming
> it's not a huge mess.  I don't know enough about AC97 to know how easy
> that is, though.

>From the hardware side it's basically calling setup_channel_to_ac97()
and providing AC97 register read/write functions. One ugly detail is
that we need a bus reset function. This basically means putting the
pins in gpio mode and issuing the reset manually. The SSI unit does
not provide a way to reset the bus.
I don't know how this AC97 stuff integrates into the devicetree. Anyway,
that's a topic for future discussions and shouldn't block the current
patches. I just want to make sure that the original imx-ssi driver is
not removed as long as the fsl_ssi driver does not have AC97 support.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
