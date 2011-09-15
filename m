From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: support all possible sample
 rates in the WM8776 driver
Date: Thu, 15 Sep 2011 10:08:29 -0500
Message-ID: <4E7214ED.9050703@freescale.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
	<1315936777-27994-2-git-send-email-timur@freescale.com>
	<20110915102430.GD7988@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from DB3EHSOBE004.bigfish.com (db3ehsobe004.messaging.microsoft.com
	[213.199.154.142])
	by alsa0.perex.cz (Postfix) with ESMTP id 07BCA103AF3
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 17:08:59 +0200 (CEST)
In-Reply-To: <20110915102430.GD7988@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> This changelog doesn't correspond to reality.  The set_sysclk() function
> in the driver makes no effort to constrain the sample rates based on
> sysclk, as is normal for CODEC drivers as the system clock is frequently
> configured based on the current sample rate (at the minute the
> configured clock is used to set up the clock dividers within the CODEC
> based on sample rate). 

My understanding of the .set_sysclk() function is that one of its primary
purpose is to tell the codec what master frequency to use for its sample rate
clock divider.  Although that doesn't technically happen in the .set_sysclk
function itself, that function is typically required.  Without that function,
codecs must hard-code their mclk frequency, which therefore also locks the list
of supported sample rates.

So although I understand that the patch description may not be 100% accurate, I
think saying that it "doesn't correspond to reality" is an exaggeration.  I can
correct the description by changing a few words around.

> Trying to implement constraints based on the
> system clock is problematic and will normally decrease the usability of
> the driver in systems where the clock rates vary.

I don't think I understand that.  set_sysclk() is suppose to increase the
usability of the driver where clock rates vary because it is *the* mechanism for
telling the driver what the clock rate is.  This is how it goes:

1. The machine driver queries the platform to determine the mclk for the codec
2. The machine driver uses set_sysclk() to tell the codec driver what that
frequency is.
3. The codec driver later uses that frequency to determine which sample rates
are actually supported.

How is this problematic?  On the P1022DS, I can dynamically switch between two
mclk frequencies on the codec just by touching a gpio.

> What's actually going on here is that the driver is being cautious about
> supporting non-audio clock rates (mostly because the digital performance
> is mainly specified for audio rates) and 192kHz was omitted from the DAC
> rates.  The change itself is OK but please resubmit with a more accurate
> changelog.

The only change that I understand that you want is to clarify that the sample
rate calculation doesn't happen directly in set_sysclk().  Is there anything
else you're expecting?


-- 
Timur Tabi
Linux kernel developer at Freescale
