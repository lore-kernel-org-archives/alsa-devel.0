From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH] ASoC: simple-card: cleanup asoc_simple_card_parse_of()
 code
Date: Tue, 31 Dec 2013 01:41:02 +0000
Message-ID: <c497d85dd348417fae4ae369d761f098@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
 <20131230121113.GQ31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>, Mark Brown <broonie@kernel.org>
Cc: "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "perex@perex.cz" <perex@perex.cz>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,


> -----
> 	......
> 
>         /* get CPU/CODEC common format via simple-audio-card,format */
>         info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
>                 (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);
> 
> 	......
> 
> 		ret = asoc_simple_card_sub_parse_of(cpu, ...);
> 
> 		...
> 
> 		ret = asoc_simple_card_sub_parse_of(codec, ...);
> 
> 	......
> -----
> The SND_SOC_DAIFMT_INV_MASK bits mask should be for "bitclock-master" and

Sorry the "bitclock-master" should be "bitclock-inversion" just for written
Mistake.



> "frame-inversion" in subnodes' daifmt parsing if need, or why shouldn't
> SND_SOC_DAIFMT_CLOCK_MASK be here like SND_SOC_DAIFMT_INV_MASK ?
> 
> IMO, the SND_SOC_DAIFMT_INV_MASK bits mask here maybe a little confused.
> 
> Certainly, these two and other subnode properties can also be common
> properties
> like "[prefix]format" for other drivers.
> 
> It's the limitation of snd_soc_of_parse_daifmt() that the simple-card driver
> must
> do the mask(except SND_SOC_DAIFMT_MASTER_MASK, because it default value is not
> zero)
> operation.
> 
> Or should we change "bitclock-master" and "frame-master" as one string
> property
> like "[prefix]master = XXX", and set the default value as zero like others.
> And then
> we can remove all the bits mask operations in simple-card and other drivers.
> If need, I will send this patch of this.
> 

 Thanks,
 
 --
 Best Regards,
 Xiubo
