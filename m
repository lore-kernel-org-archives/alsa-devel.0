From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] Add support for CLKOUT to wm8731 codec
	driver
Date: Fri, 30 Oct 2009 14:04:25 -0500
Message-ID: <4AEB38B9.2090204@billgatliff.com>
References: <1256829202-2508-1-git-send-email-bgat@billgatliff.com>
	<1256829202-2508-2-git-send-email-bgat@billgatliff.com>
	<20091029160534.GE15559@sirena.org.uk>
	<4AEB194C.700@billgatliff.com>
	<20091030170003.GA28420@rakim.wolfsonmicro.main>
	<4AEB2EDA.8080008@billgatliff.com>
	(sfid-20091030_182231_835396_A571493E)
	<B3102D86-255A-4DC5-BEDA-28356E5F57AD@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f217.google.com (mail-bw0-f217.google.com
	[209.85.218.217])
	by alsa0.perex.cz (Postfix) with ESMTP id 6BED91037F9
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 20:04:26 +0100 (CET)
Received: by bwz9 with SMTP id 9so10159067bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2009 12:04:25 -0700 (PDT)
In-Reply-To: <B3102D86-255A-4DC5-BEDA-28356E5F57AD@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> wm8993 supports multiple internal options for sysclk usig the id
> parameter. Could you be more explicit about what you can't follow here
> please? I might be able to help more if I could see what's confusing you.

I guess what it comes down to is, I have no idea what I'm doing as far
as the Alsa SoC APIs are concerned.  I understand fully how the hardware
works, but not any of the SND_SOC_* macros.  I'm lost!  :)

I see in the wm8993 code the following:

static const struct snd_soc_dapm_widget wm8993_dapm_widgets[] = {
SND_SOC_DAPM_SUPPLY("CLK_SYS", WM8993_BUS_CONTROL_1, 1, 0, clk_sys_event,
                    SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
...

And I also have looked at the clk_sys_event function in the same file. 
And then farther down:

static const struct snd_soc_dapm_route routes[] = {
...
        { "DACL", NULL, "CLK_SYS" },


I guess that the updates to the wm8731 would somehow look like the
above?  I don't mind looking at code and macros at all, I'm just not yet
seeing how all this stuff fits together.


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com
