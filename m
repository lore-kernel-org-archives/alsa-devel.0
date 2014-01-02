From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: cleanup
 asoc_simple_card_parse_of() code
Date: Thu, 2 Jan 2014 09:26:50 +0000
Message-ID: <f91162146c844cf79694b1b3880fd926@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1388114078-24517-1-git-send-email-Li.Xiubo@freescale.com>
 <20131230121113.GQ31886@sirena.org.uk>
 <4c44077c52604d0b85c4babb59268eb7@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131231122036.GM31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 5B6D4261651
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 10:26:56 +0100 (CET)
In-Reply-To: <20131231122036.GM31886@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


> Subject: Re: [PATCH] ASoC: simple-card: cleanup asoc_simple_card_parse_of()
> code
> 
> On Tue, Dec 31, 2013 at 03:27:53AM +0000, Li.Xiubo@freescale.com wrote:
> 
> > Also, for most of the devices of the same DAI link, they use the same DAI
> > formats, but I have found some drivers like : "sound/soc/pxa/magician.c"
> > and "sound/soc/s6000/s6105-ipcam.c", etc, may have different DAI format
> > settings for some reasons(maybe some formats are the CPU/Codec devices
> > default setting that it needn't set it here or others).
> 
> The ipcam still has that?  

	-----------
        /* set codec DAI configuration */
        ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
                                             SND_SOC_DAIFMT_CBM_CFM);
        if (ret < 0)
                return ret;

        /* set cpu DAI configuration */
        ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_CBM_CFM |
                                           SND_SOC_DAIFMT_NB_NF);
        if (ret < 0)
                return ret;
	----------

 ... ?

> 
> > I think maybe this is also the reason why the simple-card has common DAI
> > format and CPU/CODEC private DAI formats at the same time.
> 
> I'd really want to see a real use case that actually was a simple card.

I'm also still trying.


Thanks,

--
Best Regards,
Xiubo
