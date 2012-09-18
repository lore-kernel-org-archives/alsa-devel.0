From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 1/2] ASoC: fsl_ssi: Let it understand mono
Date: Tue, 18 Sep 2012 11:14:15 -0500
Message-ID: <50589DD7.8050409@freescale.com>
References: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 by alsa0.perex.cz (Postfix) with ESMTP id A87F02650D2
 for <alsa-devel@alsa-project.org>; Tue, 18 Sep 2012 18:14:20 +0200 (CEST)
In-Reply-To: <1347984234-9275-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, javier.martin@vista-silicon.com
List-Id: alsa-devel@alsa-project.org

Fabio Estevam wrote:
> 
> Can you please try to play a mono track on your PowerPC platform with these 
> series applied?

I'm pretty sure this won't work.  The SSI is programmed to expect a left
and right sample.  There is no code in fsl_ssi.c for checking the channel
count and adjusting the hardware accordingly.  I don't see any code like
that in imx-ssi.c either, so I don't even know how it's supposed to work.

-- 
Timur Tabi
Linux kernel developer at Freescale
