From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 03/14] ASoC: SOF: Add driver debug
 support.
Date: Tue, 11 Dec 2018 17:29:12 -0600
Message-ID: <aaa36a79-8438-5fcd-e832-5d65c339f67c@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-4-pierre-louis.bossart@linux.intel.com>
 <20181211223223.GI10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211223223.GI10650@smile.fi.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


>> +	if (count > size - pos)
>> +		count = size - pos;
> max() / min()
ok
>
>> +	/* intermediate buffer size must be u32 multiple */
>> +	size = (count + 3) & ~3;
> Hmm, don't we have something like round_up()?
yes, round_up (count, 4) would work.
>
>> +	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
>> +					     dfse, &sof_dfs_fops);
>> +	if (!dfse->dfsentry) {
>> +		dev_err(sdev->dev, "error: cannot create debugfs entry.\n");
>> +		return -ENODEV;
>> +	}
> We shouldn't rely on debugfs files.
> Thus, error checking needs to be removed.
>
> Something like
>
> void ()
> {
> struct dentry *d;
>
> d = debugfs_...();
> if (!d)
> 	dev_err();
> }

You lost me on this one. The main purpose of this return -ENODEV is to 
avoid adding more entries if one item failed. It's not different from 
what our estimeed colleagues did in skl-debug.c


>
>
>> +	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
>> +					     dfse, &sof_dfs_fops);
>> +	if (!dfse->dfsentry) {
>> +		dev_err(sdev->dev, "error: cannot create debugfs entry.\n");
>> +		return -ENODEV;
>> +	}
> Ditto.
>
>> +	sdev->debugfs_root = debugfs_create_dir("sof", NULL);
>> +	if (IS_ERR_OR_NULL(sdev->debugfs_root)) {
>> +		dev_err(sdev->dev, "error: failed to create debugfs directory\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* create debugFS files for platform specific MMIO/DSP memories */
>> +	for (i = 0; i < ops->debug_map_count; i++) {
>> +		map = &ops->debug_map[i];
>> +
>> +		err = snd_sof_debugfs_io_create_item(sdev, sdev->bar[map->bar] +
>> +						  map->offset, map->size,
>> +						  map->name);
>> +		if (err < 0)
>> +			dev_err(sdev->dev, "error: cannot create debugfs for %s\n",
>> +				map->name);
> Ditto (error message dups above).
>
>> +	}
>> +
>> +	return err;

or maybe that's the issue, we shouldn't return an error on the init 
proper, but I see nothing wrong in stopping when things go south.


>> +}
>> +EXPORT_SYMBOL(snd_sof_dbg_init);
