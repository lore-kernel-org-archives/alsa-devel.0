From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 06/21] ASoC: SOF: Intel: Add Intel specific
 HDA DSP HW operations
Date: Wed, 12 Dec 2018 08:48:42 -0600
Message-ID: <3b47644d-262b-d6a8-d90d-bacc942b3770@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-7-pierre-louis.bossart@linux.intel.com>
 <s5hpnu7j6is.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hpnu7j6is.wl-tiwai@suse.de>
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
Cc: Daniel Baluta <daniel.baluta@gmail.com>, andriy.shevchenko@intel.com, Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the reviews Takashi.

On 12/12/18 6:04 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:30:14 +0100,
> Pierre-Louis Bossart wrote:
>> +int hda_dsp_resume(struct snd_sof_dev *sdev)
>> +{
>> +	struct hdac_bus *bus = sof_to_bus(sdev);
>> +	int ret;
>> +
>> +	/* turn display power on */
>> +	ret = hda_codec_i915_get(sdev);
> OK, we need to change this one for following my latest HD-audio PM
> refactoring...
Yes, it's already tracked as an item to fix. We might change the name 
even since there is no reference count any longer, so something like 
hda_codec_i915_power would make more sense.
>
>> +	if (ret < 0) {
>> +		dev_err(bus->dev, "error: cannot turn on display power on i915 after resume\n");
>> +		return ret;
>> +	}
>> +
>> +	/* init hda controller and power dsp up */
>> +	return hda_resume(sdev);
>> +}
>> +
>> +int hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
>> +{
>> +	/* init hda controller and power dsp up */
>> +	return hda_resume(sdev);
>> +}
> But why can't runtime PM turn on/off the display power?
I think it does? We'll double-check this.
