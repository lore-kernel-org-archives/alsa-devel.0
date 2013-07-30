From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH] ASoC: fsl: Fix module build
Date: Tue, 30 Jul 2013 23:48:23 +0800
Message-ID: <20130730154820.GA18761@S2101-09.ap.freescale.net>
References: <1375133852-15248-1-git-send-email-festevam@gmail.com>
 <20130730075526.GE12382@S2101-09.ap.freescale.net>
 <CAOMZO5CZbPkhs=4q7pNGL9uWtTn8BUZRfpjVuvFFzYFvcx1TbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0189.outbound.messaging.microsoft.com [213.199.154.189])
 by alsa0.perex.cz (Postfix) with ESMTP id C5F2A26087A
 for <alsa-devel@alsa-project.org>; Tue, 30 Jul 2013 17:48:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5CZbPkhs=4q7pNGL9uWtTn8BUZRfpjVuvFFzYFvcx1TbA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, broonie@kernel.org, g.liakhovetski@gmx.de, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2013 at 09:53:21AM -0300, Fabio Estevam wrote:
> Hi Shawn,
> 
> On Tue, Jul 30, 2013 at 4:55 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > What tree?  I tested linux-next 20130730 and did not see the error.
> 
> Just tested it with linux-next 20130730 and could reproduce the error
> there as well.
> 
> You can apply the attached patch and you will see the error.

I see the difference here.  With my build, I only set CONFIG_SND_IMX_SOC
to 'm', while you set CONFIG_SND to 'm'.

As imx-pcm-fiq is only used by imx-ssi and imx-pcm-dma is pretty small,
I thought that it's not worth to build imx-pcm-fiq and imx-pcm-dma as
modules, and having them be 'bool' and then link them into imx-ssi
and fsl-ssi should also work.  But I see Markus is working on fsl-ssi
to adopt imx-pcm-fiq.  And imx-pcm-fiq is still big, it makes some sense
to build them as modules.  So,

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Shawn
