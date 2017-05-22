From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/3] ALSA: core: modify .ack callback to
 take arguments for updating appl ptr
Date: Mon, 22 May 2017 10:51:15 +0530
Message-ID: <20170522052114.GS15061@localhost>
References: <1494896518-23399-1-git-send-email-subhransu.s.prusty@intel.com>
 <1494896518-23399-3-git-send-email-subhransu.s.prusty@intel.com>
 <0be78e8b-ebc0-9f8b-5bed-df01a791f940@sakamocchi.jp>
 <s5h7f1dmkdf.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A280266C7B
 for <alsa-devel@alsa-project.org>; Mon, 22 May 2017 07:19:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h7f1dmkdf.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>, lgirdwood@gmail.com, broonie@kernel.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 19, 2017 at 08:27:40AM +0200, Takashi Iwai wrote:
> On Fri, 19 May 2017 05:57:05 +0200,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > On May 16 2017 10:01, Subhransu S. Prusty wrote:
> > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > >
> > > When appl_ptr is updated let low-level driver know, e.g.  to let the
> > > low-level driver/hardware pre-fetch data opportunistically.
> > >
> > > The existing .ack callback is extended with new attribute argument, to
> > > support this capability. Legacy driver subscribe to SND_PCM_ACK_LEGACY and
> > > doesn't process ack if it is not set. SND_PCM_ACK_APP_PTR can be used to
> > > process the application ptr update in the driver like in the skylake
> > > driver which can use this to inform position of appl pointer to host DMA
> > > controller. The skylake driver to process the SND_PCM_ACK_APP_PTR will be
> > > submitted with a separate patch set.
> > >
> > > In the ALSA core, this capability is independent from the NO_REWIND
> > > hardware flag. The low-level driver may however tie both options and only
> > > use the updated appl_ptr when rewinds are disabled due to hardware
> > > limitations.
> > >
> > > Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > Signed-off-by: Jaikrishna Nemallapudi <jaikrishnax.nemallapudi@intel.com>
> > > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > > ---
> > >   include/sound/pcm-indirect.h  |  4 ++--
> > >   include/sound/pcm.h           |  8 +++++++-
> > >   sound/core/pcm_lib.c          |  6 ++++--
> > >   sound/core/pcm_native.c       | 24 +++++++++++++++++++++++-
> > >   sound/mips/hal2.c             | 14 +++++++++++---
> > >   sound/pci/cs46xx/cs46xx_lib.c | 18 ++++++++++++++----
> > >   sound/pci/emu10k1/emupcm.c    |  8 ++++++--
> > >   sound/pci/rme32.c             | 15 ++++++++++++---
> > >   8 files changed, 79 insertions(+), 18 deletions(-)
> > 
> > I think it better to take care of
> > 'drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c' as
> > well. This is a driver for sound functionality of Raspberry PI 1/zero
> > and some people may still get influences from this work.
> > 
> > $ git grep -A20 'struct snd_pcm_ops' v4.12-rc1 | grep \\.ack
> > v4.12-rc1:drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c-...
> > ...
> 
> Yep, we need to cover all codes if we really change the PCM ops.

Yes and fortunately there are a large set, so conversion is not a big issue
here, converging to best approach is :)

-- 
~Vinod
