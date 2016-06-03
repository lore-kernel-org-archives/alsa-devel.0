From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: add bytcr_rt5651 machine
 driver for Cherryview-based platforms
Date: Fri, 3 Jun 2016 11:18:38 -0500
Message-ID: <950ed982-1aca-3e5b-2e07-bf8838358336@linux.intel.com>
References: <1464967985-18355-1-git-send-email-pxpert@gmail.com>
 <1464967985-18355-2-git-send-email-pxpert@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A72D265554
 for <alsa-devel@alsa-project.org>; Fri,  3 Jun 2016 18:21:06 +0200 (CEST)
In-Reply-To: <1464967985-18355-2-git-send-email-pxpert@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pietro Di Costanzo <pxpert@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/3/16 10:33 AM, Pietro Di Costanzo wrote:
> Some CHT-T platforms rely on RT5651 (Just like RT5640). Add bytcr_rt5651 for these platforms
>
> Signed-off-by: Pietro Di Costanzo <pxpert@gmail.com>

no issue here so

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/atom/sst/sst_acpi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index 3bc4b63..f1b1942 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -342,10 +342,11 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
>  						&chv_platform_data },
>  	{"193C9890", "cht-bsw-max98090", "intel/fw_sst_22a8.bin", "cht-bsw", NULL,
>  						&chv_platform_data },
> -	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
> +	/* some CHT-T platforms rely on RT5640 and RT5651, use Baytrail machine driver */
>  	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
>  						&chv_platform_data },
> -
> +	{"10EC5651", "bytcr_rt5651", "intel/fw_sst_22a8.bin", "bytcr_rt5651", NULL,
> +						&chv_platform_data },
>  	{},
>  };
>
>
