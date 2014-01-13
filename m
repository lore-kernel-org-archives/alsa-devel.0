From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: fix one bug to writing
 to the platform data
Date: Mon, 13 Jan 2014 09:09:43 +0000
Message-ID: <4ff4c32fbad64d90b0839a7a43642adb@BY2PR03MB505.namprd03.prod.outlook.com>
References: <20140110081729.035ce46f@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 by alsa0.perex.cz (Postfix) with ESMTP id 785302608C7
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 10:10:02 +0100 (CET)
In-Reply-To: <20140110081729.035ce46f@armhf>
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
To: Jean-Francois Moine <moinejf@free.fr>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "broonie@linaro.org" <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark, Jean-Francios

> If the original cinfo is not used anymore, the use of its structure to
> handle the card information is not a good idea:
> 
> - almost all cinfo information are in the struct snd_soc_card,
> 
> - this cinfo structure cannot be extended to handle many DAI links,
> 
> - it contains simple-card information which are of no use for the
>   platform caller.
> 
> So, I'd rather have seen:
> 
> - the removal of 'snd_link' and 'snd_card' from the platform interface
>   (struct asoc_simple_card_info),
> 
> - the definition of a local struct simple_card_data containing the
>   struct snd_soc_card and a pointer to an array of fmt/sysclk values
>   (one per DAI link).
>

@Jean-Francios, apart from this separate issue we're discussing, do you have
any comment on this patch itself?

@Mark, Since what Jean-Francios is concerned by is another issue apart from
this patch itself and being discussed, can you apply the patch?

Thanks,

--
Best Regards,
Xiubo
