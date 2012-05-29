From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] ASoC: mmp: add audio dma support
Date: Tue, 29 May 2012 10:21:29 +0100
Message-ID: <20120529092129.GE12217@n2100.arm.linux.org.uk>
References: <1337929863-31885-1-git-send-email-zhangfei.gao@marvell.com>
	<1337929863-31885-3-git-send-email-zhangfei.gao@marvell.com>
	<1337932416.1580.2.camel@vkoul-udesk3>
	<20120525080500.GB24149@n2100.arm.linux.org.uk>
	<CAMj5Bkhc46zqY5AbJkc=-h02taP_esxrqpNu--aYtZZcVcPK6A@mail.gmail.com>
	<20120525094231.GC24149@n2100.arm.linux.org.uk>
	<CAMj5BkjhCakuZdUcA+P_nbETi8tnYK5Ok6HMWTG61whZXwCD6g@mail.gmail.com>
	<1338268734.1580.26.camel@vkoul-udesk3>
	<20120529073334.GA12217@n2100.arm.linux.org.uk>
	<20120529090215.GA3954@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 8578124AAC
	for <alsa-devel@alsa-project.org>;
	Tue, 29 May 2012 11:21:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20120529090215.GA3954@opensource.wolfsonmicro.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, alsa-devel@alsa-project.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>, Qiao Zhou <zhouqiao@marvell.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, zhangfei gao <zhangfei.gao@gmail.com>, alsa-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 29, 2012 at 10:02:15AM +0100, Mark Brown wrote:
> On Tue, May 29, 2012 at 08:33:34AM +0100, Russell King - ARM Linux wrote:
> 
> > But, as I pointed out earlier, there's the issue of using the wrong
> > struct device to allocate memory for the DMA engine.  That's something
> > that my soc-dmaengine.c got _right_, and soc-dmaengine-pcm.c gets _wrong_.
> 
> What is the issue with the current code - it *looks* like you want to
> use the component device for the DMA as the struct device with dmaengine
> but I don't understand the issue that's created if we don't (and why
> things appear to be working for people as they are).

Look.  It's very very very very simple.

What does the DMA API take?  A struct device.  What struct device?  Some
random struct device for something in the system, or what?  No, it takes
the struct device for the _device_ in the system which is _performing_
the DMA.

If your DMA is offloaded onto anther device, as is the case with DMA engine,
the _correct_ struct device to use with the DMA API is the DMA engine
device structure.  Because, if there's any restrictions on how that memory
is accessed - as I said in my other email - for instance, whether it be
that the DMA engine has an IOMMU in the way, or maybe has a restricted
view of memory - then your local struct device is the wrong one to be
using, because it will _not_ have that information to convey into the
DMA API.

Therefore, allocating or mapping DMA memory against one struct device,
and then passing it to an entirely different device in the system to
perform DMA on is _WRONG_.

It _may_ work as long as there are no restrictions or IOMMUs in the way,
because you'll happen to setup your local struct device the same as the
DMA engine struct device.  That's not always going to be the case.

If you persist in not wanting to care about this, then I'm afraid I'll
ignore soc-dmaengine-pcm.c entirely as to me its totally bolloxed code.
What I have as my own version (now with cyclic DMA support) is IMHO a
far superior and more correct implementation.
