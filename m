From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 10:54:40 -0600
Message-ID: <4D2B39D0.4020202@freescale.com>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>	
	<1294676990.11031.10.camel@dplaptop.localdomain>	
	<4D2B34C1.7050209@freescale.com>
	<1294677365.11031.13.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by alsa0.perex.cz (Postfix) with ESMTP id C5C5224534
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 17:54:50 +0100 (CET)
In-Reply-To: <1294677365.11031.13.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> There's not much that can be done for error recovery at that point.
> Usually a failing snd_soc_read()/snd_soc_write() will complain wildly
> with errors from the underlying bus.  The only place that
> snd_soc_read()/snd_soc_write() are checked for errors is usually in
> _probe() functions.

And that's when I call it, so that's when I'd like it to report errors.

I'll submit a patch.

-- 
Timur Tabi
Linux kernel developer at Freescale
