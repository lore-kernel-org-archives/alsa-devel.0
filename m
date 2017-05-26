From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA: core: modify .ack callback to
 take arguments for updating appl ptr
Date: Fri, 26 May 2017 13:31:16 +0530
Message-ID: <20170526080116.GJ15061@localhost>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
 <1494896518-23399-3-git-send-email-subhransu.s.prusty@intel.com>
 <0be78e8b-ebc0-9f8b-5bed-df01a791f940@sakamocchi.jp>
 <s5h7f1dmkdf.wl-tiwai@suse.de>
 <c2cb17f3-a37f-8e7e-eac5-0fcb0178f2bd@linux.intel.com>
 <20170522052219.GT15061@localhost> <s5hefvhicod.wl-tiwai@suse.de>
 <20170526074243.GI15061@localhost> <s5hzie0hxez.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id DDDF7266B88
 for <alsa-devel@alsa-project.org>; Fri, 26 May 2017 09:59:01 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hzie0hxez.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, lgirdwood@gmail.com, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, broonie@kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 26, 2017 at 09:47:32AM +0200, Takashi Iwai wrote:
> On Fri, 26 May 2017 09:42:43 +0200,
> Vinod Koul wrote:
> > 
> > On Mon, May 22, 2017 at 09:16:34AM +0200, Takashi Iwai wrote:
> > > On Mon, 22 May 2017 07:22:19 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > On Fri, May 19, 2017 at 10:01:04AM -0500, Pierre-Louis Bossart wrote:
> > > > > On 5/19/17 1:27 AM, Takashi Iwai wrote:
> > > > > >On Fri, 19 May 2017 05:57:05 +0200,
> > > > > >Takashi Sakamoto wrote:
> > > > > >>
> > > > > >>Hi,
> > > > > >>
> > > > > >>On May 16 2017 10:01, Subhransu S. Prusty wrote:
> > > > > >>>From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > >>>
> > > > > >>>When appl_ptr is updated let low-level driver know, e.g.  to let the
> > > > > >>>low-level driver/hardware pre-fetch data opportunistically.
> > > > > >>>
> > > > > >>>The existing .ack callback is extended with new attribute argument, to
> > > > > >>>support this capability. Legacy driver subscribe to SND_PCM_ACK_LEGACY and
> > > > > >>>doesn't process ack if it is not set. SND_PCM_ACK_APP_PTR can be used to
> > > > > >>>process the application ptr update in the driver like in the skylake
> > > > > >>>driver which can use this to inform position of appl pointer to host DMA
> > > > > >>>controller. The skylake driver to process the SND_PCM_ACK_APP_PTR will be
> > > > > >>>submitted with a separate patch set.
> > > > > >>>
> > > > > >>>In the ALSA core, this capability is independent from the NO_REWIND
> > > > > >>>hardware flag. The low-level driver may however tie both options and only
> > > > > >>>use the updated appl_ptr when rewinds are disabled due to hardware
> > > > > >>>limitations.
> > > > > >>>
> > > > > >>>Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > >>>Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> > > > > >>>Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > > > >>>---
> > > > > >>>  include/sound/pcm-indirect.h  |  4 ++--
> > > > > >>>  include/sound/pcm.h           |  8 +++++++-
> > > > > >>>  sound/core/pcm_lib.c          |  6 ++++--
> > > > > >>>  sound/core/pcm_native.c       | 24 +++++++++++++++++++++++-
> > > > > >>>  sound/mips/hal2.c             | 14 +++++++++++---
> > > > > >>>  sound/pci/cs46xx/cs46xx_lib.c | 18 ++++++++++++++----
> > > > > >>>  sound/pci/emu10k1/emupcm.c    |  8 ++++++--
> > > > > >>>  sound/pci/rme32.c             | 15 ++++++++++++---
> > > > > >>>  8 files changed, 79 insertions(+), 18 deletions(-)
> > > > > >>
> > > > > >>I think it better to take care of
> > > > > >>'drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c' as
> > > > > >>well. This is a driver for sound functionality of Raspberry PI 1/zero
> > > > > >>and some people may still get influences from this work.
> > > > > >>
> > > > > >>$ git grep -A20 'struct snd_pcm_ops' v4.12-rc1 | grep \\.ack
> > > > > >>v4.12-rc1:drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c-...
> > > > > >>...
> > > > > >
> > > > > >Yep, we need to cover all codes if we really change the PCM ops.
> > > > > 
> > > > > The reason precisely why I preferred to avoid mucking with the
> > > > > existing .ack(). we have a risk of introducing problems for legacy
> > > > > and staging, not to mention out-of-tree.
> > > > 
> > > > Patching them should be fine, and I wont mind breaking out-of tree ones,
> > > > isn't that a good thing :)
> > > 
> > > Heh, that's a fun as always :)
> > > 
> > > Actually it's a difficult judgment when to change the API and when
> > > not.  This case is also in the gray zone.
> > > 
> > > If it were only additions of some new features, I'd think of avoiding
> > > to change the existing API.  But, when it eventually fixes the bugs in
> > > the existing drivers, we should not be too afraid of changing it.
> > 
> > Then this case falls in the case where we are not changing API, right. If
> > you agree we can post the other approach.
> 
> Actually the changes for ack have been merged yesterday; the ack gets
> called whenever appl_ptr changes.  This *is* the right behavior, after
> all.


Thats right, so we don't need additonal arg anymore, thanks for pointing out.
I had missed the patches.

Will respin this on top of those changes

-- 
~Vinod
