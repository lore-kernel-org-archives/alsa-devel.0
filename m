From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] soundwire: intel: add debugfs register dump
Date: Sat, 10 Aug 2019 09:03:43 +0200
Message-ID: <20190810070343.GC6896@kroah.com>
References: <20190809224341.15726-1-pierre-louis.bossart@linux.intel.com>
 <20190809224341.15726-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190809224341.15726-4-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, jank@cadence.com, srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 09, 2019 at 05:43:41PM -0500, Pierre-Louis Bossart wrote:
> @@ -885,6 +996,8 @@ static int intel_probe(struct platform_device *pdev)
>  		goto err_dai;
>  	}
>  
> +	intel_debugfs_init(sdw);

See, make patch 1/3 work the same like this.  It's much cleaner.

thanks,

greg k-h
