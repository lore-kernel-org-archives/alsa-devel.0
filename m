From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Initial WM8741 CODEC driver
Date: Mon, 02 Aug 2010 10:44:44 +0100
Message-ID: <1280742284.3095.26.camel@odin>
References: <1280532731.2130.157.camel@Tapajos>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id C64D1243BB
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Aug 2010 11:44:48 +0200 (CEST)
Received: by wyb42 with SMTP id 42so2946680wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 02 Aug 2010 02:44:48 -0700 (PDT)
In-Reply-To: <1280532731.2130.157.camel@Tapajos>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Sat, 2010-07-31 at 00:32 +0100, Ian Lartey wrote:
> The WM8741 is a very high performance stereo DAC designed for audio
>  applications such as professional recording systems, A/V receivers and high
>  specification CD, DVD and home theatre systems. The device supports PCM
>  data input word lengths from 16 to 32-bits and sampling rates up to 192kHz.
>  The WM8741 also supports DSD bit-stream data format, in both direct DSD and
>  PCM-converted DSD modes.
> 
> TODO: Expand wm8741_set_dai_sysclk and rate_constraint members to
> allow for all supported sample rate / Master Clock frequency combinations.
> Fully enable control of supplies.
> 
> 
> Signed-off-by: Ian Lartey <ian@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

Btw, Mark will port this to ASoC multi-component.

Thanks

Liam
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
