From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 08:48:46 -0500
Message-ID: <4E7353BE.9010609@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
	<20110915102430.GD7988@opensource.wolfsonmicro.com>
	<4E7214ED.9050703@freescale.com>
	<20110915223821.GA3218@opensource.wolfsonmicro
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
	[213.199.154.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F5532452D
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 15:50:35 +0200 (CEST)
In-Reply-To: <20110915234914.GG3218@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> The first one says that the rates announced by the driver are the
> superset of all rates the device can ever support, the second says that
> this is done because the system can change the clock rate after we're
> done announcing what sample rates we support.

Ok, I understand what you're saying.  In fact, it seems this change, while it
allows the codec driver to automatically support all of the sample rates that
the hardware actually supports at the moment, it has the drawback in that it
doesn't tell ASoC what that list is.  All .hw_params() does is accept or reject
any particular sample rate.

Is there a way for set_syclk() to tell ASoC the full list of supported rates?
That is, is there any way it can update snd_soc_dai_driver.playback.rates?

-- 
Timur Tabi
Linux kernel developer at Freescale
