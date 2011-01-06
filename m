From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: cs4270: fix dynamic initialization
 of register cache
Date: Thu, 6 Jan 2011 15:35:56 -0600
Message-ID: <4D2635BC.1080108@freescale.com>
References: <1294339968-420-1-git-send-email-timur@freescale.com>
	<20110106201511.GA8018@opensource.wolfsonmicro.com>
	<4D262B29.3010606@freescale.com>
	<20110106213139.GG8018@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	by alsa0.perex.cz (Postfix) with ESMTP id C8BB5103807
	for <alsa-devel@alsa-project.org>; Thu,  6 Jan 2011 22:36:03 +0100 (CET)
In-Reply-To: <20110106213139.GG8018@opensource.wolfsonmicro.com>
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
> If you're completely ignoring the standard cache and register I/O code
> (which isn't ideal) then you should't be telling the core about your
> cache.

Tell that to the person who hacked up my driver and apparently broke it.  I'm
now playing catch-up.  I need to learn all about this (new) register cache
feature and then try to figure out how to make it work in my driver.

-- 
Timur Tabi
Linux kernel developer at Freescale
