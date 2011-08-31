From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry
 checking for each DAIs separately
Date: Wed, 31 Aug 2011 11:55:39 +0000
Message-ID: <4E5E213A.8040909@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
	<CAOZdJXXzMgET+gDknrRBv_yFENrzJe+oFPN7_o7RisBLUhw0Rw@mail.gmail.com>
	<65EE16ACC360FA4D99C96DC085B3F77222AE40@039-SN1MPN1-001.039d.mgd.msft.net>
	<4E5E1285.8020508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EC972479F
	for <alsa-devel@alsa-project.org>;
	Wed, 31 Aug 2011 13:55:43 +0200 (CEST)
In-Reply-To: <4E5E1285.8020508@ti.com>
Content-Language: en-US
Content-ID: <EDB5B4A8C03DC441B7F67126269898C3@freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, Dong Aisheng-B29396 <B29396@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Liam Girdwood wrote:
> Timur, iirc your driver has some special symmetry requirement (maybe something todo with having 2 DAIs) ?
>
> I assume this is OK for you too ?

Yes, that's why I was asking.  I believe I'm affected by this patch as 
well, so I will test it.  However, I never noticed a problem before, so 
I'm not sure what's going on.

-- 
Timur Tabi
Linux kernel developer at Freescale
