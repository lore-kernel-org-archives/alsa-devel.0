From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 21/21] ASoC: SOF: Add Build support for SOF
 core and Intel drivers
Date: Wed, 12 Dec 2018 08:51:50 -0600
Message-ID: <a3f5697b-e849-7d7b-c9e1-c698ac18fcd4@linux.intel.com>
References: <20181211213029.28801-1-pierre-louis.bossart@linux.intel.com>
 <20181211213029.28801-22-pierre-louis.bossart@linux.intel.com>
 <s5hr2enj75g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5hr2enj75g.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, andriy.shevchenko@intel.com, Daniel Baluta <daniel.baluta@gmail.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Alan Cox <alan@linux.intel.com>, sound-open-firmware@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/12/18 5:50 AM, Takashi Iwai wrote:
> On Tue, 11 Dec 2018 22:30:29 +0100,
> Pierre-Louis Bossart wrote:
>> --- /dev/null
>> +++ b/sound/soc/sof/Kconfig
>> @@ -0,0 +1,82 @@
>> +config SND_SOC_SOF_PCI
>> +	tristate
>> +
>> +config SND_SOC_SOF_ACPI
>> +	tristate
>> +
>> +config SND_SOC_SOF
>> +	tristate "Sound Open Firmware Support"
>> +	select SND_SOC_TOPOLOGY
>> +	help
>> +          This adds support for Sound Open Firmware (SOF). SOF is a free and
>> +	  generic open source audio DSP firmware for multiple devices.
>> +          Say Y if you have such a device that is supported by SOF.
>> +          If unsure select "N".
> You can put
>    if SND_SOC_SOF
> at this point.  This will reduce lots of "depends on SND_SOC_SOF"
> lines.
Yes. I tend to use 'ifs' and others 'depends on', will align.
>
>> +config SND_SOC_SOF_NOCODEC
>> +	tristate "SOF nocodec mode Support"
>> +	depends on SND_SOC_SOF
> ....
>> +source "sound/soc/sof/intel/Kconfig"
>> +source "sound/soc/sof/xtensa/Kconfig"
> ... the endif for SND_SOC_SOF can be put here, then both Kconfigs are
> covered by SND_SOC_SOF condition.
>
>
> OTOH, the usage of if-block below is an overkill.
>
>> --- /dev/null
>> +++ b/sound/soc/sof/intel/Kconfig
> ....
>> +if SND_SOC_SOF_HDA_COMMON
>> +
>> +config SND_SOC_SOF_HDA_LINK
>> +	bool "SOF support for HDA Links(HDA/HDMI)"
>> +	help
>> +          This adds support for HDA links(HDA/HDMI) with Sound Open Firmware
>> +		  for Intel(R) platforms.
>> +          Say Y if you want to enble HDA links with SOF.
>> +          If unsure select "N".
>> +
>> +if SND_SOC_SOF_HDA_LINK
>> +config SND_SOC_SOF_HDA_AUDIO_CODEC
>> +	bool "SOF support for HDAudio codecs"
>> +	help
>> +          This adds support for HDAudio codecs with Sound Open Firmware
>> +		  for Intel(R) platforms.
>> +          Say Y if you want to enble HDAudio codecs with SOF.
>> +          If unsure select "N".
>> +endif ## SND_SOC_SOF_HDA_LINK
>> +
>> +endif ## SND_SOC_SOF_HDA_COMMON
> For single items, just use depends on.  It's easier to read.
Agree, we could remove the nested one. I tend to use 'ifs' when there 
are two or more configs, here it's not really needed.
