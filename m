From: "yitian" <yitian.bu@tangramtek.com>
Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop
	transferring issue
Date: Thu, 1 Oct 2015 10:24:42 +0800
Message-ID: <00f401d0fbf0$65f32220$31d96660$@tangramtek.com>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
 <20150930182219.GU15635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpproxy19.qq.com (smtpproxy19.qq.com [184.105.206.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D3A1266560
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 04:25:20 +0200 (CEST)
In-Reply-To: <20150930182219.GU15635@sirena.org.uk>
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org, Andrew.Jackson@arm.com, lgirdwood@gmail.com, tiwai@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of Mark
> Brown
> Sent: Thursday, October 1, 2015 2:22 AM
> To: yitian <yitian.bu@tangramtek.com>
> Cc: alsa-devel@alsa-project.org; wsa@the-dreams.de;
> linux-kernel@vger.kernel.org; Andrew.Jackson@arm.com; tiwai@suse.com;
> lgirdwood@gmail.com; perex@perex.cz;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma stop transferring
> issue
> 
> On Tue, Sep 29, 2015 at 10:43:17PM +0800, yitian wrote:
> > Designware I2S uses tx empty and rx available signals as the DMA
> > handshaking signals. during music playing, if XRUN occurs,
> > i2s_stop() function will be executed and both tx and rx irq are
> > masked, when music continues to be played, i2s_start() is executed
> > but both tx and rx irq are not unmasked which cause I2S stop
> > sending DMA handshaking signal to DMA controller, and it finally
> > causes music playing will be stopped once XRUN occurs for the first
> > time.
> 
> I'm a bit concerned about how this code ever worked given the above
> description - is there some race condition which allows things to work
> if we're lucky?

Hi Mark:

Thanks for your comments.
I think maybe two reasons:
1. designware I2S IP in my chipset(new design) is using tx empty and rx
available signal as the DMA handshaking signal, but it may be not true
for all chipsets. If I2S has separate signal as DMA handshaking signal, mask
irq should not impact DMA transfer. But Synopsys's engineer recommend us to
use
tx and rx irq signal as the DMA handshaking signal, meanwhile we cannot find
separate DMA handshaking signal from designware's IP spec, that's why tx/rx
irq
will impact DMA transfer.

2. I am using a FPGA for test, the cpu frequency of it is only 26MHz, that
means
XRUN is very easy to happen on my board. But I guess most of the developers
are using real chipset which can have at least 600MHz frequency so XRUN is
not easy to be reproduced. As my test, No XUN, no this bug...
