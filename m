From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] ASoC: don't call
	of_dma_request_slave_channel directly
Date: Wed, 24 Apr 2013 14:52:10 +0200
Message-ID: <201304241452.10298.arnd@arndb.de>
References: <1366732475-479886-1-git-send-email-arnd@arndb.de>
 <1366732475-479886-3-git-send-email-arnd@arndb.de>
 <20130424011153.GA2319@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 6767D265375
 for <alsa-devel@alsa-project.org>; Wed, 24 Apr 2013 14:52:23 +0200 (CEST)
In-Reply-To: <20130424011153.GA2319@shlinux1.ap.freescale.net>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Wednesday 24 April 2013, Shawn Guo wrote:
> On Tue, Apr 23, 2013 at 05:54:33PM +0200, Arnd Bergmann wrote:
> > The exported interface for device drivers is dma_request_slave_channel,
> > not of_dma_request_slave_channel. The former does not depend on device
> > tree but also works with ACPI and other interfaces providing an
> > abstraction for DMA channels.
> > 
> > This fixes link errors when building ALSA as a loadable module.
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> I had already sent a similar patch [1] for that.
> 

Yes, I see it in linux-next now.

Thanks,

	Arnd
