From: Hugo Villeneuve <hugo@hugovil.com>
Subject: Re: [PATCH 1/1] ASoC: Fix compilation error with
 davinci-sffsdr module
Date: Fri, 16 Jan 2009 12:05:38 -0500
Message-ID: <20090116120538.7ec3f3d8.hugo@hugovil.com>
References: <1231277025-2100-1-git-send-email-hugo@hugovil.com>
	<20090106213116.GA3549@sirena.org.uk>
	<20090106164120.bd2fb16b.hugo@hugovil.com>
	<20090106220005.GB3549@sirena.org.uk>
	<20090114155406.a086c6ef.hugo@hugovil.com>
	<20090115111806.GB2147@sirena.org.uk>
	<20090115145454.17178d53.hugo@hugovil.com>
	<20090115200121.GH12768@sirena.org.uk>
	<496FB439.1090900@boundarydevices.com>
	<20090115172818.8a216670.hugo@hugovil.com>
	<496FBDCC.7030604@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.hugovil.com (201-217-static-ppp.3menatwork.com
	[64.235.217.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 67BBE24386
	for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2009 18:05:41 +0100 (CET)
In-Reply-To: <496FBDCC.7030604@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 15 Jan 2009 15:50:52 -0700
Troy Kisky <troy.kisky@boundarydevices.com> wrote:

> Hugo Villeneuve wrote:
> > On Thu, 15 Jan 2009 15:10:01 -0700
> > Troy Kisky <troy.kisky@boundarydevices.com> wrote:
> > 
> >>> Hopefully a comparison of the mainline and DaVinci trees will show
> >>> something...
> >> In davinci-sffsdr.c I see
> >>
> >> 	ret = snd_soc_dai_set_fmt(cpu_dai,
> >> 				  SND_SOC_DAIFMT_RIGHT_J |
> >> 				  SND_SOC_DAIFMT_CBM_CFS |
> >> 				  SND_SOC_DAIFMT_IB_NF);
> >>
> >> When I changed the evm board flags passed, I didn't change this
> >> file. So, you'll need something like
> >>
> >> 	ret = snd_soc_dai_set_fmt(cpu_dai,
> >> 				  SND_SOC_DAIFMT_DSP_A |
> >> 				  SND_SOC_DAIFMT_CBM_CFS |
> >> 				  SND_SOC_DAIFMT_NB_NF);
> > 
> 
> 
> 
> Actually, that should be
> 
>  	ret = snd_soc_dai_set_fmt(cpu_dai,
>  				  SND_SOC_DAIFMT_DSP_B |
>  				  SND_SOC_DAIFMT_CBM_CFS |
>  				  SND_SOC_DAIFMT_NB_NF);
> 
> 
> I had dsp_a and dsp_b backwards again.

Hi Troy,
Finally the problem was hardware related. The PLL feeding the clocks
to the ASP was dead, so that is why the DMA were never triggered. I
replaced it and everything is working fine now, using my original
config:
   SND_SOC_DAIFMT_RIGHT_J |
   SND_SOC_DAIFMT_CBM_CFS |
   SND_SOC_DAIFMT_IB_NF);

Mark: this also means that the latest davinci git tree has
working audio support (without needing any DMA patch) :)

Thank-you all, Hugo.

---------------
Hugo Villeneuve
www.hugovil.com
---------------
