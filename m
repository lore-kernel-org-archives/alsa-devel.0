From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/8] soundwire: intel: filter SoundWire controller device
 search
Date: Tue, 7 May 2019 17:56:51 +0530
Message-ID: <20190507122651.GO16052@vkoul-mobl>
References: <20190504002926.28815-1-pierre-louis.bossart@linux.intel.com>
 <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190504002926.28815-2-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On 03-05-19, 19:29, Pierre-Louis Bossart wrote:
> The convention is that the SoundWire controller device is a child of
> the HDAudio controller. However there can be more than one child
> exposed in the DSDT table, and the current namespace walk returns the
> last device.
> 
> Add a filter and terminate early when a valid _ADR is provided,
> otherwise keep iterating to find the next child.

So what are the other devices in DSDT here..

> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/intel_init.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index d3d6b54c5791..f85db67d05f0 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -150,6 +150,12 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>  {
>  	struct sdw_intel_res *res = cdata;
>  	struct acpi_device *adev;
> +	acpi_status status;
> +	u64 adr;
> +
> +	status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &adr);
> +	if (ACPI_FAILURE(status))
> +		return AE_OK; /* keep going */
>  
>  	if (acpi_bus_get_device(handle, &adev)) {
>  		pr_err("%s: Couldn't find ACPI handle\n", __func__);
> @@ -157,7 +163,18 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>  	}
>  
>  	res->handle = handle;
> -	return AE_OK;
> +
> +	/*
> +	 * On some Intel platforms, multiple children of the HDAS
> +	 * device can be found, but only one of them is the SoundWire
> +	 * controller. The SNDW device is always exposed with
> +	 * Name(_ADR, 0x40000000) so filter accordingly
> +	 */
> +	if (adr != 0x40000000)

I do not recall if 4 corresponds to the links you have or soundwire
device type, is this number documented somewhere is HDA specs?

Also it might good to create a define for this
 
> +		return AE_OK; /* keep going */
> +
> +	/* device found, stop namespace walk */
> +	return AE_CTRL_TERMINATE;
>  }
>  
>  /**
> -- 
> 2.17.1

-- 
~Vinod
