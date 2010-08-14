From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
Date: Sat, 14 Aug 2010 11:47:27 +0100
Message-ID: <1281782847.3394.121.camel@odin>
References: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
	<1281713056.2074.28.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A71B024485
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Aug 2010 12:47:30 +0200 (CEST)
Received: by wwi17 with SMTP id 17so1807110wwi.20
	for <alsa-devel@alsa-project.org>; Sat, 14 Aug 2010 03:47:30 -0700 (PDT)
In-Reply-To: <1281713056.2074.28.camel@Tapajos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Haojian Zhuang <haojian.zhuang@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-08-13 at 16:24 +0100, Ian Lartey wrote:
> On Fri, 2010-08-13 at 21:55 +0800, Haojian Zhuang wrote:
> > From b761e3bb374e630011f22ce54963877310a0baca Mon Sep 17 00:00:00 2001
> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Date: Fri, 13 Aug 2010 21:14:52 +0800
> > Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
> > 
> > Since pxa2xx-pcm.h is removed from sound/soc/pxa, we need to update the
> > path in related files.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> > ---
> >  sound/soc/pxa/pxa-ssp.c    |    2 +-
> >  sound/soc/pxa/pxa2xx-pcm.c |    1 -
> >  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> Tested-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
