From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: ASoC ac97: kobject warnings
Date: Fri, 13 Feb 2009 08:10:04 +0100
Message-ID: <20090213071004.GA12667@roarinelk.homelinux.net>
References: <20090212170504.GA7118@roarinelk.homelinux.net>
	<20090212193756.GB9772@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from roarinelk.homelinux.net (fnoeppeil36.netpark.at
	[217.175.205.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 155651037FB
	for <alsa-devel@alsa-project.org>; Fri, 13 Feb 2009 08:10:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090212193756.GB9772@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 12, 2009 at 07:37:56PM +0000, Mark Brown wrote:
> On Thu, Feb 12, 2009 at 06:05:05PM +0100, Manuel Lauss wrote:
> 
> > the asoc generic ac97 codec support throws a warning on 2.6.29:
> 
> Please try this patch, it fixes the problem for me here:
> 
> From 809e4472590e2312d3bea70b4327c3b65676b1a6 Mon Sep 17 00:00:00 2001
> From: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Date: Thu, 12 Feb 2009 19:33:19 +0000
> Subject: [PATCH] ASoC: Only register AC97 bus if it's not done already
> 
> ASoC supports both explicit codec drivers for AC97 devices and a simple
> driver which uses the standard ALSA AC97 framework for codec support.
> When used with the generic AC97 codec support that will provide the
> ad hoc AC97 device for drivers like touchscreens to attach to so the
> core shouldn't do so.
[...]

Yes it's fixed here too.


Thanks,
	Manuel Lauss
