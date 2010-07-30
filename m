From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Initial WM8741 CODEC driver
Date: Fri, 30 Jul 2010 18:18:41 +0100
Message-ID: <1280510321.3059.36.camel@odin>
References: <1280508308.2130.148.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 7F1E9243E1
	for <alsa-devel@alsa-project.org>;
	Fri, 30 Jul 2010 19:18:50 +0200 (CEST)
Received: by wyb42 with SMTP id 42so1323801wyb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Jul 2010 10:18:50 -0700 (PDT)
In-Reply-To: <1280508308.2130.148.camel@Tapajos>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ian Lartey <ian@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Hi Ian,

On Fri, 2010-07-30 at 17:45 +0100, Ian Lartey wrote:
> The WM8741 is a very high performance stereo DAC designed for audio
> applications such as professional recording systems, A/V receivers and
> high specification CD, DVD and home theatre systems. The device
> supports PCM data input word lengths from 16 to 32-bits and sampling
> rates up to 192kHz. The WM8741 also supports DSD bit-stream data
> format, in both direct DSD and PCM-converted DSD modes.
> 
> TODO: Expand wm8741_set_dai_sysclk and rate_constraint members to
> allow for all supported sample rate / Master Clock frequency
> combinations.
> Fully enable control of supplies.
> 
> 
> Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> ---
>  sound/soc/codecs/Kconfig  |    4 +
>  sound/soc/codecs/Makefile |    2 +
>  sound/soc/codecs/wm8741.c |  579
> +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wm8741.h |  214 +++++++++++++++++

Looks like your mailer has mangled this patch. 

Could you fix your mailer and resend.

Thanks

Liam 
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
