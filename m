From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v5 8/8] ASoC: fsl: add imx-sgtl5000 machine
 driver
Date: Fri, 16 Mar 2012 16:31:20 -0500
Message-ID: <4F63B128.7040705@freescale.com>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
	<1331888204-27058-9-git-send-email-shawn.guo@linaro.org>
	<CA+7tXihmfBQCgvuY0rx5v4w-bcwYK+7kP9v29w36N-Rc9KSQ+A@mail.gmail.com>
	<20120316111814.GA7860@S2101-09.ap.freescale.net>
	<20120316192110.GH3158@opensource.wolfsonmicro.com>
	<CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
	(va3ehsobe010.messaging.microsoft.com [216.32.180.30])
	by alsa0.perex.cz (Postfix) with ESMTP id B8991243EF
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 22:31:28 +0100 (CET)
In-Reply-To: <CA+7tXih-omxaDq6dSKBeOaZ7YRWDVSQnMY=eJZ0-YumOBG=oCA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <tpiepho@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> The ESAI and SSI hardware are totally different.  SSI gives you a
> playback and a record stream in an I2S, or I2S like, interface.  A
> stream is mono or stereo. ESAI has IIRC up to six output and four
> inputs streams.  Each stream is in parallel on the same clock, and can
> have one or more channels. 

Are these channels on the same wire in a time-division multiplexing, or on
six different wires?  If it's a TDM, then the SSI can actually do this
using "network mode", but I don't enable that in the driver, since it's
not really I2S compliant.

Well, this point is not really relevant to the discussion.

-- 
Timur Tabi
Linux kernel developer at Freescale
