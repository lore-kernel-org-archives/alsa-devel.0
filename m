From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 8/8] ASoC: Intel: Allocate for the
 mailbox with max size
Date: Tue, 19 May 2015 16:37:50 +0530
Message-ID: <20150519110750.GL3140@localhost>
References: <1432027840-18711-1-git-send-email-vinod.koul@intel.com>
 <1432027840-18711-9-git-send-email-vinod.koul@intel.com>
 <s5hoalgzw5g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A6F6F2650C3
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 13:06:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hoalgzw5g.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 19, 2015 at 12:42:03PM +0200, Takashi Iwai wrote:
> At Tue, 19 May 2015 15:00:40 +0530,
> Vinod Koul wrote:
> > 
> > From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
> > 
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/intel/common/sst-ipc.c | 29 ++++++++++++++++++++++++++++-
> >  sound/soc/intel/common/sst-ipc.h |  4 ++--
> >  2 files changed, 30 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/soc/intel/common/sst-ipc.c b/sound/soc/intel/common/sst-ipc.c
> > index a7699f35a8d2..a12c7bb08d3b 100644
> > --- a/sound/soc/intel/common/sst-ipc.c
> > +++ b/sound/soc/intel/common/sst-ipc.c
> > @@ -129,11 +129,31 @@ static int msg_empty_list_init(struct sst_generic_ipc *ipc)
> >  		return -ENOMEM;
> >  
> >  	for (i = 0; i < IPC_EMPTY_LIST_SIZE; i++) {
> > +		ipc->msg[i].tx_data = kzalloc(ipc->tx_data_max_size, GFP_KERNEL);
> > +		if (ipc->msg[i].tx_data == NULL)
> > +			goto free_mem;
> > +
> > +		ipc->msg[i].rx_data = kzalloc(ipc->rx_data_max_size, GFP_KERNEL);
> > +		if (ipc->msg[i].rx_data == NULL) {
> > +			kfree(ipc->msg[i].tx_data);
> > +			goto free_mem;
> > +		}
> > +
> >  		init_waitqueue_head(&ipc->msg[i].waitq);
> >  		list_add(&ipc->msg[i].list, &ipc->empty_list);
> 
> Wouldn't this leave stale linked list entries at error?
Yes it will, but this is happening at device probe, so the probe will fail
and device will no longer be usable. We do free the memory so shouldn't
leak.

-- 
~Vinod
