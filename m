From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Disable
 SND_SOC_INTEL_BAYTRAIL when SND_SST_ATOM_HIFI2_PLATFORM is enabled
Date: Fri, 13 Apr 2018 09:50:45 -0500
Message-ID: <7d14acfc-f9e1-f408-2f76-bf00ab8b9534@linux.intel.com>
References: <20180413124537.6765-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E6922670D5
 for <alsa-devel@alsa-project.org>; Fri, 13 Apr 2018 16:50:48 +0200 (CEST)
In-Reply-To: <20180413124537.6765-1-hdegoede@redhat.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On 4/13/18 7:45 AM, Hans de Goede wrote:
> The sound/soc/intel/common/sst-acpi.c code only tries to load the
> "baytrail-pcm-audio" driver (and supporting board drivers) when
> SND_SST_ATOM_HIFI2_PLATFORM is not enabled, since otherwise these
> are handled by snd-soc-sst-atom-hifi2-platform.ko.
> 
> Since these thus will never be used when SND_SST_ATOM_HIFI2_PLATFORM is
> enabled, building these drivers when it is enabled is useless.
> 
> Add a Kconfig dependency to reflect this, so that SND_SOC_INTEL_BAYTRAIL
> cannot be enabled when SND_SST_ATOM_HIFI2_PLATFORM is also enabled.

We had this before and I dropped it when we cleaned the code, mainly 
since this dependency is one-sided and the selections in menuconfig are 
a bit odd. It's really a mutual exclusion we'd want.

> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   sound/soc/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index ceb105cbd461..640f9bc9bd46 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -61,7 +61,7 @@ config SND_SOC_INTEL_HASWELL
>   
>   config SND_SOC_INTEL_BAYTRAIL
>   	tristate "Baytrail (legacy) Platforms"
> -	depends on DMADEVICES && ACPI
> +	depends on DMADEVICES && ACPI && SND_SST_ATOM_HIFI2_PLATFORM=n
>   	select SND_SOC_INTEL_SST
>   	select SND_SOC_INTEL_SST_ACPI
>   	select SND_SOC_INTEL_SST_FIRMWARE
> 
