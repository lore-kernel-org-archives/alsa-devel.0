From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/2] ALSA: HD-Audio: SKL+: abort probe if
 DSP is present and Skylake driver selected
Date: Mon, 10 Dec 2018 08:31:08 -0600
Message-ID: <8fdcc781-ff56-f28e-aa1a-7df6e3694836@linux.intel.com>
References: <20181208000039.23384-1-pierre-louis.bossart@linux.intel.com>
 <20181208000039.23384-2-pierre-louis.bossart@linux.intel.com>
 <s5hin04fo4k.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CC92267AFE
 for <alsa-devel@alsa-project.org>; Mon, 10 Dec 2018 15:55:34 +0100 (CET)
In-Reply-To: <s5hin04fo4k.wl-tiwai@suse.de>
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Filip Kaczmarski <filip.kaczmarski@intel.com>, Chris Chiu <chiu@endlessm.com>, alsa-devel@alsa-project.org, Daniel Drake <drake@endlessm.com>, liam.r.girdwood@linux.intel.com, vkoul@kernel.org, broonie@kernel.org, Michal Wasko <michal.wasko@intel.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


On 12/8/18 1:56 AM, Takashi Iwai wrote:
> On Sat, 08 Dec 2018 01:00:38 +0100,
> Pierre-Louis Bossart wrote:
>> Now that the SST/Skylake driver supports per platform selectors, we
>> can add logic to automatically select the right driver.
>>
>> If the Skylake driver is selected, and the DSP is enable, the legacy
>> HDaudio driver aborts the probe. This will result in a single driver
>> probing and remove the need for modprobe blacklists.
>>
>> Follow-up patches will add a module parameter to bypass the logic if
>> this automatic detection fails, or if the Skylake driver is unable to
>> actually support the platform (firmware authentication, missing
>> topology file, hardware issue, etc).
>>
>> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> ---
>>   sound/pci/hda/Kconfig          | 46 ++++++++++++++++++++++++++++++++++
>>   sound/pci/hda/hda_controller.h |  2 +-
>>   sound/pci/hda/hda_intel.c      | 34 +++++++++++++++++++------
>>   sound/soc/intel/Kconfig        |  6 +++++
>>   4 files changed, 80 insertions(+), 8 deletions(-)
>>
>> diff --git a/sound/pci/hda/Kconfig b/sound/pci/hda/Kconfig
>> index 4235907b7858..634b7fe6a936 100644
>> --- a/sound/pci/hda/Kconfig
>> +++ b/sound/pci/hda/Kconfig
>> @@ -226,6 +226,52 @@ config SND_HDA_POWER_SAVE_DEFAULT
>>   	  The default time-out value in seconds for HD-audio automatic
>>   	  power-save mode.  0 means to disable the power-save mode.
>>   
>> +if SND_HDA_INTEL
>> +
>> +config SND_HDA_INTEL_DISABLE_SKL
>> +	bool
>> +	help
>> +	  This option disables HD-audio legacy for
>> +	  Skylake machines
> I'm not sure whether we need the selection of this disablement for
> each model.  Distros would choose these unlikely, and individual users
> don't have to select multiple of them but only for their machine's
> model.  So, in the end, the choice would be either yes or no.

Ah yes, maybe I wasn't clear. This wasn't intended to be selected by the 
user, but selected when when the SND_SOC_INTEL_KBL or SND_SOC_SOF_CNL 
options are set. See the conditions below.

The main idea what to only deal with the conflict resolution when we 
indeed have a conflict. I also introduced this option on the 
sound/pci/hda side so that SOF can use the same mechanisms, i.e. it's 
the legacy driver doesn't need to know if the conflict happens with the 
SST/Skylake or SOF driver.

>> @@ -188,6 +188,12 @@ config SND_SOC_INTEL_SKYLAKE_COMMON
>>   	select SND_SOC_TOPOLOGY
>>   	select SND_SOC_INTEL_SST
>>   	select SND_SOC_HDAC_HDA if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
>> +	select SND_HDA_INTEL_DISABLE_SKL if SND_SOC_INTEL_SKL
>> +	select SND_HDA_INTEL_DISABLE_APL if SND_SOC_INTEL_APL
>> +	select SND_HDA_INTEL_DISABLE_KBL if SND_SOC_INTEL_KBL
>> +	select SND_HDA_INTEL_DISABLE_GLK if SND_SOC_INTEL_GLK
>> +	select SND_HDA_INTEL_DISABLE_CNL if SND_SOC_INTEL_CNL
>> +	select SND_HDA_INTEL_DISABLE_CFL if SND_SOC_INTEL_CFL
>>   	select SND_SOC_ACPI_INTEL_MATCH
>>   	help
>>   	  If you have a Intel Skylake/Broxton/ApolloLake/KabyLake/
>> -- 
>> 2.17.1
>>
