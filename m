From: "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
Subject: Re: [PATCH 0/3] Add SPIB Support for Intel Skylake
 platforms
Date: Tue, 30 Jan 2018 16:37:44 +0530
Message-ID: <20180130110743.GA26938@subhransu-desktop>
References: <1517304986-16847-1-git-send-email-sriramx.periyasamy@intel.com>
 <013428a5-b593-1a7d-5a62-4e838a9fe5d0@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 20A532671F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:23:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <013428a5-b593-1a7d-5a62-4e838a9fe5d0@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>, Patches Audio <patches.audio@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "Koul,
 Vinod" <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 30, 2018 at 04:08:39PM +0530, Takashi Sakamoto wrote:
> Hi,
> 
> On Jan 30 2018 18:36, Sriram Periyasamy wrote:
> > Skylake audio controller supports SPIB (Software Position in buffer)
> > capability, which can be used to inform position of application pointer
> > to host DMA controller. When SPIB mode is enabled, driver could write
> > the application pointer position in SPIB register. Host DMA will make
> > sure it won't read/write beyond bytes specified in SPIB register.
> > 
> > SPIB mode will be useful in low power use cases, where DSP could
> > pre-fetch large buffers to avoid frequent wakes caused due to interrupts.
> > 
> > To support SPIB in the driver, save the spib values in stream context
> > which can be restored during resume from S3. Add new hw_params flag to
> > explicitly tell driver that rewinds will never be used.
> > 
> > Pierre-Louis Bossart (1):
> >   ALSA: core: let low-level driver or userspace disable rewinds
> > 
> > Ramesh Babu (2):
> >   ALSA: hda: ext: add spib to stream context
> >   ASoC: Intel: Skylake: Add support for spib mode
> > 
> >  include/sound/hdaudio_ext.h       |  1 +
> >  include/sound/pcm.h               |  1 +
> >  include/uapi/sound/asound.h       |  1 +
> >  sound/core/pcm_native.c           |  8 ++++++++
> >  sound/hda/ext/hdac_ext_stream.c   |  2 ++
> >  sound/soc/intel/skylake/skl-pcm.c | 43 ++++++++++++++++++++++++++++++++++++++-
> >  6 files changed, 55 insertions(+), 1 deletion(-)
> 
> In my opinion, when drivers
> return appropriate values at implementations of
> "struct snd_pcm_ops.pointer" and "struct snd_pcm_ops.ack", your aim is
> satisfied. In short, you can let ALSA PCM core to handle
> rewinding/forwarding requests from userland for zero number of handled
> frames in result. So the 'SNDRV_PCM_HW_PARAMS_NO_REWINDS' flag is
> useless.

Based on the earlier discussion in v3, this series includes the usage of the
'SNDRV_PCM_HW_PARAMS_NO_REWINDS' flag. Please refer to the discussion on
https://patchwork.kernel.org/patch/9795233/

> 
> From me, please refer to our previous discussion about this
> flag[1][2][3], then describe your insistence of this flag. At least,
> it's not better idea to abandon the old discussion when posting this
> kind of patches. Additionally you should add 'v4' in title of this

Yes should have added the reference and v4. Sorry to have missed it.

Regards,
Subhransu

> patchset to represent this patchset is a part of series of your work for
> the flag and your Intel platform.
> 
> [1]
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-May/120676.html
> [2]
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/121683.html
> [3]
> http://mailman.alsa-project.org/pipermail/alsa-devel/2017-June/121967.html
> 
> 
> Regards
> 
> Takashi Sakamoto
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
