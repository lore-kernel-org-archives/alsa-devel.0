From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 6/6] ASoC: fsl: check property 'compatible'
 for the machine name
Date: Tue, 28 Feb 2012 03:42:57 +0000
Message-ID: <4F4C4D3F.3070907@freescale.com>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
	<1330092582-21180-7-git-send-email-shawn.guo@linaro.org>
	<4F4BFB79.30801@freescale.com>
	<20120228015012.GA13886@S2101-09.ap.freescale.net>
	<4F4C3824.90306@freescale.com>
	<20120228031308.GI13886@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id 7093524465
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 04:43:05 +0100 (CET)
In-Reply-To: <20120228031308.GI13886@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <AC8AF72BFDDCAF459971AD99614B4F79@mgd.freescale.com>
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
> Are you saying that both older and new P1022 device trees have
> compatible = "fsl,P1022DS", so that changing to check /compatible
> could save the check on /model of P1022 device tree?

Yes, that's what I'm saying.

You can verify for yourself by looking at the git history of the device trees.

-- 
Timur Tabi
Linux kernel developer at Freescale
