From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 07/14] ASoC: SOF: Add DSP firmware
 logger support
Date: Tue, 11 Dec 2018 17:43:26 -0600
Message-ID: <5d4486b8-2568-4d3d-6e32-655fbb9c5824@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-8-pierre-louis.bossart@linux.intel.com>
 <20181211232115.GO10650@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181211232115.GO10650@smile.fi.intel.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, Pan Xiuli <xiuli.pan@linux.intel.com>, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/11/18 5:21 PM, Andy Shevchenko wrote:
> On Tue, Dec 11, 2018 at 03:23:11PM -0600, Pierre-Louis Bossart wrote:
>> From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
>>
>> This patch adds support for real-time DSP logging (timestamped events
>> and bespoke binary data) for firmware debug. The current solution
>> relies on DMA transfers to system memory that is then accessed by
>> userspace tools such as sof-logger. For Intel platforms, two types of
>> DMAs are currently used (GP-DMA for Baytrail/CherryTrail and HDaudio
>> DMA for SKL+)
>>
>> Due to historical reasons, the driver code follows the DSP firmware
>> conventions and refers to 'traces', but it is currently unrelated to
>> the Linux trace subsystem. Future solutions will include support for
>> more advanced hardware (e.g. MIPI Sys-T), additional formats and the
>> ability to enable/disable specific traces dynamically.
>> +	if (count > buffer_size - lpos)
>> +		count = buffer_size - lpos;
> min() / max() ?
>
>> +	/* make sure count is <= avail */
>> +	count = avail > count ? count : avail;
> ditto.
> Check entire series for such.
yep.
>
>> +	dfse->dfsentry = debugfs_create_file("trace", 0444, sdev->debugfs_root,
>> +					     dfse, &sof_dfs_trace_fops);
>> +	if (!dfse->dfsentry) {
>> +		dev_err(sdev->dev,
>> +			"error: cannot create debugfs entry for trace\n");
>> +		kfree(dfse);
>> +		return -ENODEV;
> Should not return an error. We must be fine w/o debugfs files.

Not sure I fully agree with the 'must'.

yes execution should proceed, but without debugfs we cannot, well, 
debug, so this is a real show-stopper

>
>> +	}
>> +
>> +	return 0;
>> +}
