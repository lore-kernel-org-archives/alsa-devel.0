From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: Re: [PATCH] ASoC: simple-card: remove snd_link and
 snd_card from struct asoc_xx_info
Date: Mon, 13 Jan 2014 10:28:11 +0000
Message-ID: <c61852edec5444aea13d5096804a9901@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1389358557-2214-1-git-send-email-Li.Xiubo@freescale.com>
 <20140113085648.0fbcf63b@armhf>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0149.outbound.protection.outlook.com [207.46.163.149])
 by alsa0.perex.cz (Postfix) with ESMTP id 5353B26089A
 for <alsa-devel@alsa-project.org>; Mon, 13 Jan 2014 11:28:15 +0100 (CET)
In-Reply-To: <20140113085648.0fbcf63b@armhf>
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
To: Jean-Francois Moine <moinejf@free.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


> I don't agree your code: you should not use the cinfo anymore, but
> rather move the information it contains to the sound card structure.
> 
> Then, you use a static variable as the card structure. It is not
> possible to extend this table to handle many DAI links, and, as not
> re-entrant, the driver cannot create many sound cards.
> 

Yes, that's right.

Thanks,

--
Best Regards,
Xiubo
