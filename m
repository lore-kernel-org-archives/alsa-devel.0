From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx-ssi: Fix mono playback
Date: Mon, 6 Aug 2012 23:25:31 +0100
Message-ID: <20120806222530.GG26698@opensource.wolfsonmicro.com>
References: <1344281785-22478-1-git-send-email-fabio.estevam@freescale.com>
 <20120806195438.GD16199@opensource.wolfsonmicro.com>
 <CAOMZO5B15kcUziVCMBctGdFmx6xkTqby1-cE+arVUJSXosDU-A@mail.gmail.com>
 <CAOMZO5AekbYTnrSM+jK_PBeHDx6vKT4DbxbuXhUwA6uD3PAZFQ@mail.gmail.com>
 <20120806220136.GE26698@opensource.wolfsonmicro.com>
 <CAOMZO5AsS2sxUdo1aKXvtwetTr1LB31W6aJBVnGuVGAHPXmuZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 300FE265E16
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2012 23:55:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AsS2sxUdo1aKXvtwetTr1LB31W6aJBVnGuVGAHPXmuZQ@mail.gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, kernel@pengutronix.de, gcembed@gmail.com
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 06, 2012 at 07:10:07PM -0300, Fabio Estevam wrote:
> On Mon, Aug 6, 2012 at 7:01 PM, Mark Brown

> > Is the device using I2S?  I2S doesn't really support stero properly...

> The format is:

> #define FMT_SSI (SND_SOC_DAIFMT_DSP_A | SND_SOC_DAIFMT_NB_NF | \
> 		SND_SOC_DAIFMT_CBM_CFM)

No, then.

> Maybe I should do something similar in imx-mc13783?

That's cut'n'paste since before my time, and the comment about it being
something the SSI driver ought to do does apply.  But it's worth trying.
