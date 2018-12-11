From: Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 03/14] ASoC: SOF: Add driver debug
	support.
Date: Wed, 12 Dec 2018 00:32:23 +0200
Message-ID: <20181211223223.GI10650@smile.fi.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-4-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20181211212318.28644-4-pierre-louis.bossart@linux.intel.com>
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

On Tue, Dec 11, 2018 at 03:23:07PM -0600, Pierre-Louis Bossart wrote:
> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
> 
> Add debugFS files that can be used to expose DSP memories and
> and peripherals to userspace to assist with firmware debugging.
> 
> TODO: The runtime_pm parts are not final and will be updated.

> +	if (count > size - pos)
> +		count = size - pos;

max() / min()

> +	/* intermediate buffer size must be u32 multiple */
> +	size = (count + 3) & ~3;

Hmm, don't we have something like round_up()?

> +	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
> +					     dfse, &sof_dfs_fops);
> +	if (!dfse->dfsentry) {
> +		dev_err(sdev->dev, "error: cannot create debugfs entry.\n");
> +		return -ENODEV;
> +	}

We shouldn't rely on debugfs files.
Thus, error checking needs to be removed.

Something like

void ()
{
struct dentry *d;

d = debugfs_...();
if (!d)
	dev_err();
}


> +	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
> +					     dfse, &sof_dfs_fops);
> +	if (!dfse->dfsentry) {
> +		dev_err(sdev->dev, "error: cannot create debugfs entry.\n");
> +		return -ENODEV;
> +	}

Ditto.

> +	sdev->debugfs_root = debugfs_create_dir("sof", NULL);
> +	if (IS_ERR_OR_NULL(sdev->debugfs_root)) {
> +		dev_err(sdev->dev, "error: failed to create debugfs directory\n");
> +		return -EINVAL;
> +	}
> +
> +	/* create debugFS files for platform specific MMIO/DSP memories */
> +	for (i = 0; i < ops->debug_map_count; i++) {
> +		map = &ops->debug_map[i];
> +

> +		err = snd_sof_debugfs_io_create_item(sdev, sdev->bar[map->bar] +
> +						  map->offset, map->size,
> +						  map->name);
> +		if (err < 0)
> +			dev_err(sdev->dev, "error: cannot create debugfs for %s\n",
> +				map->name);

Ditto (error message dups above).

> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(snd_sof_dbg_init);

-- 
With Best Regards,
Andy Shevchenko
