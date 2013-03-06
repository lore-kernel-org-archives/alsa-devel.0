From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
Date: Wed, 6 Mar 2013 17:41:59 +0100
Message-ID: <201303061741.59436.marex@denx.de>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <201303060028.18625.marex@denx.de>
 <20130306051131.GB1828@S2100-06.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130306051131.GB1828@S2100-06.ap.freescale.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Huang Shijie <b32955@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Dear Shawn Guo,

> On Wed, Mar 06, 2013 at 12:28:18AM +0100, Marek Vasut wrote:
> > Hi Shawn,
> > 
> > > With generic DMA device tree binding and helper function
> > > dma_request_slave_channel() in place, dmaengine_pcm should support
> > > that in requesting DMA channel for users that support generic DMA
> > > device tree binding.
> > > 
> > > Add a new API snd_dmaengine_generic_pcm_open() as the variant of
> > > snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
> > > and slave channel name as arguments and calls generic DMA helper
> > > dma_request_slave_channel() to request DMA channel from dmaengine.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > > Cc: alsa-devel@alsa-project.org
> > > ---
> > > 
> > > Changes since v2:
> > >  - Drop 'const' from argument 'name' to fix the warning below.
> > 
> > [...]
> > 
> > v3 changelog missing ;-) What did you adjust here please?
> 
> The "Changes since v2" means v3 changelog.

Bah, it was too late then, sorry.

Best regards,
Marek Vasut
