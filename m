From: Timur Tabi <b04825@freescale.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error
 checking on codec-handle
Date: Wed, 14 Mar 2012 18:00:41 -0500
Message-ID: <4F612319.50302@freescale.com>
References: <1331225990-27308-1-git-send-email-shawn.guo@linaro.org>
	<1331225990-27308-10-git-send-email-shawn.guo@linaro.org>
	<4F591B8D.8090705@freescale.com>
	<20120309013216.GH2499@S2101-09.ap.freescale.net>
	<4F5FD706.8040209@freescale.com>
	<20120313234638.GY3177@opensource.wolfsonmicro.com>
	<4F6008FA.3040805@freescale.com>
	<20120314122723.GC3133@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db3outboundpool.messaging.microsoft.com
	(db3ehsobe006.messaging.microsoft.com [213.199.154.144])
	by alsa0.perex.cz (Postfix) with ESMTP id BBBB610414F
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 00:00:55 +0100 (CET)
In-Reply-To: <20120314122723.GC3133@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> All of which is exactly the same as for any other device and essentially
> irrelevant to how we define the bindings for the cards.

So using imx-audio-sgtl5000.txt as an example, you're saying that if I
have two SSIs, I should do this in my device tree:

sound1 {
	compatible = "fsl,imx51-babbage-sgtl5000",
		     "fsl,imx-audio-sgtl5000";
	model = "imx51-babbage-sgtl5000";
	ssi-controller = <&ssi1>;
	audio-codec = <&sgtl5000_1>;
	mux-int-port = <1>;
	mux-ext-port = <3>;
};

sound2 {
	compatible = "fsl,imx51-babbage-sgtl5000",
		     "fsl,imx-audio-sgtl5000";
	model = "imx51-babbage-sgtl5000";
	ssi-controller = <&ssi2>;
	audio-codec = <&sgtl5000_2>;
	mux-int-port = <1>;
	mux-ext-port = <3>;
};

>>> The biggest improvement is that the SoC binding knows nothing about the
>>> card binding at all, cards are completely separate and are free to
>>> define any binding they choose using any number of on-SoC and off-SoC
>>> devices.
> 
>> Ok, I don't understand that at all.
> 
> Do you have some questions about the above?  What is it that you find
> unclear?   

What's the difference between an "SoC binding" and a "card binding"?

> We've been through this *repeatedly*, including in the message you're
> replying to, and we're still going back to square one every time you
> decide to start talking about device tree again.  This is frustrating
> in the extreme.

I'm sorry you're frustrated, but so am I.  I still don't understand why
the binding that I invented for the SSI driver isn't good enough for i.MX.
 The binding and the code was documented and approved a long time ago.
Why can't we keep the same binding on i.MX, to keep the code simpler?

-- 
Timur Tabi
Linux kernel developer at Freescale
