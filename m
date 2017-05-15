From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: dw: Remove AVR32 bits
 from the driver
Date: Mon, 15 May 2017 20:19:40 +0530
Message-ID: <20170515144939.GC15061@localhost>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
 <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
 <20170514130457.GK6263@localhost>
 <1494837791.6967.44.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D9EFB266E0E
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 16:47:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1494837791.6967.44.camel@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
List-Id: alsa-devel@alsa-project.org

On Mon, May 15, 2017 at 11:43:11AM +0300, Andy Shevchenko wrote:
> On Sun, 2017-05-14 at 18:34 +0530, Vinod Koul wrote:
> > On Tue, May 09, 2017 at 07:18:37PM +0300, Andy Shevchenko wrote:
> > > AVR32 is gone. Now it's time to clean up the driver by removing
> > > leftovers that was used by AVR32 related code.
> > 
> > Since the cover didn't mention any dependency, I went ahead and
> > applied this
> > now
> > 
> 
> Sorry, I forgot to mention that it's supposed to go via either tree,
> though together. Since first we remove users of non-standard DMA
> callbacks.

Okay dropped it, anyway the kbuild complained due to dependency

SO if you want this to be merged thru sound tree:

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
