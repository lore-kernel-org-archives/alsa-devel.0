From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/4] mmp: support ssp in pxa168
Date: Wed, 10 Mar 2010 14:28:32 +0000
Message-ID: <20100310142832.GB24422@rakim.wolfsonmicro.main>
References: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CBDFC2443E
	for <alsa-devel@alsa-project.org>; Wed, 10 Mar 2010 15:28:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <771cded01003100514r70f0f53eydda7b916f92bef64@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 10, 2010 at 08:14:42AM -0500, Haojian Zhuang wrote:
> From 75fe4b02234f6476e72827508f11f1035d7aaf68 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Wed, 10 Mar 2010 06:32:43 -0500
> Subject: [PATCH] [ARM] mmp: support ssp in pxa168
> 
> Support ssp in pxa168. The basic function of SSP is same as pxa, but clock
> source and IRQ is changed.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

That said might it make sense to merge this and the previous patch via
ASoC since there's new drivers using this following on and Liam's
multi-codec work is likely to be creating merge issues this development
cycle?  I can apply the patches on a branch by themselves which can also
be pulled into the PXA tree if needed.
