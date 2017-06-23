From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 8/8] ASoC: AMD: Add machine driver for cz
 rt5650
Date: Fri, 23 Jun 2017 15:01:46 -0500
Message-ID: <cb300a11-304a-2eee-6613-4d25b312b4a9@linux.intel.com>
References: <1498235706-31111-1-git-send-email-alexander.deucher@amd.com>
 <1498235706-31111-9-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 457BB266AE2
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 22:01:50 +0200 (CEST)
In-Reply-To: <1498235706-31111-9-git-send-email-alexander.deucher@amd.com>
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
To: Alex Deucher <alexdeucher@gmail.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, alsa-devel@alsa-project.org, airlied@gmail.com, broonie@kernel.org, Vijendar.Mukunda@amd.com, rajeevkumar.linux@gmail.com
Cc: tiwai@suse.de, Alex Deucher <alexander.deucher@amd.com>, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org


> +static const struct acpi_device_id cz_audio_acpi_match[] = {
> +	{ "I2SC1002", 0 },
This one goes on my list of _HID that don't follow ACPI/PCI 
vendorID/PartID conventions.
AMD shoud use the "AMDI" ACPI ID or the 0x1002 PCI ID for the 4 first 
characters, if everyone does what they feel like one day we'll have a 
conflict between devices and probe the wrong driver...

> +	{},
> +};
> +
> +static struct platform_driver cz_pcm_driver = {
> +	.driver = {
> +		.name = "cz-rt5645",
> +		.acpi_match_table = ACPI_PTR(cz_audio_acpi_match),
> +		.pm = &snd_soc_pm_ops,
> +	},
> +	.probe = cz_probe,
> +	.remove = cz_remove,
> +};
> +
> +module_platform_driver(cz_pcm_driver);
> +
> +MODULE_AUTHOR("akshu.agrawal@amd.com");
> +MODULE_DESCRIPTION("cz-rt5645 audio support");
> +MODULE_LICENSE("GPL v2");
