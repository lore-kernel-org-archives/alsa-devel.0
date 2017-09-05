From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
Date: Mon, 4 Sep 2017 22:20:32 -0700
Message-ID: <20170905052031.GB2774@Asurada-CZ80>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Majewski <lukma@denx.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "festevam@gmail.com" <festevam@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 03, 2017 at 04:40:21PM +0200, Łukasz Majewski wrote:
> >/*
> >* Hardware limitation: The bclk rate must be
> >* never greater than 1/5 IPG clock rate
> >*/
> >if (freq * 5 > clk_get_rate(ssi_private->clk)) {
> >dev_err(cpu_dai->dev, "bitclk > ipgclk/5\n");
> >return -EINVAL;
> >}
> >
> 
> Unfortunately not.
> 
> This is the part of fsl_ssi_set_bclk() function which is called after
> fsl_ssi_set_dai_sysclk() (which sets ssi_private->bitclk_freq = freq;).
> 
> Before the aforementioned check we do have:
> 
> 	if (ssi_private->bitclk_freq)
> 		freq = ssi_private->bitclk_freq;
> 	else
> 		freq = params_channels(hw_params) * 32 * 	params_rate(hw_params);
> 
> 
> Which assigns freq = bitclk_freq (66 MHz)
> 
[...]
> And then we break on this particular check:
> 66MHz * 5 > 66 MHz.
[...]

Does the check fail and return an error here, or not?

> The culprit IMHO is the  ssi_private->bitclk_freq = freq; in the
> fsl_ssi_set_dai_sysclk(), since we _should_ set SSI's IP block clock
> (ssi_private->clk), not the bit clock (BCLK).

No. We should not set the IP block clock. That's from IPG bus
on certain IMX SoCs. Setting it might change IPG bus clocks
which might break the system.

And apparently, we shouldn't set bitclk to 66MHz either. Can
you help to find where this 66MHz comes from?

> This patch just quits early if it detects change, which don't need to be
> done.

I kinda see your point is to error out before hw_params(). So
I feel it would be better to have a similar 5-times-check in
the set_sysclk() too, if it's really necessary.

Btw, I don't see simple card calling set_sysclk() function in
any earlier stage than hw_params(). I am wondering how did you
encounter the problem?

Thanks
Nicolin
