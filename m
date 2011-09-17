From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Sat, 17 Sep 2011 14:04:37 +0100
Message-ID: <20110917130437.GB2909@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
	<20110915102430.GD7988@opensource.wolfsonmicro.com>
	<4E7214ED.9050703@freescale.com> <4E7353BE.9010609@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2CCCF24499
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 15:04:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E7353BE.9010609@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@ti.com" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 08:48:46AM -0500, Timur Tabi wrote:

> Ok, I understand what you're saying.  In fact, it seems this change, while it
> allows the codec driver to automatically support all of the sample rates that
> the hardware actually supports at the moment, it has the drawback in that it
> doesn't tell ASoC what that list is.  All .hw_params() does is accept or reject
> any particular sample rate.

Yes.

> Is there a way for set_syclk() to tell ASoC the full list of supported rates?
> That is, is there any way it can update snd_soc_dai_driver.playback.rates?

No, you can't modify the DAI dynamically.  You can set constraints in
the startup() callback as the WM8988 driver does.
