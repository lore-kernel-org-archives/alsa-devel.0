From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] [v2] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Fri, 16 Sep 2011 17:47:54 +0100
Message-ID: <20110916164753.GE23727@opensource.wolfsonmicro.com>
References: <1316182614-9666-1-git-send-email-timur@freescale.com>
	<s5hwrd8jy68.wl%tiwai@suse.de> <4E736F9B.6080206@freescale.com>
	<20110916162630.GB23727@opensource.wolfsonmicro.com>
	<4E737A62.5080501@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B3DBC2433B
	for <alsa-devel@alsa-project.org>;
	Fri, 16 Sep 2011 18:47:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E737A62.5080501@freescale.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 16, 2011 at 11:33:38AM -0500, Timur Tabi wrote:
> Mark Brown wrote:
> > Machine drivers are currently best placed to set constraints if the
> > clocking is limited.

> But how is the machine driver supposed to know what those sample rates
> are?  It would need to know how which dividers that codec uses.  That
> would mean that the machine driver has to be hard-codec with
> information on the internals of the codec.

You'd have to look at the CODEC datasheet and figure out what it's
capable of given the clocks you're able to give it.  Depending on the
flexibility you've got and power you're willing to spend there may be no
need to do anything as you may be able to generate any clocks the device
may need (for example with devices that have FLLs).
