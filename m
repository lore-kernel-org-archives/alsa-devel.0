From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] ASoC: intel: rt5640: add support for sound
 card found on HP Pavilion x2 10-p000
Date: Wed, 4 Jan 2017 09:32:17 +0530
Message-ID: <20170104040217.GG3573@localhost>
References: <505f46a71aa53080da43f9c8abeb3b5d@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id A4DF4266E4A
 for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2017 05:02:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <505f46a71aa53080da43f9c8abeb3b5d@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stanislav <neko@nya.ai>
Cc: Alsa Devel <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 03, 2017 at 11:40:04PM +0300, Alexandrov Stanislav wrote:
> Add support for rt5640 sound card found on HP Pavilion x2 10-p000
> tablet.
> 
> Inside DSDT table there is record for this soundcard:
> 
>             Device (RTKC)
>             {
>                 Name (_ADR, Zero)  // _ADR: Address
>                 Name (_HID, "10EC3276")  // _HID: Hardware ID
>                 Name (_CID, "10EC3276")  // _CID: Compatible ID
>                 Name (_DDN, "ALC3276")  // _DDN: DOS Device Name
>                 Name (_SUB, "103C827C")  // _SUB: Subsystem ID
>                 Name (_PR0, Package (0x01)  // _PR0: Power Resources
> for D0
> 
> original bugreport: https://bugzilla.kernel.org/show_bug.cgi?id=187621

Hi,

Thanks for the patch, changes look okay, but they need to be split per
driver and you need to sign-off these changes.
See Documentation/process/submitting-patches.rst esp Section 11.

> 
> ---
> 
> diff --git a/sound/soc/codecs/rt5640.c b/sound/soc/codecs/rt5640.c
> index e29a6de..c5234b9 100644
> --- a/sound/soc/codecs/rt5640.c
> +++ b/sound/soc/codecs/rt5640.c
> @@ -2315,6 +2315,7 @@ static const struct acpi_device_id
> rt5640_acpi_match[] = {
>         { "INT33CA", 0 },
>         { "10EC5640", 0 },
>         { "10EC5642", 0 },
> +       { "10EC3276", 0 },
>         { "INTCCFFD", 0 },
>         { },
>  };
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c
> b/sound/soc/intel/atom/sst/sst_acpi.c
> index f4d92bb..896ced2 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -463,6 +463,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
>         /* some CHT-T platforms rely on RT5640, use Baytrail machine
> driver */
>         {"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin",
> "bytcr_rt5640", cht_quirk,
>                                                 &chv_platform_data },
> +       {"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin",
> "bytcr_rt5640", NULL,
> +                                               &chv_platform_data },
> 
>         {},
>  };

-- 
~Vinod
