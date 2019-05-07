From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: SOF: Add Comet Lake PCI IDs
Date: Tue, 7 May 2019 17:14:36 -0500
Message-ID: <cb0accd5-6b0d-065a-9b54-321252862d88@linux.intel.com>
References: <20190507215359.113378-1-evgreen@chromium.org>
 <20190507215359.113378-2-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190507215359.113378-2-evgreen@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Evan Green <evgreen@chromium.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: Naveen M <naveen.m@intel.com>, Sathya Prakash <sathya.prakash.m.r@intel.com>, Ben Zhang <benzh@chromium.org>, Rajat Jain <rajatja@chromium.org>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Minor nit-picks below. The Kconfig would work but select CANNONLAKE even 
if you don't want it.

>   
> +config SND_SOC_SOF_COMETLAKE_LP
> +	tristate
> +	select SND_SOC_SOF_CANNONLAKE

This should be
select SND_SOF_SOF_HDA_COMMON

> +	help
> +	  This option is not user-selectable but automagically handled by
> +	  'select' statements at a higher level
> +
> +config SND_SOC_SOF_COMETLAKE_LP_SUPPORT
> +	bool "SOF support for CometLake-LP"
> +	help
> +	  This adds support for Sound Open Firmware for Intel(R) platforms
> +	  using the Cometlake-LP processors.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".
> +
> +config SND_SOC_SOF_COMETLAKE_H
> +	tristate
> +	select SND_SOC_SOF_CANNONLAKE

This should be
select SND_SOF_SOF_HDA_COMMON

> +	help
> +	  This option is not user-selectable but automagically handled by
> +	  'select' statements at a higher level
> +
> +config SND_SOC_SOF_COMETLAKE_H_SUPPORT
> +	bool "SOF support for CometLake-H"
> +	help
> +	  This adds support for Sound Open Firmware for Intel(R) platforms
> +	  using the Cometlake-H processors.
> +	  Say Y if you have such a device.
> +	  If unsure select "N".
