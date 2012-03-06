From: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH 15/20] ASoC: fsl: make fsl_ssi driver
 compilable on ARM/IMX
Date: Tue, 6 Mar 2012 13:02:35 +0000
Message-ID: <4F560AE9.90502@freescale.com>
References: <1330788001-10158-16-git-send-email-shawn.guo@linaro.org>
	<4F53F704.8080703@freescale.com>
	<20120304232817.GA13516@n2100.arm.linux.org.uk>
	<4F53FBA1.8090200@freescale.com>
	<20120305000411.GL7363@n2100.arm.linux.org.uk>
	<4F54053F.9070502@freescale.com>
	<20120305002635.GA23798@opensource.wolfsonmicro.com>
	<20120306104015.GF17370@n2100.arm.linux.org.uk>
	<20120306120646.GH19635@opensource.wolfsonmicro.com>
	<20120306122516.GH17370@n2100.arm.linux.org.uk>
	<20120306123322.GP19635@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
	(tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 686631044FD
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 14:02:43 +0100 (CET)
In-Reply-To: <20120306123322.GP19635@opensource.wolfsonmicro.com>
Content-Language: en-US
Content-ID: <74AFC89B10B75049B1993E746F6CFCF2@mgd.freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> Well, who reads the documentation to get this stuff anyway?  As you
> observe it's far from complete about what's what locked when and how so
> you need to go to the code to see what's actually going on, especially
> whenever you need to call back into the ALSA APIs.  Though of course I'm
> pretty sure there's a bunch of uniprocessor assumptions through the body
> of driver code anyway...

So are you saying that it's possible for one CPU to call my trigger 
callback to start playback on one substream, while another CPU calls it to 
start capture on another substream?

If so, then I need to add locking in my trigger function.

-- 
Timur Tabi
Linux kernel developer at Freescale
