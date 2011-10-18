From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: [PATCH v4 3/7] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Tue, 18 Oct 2011 17:59:03 +0530
Message-ID: <1318940943.13721.25.camel@matrix>
References: <1318670595.613.42.camel@matrix>
	<20111017214242.GD5200@opensource.wolfsonmicro.com>
	<1318938548.13721.23.camel@matrix>
	<20111018120841.GA28501@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 291BB2451E
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Oct 2011 14:20:07 +0200 (CEST)
In-Reply-To: <20111018120841.GA28501@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>, David@alsa-project.org, Chen <david.chen@diasemi.com>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-10-18 at 13:08 +0100, Mark Brown wrote:
> On Tue, Oct 18, 2011 at 05:19:08PM +0530, Ashish Chavan wrote:
> 
> > 	SOC_DOUBLE_R("Mic Capture Switch", ...),
> > 	SOC_SINGLE("Aux2 Capture Switch", ...),
> 
> > Now I have realized that this may cause a naming conflict with my
> > "mic_aux_inpga" patch, which I am going to submit after DAPM issues get
> > sorted. In "mic aux inpga" patch there are controls for Mic and Aux2
> > volume control,
> 
> > 	SOC_DOUBLE_R_TLV("Mic Capture Volume", ...),
> > 	SOC_SINGLE_TLV("Aux2 Capture Volume", ...),
> 
> > As per my view, "Mic Capture Volume" is correct name for Mic volume
> > control and we need to change name for Mic mute control. Do you agree?
> > If yes, any suggestion for the name of Mic mute control?
> 
> I don't see any conflict in the above?
> 

If I add these two, alsamixer and amixer shows only one of them (one
which is added first). Is that fine?

I guess the token here is only "Mic" and "Aux2".
