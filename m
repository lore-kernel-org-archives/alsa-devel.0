From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 0/7] ALSA: Add rewinds disabled, delays,
 max_inflight_bytes
Date: Mon, 3 Oct 2016 09:58:44 +0530
Message-ID: <20161003042840.GA23816@subhransu-desktop>
References: <1475239410-16548-1-git-send-email-subhransu.s.prusty@intel.com>
 <s5hbmz53500.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B22A26644C
 for <alsa-devel@alsa-project.org>; Mon,  3 Oct 2016 06:35:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbmz53500.wl-tiwai@suse.de>
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
Cc: patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 30, 2016 at 03:13:19PM +0200, Takashi Iwai wrote:
> On Fri, 30 Sep 2016 14:43:23 +0200,
> Subhransu S. Prusty wrote:
> > 
> > Set of patches to fix issues with delays, hw_ptr fuzziness [1] and
> > increased buffering w/ DSPs
> > 
> > 1. Rewinds can be disabled  when data written in ring buffer will never be
> > validated. This allow for new HDaudio SPIB DMA functionality(allow fetch up to the
> > application pointer, no rewind supported)
> > 
> > 2. Report max in-flight bytes to avoid problems with stale data (like late
> > wake-ups, rewinds)
> > 
> > 3. add new estimate for USB startup delay.
> 
> Well, all these three are really individual and independent features.
> So, please send three patch sets instead.

Sure. I will send separate patch series for each of them.

> 
> For example, I would apply the USB startup delay fix easily, while the
> inflight bytes feature needs more discussion.  The rewind disablement
> needs a bit more discussion (e.g. can it be disabled from the driver
> side as well?).

No I think. Considering the SPIB usecases, user may decide to use SPIB or not.

Regards,
Subhransu

> 
> 
> thanks,
> 
> Takashi
> 
> > 
> > [1]
> > http://mailman.alsa-project.org/pipermail/alsa-devel/2015-June/093646.html
> > 
> > 
> > Pierre-Louis Bossart (6):
> >   ALSA: core: let low-level driver or userspace disable rewinds
> >   ALSA: core: add .update_appl_ptr callback for pcm ops
> >   ALSA: core: add report of max inflight bytes
> >   ALSA: hda: add default value for max_inflight_bytes
> >   ALSA: usb: no_period_wake and max_inflight_bytes report
> >   ALSA: usb: take startup delay into account
> > 
> > Ramesh Babu (1):
> >   ALSA: pcm: avoid mmap of control data if .update_appl_ptr is
> >     implemented
> > 
> >  include/sound/pcm.h            |  4 +++
> >  include/uapi/sound/asound.h    |  6 ++--
> >  sound/core/pcm_lib.c           | 26 ++++++++++++++++++
> >  sound/core/pcm_native.c        | 51 +++++++++++++++++++++++++++++++++-
> >  sound/pci/hda/hda_controller.c |  1 +
> >  sound/usb/card.h               |  1 +
> >  sound/usb/pcm.c                | 62 +++++++++++++++++++++++++++++++++++++-----
> >  7 files changed, 141 insertions(+), 10 deletions(-)
> > 
> > -- 
> > 1.9.1
> > 

-- 
