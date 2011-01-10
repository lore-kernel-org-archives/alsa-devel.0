From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 12:41:30 -0600
Message-ID: <4D2B52DA.1090102@freescale.com>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>
	<1294676990.11031.10.camel@dplaptop.localdomain>
	<4D2B34C1.7050209@freescale.com>
	<1294677365.11031.13.camel@dplaptop.localdomain>
	<4D2B4376.101@freescale.com>
	<20110110182302.GB26137@opensource.wolfsonmicro.com>
	<4D2B50FA.9060102@freescale.com>
	<20110110183615.GC26137@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) by alsa0.perex.cz (Postfix) with ESMTP id A376A24594
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 19:41:42 +0100 (CET)
In-Reply-To: <20110110183615.GC26137@opensource.wolfsonmicro.com>
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
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Note that the return value of the read functions is an unsigned int
> rather than an int.

Oh yeah, I didn't see that.  So returning any negative number is broken.

So I don't understand the philosophy here.  Are we going to propagate errors
during read operations, or not?  It seems that sometimes ASoC does, and
sometimes it doesn't, and sometimes it doesn't even know what it wants (e.g. the
snd_soc_X_X_read functions).

-- 
Timur Tabi
Linux kernel developer at Freescale
