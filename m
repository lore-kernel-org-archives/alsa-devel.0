From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Thu, 20 Dec 2007 16:40:07 -0600
Message-ID: <476AEF47.8040802@freescale.com>
References: <11981089894052-git-send-email-timur@freescale.com>	
	<9e4733910712201429q5845e786yb2ecb3ce9c8b7871@mail.gmail.com>	
	<476AED87.3090703@freescale.com>
	<9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id EE9F72485F
	for <alsa-devel@alsa-project.org>; Thu, 20 Dec 2007 23:40:11 +0100 (CET)
In-Reply-To: <9e4733910712201438u2165aa77t8eab91bccb4c5bda@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jon Smirl wrote:

> mpc5200 does it like this:
> of_platform_bus_probe(NULL, NULL, NULL);

I think that tells the OF base code to probe everything in the device tree, 
which is probably overkill.  I think fsl_soc.c covers most of the device tree, 
but the SSI is not defined in fsl_soc.c.

-- 
Timur Tabi
Linux kernel developer at Freescale
