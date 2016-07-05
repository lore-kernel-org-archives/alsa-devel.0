From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/2] ASoC: rt5645: Add support for
	Surface 3 tablet
Date: Tue, 5 Jul 2016 08:05:36 +0530
Message-ID: <20160705023536.GX14945@localhost>
References: <20160704165348.2558-1-stephenjust@gmail.com>
 <20160704165348.2558-2-stephenjust@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20160704165348.2558-2-stephenjust@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Just <stephenjust@gmail.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 04, 2016 at 10:53:47AM -0600, Stephen Just wrote:
> * Add a dmi match for Surface 3
> * Add ACPI match "10EC5640"
> 
> The Surface 3 tablet identifies the codec in ACPI as
> 10EC5640, but other devices use this identifier to match
> the rt5640 codec. However, the probe code for each driver
> will filter out mismatches.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Stephen Just <stephenjust@gmail.com>
> ---
>  sound/soc/codecs/rt5645.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> v1 -> v2: No change

That is wrong!

> 
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 3c6594d..761ca88 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3531,6 +3531,7 @@ MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
>  static const struct acpi_device_id rt5645_acpi_match[] = {
>  	{ "10EC5645", 0 },
>  	{ "10EC5650", 0 },
> +	{ "10EC5640", 0 },

AT least here you have a change, but earlier rev was the one I posted in BZ. It is
NOT nice to take other peoples change and post them as your patches.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(acpi, rt5645_acpi_match);
> @@ -3561,6 +3562,12 @@ static const struct dmi_system_id dmi_platform_intel_braswell[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Setzer"),
>  		},
>  	},
> +	{
> +		.ident = "Microsoft Surface 3",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Surface 3"),
> +		},
> +	},
>  	{ }
>  };
>  
> -- 
> 2.7.4
> 

-- 
~Vinod
