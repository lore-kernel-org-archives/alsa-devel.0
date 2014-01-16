From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: Problems with simple-card
Date: Thu, 16 Jan 2014 03:47:58 +0000
Message-ID: <81eea230fdfa45bfa6d1f9d2b941221e@BY2PR03MB505.namprd03.prod.outlook.com>
References: <20140115191831.5965d17e@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0153.outbound.protection.outlook.com [207.46.163.153])
 by alsa0.perex.cz (Postfix) with ESMTP id D3B22265050
 for <alsa-devel@alsa-project.org>; Thu, 16 Jan 2014 04:48:03 +0100 (CET)
In-Reply-To: <20140115191831.5965d17e@armhf>
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
To: Jean-Francois Moine <moinejf@free.fr>, "broonie@kernel.org" <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

> I did a mistake in the v1 of my 'ASoC: simple-card: simplify code': I
> did not initialize the pointer to the asoc_simple_card_dai_init()
> function when DT. Then, I fixed that, and the simple card does not work
> for me.
> 
> First, without any 'format' in the DT, I get a fmt for each CPU / CODEC
> DAI: SND_SOC_DAIFMT_CBS_CFS is always set. Well, some code is executed
> for nothing, but this is not critical.
> 

This is the old issue that I have raised before, which is one limitation
of snd_soc_of_parse_daifmt(). As descript above, if without any fmt in the
DT node, and just using snd_soc_of_parse_daifmt() for each CPU/CODEC DAI fmt
the SND_SOC_DAIFMT_CBS_CFS (none zero) is always set.

@Mark and Morimoto-san, there has two ways to deal with this in my mind:
Fist, in the snd_soc_of_parse_daifmt(), modifying the
boolen : "[prefix]bitclock-master"
boolen : "[prefix]frame-master"
	==> 
[prefix]master = "XXX" and "XXX" is :
"cbm-cfm" --> SND_SOC_DAIFMT_CBM_CFM          
"cbs-cfm" --> SND_SOC_DAIFMT_CBS_CFM          
"cbm-cfs" --> SND_SOC_DAIFMT_CBM_CFS          
"cbs-cfs" --> SND_SOC_DAIFMT_CBS_CFS         

And the default value will be zero...

If this method is applied, and there is no need any masks for
snd_soc_of_parse_daifmt(), like in simple card driver:

/* get CPU/CODEC common format via simple-audio-card,format */
info->daifmt = snd_soc_of_parse_daifmt(node, "simple-audio-card,") &
           (SND_SOC_DAIFMT_FORMAT_MASK | SND_SOC_DAIFMT_INV_MASK);

Second, if there hasn't any DAI fmts in DT node and at the same time the CPU
and CODEC DAI devices don't need to care about of them, and set_dai() pointer
could be set to be NULL, and then snd_soc_dai_set_fmt() just returned -ENOTSUPP.


Thanks,
