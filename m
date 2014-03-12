From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: simple-card: overwrite DAIFMT_MASTER
 of	cpu_dai->fmt
Date: Wed, 12 Mar 2014 11:26:58 +0800
Message-ID: <20140312032657.GF1177@MrMyself>
References: <1394542472-16580-1-git-send-email-Guangyu.Chen@freescale.com>
 <8761nkryky.wl%kuninori.morimoto.gx@gmail.com>
 <20140312014927.GK28112@sirena.org.uk>
 <874n34rsul.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <874n34rsul.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, moinejf@free.fr, alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

Hi Morimoto-san,

On Tue, Mar 11, 2014 at 08:36:22PM -0700, Kuninori Morimoto wrote:
> 
> Hi Mark
> 
> > > > asoc-simple-card sound-cs42888.12: cpu : 2024000.esai / 4003 / 132000000
> > > > asoc-simple-card sound-cs42888.12: codec : cs42888 / 1003 / 24576000
> > > > asoc-simple-card sound-cs42888.12: cs42888 <-> 2024000.esai mapping ok
> > 
> > > cpu   = 4003 : SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_LEFT_J
> > > codec = 1003 : SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_LEFT_J
> > 
> > > codec is master, cpu is slave...
> > > what is problem ??
> > > Am I misunderstanding ?
> > 
> > The C in those constants stands for CODEC and the values should be
> > identical for both ends of the link.
> 
> Wow ! really ??
> Then, is this settiting wrong ??
> 
> ${LINUX}/arch/arm/mach-shmobile/board-armadillo800eva.c :: fsi_wm8978_info
> 
> static struct asoc_simple_card_info fsi_wm8978_info = {
> 	...
> 	.daifmt		= SND_SOC_DAIFMT_I2S,
> 	.cpu_dai = {
> 		...
> 		.fmt	= SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_IB_NF,
> 	},
> 	.codec_dai = {
> 		...
> 		.fmt	= SND_SOC_DAIFMT_CBM_CFM | SND_SOC_DAIFMT_NB_NF,
> 	},
> };
> 
> It should be like this ?
> 
> static struct asoc_simple_card_info fsi_wm8978_info = {
> 	...
> 	.daifmt		= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
> 	.cpu_dai = {
> 		...
> 		.fmt	= SND_SOC_DAIFMT_IB_NF,
> 	},
> 	.codec_dai = {
> 		...
> 		.fmt	= SND_SOC_DAIFMT_NB_NF,
> 	},
> };

This would be better imo.

And ideally we should also keep the xB_xF identical like Mark said _identical_.
Just some cpu dai drivers might do an incorrect settings for it, like regarding
NB as sampling on rising edge and IF as active low (I'm saying this without a
careful check though), which results people need to re-set bitclock-invert and
frame-invert if they switch the DAI format from left_j to i2s for example.

Thank you,
Nicolin Chen
