From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: fsl-sai: convert to use regmap API
 for Freeacale SAI
Date: Thu, 23 Jan 2014 10:32:57 +0000
Message-ID: <b073a0513dd04d4b99177b2f2c3a8eb5@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1390463283-7545-1-git-send-email-Li.Xiubo@freescale.com>
 <CAOMZO5ATVkcORZBMbNzu2F-dyJxjzgjkRgezj2vGM9v7cyfy1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0150.outbound.protection.outlook.com [207.46.163.150])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FBBF265185
 for <alsa-devel@alsa-project.org>; Thu, 23 Jan 2014 11:33:02 +0100 (CET)
In-Reply-To: <CAOMZO5ATVkcORZBMbNzu2F-dyJxjzgjkRgezj2vGM9v7cyfy1w@mail.gmail.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, "guangyu.chen@freescale.com" <guangyu.chen@freescale.com>
List-Id: alsa-devel@alsa-project.org


> >  static int fsl_sai_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
> >                 int clk_id, unsigned int freq, int dir)
> >  {
> > -       struct fsl_sai *sai = snd_soc_dai_get_drvdata(cpu_dai);
> >         int ret;
> >
> >         if (dir == SND_SOC_CLOCK_IN)
> >                 return 0;
> >
> > -       ret = clk_prepare_enable(sai->clk);
> > -       if (ret)
> > -               return ret;
> 
> The clock related change seems unrelated to the usage of regmap, right?
> 
 
The clock operations in the driver is only related to the module clock, and has
move to the regmap core and regmap core will to the same clock operations at 
proper time, since we are using:

+	sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
+			"sai", base, &fsl_sai_regmap_config);


Thanks,

Best Regards,
Xiubo
