From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH v5 8/8] ASoC: Intel: Skylake: add option to
 control HDAudio + DSP usage
Date: Wed, 1 Aug 2018 07:50:06 -0700
Message-ID: <b3bf46c2-01ed-ba28-b96c-6c670d607846@linux.intel.com>
References: <20180727230554.31027-1-pierre-louis.bossart@linux.intel.com>
 <20180727230554.31027-9-pierre-louis.bossart@linux.intel.com>
 <s5hbmanr895.wl-tiwai@suse.de>
 <5f73f810-6fe5-bad9-81fb-fd587ef39e8c@linux.intel.com>
 <20180731162000.GJ5719@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id A8B062677AA
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2018 16:51:08 +0200 (CEST)
In-Reply-To: <20180731162000.GJ5719@sirena.org.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, vkoul@kernel.org
List-Id: alsa-devel@alsa-project.org

On 7/31/18 9:20 AM, Mark Brown wrote:
> On Tue, Jul 31, 2018 at 09:06:54AM -0700, Pierre-Louis Bossart wrote:
>> On 7/31/18 3:48 AM, Takashi Iwai wrote:
>>> Pierre-Louis Bossart wrote:
> 
>>>> +config SND_SOC_INTEL_SKYLAKE_FORCE_HDA_DSP
>>>> +	bool "Force HDAudio Codec + DSP support"
>>>> +	depends on SND_SOC_INTEL_SKYLAKE_HDA_DSP
>>>> +	help
>>>> +	  If you have a Intel Skylake+ platform with the DSP enabled in
>>>> +	  the BIOS and an HDAudio codec, then enable this option by saying Y
>>>> +	  This option will ignore information from the BIOS and force the use
>>>> +	  of the HDaudio codec, if present.
>>>> +	  This is a debug option not recommended for distros.
> 
>>> ... and this one is better to be a module option.
>>> Distros tend to enable all possible options, and this may be set
>>> unnecessarily.  If any, this kconfig should be only toggling the
>>> default option value.
> 
>> Sorry, I don't get this one. this wouldn't change anything between built-in
>> or module, it's just a yes/no answer to ignore ACPI stuff. the default is
>> also no and there is a clear statement not to include it except for debug.
>> We have a similar option for SOF to bypass all ACPI information and go
>> straight to 'nocodec' mode.
> 
> Debug options like these are really a lot more useful as something
> runtime selectable with something like a module parameter as Takashi
> suggests - an innatentive distro maintainer could easily enable it by
> mistake when going through a bunch of new options in a new kernel
> release and if someone needs it for debugging purposes in a distro
> context it's a real pain to have to rebuild the kernel.

Ah yes, I get it now and yes it's probably a better idea to have a 
kernel parameter. I saw multiple cases of distros such as Arch enabling 
the baytrail nocodec mode and it's not straightforward to reach all 
maintainers of all distros.
Will fix, thanks for the feedback.

> 
> It's also a bit confusing as the config text says:
> 
>>>> +	  If you have a Intel Skylake+ platform with the DSP enabled in
>>>> +	  the BIOS and an HDAudio codec, then enable this option by saying Y
> 
> which sounds like people should turn it on, the bit about it being a
> debug option is quite deep in the text.
> 
