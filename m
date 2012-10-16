From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/2] ASoC: atmel-ssc: use module_platform_driver macro
Date: Tue, 16 Oct 2012 10:07:48 +0100
Message-ID: <20121016090748.GX21164@n2100.arm.linux.org.uk>
References: <1350359819-2461-1-git-send-email-voice.shen@atmel.com> <1350359819-2461-2-git-send-email-voice.shen@atmel.com> <507D15C2.7000606@atmel.com> <20121016084947.GD12801@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121016084947.GD12801@game.jcrosoft.org>
Sender: linux-sound-owner@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Wolfram Sang <w.sang@pengutronix.de>, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 16, 2012 at 10:49:47AM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:07 Tue 16 Oct     , Nicolas Ferre wrote:
> > On 10/16/2012 05:56 AM, Bo Shen :
> > > -static int __init ssc_probe(struct platform_device *pdev)
> > > +static int ssc_probe(struct platform_device *pdev)
> > 
> > Here you remove the __init altogether, maybe converting to __devinit is
> > the proper replacement for this? I do not know myself but if anybody knows?
> yes __devinit is mandatory

No it isn't.  __init is plain buggy.  __devinit is better, but there's
plans to remove all __devinit from the kernel.  Having nothing there
will make GregKH's life a lot easier when he does come to remove __devinit.
