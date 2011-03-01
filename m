From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: Remove module probe announcements
	from CODEC drivers
Date: Tue, 1 Mar 2011 14:17:09 -0600
Message-ID: <4D6D5445.3010202@freescale.com>
References: <1299010455-31934-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1outboundpool.messaging.microsoft.com [216.32.181.183])
	by alsa0.perex.cz (Postfix) with ESMTP id F0DA3103854
	for <alsa-devel@alsa-project.org>; Tue,  1 Mar 2011 21:17:35 +0100 (CET)
In-Reply-To: <1299010455-31934-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
>  static int __init cs4270_init(void)
>  {
> -	pr_info("Cirrus Logic CS4270 ALSA SoC Codec Driver\n");
> -
>  	return i2c_add_driver(&cs4270_i2c_driver);
>  }

I'm not fond of this at all.

Can I get a justification for this change?  On my boards, the CS4270 driver is
compiled in-kernel, not as a module, and so when the kernel boots, the driver
announces itself when it's loaded.  I like this a lot, which is why I always put
a pr_info() in the __init function of my modules.

-- 
Timur Tabi
Linux kernel developer at Freescale
