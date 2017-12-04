From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC 02/10] ASoC: Intel: Skylake: Add entry in
 sst_acpi_mach for HDA codecs
Date: Mon, 4 Dec 2017 16:27:19 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AC608A@BGSMSX104.gar.corp.intel.com>
References: <1512119648-2700-1-git-send-email-rakesh.a.ughreja@intel.com>
 <1512119648-2700-3-git-send-email-rakesh.a.ughreja@intel.com>
 <ac3f61b8-f9ef-91f3-1e4d-36d88d14d6a0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id 7AD09266BBC
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 17:27:24 +0100 (CET)
In-Reply-To: <ac3f61b8-f9ef-91f3-1e4d-36d88d14d6a0@linux.intel.com>
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
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "tiwai@suse.de" <tiwai@suse.de>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Patches Audio <patches.audio@intel.com>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: Pierre-Louis Bossart [mailto:pierre-louis.bossart@linux.intel.com]
>Sent: Friday, December 1, 2017 11:46 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; alsa-devel@alsa-
>project.org; broonie@kernel.org; tiwai@suse.de; liam.r.girdwood@linux.intel.com
>Cc: Koul, Vinod <vinod.koul@intel.com>; Patches Audio
><patches.audio@intel.com>
>Subject: Re: [alsa-devel] [RFC 02/10] ASoC: Intel: Skylake: Add entry in
>sst_acpi_mach for HDA codecs
>
>On 12/1/17 3:14 AM, Rakesh Ughreja wrote:
>> When no I2S based codecs are detected in the BIOS, check if there are
>> any HDA codecs present. If yes, load the corresponding machine driver.
>
>Is this completely correct?
>I may be splitting hair but I believe it's possible to have an HDAudio
>codec connected to some pins and an I2S/PDM device on non-conflicting
>pins. The PDM case is very real and isn't related to I2S

Yes, agree. In that case there should be different Machine driver.
I expected the skl_hda_generic machine driver to be loaded only when
we have iDisp and HDA codecs and nothing else.

>
>You may also want to explain that you *have* to look for non-HDaudio
>stuff first, because otherwise the iDisp codec will be detected but that
>is not sufficient to load the HDaudio machine driver (could be
>iDisp+I2S+PDM)

Yes, I have done the same thing in this patch. You can see that the
HDA_GEN entry is the last one.

>
>>
>> TODO:
>> support for detecting the presence of HDA codec is not implemented.
>> it will be implemented in the next revision.
>>
>> Signed-off-by: Rakesh Ughreja <rakesh.a.ughreja@intel.com>
>> ---
>>   sound/soc/intel/skylake/skl.c | 46
>++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 43 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
>> index 27462c0..568a285 100644
>> --- a/sound/soc/intel/skylake/skl.c
>> +++ b/sound/soc/intel/skylake/skl.c
>> @@ -424,6 +424,26 @@ static int skl_free(struct hdac_bus *bus)
>>   	return 0;
>>   }
>>
>> +static struct snd_soc_acpi_mach *skl_probe_hda_machine(
>> +					struct snd_soc_acpi_mach *machines)
>> +{
>> +
>> +	struct snd_soc_acpi_mach *mach;
>> +
>> +	/*
>> +	 * FIXME:
>> +	 * First check if there are any HDA codecs present on the system
>> +	 * then search the match table.
>> +	 * For now this function is not detecting the presence of any
>> +	 * HDA codecs.
>
>D'oh. so how was this patchset tested then?

I have tested this patchset on Dell XPS13 machine, where I have
only one HDA codec and one iDisp codec. The current code
does not find the match for any of the I2S codec machine
driver and so the default HDA_GEN machine driver gets loaded.

Once the FIXME is implemented HDA_GEN machine driver will
be loaded only if there is a HDA and iDisp codec present, else
no machine driver will be loaded.

>
>> +	 */
>> +	for (mach = machines; mach->id[0]; mach++) {
>> +		if (!strcmp(mach->id, "HDA_GEN"))
>
>Do you mean to say this was a temporary hack assuming a modified DSDT to
>force the detection of the codec?

There is a FIXME on the top, where I would like to detect if we
really have only HDA and iDisp codecs present on the system.

>
>And while I am at it in the hair-splitting department, in theory HDAudio
>can work with multiple codecs (each using its own SDI line), did you
>think of this case and how would it impact the machine driver selection?

As long as we have only HDA and iDisp codecs, the current machine
driver can scale. You will need more BE DAI Links in the machine driver
to bind the codecs.
