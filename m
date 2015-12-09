From: Zidan Wang <zidan.wang@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: imx-wm8958: add imx-wm8958
 machine driver
Date: Wed, 9 Dec 2015 11:34:52 +0800
Message-ID: <20151209033449.GA30401@shlinux2>
References: <1430be98728abfe543d9a1e245d9b80f6d8f3c44.1449567072.git.zidan.wang@freescale.com>
 <20151208124713.GQ5727@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0138.outbound.protection.outlook.com [157.56.111.138])
 by alsa0.perex.cz (Postfix) with ESMTP id DC6B1260560
 for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2015 04:38:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151208124713.GQ5727@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: nicoleotsuka@gmail.com, alsa-devel@alsa-project.org, timur@tabi.org, Xiubo.Lee@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2015 at 12:47:13PM +0000, Mark Brown wrote:
> On Tue, Dec 08, 2015 at 05:40:13PM +0800, Zidan Wang wrote:
> 
> > + - aifx-format             : set format for aifx, such as "i2s", "left_j",
> > +			     "dsp_a", "dsp_b".
> 
> > + - aifx-bitclock-master    : If present, aifx wroks as bit clock master.
> > +			     Otherwise, aifx works as bit clock slave.
> 
> > + - aifx-frame-master	   : If present, aifx wroks as frame clock master.
> > +			     Otherwise, aifx works as frame clock slave.
> 
> > + - aifx-bitclock-inversion : If present, bit clock will invert polarity.
> 
> > + - aifx-frame-inversion	   : If present, frame clock will invert polarity.
> 
> > + - aifx-continuous-clock   : If present, bit clock will be continuous.
> > +			     Otherwise, dai bit clocks can be be gated
> > +			     (disabled) when the dai is not sending or
> > +			     receiving PCM data in a frame.
> 
> Why are these selectable in the machine driver?
I have tested and found that sai<->aif1 can support "i2s" "left_j"
"dsp_a" "dsp_b" format, and can support cpu dai master and slave
mode. But I haven't tested voice dai and bt dai because of hardware
limitation. I just using sai<->aif2 to test aif2.

So I want to configure the dai format from device tree. And there is
a help function snd_soc_of_parse_daifmt for me to do this, so I add
these selectable to the machine driver.

> 
> > +		model = "wm8960-audio";
> 
> Cut'n'paste error here.

it should be "wm8958-audio", i will modify it.


Best Regards,
Zidan Wang
