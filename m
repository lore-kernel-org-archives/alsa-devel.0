From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC - Add support for upto 16 channels on
 OMAP MCBSP
Date: Thu, 5 Nov 2009 21:28:22 +0200
Message-ID: <20091105212822.2fab9974.jhnikula@gmail.com>
References: <1257357235.2887.499.camel@odin>
	<20091104185534.GA22055@xora.vm.bytemark.co.uk>
	<1257364009.2887.665.camel@odin>
	<20091105095143.995beeea.jhnikula@gmail.com>
	<1257432930.3603.902.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 8FC76103969
	for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2009 20:27:25 +0100 (CET)
Received: by bwz9 with SMTP id 9so796750bwz.32
	for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2009 11:27:24 -0800 (PST)
In-Reply-To: <1257432930.3603.902.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 05 Nov 2009 14:55:30 +0000
Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> I've reworked this myself now. It does appear that the current FPER
> calculations assume BCLK scales with rate 
> 
> i.e. BCLK = rate * channels * word len
> 
> This is fine for when McBSP is FRM/BCLK slave (all users except pandora)
> as FPER should be ignored internally.
> 
> However, when BCLK is constant (e.g. McBSP BCLK derived from constant
> source) and we run McBSP as FRM/BCLK master we currently break our
> sample rate generation.
> 
This is true, currently possibilities to get standard sample rates as
accurately as possible when using McBSP as a master and when using
fixed sample rate generator input clock (CLKSRG) are too much limited.
So the period size adjustment is a good improvement.

CLKSRG can take its input from internal fixed 96 MHz, CLKS pin, CLKR
pin, CLKX pin or internal interface clock (proprotional to CPU freq).

> Imho, it's better to generate FPER based upon BCLK and rate. e.g. we
> calculate the frame size required for the given BCLK and rate.
> 
Yep.

Actually BCLK doesn't have to be fixed as it is derived by dividing the
CLKSRG with CLKGDV. This can allow to optimize the BCLK and frame size
to be smaller when CLKSRG >> BCLK.

Would be nice if both the divider and frame size are calculated
dynamically based on CLKSRG frequency and sample rate.

> I'm now slightly curious about how pandora handles different rates since
> it uses the McBSP in master mode too. I guess they can only handle a
> single sample rate ?
> 
IRCC correctly the external master clock used in Pandora was derived
from the codec and that clock was following the sample rate.


-- 
Jarkko
