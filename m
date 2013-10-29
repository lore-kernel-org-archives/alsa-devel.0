From: Timur Tabi <timur@tabi.org>
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
Date: Tue, 29 Oct 2013 07:42:41 -0500
Message-ID: <526FAD41.2000805@tabi.org>
References: <cover.1383047327.git.b42378@freescale.com> <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nicolin Chen <b42378@freescale.com>, shawn.guo@linaro.org, broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, rob.herring@calxeda.com, mark.rutland@arm.com, swarren@wwwdotorg.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, s.hauer@pengutronix.de, b32955@freescale.com
List-Id: alsa-devel@alsa-project.org

Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.

Have you measured any real performance gain with this patch?  I 
considered adding dual-FIFO support when I originally wrote this driver, 
but it didn't appear to have any real benefit, but it used twice as many 
DMA channels.

I'm concerned that this is another patch that just enables a useless 
feature.
