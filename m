From: Dong Aisheng-B29396 <B29396@freescale.com>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix wrong register name
	in restore
Date: Wed, 18 Jan 2012 06:09:00 +0000
Message-ID: <7FE21149F4667147B645348EC6057885093CC1@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1326866287-16283-1-git-send-email-zengzm.kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE008.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) by alsa0.perex.cz (Postfix) with ESMTP id 8649E244F7
	for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2012 07:09:10 +0100 (CET)
In-Reply-To: <1326866287-16283-1-git-send-email-zengzm.kernel@gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "zengzm.kernel@gmail.com" <zengzm.kernel@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "w.sang@pengutronix.de" <w.sang@pengutronix.de>, "julia.lawall@lip6.fr" <julia.lawall@lip6.fr>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "festevam@gmail.com" <festevam@gmail.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: zengzm.kernel@gmail.com [mailto:zengzm.kernel@gmail.com]
> Sent: Wednesday, January 18, 2012 1:58 PM
> To: alsa-devel@alsa-project.org
> Cc: Dong Aisheng-B29396; broonie@opensource.wolfsonmicro.com;
> julia.lawall@lip6.fr; festevam@gmail.com; w.sang@pengutronix.de;
> shawn.guo@linaro.org; lrg@ti.com; zengzm.kernel@gmail.com
> Subject: [PATCH v2] ASoC: sgtl5000: Fix wrong register name in restore
> Importance: High
> 
> From: Zeng Zhaoming <zengzm.kernel@gmail.com>
> 
> Correct SGTL5000_CHIP_CLK_CTRL to SGTL5000_CHIP_REF_CTRL in
> sgtl5000_restore_regs(), and add comment to explain the restore order.
> 
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Signed-off-by: Zeng Zhaoming <zengzm.kernel@gmail.com>
> ---
>  sound/soc/codecs/sgtl5000.c |   17 +++++++++++++----
>  1 files changed, 13 insertions(+), 4 deletions(-)
> 

Acked-by: Dong Aisheng <dong.aisheng@linaro.org>

Regards
Dong Aisheng
