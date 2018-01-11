From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 1/2] ASoC: Intel: bytcht_es8316: fix HID
	handling
Date: Thu, 11 Jan 2018 22:12:10 +0200
Message-ID: <1515701530.7000.932.camel@linux.intel.com>
References: <20180111195209.5809-1-pierre-louis.bossart@linux.intel.com>
 <20180111195209.5809-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id AAC8D266E62
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 21:13:45 +0100 (CET)
In-Reply-To: <20180111195209.5809-2-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, vinod.koul@intel.com, broonie@kernel.org, jeremy@jcline.org, liam.r.girdwood@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, 2018-01-11 at 13:52 -0600, Pierre-Louis Bossart wrote:
> Same problem as with previous machine drivers, the codec dai
> uses a hard-coded name of "i2c-ESSX8316:00" but ACPI provides
> "i2c-ESSX8316:01" in some systems.

>  static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>  {
> -	int ret = 0;
>  	struct byt_cht_es8316_private *priv;
> +	struct snd_soc_acpi_mach *mach;
> +	const char *i2c_name = NULL;
> +	int dai_index = 0;

> +	int i;

A nit: unsigned int will look more natural here.

> +	int ret = 0;

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
