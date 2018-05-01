From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
Date: Tue, 1 May 2018 10:59:57 -0500
Message-ID: <f72b3f60-7c9f-e89f-7907-61cc68ceebc6@linux.intel.com>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <cb0df61c-596b-b23c-fc34-52ac4b7830e8@linux.intel.com>
 <43c7939d-e30b-27eb-59e4-c0e16248dad1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <43c7939d-e30b-27eb-59e4-c0e16248dad1@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>, Support Opensource <support.opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com, Adam.Thomson.Opensource@diasemi.com
List-Id: alsa-devel@alsa-project.org

On 5/1/18 9:31 AM, Agrawal, Akshu wrote:
> 
> 
> On 4/30/2018 9:54 PM, Pierre-Louis Bossart wrote:
>> On 4/30/18 4:23 AM, Akshu Agrawal wrote:
>>> Non-dts based systems can use ACPI DSDT to pass on the mclk
>>> to da7219.
>>> This enables da7219 mclk to be linked to system clock.
>>> Enable/Disable of the mclk is already handled in the codec so
>>> platform drivers don't have to explicitly do handling of mclk.
>>>
>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>> ---
>>> v2: Fixed kbuild error
>>>   include/sound/da7219.h    | 2 ++
>>>   sound/soc/codecs/da7219.c | 7 ++++++-
>>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
>>> index 1bfcb16..df7ddf4 100644
>>> --- a/include/sound/da7219.h
>>> +++ b/include/sound/da7219.h
>>> @@ -38,6 +38,8 @@ struct da7219_pdata {
>>>       const char *dai_clks_name;
>>> +    const char *mclk_name;
>>> +
>>>       /* Mic */
>>>       enum da7219_micbias_voltage micbias_lvl;
>>>       enum da7219_mic_amp_in_sel mic_amp_in_sel;
>>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>>> index 980a6a8..aed68a4 100644
>>> --- a/sound/soc/codecs/da7219.c
>>> +++ b/sound/soc/codecs/da7219.c
>>> @@ -1624,6 +1624,8 @@ static struct da7219_pdata 
>>> *da7219_fw_to_pdata(struct snd_soc_component *compone
>>>           dev_warn(dev, "Using default clk name: %s\n",
>>>                pdata->dai_clks_name);
>>> +    device_property_read_string(dev, "dlg,mclk-name", 
>>> &pdata->mclk_name);
>>> +
>>>       if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) 
>>> >= 0)
>>>           pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
>>>       else
>>> @@ -1905,7 +1907,10 @@ static int da7219_probe(struct 
>>> snd_soc_component *component)
>>>       da7219_handle_pdata(component);
>>>       /* Check if MCLK provided */
>>> -    da7219->mclk = devm_clk_get(component->dev, "mclk");
>>> +    if (da7219->pdata->mclk_name)
>>> +        da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
>>> +    if (!da7219->mclk)
>>> +        da7219->mclk = devm_clk_get(component->dev, "mclk");
>>
>> this looks weird, why are you using different clk functions depending 
>> on the existence of a _DSD property? Why not just change the name and 
>> keep the same flow, e.g something like
>>
>> if(!da7219->pdata->mclk_name)
>>      da7219->pdata->mclk_name = "mclk";
>> da7219->mclk = devm_clk_get(component->dev, da7219->pdata->mclk_name);
>>
>>
> 
> We can't use devm_clk_get as the value of dev argument has to be NULL, 
> which can not be used with devm_clk_get.
> System clock which are linked to mclk are registered by a separate ACPI 
> device. And this exposing of DSD property is for all those platforms 
> which are non-dts based.

Alternatively you could modify clk_get to use device_property instead of 
of_property.

> 
>>>       if (IS_ERR(da7219->mclk)) {
>>>           if (PTR_ERR(da7219->mclk) != -ENOENT) {
>>>               ret = PTR_ERR(da7219->mclk);
>>>
>>
