From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/7] ASoC: ts3a227e: add acpi table
Date: Fri, 8 Sep 2017 18:57:05 +0530
Message-ID: <20170908132705.GH3053@localhost>
References: <20170908051309.19028-1-pierre-louis.bossart@linux.intel.com>
 <20170908051309.19028-6-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 55927266DCE
 for <alsa-devel@alsa-project.org>; Fri,  8 Sep 2017 15:27:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20170908051309.19028-6-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Thierry Escande <thierry.escande@collabora.com>, tiwai@suse.de, Fang@alsa-project.org, liam.r.girdwood@linux.intel.com, "Fang,
 Yang A" <yang.a.fang@intel.com>, broonie@kernel.org, jarkko.nikula@linux.intel.com, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 08, 2017 at 12:13:07AM -0500, Pierre-Louis Bossart wrote:
> From: "Fang, Yang A" <yang.a.fang@intel.com>
> 
> This patch adds the acpi match table for the ts3a227e audio accessory
> detection device. This enables headset features like jack plug/unplug
> notifications, mic presence, and button pressed events.
> 
> Signed-off-by: Fang, Yang A <yang.a.fang@intel.com>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  sound/soc/codecs/ts3a227e.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
> index 4356843..738e04b 100644
> --- a/sound/soc/codecs/ts3a227e.c
> +++ b/sound/soc/codecs/ts3a227e.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of_gpio.h>
>  #include <linux/regmap.h>
> +#include <linux/acpi.h>
>  
>  #include <sound/core.h>
>  #include <sound/jack.h>
> @@ -374,11 +375,20 @@ static const struct of_device_id ts3a227e_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, ts3a227e_of_match);
>  
> +#ifdef CONFIG_ACPI
> +static struct acpi_device_id ts3a227e_acpi_match[] = {
> +	{ "104C227E", 0 },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, ts3a227e_acpi_match);
> +#endif

so this is not present for non ACPI system,... fine

> +
>  static struct i2c_driver ts3a227e_driver = {
>  	.driver = {
>  		.name = "ts3a227e",
>  		.pm = &ts3a227e_pm,
>  		.of_match_table = of_match_ptr(ts3a227e_of_match),
> +		.acpi_match_table = ACPI_PTR(ts3a227e_acpi_match),

but then this would give compiler error on those systems as .acpi_match_table is
defined in driver core... can you compile this on non acpi and check

struct device_driver {
	const char		*name;
	struct bus_type		*bus;

	struct module		*owner;
	const char		*mod_name;	/* used for built-in modules */

	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
	enum probe_type probe_type;

	const struct of_device_id	*of_match_table;
	const struct acpi_device_id	*acpi_match_table;

	int (*probe) (struct device *dev);
	int (*remove) (struct device *dev);
	void (*shutdown) (struct device *dev);
	int (*suspend) (struct device *dev, pm_message_t state);
	int (*resume) (struct device *dev);
	const struct attribute_group **groups;

	const struct dev_pm_ops *pm;

	struct driver_private *p;
};

-- 
~Vinod
