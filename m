From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 1/4] ASoC: imx: add an explicit Kconfig
 option for imx-ssi driver
Date: Fri, 24 Feb 2012 02:59:22 +0000
Message-ID: <4F46FD09.5020700@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-1-git-send-email-shawn.guo@linaro.org>
	<1330008519-3584-2-git-send-email-shawn.guo@linaro.org>
	<4F465DD0.1020304@freescale.com>
	<20120224012850.GA4441@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
	by alsa0.perex.cz (Postfix) with ESMTP id B6174243E8
	for <alsa-devel@alsa-project.org>; Fri, 24 Feb 2012 03:59:30 +0100 (CET)
In-Reply-To: <20120224012850.GA4441@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <0833CD5E8D5EBA41BBF645761B853BF4@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> That's what I'm doing.  But to be clear, imx-ssi driver will still
> exist for all those non-DT i.MX platforms.  We are supporting DT for
> imx5 and imx6, but have not seen a plan to migrate all those old i.MX
> platforms to DT.

On PowerPC, we handle this by creating cuImages.  These are kernel images 
that have a DTB built-in.  Perhaps something like that is needed for ARM?

-- 
Timur Tabi
Linux kernel developer at Freescale
