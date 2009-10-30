From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add support for CLKOUT to wm8731
	codec	driver
Date: Fri, 30 Oct 2009 19:44:02 +0000
Message-ID: <20091030194402.GA31601@opensource.wolfsonmicro.com>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
	<1256829202-2508-2-git-send-email-bgat@billgatliff.com>
	<20091029160534.GE15559@sirena.org.uk>
	<4AEB194C.700@billgatliff.com>
	<20091030170003.GA28420@rakim.wolfsonmicro.main>
	<4AEB2EDA.8080008@billgatliff.com>
	<B3102D86-255A-4DC5-BEDA-28356E5F57AD@opensource.wolfsonmicro.com>
	<4AEB38B9.2090204@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F1D391037F9
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 20:44:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4AEB38B9.2090204@billgatliff.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 30, 2009 at 02:04:25PM -0500, Bill Gatliff wrote:
> Mark Brown wrote:

> > wm8993 supports multiple internal options for sysclk usig the id
> > parameter. Could you be more explicit about what you can't follow here
> > please? I might be able to help more if I could see what's confusing you.

> I guess what it comes down to is, I have no idea what I'm doing as far
> as the Alsa SoC APIs are concerned.  I understand fully how the hardware
> works, but not any of the SND_SOC_* macros.  I'm lost!  :)

All I said to do was to take your code to set this via the set_sysclk()
function and use the id that gets passed in to split up the changes to
the master clock and the output clock so the two are adjusted
independently.

> I see in the wm8993 code the following:

> static const struct snd_soc_dapm_widget wm8993_dapm_widgets[] = {
> SND_SOC_DAPM_SUPPLY("CLK_SYS", WM8993_BUS_CONTROL_1, 1, 0, clk_sys_event,
>                     SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
> ...

This is used to switch on and off the internal system clock in the
CODEC which supplies the clock to all the digital functionaliy in the
device, it's not something that's visible outside the device.  The
wm8731 is a much older device and doesn't have this sort of detailed
control.
