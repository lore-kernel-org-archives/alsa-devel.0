From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: PM issue with Intel SST Atom driver
Date: Mon, 24 Apr 2017 21:57:38 +0530
Message-ID: <20170424162738.GU6263@localhost>
References: <s5hpog5dgh8.wl-tiwai@suse.de> <20170424050144.GG6263@localhost>
 <s5ho9vmjmyv.wl-tiwai@suse.de> <s5hpog2b2o2.wl-tiwai@suse.de>
 <20170424091213.GO6263@localhost> <s5hh91eb0oc.wl-tiwai@suse.de>
 <20170424095244.GP6263@localhost> <s5hefwib075.wl-tiwai@suse.de>
 <d4e73746-40f7-8929-bdc4-5bf54aef982d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A7943266DED
 for <alsa-devel@alsa-project.org>; Mon, 24 Apr 2017 18:25:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d4e73746-40f7-8929-bdc4-5bf54aef982d@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 24, 2017 at 09:22:38AM -0500, Pierre-Louis Bossart wrote:
> On 4/24/17 4:54 AM, Takashi Iwai wrote:
> >On Mon, 24 Apr 2017 11:52:44 +0200,
> >Vinod Koul wrote:
> >>
> >>On Mon, Apr 24, 2017 at 11:43:47AM +0200, Takashi Iwai wrote:
> >>>On Mon, 24 Apr 2017 11:12:14 +0200,
> >>>Vinod Koul wrote:
> >>>>
> >>>>On Mon, Apr 24, 2017 at 11:00:45AM +0200, Takashi Iwai wrote:
> >>>>
> >>>>>Removing ignore_suspend makes the PM succeeds.  But it hits some other
> >>>>>ugly kernel bugs.
> >>>>
> >>>>Okay have you marked .nonatomic = true for the machine DAIs?
> >>>
> >>>Ah that's it.  The patch below seems fixing the PM and the nonatomic
> >>>problems.  I'm not sure about the nonatomic flag for the compress
> >>>stream, though.
> >>
> >>Well we dont have upstream decoders so it wont be used in this case.
> >>
> >>>Also I fiddled only with FE.  Do we need the same flags for BE?  The
> >>>others don't look setting like that, so I left so.
> >>
> >>I dont remember if BE needs or not FE should suffice.
> >
> >OK then I leave it as is.
> >
> >When I submit the fix, I should put Cc to stable, and wonder which
> >version we assure the nonatomic ops in SST driver.  Did the code base
> >support nonatomic ops from the beginning?
> 
> can we take this opportunity to align all drivers?
> The .nonatomic=true is set in all drivers for the BE, except for
> cht_bsw_max98090_ti.c

??

$ grep nonatomic sound/soc/intel/boards/cht_bsw_max98090_ti.c
                .nonatomic = true,
                .nonatomic = true,

> It's either needed for all or not needed for all...

For the record it is must have for all of the drivers :)

$ grep -L nonatomic sound/soc/intel/boards/*.c
sound/soc/intel/boards/bdw-rt5677.c
sound/soc/intel/boards/broadwell.c
sound/soc/intel/boards/byt-max98090.c
sound/soc/intel/boards/byt-rt5640.c
sound/soc/intel/boards/haswell.c
sound/soc/intel/boards/mfld_machine.c

So we should add the remaining one byt-max98090.c as Takashi fixed
byt-rt5640.c one. I will send the patch for this one.

-- 
~Vinod
