From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 4/5] ASoC: Intel: bytcr_rt5651: filter
	codec name
Date: Mon, 18 Sep 2017 10:13:05 +0300
Message-ID: <1505718785.25945.267.camel@linux.intel.com>
References: <20170908174356.23788-1-pierre-louis.bossart@linux.intel.com>
 <20170908174356.23788-5-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id DCE482668F0
 for <alsa-devel@alsa-project.org>; Mon, 18 Sep 2017 09:13:10 +0200 (CEST)
In-Reply-To: <20170908174356.23788-5-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, liam.r.girdwood@linux.intel.com, broonie@kernel.org, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, 2017-09-08 at 12:43 -0500, Pierre-Louis Bossart wrote:
> Use same fix as other codecs to work around BIOS/ACPI issues
> 
> 

>  {
>  	int ret_val = 0;
> +	struct sst_acpi_mach *mach;
> +	const char *i2c_name = NULL;
> +	int i;
> +	int dai_index;
>  	struct byt_rt5651_private *priv;

I would rather put variables in reversed xmas tree order or close to it.

+
> +	/* fixup codec name based on HID */
> +	i2c_name = sst_acpi_find_name_from_hid(mach->id);

> +	if (i2c_name != NULL) {

if (i2c_name) { ?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
