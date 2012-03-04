From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Sun, 4 Mar 2012 23:32:50 +0000
Message-ID: <4F53FBA1.8090200@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
	(am1ehsobe001.messaging.microsoft.com [213.199.154.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 44B89243FD
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 00:33:00 +0100 (CET)
In-Reply-To: <20120304232817.GA13516@n2100.arm.linux.org.uk>
Content-Language: en-US
Content-ID: <D15759C508E7674CAFC7B25A67191273@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux wrote:
> Is the SCR shared between capture and playback?  In that case, what
> makes this read-modify-write thread safe?

What's "SCR"?

It's not thread-safe on PPC, but then neither is the entire function.  You 
can't have two threads attempt to initialize the hardware at the same 
time.  The macro does not attempt to be atomic, just convenient.

-- 
Timur Tabi
Linux kernel developer at Freescale
