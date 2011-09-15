From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Thu, 15 Sep 2011 23:06:53 +0000
Message-ID: <4E728509.9060705@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
	<20110915102430.GD7988@opensource.wolfsonmicro.com>
	<4E7214ED.9050703@freescale.com>
	<20110915223821.GA3218@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
	[213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id C7ADD103861
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 01:06:59 +0200 (CEST)
In-Reply-To: <20110915223821.GA3218@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <8A0A1A206F6A2A4A8109ED5062316687@freescale.net>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Tabi Timur-B04825 <B04825@freescale.com>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> This isn't what happens at all.  The constraints set in the DAIs
> generally just list all the sample rates the device can possibly
> support, there's no dynamic information injected into the subsystem
> about what's supported.  This is because in many systems the various
> clock rates are dynamically controlled and so the clocks are adjusted to
> reflect the sample rates the application layer wants.

IMHO, these two sentences contradict each other.

> As a result we
> never actually bother specifying the supported rates for the current
> clock at all, we just try to make the best of what we're given when it
> comes to configuring which is a rather different thing.

But why would you do that?  That just creates an artificial limitation on 
the list of supported sample rates.  If you include a set_sysclk() 
function in the codec driver, then you should always specify 
SNDRV_PCM_RATE_CONTINUOUS in snd_soc_dai_driver.rates.  To me, the two go 
hand-in-hand.

-- 
Timur Tabi
Linux kernel developer at Freescale
