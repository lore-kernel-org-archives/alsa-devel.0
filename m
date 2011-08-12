From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] soc/soc-io.c: Use regmap_init_{i2c,
 spi} only if it's available
Date: Fri, 12 Aug 2011 23:59:02 +0900
Message-ID: <1313161142.19990.58.camel@finisterre.wolfsonmicro.main>
References: <1313160780-20633-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 149FB1037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 16:59:09 +0200 (CEST)
In-Reply-To: <1313160780-20633-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassisinghbrar@gmail.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-08-12 at 17:52 +0300, Vasily Khoruzhick wrote:
> Otherwise we get linker error like:
> ERROR: "regmap_init_spi" [sound/soc/snd-soc-core.ko] undefined!

Too late, already fixed in git by Stephen and Axel. But thanks.
