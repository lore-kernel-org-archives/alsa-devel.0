From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH 1/2] dma: Add a PAUSE_RESUME capability
Date: Thu, 30 May 2013 22:19:35 +0530
Message-ID: <1369932575.3890.18.camel@vkoul-udesk3>
References: <1369827743-5533-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 600BA26168C
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 19:27:10 +0200 (CEST)
In-Reply-To: <1369827743-5533-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Scott Jiang <scott.jiang.linux@gmail.com>, alsa-devel@alsa-project.org, Steven Miao <realmz6@gmail.com>, vinod.koul@intel.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, uclinux-dist-devel@blackfin.uclinux.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2013-05-29 at 13:42 +0200, Lars-Peter Clausen wrote:
> Add a capability which allows dmaengine consumers to query whether a dmaengine
> controller supports the DMA_PAUSE and DMA_RESUME commands. Sometimes a user of
> the dmaengine API needs to know in advance if a channel will support
> pause/resume. E.g. in ALSA the information whether it is possible to
> pause/resume a audio stream or whether it is necessary to abort and restart the
> stream is communicated to userspace so it can act accordingly.
- This mail-list is not correct for this patch
- use get_maintainer.pl, if you dont know but you already know!
- always CC maintainers

the enum dma_transaction_type reports what kind of transactions DMA
controller is capable of. This is not for capabilities of a given
transaction type, so this approach is not right.

Unfortunately, this is not supported by dmaengine atm. We had discussed
this in last plumbers, and discussion with Matt was to add capability
API (at least for slave usages). The work from Matt had reached a good
point but unfortunately didn't reach its conclusion. [1]

Let me resurrect those patches and add the pause, resume query to it in
more generic way

--
~Vinod

[1]: https://patchwork.kernel.org/patch/2094891/
