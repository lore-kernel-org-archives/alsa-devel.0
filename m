From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v4 0/7] ASoC: intel - add skylake PCM driver
Date: Fri, 22 May 2015 17:50:49 +0530
Message-ID: <20150522122049.GU3140@localhost>
References: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 803D62625CF
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 14:19:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1431341645-2457-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, alsa-devel@alsa-project.org, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, May 11, 2015 at 04:23:58PM +0530, Vinod Koul wrote:
> SKL has HDA controller based audio subsystem with DSP and support for I2S,
> HDA, PDM links. The hda core code has been moved to sound/hda/ by Takashi
> which current HDA drivers use and will also be used by ASoC SKL driver.
> 
> The SKL platform driver will load and create the soc_hdac_bus which embeds
> the hdac_bus, same for hdac_device (hda codecs) and hdac_stream (pcms) This
> is on top of hdac code in Takashi's topic/hda
> 
> This patch provides the match function for asoc type hda codecs and let's
> them get enumerated by hdac. The second patch in this series adds the
> controller specific soc code. Common parts are in hdac core with changes
> introduced as part of SKL controller in soc part. Then we add the rest of
> controller PCM driver code (still HDA) and last patch breaks the HDA streams
> to host and link which will allow insertion of DSP in between these links.
> 
> The subsequent series will add IPC driver for SKL (using common IPC
> routines), then DSP topology handlers, DSP code with I2S support and then
> lastly when DFW is accepted then its handlers.
> 
> This patch series adds the hda codec match functions followed by asoc hda
> controller routines, then SKL PCM driver and last decouples the controller
> for splitting the links

Hey Mark,

Any word on this series ..

Thanks
-- 
~Vinod
> 
> Fixes in v4:
>   Updates changelog in patch1 and few other patches
>   Address Takashi's comment
>   Address Marks comments
> 
> Jeeja KP (7):
>   ASoC: hda - add ASoC HDA codec match function
>   ALSA: hda - add new HDA registers
>   ASoC: hda - add asoc hda core bus, controller and stream helpers
>   ASoC: intel - add Skylake HDA platform driver
>   ASoC: intel - add Skylake HDA audio driver
>   ASoC: intel - add makefile support for SKL driver
>   ASoC: intel - adds support for decoupled mode in skl driver
> 
>  include/sound/hda_register.h          |  88 ++++
>  include/sound/soc-hda-codec.h         |  49 ++
>  include/sound/soc-hdaudio.h           | 360 +++++++++++++
>  sound/soc/Kconfig                     |   1 +
>  sound/soc/Makefile                    |   1 +
>  sound/soc/hda/Kconfig                 |   3 +
>  sound/soc/hda/Makefile                |   4 +
>  sound/soc/hda/soc-hda-codec.c         |  89 ++++
>  sound/soc/hda/soc-hdac-bus.c          | 115 +++++
>  sound/soc/hda/soc-hdac-controller.c   | 296 +++++++++++
>  sound/soc/hda/soc-hdac-stream.c       | 409 +++++++++++++++
>  sound/soc/intel/Kconfig               |  17 +
>  sound/soc/intel/Makefile              |   1 +
>  sound/soc/intel/skylake/Makefile      |   3 +
>  sound/soc/intel/skylake/hda-skl-pcm.c | 937 ++++++++++++++++++++++++++++++++++
>  sound/soc/intel/skylake/hda-skl.c     | 670 ++++++++++++++++++++++++
>  sound/soc/intel/skylake/hda-skl.h     |  74 +++
>  17 files changed, 3117 insertions(+)
>  create mode 100644 include/sound/soc-hda-codec.h
>  create mode 100644 include/sound/soc-hdaudio.h
>  create mode 100644 sound/soc/hda/Kconfig
>  create mode 100644 sound/soc/hda/Makefile
>  create mode 100644 sound/soc/hda/soc-hda-codec.c
>  create mode 100644 sound/soc/hda/soc-hdac-bus.c
>  create mode 100644 sound/soc/hda/soc-hdac-controller.c
>  create mode 100644 sound/soc/hda/soc-hdac-stream.c
>  create mode 100644 sound/soc/intel/skylake/Makefile
>  create mode 100644 sound/soc/intel/skylake/hda-skl-pcm.c
>  create mode 100644 sound/soc/intel/skylake/hda-skl.c
>  create mode 100644 sound/soc/intel/skylake/hda-skl.h
> 
> -- 
> 1.9.1
> 

-- 
