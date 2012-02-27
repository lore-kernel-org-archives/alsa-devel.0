From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
Date: Mon, 27 Feb 2012 14:28:43 -0600
Message-ID: <4F4BE77B.2040802@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 0A6F7103B51
	for <alsa-devel@alsa-project.org>; Mon, 27 Feb 2012 21:28:55 +0100 (CET)
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Shawn Guo wrote:
> This is the third series towards reusing fsl_ssi driver on device tree
> based IMX platforms.  It makes a few cleanups on existing PowerPC code
> to ease the later addition of an IMX machine driver that works on
> fsl_ssi.

These patches don't apply 100% cleanly, and there are some issues that
need to be resolved, but I'll review each one and ACK those that I think
are okay.  It would probably be better if none were applied until the
whole patchset is okay, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
