From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 14:50:49 -0600
Message-ID: <4D262B29.3010606@freescale.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE003.bigfish.com (db3ehsobe003.messaging.microsoft.com
	[213.199.154.141])
	by alsa0.perex.cz (Postfix) with ESMTP id CE21524538
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 21:52:18 +0100 (CET)
In-Reply-To: <20110106201511.GA8018@opensource.wolfsonmicro.com>
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
Cc: dp@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Having a driver per device is pretty icky and off the top of my head I'd
> expect it to cause problems if there are two cs4270 in the system.  It
> would be much nicer and more maintainable to avoid bodging around the
> API like this.

BTW, why does ASoC even care about the register cache, if I have to have my own
functions to read and write it?  In other words, why does function
cs4270_read_reg_cache() exist at all?  What is the point of having ASoC allocate
the cache if the driver has to supply functions to read and write it?

-- 
Timur Tabi
Linux kernel developer at Freescale
