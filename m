From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: DaVinci: Fix McASP hardware FIFO
 configuration
Date: Mon, 14 Jun 2010 14:43:35 +0100
Message-ID: <1276523015.3064.4.camel@odin>
References: <1276496066-4489-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D0D22103840
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Jun 2010 15:43:37 +0200 (CEST)
Received: by wyb32 with SMTP id 32so3827330wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 14 Jun 2010 06:43:36 -0700 (PDT)
In-Reply-To: <1276496066-4489-1-git-send-email-sudhakar.raj@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-14 at 11:44 +0530, Sudhakar Rajashekhara wrote:
> On DA830/OMAP-L137 and DA850/OMAP-L138 SoCs, the McASP peripheral
> has FIFO support. This FIFO provides additional data buffering. It
> also provides tolerance to variation in host/DMA controller response
> times. More details of the FIFO operation can be found at
> 
> http://focus.ti.com/general/docs/lit/getliterature.tsp?literatureNumber=sprufm1&fileType=pdf
> 
> Existing sequence of steps for audio playback/capture are:
> a. DMA configuration
> b. McASP configuration (configures and enables FIFO)
> c. Start DMA
> d. Start McASP (enables FIFO)
> 
> During McASP configuration, while FIFO was being configured, FIFO
> was being enabled in davinci_hw_common_param() function of
> sound/soc/davinci/davinci-mcasp.c file. This generated a transmit
> DMA event, which gets serviced when DMA is started.
> 
> https://patchwork.kernel.org/patch/84611/ patch clears the DMA
> events before starting DMA, which is the right thing to do. But
> this resulted in a state where DMA was waiting for an event from
> McASP (after step c above), but the event which was already there,
> has got cleared (because of step b above).
> 
> The fix is not to enable the FIFO during McASP configuration as
> FIFO was being enabled as part of McASP start.
> 
> Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
