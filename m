From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v3 9/9] ARM: DTS: imx5* imx6*, use imx51-ssi
Date: Wed, 18 Dec 2013 15:10:06 +0100
Message-ID: <20131218141006.GA23493@pengutronix.de>
References: <1387367865-26391-1-git-send-email-mpa@pengutronix.de>
 <1387367865-26391-10-git-send-email-mpa@pengutronix.de>
 <20131218135826.GC7172@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 28569261664
 for <alsa-devel@alsa-project.org>; Wed, 18 Dec 2013 15:10:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131218135826.GC7172@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 18, 2013 at 09:58:30PM +0800, Shawn Guo wrote:
> On Wed, Dec 18, 2013 at 12:57:45PM +0100, Markus Pargmann wrote:
> > imx51-ssi and imx21-ssi are different IPs. imx51-ssi supports online
> > reconfiguration and needs this for correct interaction with SDMA. This
> > patch adds imx51-ssi before each imx21-ssi for all imx5/imx6 SoCs.
> > 
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx51.dtsi   |  3 ++-
> >  arch/arm/boot/dts/imx53.dtsi   | 10 +++++++---
> >  arch/arm/boot/dts/imx6qdl.dtsi | 12 +++++++++---
> >  arch/arm/boot/dts/imx6sl.dtsi  | 12 +++++++++---
> >  4 files changed, 27 insertions(+), 10 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> > index 4bcdd3a..1496421 100644
> > --- a/arch/arm/boot/dts/imx51.dtsi
> > +++ b/arch/arm/boot/dts/imx51.dtsi
> > @@ -155,7 +155,8 @@
> >  				};
> >  
> >  				ssi2: ssi@70014000 {
> > -					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
> > +					compatible = "fsl,imx51-ssi",
> > +							"fsl,imx21-ssi";
> 
> This is an unnecessary change.
> 
> Shawn

Thank you, fixed.

Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
