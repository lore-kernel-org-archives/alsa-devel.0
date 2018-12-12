From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v3 01/14] ASoC: SOF: Add Sound Open
 Firmware driver core
Date: Wed, 12 Dec 2018 08:53:27 -0600
Message-ID: <95239c7f-7449-fb51-c7a2-80d428ca9df1@linux.intel.com>
References: <20181211212318.28644-1-pierre-louis.bossart@linux.intel.com>
 <20181211212318.28644-2-pierre-louis.bossart@linux.intel.com>
 <s5hefanuqrt.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hefanuqrt.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, sound-open-firmware@alsa-project.org, Alan Cox <alan@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/12/18 1:51 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:23:05 +0100,
> Pierre-Louis Bossart wrote:
>> +static int sof_probe(struct platform_device *pdev)
>> +{
> ....
>> +	/* register any debug/trace capabilities */
>> +	ret = snd_sof_dbg_init(sdev);
>> +	if (ret < 0) {
>> +		dev_err(sdev->dev, "error: failed to init DSP trace/debug %d\n",
>> +			ret);
>> +		goto dbg_err;
>> +	}
> So that's the problem Andy suggested.
> snd_sof_dbg_init() returns an error for whatever reason, and this is
> considered as a fatal error and the probe fails.  The error about
> debugfs is no fatal error, it should continue.
>
> Moreover, as I mentioned for another patch (I read that before this
> one due to the mail delivery order :), it would fail always when
> CONFIG_DEBUGFS=n.  At best, create a wrapper for CONFIG_DEBUGFS=n to
> return 0 (and void for free).
ok. we'll fix this, point taken.
