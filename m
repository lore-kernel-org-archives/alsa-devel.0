From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/2] ASoC: Intel: Atom: Add support for
 rt5640 sound card found on HP Pavilion x2 10-p000 tablet.
Date: Thu, 5 Jan 2017 09:22:53 +0530
Message-ID: <20170105035252.GK3573@localhost>
References: <cover.1483531270.git.neko@nya.ai>
 <e129703fe81de8fdba680a4a6e27d1e414af2579.1483531270.git.neko@nya.ai>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id F377D266DB0
 for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2017 04:52:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <e129703fe81de8fdba680a4a6e27d1e414af2579.1483531270.git.neko@nya.ai>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexandrov Stansilav <neko@nya.ai>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2017 at 03:22:13PM +0300, Alexandrov Stansilav wrote:
> Signed-off-by: Alexandrov Stansilav <neko@nya.ai>

Same comments here too, the title and log doesn't tell me the changes in the
patch.

So a better title could be:

ASoC: Intel: Atom: Add HP Pavilion x2 10-p000 machine entry

And log may contain:

HP Pavilion x2 10-p000 sports a rt5640 codec, bit with ACPI ID 10EC5640, so
add a new entry in machine table for this configuration.

> ---
>  sound/soc/intel/atom/sst/sst_acpi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
> index f4d92bb..896ced2 100644
> --- a/sound/soc/intel/atom/sst/sst_acpi.c
> +++ b/sound/soc/intel/atom/sst/sst_acpi.c
> @@ -463,6 +463,8 @@ static struct sst_acpi_mach sst_acpi_chv[] = {
>  	/* some CHT-T platforms rely on RT5640, use Baytrail machine driver */
>  	{"10EC5640", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", cht_quirk,
>  						&chv_platform_data },
> +	{"10EC3276", "bytcr_rt5640", "intel/fw_sst_22a8.bin", "bytcr_rt5640", NULL,
> +						&chv_platform_data },
>  
>  	{},
>  };
> -- 
> 2.10.2
> 

-- 
~Vinod
