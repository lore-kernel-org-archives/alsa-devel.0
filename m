From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: Intel: Boards: Add CNL RT274 I2S
 machine driver
Date: Tue, 28 Nov 2017 21:54:15 +0530
Message-ID: <20171128162415.GV3187@localhost>
References: <20171127124437.8441-1-guneshwor.o.singh@intel.com>
 <5bdd77e1-fb83-0626-c377-a457294ca38d@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 181BB2677C6
 for <alsa-devel@alsa-project.org>; Tue, 28 Nov 2017 17:20:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <5bdd77e1-fb83-0626-c377-a457294ca38d@linux.intel.com>
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
Cc: ALSA ML <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Guneshwor Singh <guneshwor.o.singh@intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 27, 2017 at 08:45:16AM -0600, Pierre-Louis Bossart wrote:
> On 11/27/17 6:44 AM, Guneshwor Singh wrote:
> >Add CNL I2S machine driver using Realtek RT274 codec in I2S mode
> >configured to ssp0.
> >
> >Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
> >---
> >  sound/soc/intel/boards/Kconfig     |  13 ++
> >  sound/soc/intel/boards/Makefile    |   2 +
> >  sound/soc/intel/boards/cnl_rt274.c | 250 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 265 insertions(+)
> >  create mode 100644 sound/soc/intel/boards/cnl_rt274.c
> >
> >diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
> >index 6f754708a48c..29066f0b744f 100644
> >--- a/sound/soc/intel/boards/Kconfig
> >+++ b/sound/soc/intel/boards/Kconfig
> >@@ -262,4 +262,17 @@ config SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH
> >            Say Y if you have such a device.
> >            If unsure select "N".
> >+config SND_SOC_INTEL_CNL_RT274_MACH
> >+	tristate "ASoC Audio driver for Cannonlake with RT274 I2S mode"
> >+	depends on X86 && ACPI && I2C
> >+	select SND_SOC_INTEL_SST
> >+	depends on SND_SOC_INTEL_SKYLAKE
> 
> this is going to conflict with the fixes I am working on.
> Vinod, can this wait a bit?

Hey Pierre,

Since you are still working on the fixes, I guess this can sneak in before.
The machine drivers are typically low hanging in terms on complexity so we
can merge this first followed by the rework you are doing. I think that part
will still take a bit to stabilize and cleanup.

-- 
~Vinod
