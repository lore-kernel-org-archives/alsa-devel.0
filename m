From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] ASoC: Intel: Power down links before
 turning off display audio power
Date: Fri, 9 Nov 2018 13:37:36 -0600
Message-ID: <6a916d45-1d79-a638-eff4-11f2736ffaf2@linux.intel.com>
References: <20181109173712.26925-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 607042677E4
 for <alsa-devel@alsa-project.org>; Fri,  9 Nov 2018 20:37:40 +0100 (CET)
In-Reply-To: <20181109173712.26925-1-pierre-louis.bossart@linux.intel.com>
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
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Sriram Periyasamy <sriramx.periyasamy@intel.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Sanyog Kale <sanyog.r.kale@intel.com>, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org


>   
> -	return 0;
> +	err = snd_hdac_display_power(bus, false);
> +	if (err < 0) {
> +		dev_err(dev, "Cannot turn off display power on i915\n");
> +		return err;
> +	}
> +
> +	return err;

oops, no need for these two returns. this was a bad copy/paste that 
wasn't detected in the reviews.

please ignore this one, will send a v2 shortly.
