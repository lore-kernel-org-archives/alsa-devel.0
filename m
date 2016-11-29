From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: Replace kthread with work
Date: Tue, 29 Nov 2016 19:13:41 +0530
Message-ID: <20161129134340.GS6408@localhost>
References: <20161128153219.31289-1-tiwai@suse.de>
 <20161128155236.GF6408@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A64C2667C9
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 14:34:06 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20161128155236.GF6408@localhost>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 28, 2016 at 09:22:36PM +0530, Vinod Koul wrote:
> On Mon, Nov 28, 2016 at 04:32:19PM +0100, Takashi Iwai wrote:
> > The usage pattern of kthread worker in Intel SST drivers can be
> > replaced gracefully with the normal workqueue, which is more light-
> > weight and easier to manage in general.  Let's do it.
> > 
> > While in the replacement, move the schedule_work() call inside the
> > spinlock for excluding the race, too.
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> > 
> > Vinod, I tested this only lightly, so it'd be helpful if the patch is
> > checked on the affected devices before merging.
> 
> We had  apatch done last week internally for this, but this one is fine too.
> 
> I will get it verfied on SKL tomorrow and get back

Hi Takashi,

Works fine :)

Acked-by: Vinod Koul <vinod.koul@intel.com>
Tested-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>

Thanks
-- 
~Vinod
