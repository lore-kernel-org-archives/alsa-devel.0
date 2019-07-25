From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Makefile - fix the top-level
 kernel module names (add snd- prefix)
Date: Thu, 25 Jul 2019 08:07:07 -0500
Message-ID: <e7e3f5b1-fc5f-8af2-c194-b4e0bd8ff23c@linux.intel.com>
References: <20190725110808.19938-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24640F8015A
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2019 15:07:02 +0200 (CEST)
In-Reply-To: <20190725110808.19938-1-perex@perex.cz>
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
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 7/25/19 6:08 AM, Jaroslav Kysela wrote:
> Use the proper module name. The objs assignments are already there.

Good catch, I've been using these module names blindly in our test 
scripts without noticing this.
Thanks for the correction


> Signed-off-by: Jaroslav Kysela <perex@perex.cz>
> Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: Mark Brown <broonie@kernel.org>0
> ---
>   sound/soc/sof/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/sof/Makefile b/sound/soc/sof/Makefile
> index 8f14c9d2950b..d2f7a1bc09a1 100644
> --- a/sound/soc/sof/Makefile
> +++ b/sound/soc/sof/Makefile
> @@ -11,8 +11,8 @@ obj-$(CONFIG_SND_SOC_SOF) += snd-sof.o
>   obj-$(CONFIG_SND_SOC_SOF_NOCODEC) += snd-sof-nocodec.o
>   
>   
> -obj-$(CONFIG_SND_SOC_SOF_ACPI) += sof-acpi-dev.o
> -obj-$(CONFIG_SND_SOC_SOF_PCI) += sof-pci-dev.o
> +obj-$(CONFIG_SND_SOC_SOF_ACPI) += snd-sof-acpi-dev.o
> +obj-$(CONFIG_SND_SOC_SOF_PCI) += snd-sof-pci-dev.o
>   
>   obj-$(CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL) += intel/
>   obj-$(CONFIG_SND_SOC_SOF_XTENSA) += xtensa/
> 
