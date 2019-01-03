From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 10/10] ASoC: Intel: Add ACPI match table
 entry for ES8316 codec on BYTCR platform
Date: Thu, 3 Jan 2019 10:43:07 -0600
Message-ID: <ba03ffe0-abe6-84c2-dcc9-a788aceb0006@linux.intel.com>
References: <20190103134535.13861-1-hdegoede@redhat.com>
 <20190103134535.13861-11-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id B32B6267BC7
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 17:43:10 +0100 (CET)
In-Reply-To: <20190103134535.13861-11-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux@endlessm.com, Daniel Drake <drake@endlessm.com>
List-Id: alsa-devel@alsa-project.org


On 1/3/19 7:45 AM, Hans de Goede wrote:
> Some BYTCR devices use an ES8316 codec, add an ACPI match table entry
> for this.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   sound/soc/intel/common/soc-acpi-intel-byt-match.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/intel/common/soc-acpi-intel-byt-match.c b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> index 027dc27262b7..96f9c553fe6c 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-byt-match.c
> @@ -185,6 +185,15 @@ struct snd_soc_acpi_mach  snd_soc_acpi_intel_baytrail_machines[] = {
>   		.sof_tplg_filename = "intel/sof-byt-da7213.tplg",
>   		.asoc_plat_name = "sst-mfld-platform",
>   	},
> +	{
> +		.id = "ESSX8316",
> +		.drv_name = "bytcht_es8316",
> +		.fw_filename = "intel/fw_sst_0f28.bin",
> +		.board = "bytcht_es8316",

Coming from the holiday break I saw this .board field and couldn't 
recall why we needed it. None of the more recent boards set this field. 
Is this legacy stuff that isn't used by anyone?


> +		.sof_fw_filename = "intel/sof-byt.ri",
> +		.sof_tplg_filename = "intel/sof-byt-es8316.tplg",
> +		.asoc_plat_name = "sst-mfld-platform",
> +	},
>   	/* some Baytrail platforms rely on RT5645, use CHT machine driver */
>   	{
>   		.id = "10EC5645",
