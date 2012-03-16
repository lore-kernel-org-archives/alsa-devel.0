From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Fri, 16 Mar 2012 02:07:42 +0000
Message-ID: <4F62A06C.5000304@freescale.com>
References: <1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
	<4F612319.50302@freescale.com>
	<20120315142702.GL3138@opensource.wolfsonmicro.com>
	<4F621C60.5090700@freescale.com>
	<20120316020111.GE6065@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
	by alsa0.perex.cz (Postfix) with ESMTP id 30C4524490
	for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2012 03:07:52 +0100 (CET)
In-Reply-To: <20120316020111.GE6065@S2101-09.ap.freescale.net>
Content-Language: en-US
Content-ID: <9D523AC91F602543B192A2A0706B8DB3@mgd.freescale.com>
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

> This could probably change to check whether property codec-handle is
> present under SSI node to decide if it runs with "old binding" or
> "new binding".

I guess that's how we need to do it.  The SSI driver should not be looking 
for /sound node, but that's the most reliable way to know if we have a new 
or old binding.

>> +		ssi_private->imx_pcm_pdev =
>> +			platform_device_register_simple("imx-pcm-audio",
>>
> This is still IMX vs. PowerPC thing rather than "old binding" vs. "new
> binding" one.

What is "imx-pcm-audio"?

>> This prohibits me from using the new binding on any future PowerPC parts,
>> because it clearly says "iMX" on everything.
>
> I think we can change it later when the future PowerPC parts come to
> use the new binding.  In any case, I do not see this is an issue that
> should block the whole series.

At least get rid of any unnecessary references to "imx".

-- 
Timur Tabi
Linux kernel developer at Freescale
