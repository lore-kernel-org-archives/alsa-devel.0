From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Mon, 5 Mar 2012 12:28:52 +0000
Message-ID: <4F54B183.4080607@freescale.com>
References: <1330788001-10158-1-git-send-email-shawn.guo@linaro.org>
	<1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120305073930.GC16232@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
	by alsa0.perex.cz (Postfix) with ESMTP id ECC1F103FDA
	for <alsa-devel@alsa-project.org>; Mon,  5 Mar 2012 13:29:04 +0100 (CET)
In-Reply-To: <20120305073930.GC16232@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <E341615F6DBEA749BC3592FF951CD478@mgd.freescale.com>
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
> Yeah, it makes the diff neat.  However I would make it an inline
> function which is easier to play.

However you want to do it is fine with me, although I would use "u32 
__iomem *addr" instead of "void __iomem *addr".

-- 
Timur Tabi
Linux kernel developer at Freescale
