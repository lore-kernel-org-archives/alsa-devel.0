From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH v4 3/7] ASoC: da7210: Add support for mute
 and zero cross controls
Date: Tue, 18 Oct 2011 13:08:42 +0100
Message-ID: <20111018120841.GA28501@opensource.wolfsonmicro.com>
References: <1318670595.613.42.camel@matrix>
 <20111017214242.GD5200@opensource.wolfsonmicro.com>
 <1318938548.13721.23.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1318938548.13721.23.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: lrg <lrg@ti.com>, alsa-devel <alsa-devel@alsa-project.org>, David Dajun Chen <david.chen@diasemi.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 18, 2011 at 05:19:08PM +0530, Ashish Chavan wrote:

> 	SOC_DOUBLE_R("Mic Capture Switch", ...),
> 	SOC_SINGLE("Aux2 Capture Switch", ...),

> Now I have realized that this may cause a naming conflict with my
> "mic_aux_inpga" patch, which I am going to submit after DAPM issues get
> sorted. In "mic aux inpga" patch there are controls for Mic and Aux2
> volume control,

> 	SOC_DOUBLE_R_TLV("Mic Capture Volume", ...),
> 	SOC_SINGLE_TLV("Aux2 Capture Volume", ...),

> As per my view, "Mic Capture Volume" is correct name for Mic volume
> control and we need to change name for Mic mute control. Do you agree?
> If yes, any suggestion for the name of Mic mute control?

I don't see any conflict in the above?
