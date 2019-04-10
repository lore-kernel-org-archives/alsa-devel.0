From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: Intel: common: add Geminilake
 Realtek+Maxim machine driver entry
Date: Wed, 10 Apr 2019 13:08:40 -0500
Message-ID: <5198e493-6184-2e49-d7c7-e19ecf04021c@linux.intel.com>
References: <1554917251-16772-1-git-send-email-yong.zhi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 777BBF80765
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2019 20:08:43 +0200 (CEST)
In-Reply-To: <1554917251-16772-1-git-send-email-yong.zhi@intel.com>
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
To: Yong Zhi <yong.zhi@intel.com>, alsa-devel@alsa-project.org
Cc: harshapriya.n@intel.com, liam.r.girdwood@linux.intel.com, tiwai@suse.de, vkoul@kernel.org, broonie@kernel.org, Naveen Manohar <naveen.m@intel.com>
List-Id: alsa-devel@alsa-project.org



On 4/10/19 12:27 PM, Yong Zhi wrote:
> This patch adds glk_rt5682_max98357a_i2s machine driver entry into
> machine table. Both Skylake and SOF platform drivers can use this
> machine drivers.
> 
> Signed-off-by: Yong Zhi <yong.zhi@intel.com>
> Signed-off-by: Naveen Manohar <naveen.m@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


Ack. This is needed to probe the glk_rt5682_max98357a machine driver 
that's been merged around July 2018.

> ---
> Hi, Pierre,
> 
> This is an update to https://patchwork.kernel.org/patch/10472523/
> with SOF files prefix and asoc_plat_name removed, tested with SOF v1.1, thanks!!
> 
>   sound/soc/intel/common/soc-acpi-intel-glk-match.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/intel/common/soc-acpi-intel-glk-match.c b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> index 3f2061475ae4..616eb09e78a0 100644
> --- a/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> +++ b/sound/soc/intel/common/soc-acpi-intel-glk-match.c
> @@ -31,6 +31,15 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_glk_machines[] = {
>   		.sof_fw_filename = "sof-glk.ri",
>   		.sof_tplg_filename = "sof-glk-da7219.tplg",
>   	},
> +	{
> +		.id = "10EC5682",
> +		.drv_name = "glk_rt5682_max98357a",
> +		.fw_filename = "intel/dsp_fw_glk.bin",
> +		.machine_quirk = snd_soc_acpi_codec_list,
> +		.quirk_data = &glk_codecs,
> +		.sof_fw_filename = "sof-glk.ri",
> +		.sof_tplg_filename = "sof-glk-rt5682.tplg",
> +	},
>   	{},
>   };
>   EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_glk_machines);
> 
