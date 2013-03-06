From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm:
	add	snd_dmaengine_generic_pcm_open()
Date: Wed, 6 Mar 2013 17:13:33 +0000
Message-ID: <20130306171333.GR17833@n2100.arm.linux.org.uk>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 3BFCD265CD1
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 18:14:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marek.vasut@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Huang Shijie <b32955@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 05, 2013 at 10:37:27PM +0800, Shawn Guo wrote:
> With generic DMA device tree binding and helper function
> dma_request_slave_channel() in place, dmaengine_pcm should support
> that in requesting DMA channel for users that support generic DMA
> device tree binding.

This purpetuates the brain-dead behaviour of the existing ASoC DMA
engine layer, which makes it unsuitable for platforms with special DMA
memory requirements.

The problem is that the DMA mask to be used for allocating DMA-able
memory is the DMA engine struct device, not the struct device associated
with the ASoC device.

I got this right in my ASoC generic DMA engine layer.  Converting this
layer is far from trivial though, and as my test platform has now become
my entire network firewall, I'm not doing any testing on that anymore.
