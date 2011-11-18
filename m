From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH 1/2] ASoC: cs42l73: Unify the way to define
 bits of register
Date: Fri, 18 Nov 2011 12:57:35 -0600
Message-ID: <alpine.DEB.2.02.1111181251040.14745@heelrod.ad.cirrus.com>
References: <1321603513.7338.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 5416A24381
	for <alsa-devel@alsa-project.org>; Fri, 18 Nov 2011 19:59:05 +0100 (CET)
In-Reply-To: <1321603513.7338.3.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Brian Austin <brian.austin@cirrus.com>, Vinod Koul <vinod.koul@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Georgi Vlaev <joe@nucleusys.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org



On Fri, 18 Nov 2011, Axel Lin wrote:

> Current code defines some bits with left shift to the proper bit defined in
> datasheet, but some don't.
> Unify the definition with proper left shift and adjust the code accordingly.
>
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> Hi,
> I don't have this hardware handy.
> I'd appreciate if someone can test this serial of patches.
>
> Thanks
> Axel

Tested both and it works great. The style is much better too :)
Thanks,

Acked-by: Brian Austin <brian.austin@cirrus.com>
