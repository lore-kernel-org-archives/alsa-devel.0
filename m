From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 0/3] ALSA: hda: bus cleanup
Date: Thu, 8 Aug 2019 09:23:40 -0500
Message-ID: <ae7d32fe-a279-8309-2370-1832edcce413@linux.intel.com>
References: <20190808095715.29713-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EB7EF800E3
 for <alsa-devel@alsa-project.org>; Thu,  8 Aug 2019 16:23:43 +0200 (CEST)
In-Reply-To: <20190808095715.29713-1-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Cezary Rojewski <cezary.rojewski@intel.com>, Thierry Reding <thierry.reding@gmail.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



On 8/8/19 4:57 AM, Takashi Iwai wrote:
> Hi,
> 
> this is a few patches to simplify and cleanup the HD-audio bus ops.
> 
> The first two patches translate the indirect calls of DMA page
> allocation and MMIO accesses with the direct ones, as well as
> eliminating the whole bus->io_ops.
> 
> The last one is SOF-specific, and fixes/cleans up by calling the
> proper hdaudio bus init function, as formerly discussed.

This is a good cleanup, thanks Takashi.

For the series

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

One request from me since I am lazy: could we somehow merge branches 
between you / Mark since at the moment we have two sets of conflicts 
(NHLT and this one). We test all the upstream changes on hardware as 
soon as we can, and manual conflict resolution makes it slower/more 
error prone.

> 
> 
> Takashi
> 
> ===
> 
> Takashi Iwai (3):
>    ALSA: hda: Remove page allocation redirection
>    ALSA: hda: Direct MMIO accesses
>    ASoC: SOF: Intel: Initialize hdaudio bus properly
> 
>   include/sound/hdaudio.h                | 69 +++++++++++++--------------
>   include/sound/hdaudio_ext.h            |  1 -
>   sound/hda/Kconfig                      |  3 ++
>   sound/hda/ext/hdac_ext_bus.c           | 60 +-----------------------
>   sound/hda/hdac_bus.c                   | 36 ++++++++++++--
>   sound/hda/hdac_controller.c            | 18 +++----
>   sound/hda/hdac_stream.c                |  8 ++--
>   sound/pci/hda/Kconfig                  |  1 +
>   sound/pci/hda/hda_controller.c         |  6 +--
>   sound/pci/hda/hda_controller.h         |  3 +-
>   sound/pci/hda/hda_intel.c              | 71 ++--------------------------
>   sound/pci/hda/hda_tegra.c              | 84 +--------------------------------
>   sound/soc/intel/skylake/skl-messages.c | 15 +-----
>   sound/soc/intel/skylake/skl.c          |  7 ++-
>   sound/soc/sof/intel/hda-bus.c          | 85 ++++------------------------------
>   sound/soc/sof/intel/hda-dsp.c          |  2 +-
>   sound/soc/sof/intel/hda.c              |  6 +--
>   sound/soc/sof/intel/hda.h              |  3 +-
>   18 files changed, 107 insertions(+), 371 deletions(-)
> 
