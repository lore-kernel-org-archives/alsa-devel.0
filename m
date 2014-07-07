From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 6/7] ACPI: Cleanup useless ACPI inclusion.
Date: Mon, 07 Jul 2014 23:24:11 +0200
Message-ID: <2868763.c5IhTlySqm@vostro.rjw.lan>
References: <cover.1387336613.git.lv.zheng@intel.com> <cover.1404706298.git.lv.zheng@intel.com> <cf869ff5e75e0973b065c3d3fe2fa453abcd5c97.1404706299.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <cf869ff5e75e0973b065c3d3fe2fa453abcd5c97.1404706299.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Monday, July 07, 2014 12:17:40 PM Lv Zheng wrote:
> The sst-haswell-dsp.c is an ACPI independent file, this patch removes
> ACPI header files for it.

This appears to be independent of the rest of the series.  Is that correct?

> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: alsa-devel@alsa-project.org
> ---
>  sound/soc/intel/sst-haswell-dsp.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/sound/soc/intel/sst-haswell-dsp.c b/sound/soc/intel/sst-haswell-dsp.c
> index 535f517..ecc5057 100644
> --- a/sound/soc/intel/sst-haswell-dsp.c
> +++ b/sound/soc/intel/sst-haswell-dsp.c
> @@ -28,9 +28,6 @@
>  #include <linux/firmware.h>
>  #include <linux/pm_runtime.h>
>  
> -#include <linux/acpi.h>
> -#include <acpi/acpi_bus.h>
> -
>  #include "sst-dsp.h"
>  #include "sst-dsp-priv.h"
>  #include "sst-haswell-ipc.h"
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
