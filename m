From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/7] Add capture support to compress API
Date: Fri, 19 Apr 2013 19:04:13 +0530
Message-ID: <20130419133413.GD6081@intel.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
 <s5h61zi7i4o.wl%tiwai@suse.de> <20130419133058.GC6081@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id B62042610CC
 for <alsa-devel@alsa-project.org>; Fri, 19 Apr 2013 16:05:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130419133058.GC6081@intel.com>
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
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.jf.intel.com, lgirdwood@gmail.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 19, 2013 at 07:00:58PM +0530, Vinod Koul wrote:
> On Fri, Apr 19, 2013 at 03:41:11PM +0200, Takashi Iwai wrote:
> > At Thu, 18 Apr 2013 10:58:41 +0100,
> > Richard Fitzgerald wrote:
> > > 
> > > This chain of patches does some clearing up and add capture
> > > support to the compressed API.
Charles,

I am expecting capture support patches for tinycompress :)

> > > 
> > > Missing is support for capture streams that don't use the
> > > copy callback. Also I have included two patches at the end
> > > of the chain that remove the buffer pointers and just use
> > > the cumulative values however as our setup uses the copy
> > > callback these are untested past build so should be taken
> > > with caution.
> > > 
> > > Thanks,
> > > Charles
> > > 
> > > Thess patches apply to:
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
> > >   branch "for-next"
> > > 
> > > based on top of commit
> > >   126825e ALSA: snd-usb: add quirks handler for DSD streams
> > 
> > Vinod, Pierre, could you guys check these patches?
> > 
> > If these are OK, I can still merge for 3.10.  Although it's already
> > late for 3.10, there are little users of compress stuff, so the impact
> > must be fairly small.  If you guys aren't still happy, let's postpone
> > for 3.11.
> Sorry for delay and thrash on patches, my sound clone was bad...
> 
> I think I am okay with series approach. We need small fix for state check for
> read but that need not block this series
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > 
> > If we really merge it, don't you mind me merging soc-compress patch in
> > my tree (directly to for-next branch), Mark?
> i think that should be sensible :)
> 
> --
> ~Vinod
> > 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > > 
> > > - RichF
> > > 
> > > Charles Keepax (7):
> > >   ALSA: compress_core: Update calc_avail to use cumulative values
> > >   ALSA: compress_core: Calculate avail correctly for capture streams
> > >   ALSA: compress_core: Deconstify copy callback buffer
> > >   ALSA: compress_core: Add support for capture streams
> > >   ASoC: soc-compress: Deduce stream direction
> > >   ALSA: compress_core: Remove unused hw_pointer
> > >   ALSA: compress_core: Rework writes to use cumulative values
> > > 
> > >  include/sound/compress_driver.h |    4 +-
> > >  sound/core/compress_offload.c   |  117 +++++++++++++++++++++++++-------------
> > >  sound/soc/soc-compress.c        |   11 +++-
> > >  3 files changed, 87 insertions(+), 45 deletions(-)
> > > 
> > > -- 
> > > 1.7.2.5
> > > 
