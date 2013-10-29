From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
Date: Tue, 29 Oct 2013 12:53:35 +0000
Message-ID: <flq2m8se8fxm4icha4yrpcbn.1383051217235@email.android.com>
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>,<526FAD41.2000805@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <526FAD41.2000805@tabi.org>
Content-Language: en-US
Sender: linux-doc-owner@vger.kernel.org
To: Timur Tabi <timur@tabi.org>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>, "broonie@kernel.org" <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, Huang Shijie-B32955 <B32955@freescale.co>
List-Id: alsa-devel@alsa-project.org

Without dual fifo support,  handware underrun would occasionally occur and then two audio channels would physically swap. This could be easily reproduced in low bus frequency situation, while it would be better if we enable dual fifo.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.

Have you measured any real performance gain with this patch?  I
considered adding dual-FIFO support when I originally wrote this driver,
but it didn't appear to have any real benefit, but it used twice as many
DMA channels.

I'm concerned that this is another patch that just enables a useless
feature.


