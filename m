From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
	logger support
Date: Wed, 12 Dec 2018 01:21:15 +0200
Message-ID: <20181211232115.GO10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 11, 2018 at 03:23:11PM -0600, Pierre-Louis Bossart wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> This patch adds support for real-time DSP logging (timestamped events
> and bespoke binary data) for firmware debug. The current solution
> relies on DMA transfers to system memory that is then accessed by
> userspace tools such as sof-logger. For Intel platforms, two types of
> DMAs are currently used (GP-DMA for Baytrail/CherryTrail and HDaudio
> DMA for SKL+)
> 
> Due to historical reasons, the driver code follows the DSP firmware
> conventions and refers to 'traces', but it is currently unrelated to
> the Linux trace subsystem. Future solutions will include support for
> more advanced hardware (e.g. MIPI Sys-T), additional formats and the
> ability to enable/disable specific traces dynamically.

> +	if (count > buffer_size - lpos)
> +		count = buffer_size - lpos;

min() / max() ?

> +	/* make sure count is <= avail */
> +	count = avail > count ? count : avail;

ditto.
Check entire series for such.

> +	dfse->dfsentry = debugfs_create_file("trace", 0444, sdev->debugfs_root,
> +					     dfse, &sof_dfs_trace_fops);
> +	if (!dfse->dfsentry) {
> +		dev_err(sdev->dev,
> +			"error: cannot create debugfs entry for trace\n");
> +		kfree(dfse);

> +		return -ENODEV;

Should not return an error. We must be fine w/o debugfs files.

> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko
