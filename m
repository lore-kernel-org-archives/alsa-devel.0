From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 12:14:33 +0800
Message-ID: <20120316041428.GA7772@S2101-09.ap.freescale.net>
References: <20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
	<20120316020111.GE6065@S2101-09.ap.freescale.net>
	<4F62A06C.5000304@freescale.com>
	<20120316022345.GA7632@S2101-09.ap.freescale.net>
	<4F62B729.2090902@freescale.com>
	<20120316035254.GF6065@S2101-09.ap.freescale.net>
	<4F62BCBE.7030806@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id EFC3E1046ED
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 05:14:02 +0100 (CET)
Received: by iakh37 with SMTP id h37so5464851iak.38
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 21:14:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F62BCBE.7030806@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 16, 2012 at 04:08:32AM +0000, Tabi Timur-B04825 wrote:
> Shawn Guo wrote:
> > But it's instantiated as a dmaengine device backed by dmaengine driver
> > drivers/dma/imx-dma.c.  "imx-pcm-audio" will just be an ASoC dmaengine
> > client using dmaengine API.
> 
> So you don't have the equivalent of sound/soc/fsl_dma.c?  Don't you need 
> to program the DMA controller specifically for audio?  There's no way I 
> could use drivers/dma/fsldma.c for audio.
> 
I need to program the DMA controller for audio.  But that's done through
generic dmaengine API with audio specific parameters passed in.  That's
pretty much what all snd_imx_pcm_hw_params (sound/soc/fsl/imx-pcm-dma.c)
does there.

-- 
Regards,
Shawn
