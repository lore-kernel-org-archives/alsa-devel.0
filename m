From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Tue, 13 Mar 2012 18:23:50 -0500
Message-ID: <4F5FD706.8040209@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 997081041CE
	for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2012 00:25:05 +0100 (CET)
In-Reply-To: <20120309013216.GH2499@S2101-09.ap.freescale.net>
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
> Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt, which
> takes Documentation/devicetree/bindings/sound/tegra-audio-wm8903.txt
> as the example.

sound {
	compatible = "fsl,imx51-babbage-sgtl5000",
		     "fsl,imx-audio-sgtl5000";
	model = "imx51-babbage-sgtl5000";
	ssi-controller = <&ssi1>;
	audio-codec = <&sgtl5000>;
	mux-int-port = <1>;
	mux-ext-port = <3>;
};

How does this handle multiple SSIs, each connected to its own codec?

And where's the binding for the DMA controller?

I honestly don't see how this is an improvement over what I came up with.

-- 
Timur Tabi
Linux kernel developer at Freescale
