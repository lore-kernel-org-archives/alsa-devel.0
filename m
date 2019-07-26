From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Subject: Re: [alsa-devel] [RFC PATCH 23/40] soundwire: stream: fix disable
 sequence
Date: Fri, 26 Jul 2019 16:51:29 +0200
Message-ID: <20190726145129.GI16003@ubuntu>
References: <20190725234032.21152-1-pierre-louis.bossart@linux.intel.com>
 <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190725234032.21152-24-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

Unrelated to this specific patch, but I looked at _sdw_disable_stream()
and I see this there (again, maybe my version is outdated already):

	struct sdw_master_runtime *m_rt = NULL;
	struct sdw_bus *bus = NULL;

where both those initialisations are redundant. Moreover:

On Thu, Jul 25, 2019 at 06:40:15PM -0500, Pierre-Louis Bossart wrote:
> When we disable the stream and then call hw_free, two bank switches
> will be handled and as a result we re-enable the stream on hw_free.
> 
> Make sure the stream is disabled on both banks.
> 
> TODO: we need to completely revisit all this and make sure we have a
> mirroring mechanism between current and alternate banks.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>  drivers/soundwire/stream.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 53f5e790fcd7..75b9ad1fb1a6 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -1637,7 +1637,24 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
>  		}
>  	}
>  
> -	return do_bank_switch(stream);
> +	ret = do_bank_switch(stream);
> +	if (ret < 0) {
> +		dev_err(bus->dev, "Bank switch failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* make sure alternate bank (previous current) is also disabled */
> +	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
> +		bus = m_rt->bus;

"bus" is only used below, so at least take that line under "if (ret < 0)"
or even just do "dev_err(m_rt->bus->dev,...)" everywhere in this function
and remove the variable altogether...

Thanks
Guennadi

> +		/* Disable port(s) */
> +		ret = sdw_enable_disable_ports(m_rt, false);
> +		if (ret < 0) {
> +			dev_err(bus->dev, "Disable port(s) failed: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
>  }
>  
>  /**
> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
