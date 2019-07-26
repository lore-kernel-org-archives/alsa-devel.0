From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 37/40] soundwire: cadence_master: add hw_reset
 capability in debugfs
Date: Fri, 26 Jul 2019 16:07:49 +0200
Message-ID: <20190726140749.GC8767@kroah.com>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-38-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2019 at 06:40:29PM -0500, Pierre-Louis Bossart wrote:
> This is to kick devices into reset and see what software does
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/cadence_master.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
> index fa7230b0f200..53278aa2436f 100644
> --- a/drivers/soundwire/cadence_master.c
> +++ b/drivers/soundwire/cadence_master.c
> @@ -331,6 +331,25 @@ static const struct file_operations cdns_reg_fops = {
>  	.llseek = default_llseek,
>  };
>  
> +static int cdns_hw_reset(void *data, u64 value)
> +{
> +	struct sdw_cdns *cdns = data;
> +	int ret;
> +
> +	if (value != 1)
> +		return 0;
> +
> +	dev_info(cdns->dev, "starting link hw_reset\n");
> +
> +	ret = sdw_cdns_exit_reset(cdns);
> +
> +	dev_info(cdns->dev, "link hw_reset done\n");

Do not be noisy for when things always go right.  This looks like
debuggging code, please remove.

> +
> +	return ret;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(cdns_hw_reset_fops, NULL, cdns_hw_reset, "%llu\n");
> +
>  /**
>   * sdw_cdns_debugfs_init() - Cadence debugfs init
>   * @cdns: Cadence instance
> @@ -339,6 +358,9 @@ static const struct file_operations cdns_reg_fops = {
>  void sdw_cdns_debugfs_init(struct sdw_cdns *cdns, struct dentry *root)
>  {
>  	debugfs_create_file("cdns-registers", 0400, root, cdns, &cdns_reg_fops);
> +
> +	debugfs_create_file_unsafe("cdns-hw-reset", 0200, root, cdns,
> +				   &cdns_hw_reset_fops);

Why unsafe?

thanks,

greg k-h
