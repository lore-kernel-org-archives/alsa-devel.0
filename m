From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/2] dmaengine: dw: Remove AVR32 bits
	from the driver
Date: Mon, 15 May 2017 12:42:30 +0300
Message-ID: <1494841350.6967.55.camel@linux.intel.com>
References: <20170509161837.48301-1-andriy.shevchenko@linux.intel.com>
 <20170509161837.48301-3-andriy.shevchenko@linux.intel.com>
 <20170514130457.GK6263@localhost>
 <1494837791.6967.44.camel@linux.intel.com>
 <45cb3a0a-28b5-a64c-90ac-1abf0c59d70f@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B7A50266587
 for <alsa-devel@alsa-project.org>; Mon, 15 May 2017 11:45:36 +0200 (CEST)
In-Reply-To: <45cb3a0a-28b5-a64c-90ac-1abf0c59d70f@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vinod.koul@intel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org, Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2017-05-15 at 11:25 +0200, Lars-Peter Clausen wrote:
> On 05/15/2017 10:43 AM, Andy Shevchenko wrote:
> > On Sun, 2017-05-14 at 18:34 +0530, Vinod Koul wrote:
> > > On Tue, May 09, 2017 at 07:18:37PM +0300, Andy Shevchenko wrote:
> > > > AVR32 is gone. Now it's time to clean up the driver by removing
> > > > leftovers that was used by AVR32 related code.
> > > 
> > > Since the cover didn't mention any dependency, I went ahead and
> > > applied this
> > > now
> > > 
> > 
> > Sorry, I forgot to mention that it's supposed to go via either tree,
> > though together. Since first we remove users of non-standard DMA
> > callbacks.
> > 
> 
> Since there is no hurry maybe split it over multiple releases. Audio
> patch
> now through the audio tree and once it has made it to a upstream
> release
> apply the DMA patch through the DMA tree.

While there is indeed no hurry (I'm not expecting long patches against
dw_dmac), we may do that, though OTOH better to do it at once to
minimize a probability that the second change might be forgotten for
longer.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
