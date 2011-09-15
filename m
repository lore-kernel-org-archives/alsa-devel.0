From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Thu, 15 Sep 2011 11:24:30 +0100
Message-ID: <20110915102430.GD7988@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 288952446E
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 12:24:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315936777-27994-2-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2011 at 12:59:36PM -0500, Timur Tabi wrote:

> ASoC codec drivers can use the .set_sysclk function to dynamically specify
> the list of support sample rates, because that list is often based on
> the input clock frequency.  Although the WM8776 includes a .set_sysclk
> function, it was also hard-coding the supported sample rates to a list
> that depends on a specific input clock frequency.

> So change the hard-coded list to a range within the capabilities of the
> WM8776 itself, and let wm8776_set_sysclk() do its job.

This changelog doesn't correspond to reality.  The set_sysclk() function
in the driver makes no effort to constrain the sample rates based on
sysclk, as is normal for CODEC drivers as the system clock is frequently
configured based on the current sample rate (at the minute the
configured clock is used to set up the clock dividers within the CODEC
based on sample rate).  Trying to implement constraints based on the
system clock is problematic and will normally decrease the usability of
the driver in systems where the clock rates vary.

What's actually going on here is that the driver is being cautious about
supporting non-audio clock rates (mostly because the digital performance
is mainly specified for audio rates) and 192kHz was omitted from the DAC
rates.  The change itself is OK but please resubmit with a more accurate
changelog.
