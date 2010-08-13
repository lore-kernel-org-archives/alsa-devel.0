From: Ian Lartey <ian@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
Date: Fri, 13 Aug 2010 16:24:16 +0100
Message-ID: <1281713056.2074.28.camel@Tapajos>
References: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E9AF22417D
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Aug 2010 17:24:51 +0200 (CEST)
In-Reply-To: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-13 at 21:55 +0800, Haojian Zhuang wrote:
> From b761e3bb374e630011f22ce54963877310a0baca Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 13 Aug 2010 21:14:52 +0800
> Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
> 
> Since pxa2xx-pcm.h is removed from sound/soc/pxa, we need to update the
> path in related files.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> ---
>  sound/soc/pxa/pxa-ssp.c    |    2 +-
>  sound/soc/pxa/pxa2xx-pcm.c |    1 -
>  2 files changed, 1 insertions(+), 2 deletions(-)

Tested-by: Ian Lartey <ian@opensource.wolfsonmicro.com>

Hello Haojian,  I have tested this and it works fine. I will also follow
with similar patch for pxa2xx-i2S.c.
