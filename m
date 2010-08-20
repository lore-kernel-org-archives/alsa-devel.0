From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] ASoC: clean dead file pxa2xx-pcm.h
Date: Fri, 20 Aug 2010 12:11:24 +0100
Message-ID: <20100820111124.GH13668@rakim.wolfsonmicro.main>
References: <AANLkTimwZUqjROy0POvEgS_XE3V953bzh_+hV8z8=ewz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 982A11038E5
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Aug 2010 13:11:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimwZUqjROy0POvEgS_XE3V953bzh_+hV8z8=ewz@mail.gmail.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 20, 2010 at 06:37:23PM +0800, Haojian Zhuang wrote:
> From a3d2309c28d502e89997e0cc1ab98f3cacc684df Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Fri, 20 Aug 2010 18:27:41 +0800
> Subject: [PATCH 1/1] ASoC: clean dead file pxa2xx-pcm.h
> 
> Since pxa2xx-pcm.h is removed from sound/soc/pxa directory, clean it
> for passing compilation.

I already applied the same fix from Axel Lin - I added your signoff to
his commit.
