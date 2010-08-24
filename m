From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/1] mfd: add codec resource into 88pm860x
	driver
Date: Tue, 24 Aug 2010 13:45:11 +0100
Message-ID: <20100824124511.GC15278@rakim.wolfsonmicro.main>
References: <AANLkTimu5hFvdCgHkXniDqi4OF+fsFR=zj9Rje4Sx4Oi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 012D1246C7
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Aug 2010 14:45:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimu5hFvdCgHkXniDqi4OF+fsFR=zj9Rje4Sx4Oi@mail.gmail.com>
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
Cc: Samuel Ortiz <sameo@openedhand.com>, Samuel Ortiz <sameo@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 23, 2010 at 06:24:50PM +0800, Haojian Zhuang wrote:
> From 28ed4af3929120b9b3853ffcb8055eb6a81d31d8 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Thu, 12 Aug 2010 11:59:33 +0800
> Subject: [PATCH 1/1] mfd: add codec resource into 88pm860x driver
> 
> Add codec IRQ resources that are used in 88pm860x codec driver.
> 
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

I think the MFD tree makes most sense for this - the codec driver will
build fine without it.
