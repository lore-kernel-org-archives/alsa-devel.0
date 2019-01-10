From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 03/14] ASoC: SOF: Add driver debug
	support.
Date: Thu, 10 Jan 2019 14:47:07 -0600
Message-ID: <ddfac639-631e-1205-b1db-c9fc9d0e68c6@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-4-pierre-louis.bossart@linux.intel.com>
 <20190109194020.GP10405@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20190109194020.GP10405@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

[combined feedback from Ranjani, Liam and me]


>> +	/* copy from DSP MMIO */
>> +	pm_runtime_get_noresume(sdev->dev);
> Why are we doing a _get_noresume() here?  It won't actually do anything
> to the device...
the reason we currently do a get_noresume() is so that we can still read 
the debugfs entries in case of DSP panic, where a regular resume would 
not succeed.

That said this part will be reworked based on feedback from Rafael whose 
suggestion was to get rid of the pm calls while reading debugfs. We can 
make sure that all the values are flushed out of the dsp before 
suspending which will make the need to wake it up redundant.

>
>> +
>> +	memcpy_fromio(buf,  dfse->buf + pos, size);
> Extra space?
yep. we run checkpatch.pl --strict all the time and missed this somehow.
>
>> +	/*
>> +	 * TODO: revisit to check if we need mark_last_busy, or if we
>> +	 * should change to use xxx_put_sync[_suspend]().
>> +	 */
>> +	ret = pm_runtime_put_sync_autosuspend(sdev->dev);
>> +	if (ret < 0)
>> +		dev_warn(sdev->dev, "warn: debugFS failed to autosuspend %zd\n",
>> +			 ret);
> It rather depends what you're doing...  I'm definitely confused as to
> why you need a _sync operation - if you're doing autosuspend stuff
> presumably you don't care so much if the device gets powered down
> immediately, and I can't in general see why that'd be important.
yes, as stated above we'll rework all this
>
>> +	dfse->dfsentry = debugfs_create_file(name, 0444, sdev->debugfs_root,
>> +					     dfse, &sof_dfs_fops);
>> +	if (!dfse->dfsentry) {
>> +		dev_err(sdev->dev, "error: cannot create debugfs entry.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(snd_sof_debugfs_io_create_item);
> debugfs uses EXPORT_SYMBOL_GPL().

We don't have a burning desire to keep this as EXPORT_SYMBOL since 
debugfs is really Linux specific, so will move all these statements as 
EXPORT_SYMBOL_GPL.

Thanks Mark for your time, much appreciated. We've already dealt with 
most of the feedback from Takashi/Andy/Daniel so should have a new 
version of these patches in 1-2 weeks.
