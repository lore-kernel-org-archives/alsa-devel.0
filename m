From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH v2 0/8] ASoC: TWL4030: put the codec to off
 when not active
Date: Mon, 31 May 2010 10:39:09 +0100
Message-ID: <1275298749.3174.0.camel@odin>
References: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C180103845
	for <alsa-devel@alsa-project.org>;
	Mon, 31 May 2010 11:39:16 +0200 (CEST)
Received: by wwf26 with SMTP id 26so652916wwf.38
	for <alsa-devel@alsa-project.org>; Mon, 31 May 2010 02:39:13 -0700 (PDT)
In-Reply-To: <1274863101-18514-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2010-05-26 at 11:38 +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Changes since v1:
> - Patch 3: removed the shifting of offset cancellation value
> - Added register content reset functionality as suggested by Liam and Mark
> 
> I have added Mark's Acked-by to patch 1-7, patch 8 is a new one, which shall
> address the comments regarding to the register content reset.
> 
> To-do after this series:
> Revisit the register reset functionality to use burst write.
> 
> Intro mail from the original series:
> 
> The following series at the end will let the twl4030 codec to use BIAS_OFF
> instead of BIAS_STANDBY.
> The difference in power consumption is about 0.5mA.
> 
> To achieve this:
> - The regcache has been reseted to codec default
> - The codec initialization has been optimized, it is no longer writes all 73
>   registers at startup, but only modifies few selected one.
> - The power related code has been cleaned up, and optimized
> - Support added for machine drivers to select the offset cancellation path
> - debug support for checking the codec default registers (machine drivers can
>   ask for checking, but shall be disabled in production).
> - Added codec register reset functionality
> 
> I guess that's it.
> The driver has been tested on a custom board with twl5031. It passed all of our
> internal test cases covering much of the codec features.
> 
> ---
> Peter Ujfalusi (8):
>   ASoC: TWL4030: Revisit codec defaults
>   ASoC: TWL4030: Remove wrapper for power down
>   ASoC: TWL4030: Make offset cancellation path configurable
>   ASoC: TWL4030: Optimize the power up sequence
>   ASoC: TWL4030: Helper to check chip default registers
>   ASoC: TWL4030: Correct the ARXR2_APGA_CTL chip default
>   ASoC: TWL4030: Use BIAS_OFF instead of BIAS_STANDBY, when not in use
>   ASoC: TWL4030: Add functionalty to reset the registers
> 
>  sound/soc/codecs/twl4030.c |  291 +++++++++++++++++++++++++-------------------
>  sound/soc/codecs/twl4030.h |    3 +
>  2 files changed, 169 insertions(+), 125 deletions(-)
> 

Applied.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
