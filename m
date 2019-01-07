From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] ASoC: Intel: Skylake: Switch to modern
 UUID API
Date: Mon, 7 Jan 2019 19:24:40 +0200
Message-ID: <20190107172440.GX9170@smile.fi.intel.com>
References: <20180716095240.7399-1-andriy.shevchenko@linux.intel.com>
 <20190107155556.GR9170@smile.fi.intel.com>
 <24418025-f870-8865-0fa2-6d443921ac02@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 15EDD266A73
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 18:24:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <24418025-f870-8865-0fa2-6d443921ac02@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Jie Yang <yang.jie@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 07, 2019 at 10:33:21AM -0600, Pierre-Louis Bossart wrote:
> On 1/7/19 9:55 AM, Andy Shevchenko wrote:
> > On Mon, Jul 16, 2018 at 12:52:40PM +0300, Andy Shevchenko wrote:
> > > Switch the driver to use modern UUID API, i.e. guid_t type and
> > > accompanying functions, such as guid_equal().
> > > 
> > Any comments on this?
> 
> What is the motivation for this change, is this alignment to new APIs or
> that the legacy code will be removed?

The idea is to get rid of legacy API at some point. At least for now to
minimize its use in the kernel.

> I don't know enough about this API and I don't know if we can "prove" the
> changes are harmless, so my main concern is testing and backwards
> compatibility. This Skylake topology code is far from simple, I don't know
> if there's anyone that actually understands it and we already have some
> platforms where the mainline kernel doesn't seem to work due to obscure
> topology issues, so we might want to leave it alone. "If it ain't broke
> don't fix it" applies here.

-- 
With Best Regards,
Andy Shevchenko
