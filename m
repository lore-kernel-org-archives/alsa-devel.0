From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 11/35] ASoC: Intel: Merge sst_dsp_device
 into sst_pdata
Date: Fri, 23 Aug 2019 13:54:44 -0500
Message-ID: <4ecd54e1-a7c1-fec9-3487-9b0ef8442293@linux.intel.com>
References: <20190822190425.23001-1-cezary.rojewski@intel.com>
 <20190822190425.23001-12-cezary.rojewski@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79C83F80141
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2019 22:28:06 +0200 (CEST)
In-Reply-To: <20190822190425.23001-12-cezary.rojewski@intel.com>
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
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
Cc: broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


> @@ -203,13 +192,15 @@ struct sst_pdata {
>   
>   	/* DSP */
>   	u32 id;
> +	const char *fw_name;
> +	struct sst_ops *ops;
> +	struct snd_soc_acpi_mach *boards;
>   	void *dsp;
>   };

You already have the fw_name inside of struct snd_soc_acpi_mach:

/* Descriptor for SST ASoC machine driver */
struct snd_soc_acpi_mach {
	const u8 id[ACPI_ID_LEN];
	const char *drv_name;
	const char *fw_filename;
	const char *board;
	struct snd_soc_acpi_mach * (*machine_quirk)(void *arg);
	const void *quirk_data;
	void *pdata;
	struct snd_soc_acpi_mach_params mach_params;
	const char *sof_fw_filename;
	const char *sof_tplg_filename;
};
