From: Kirill Marinushkin <k.marinushkin@gmail.com>
Subject: Re: [alsa-devel] Applied "ASoC: topology: Fix logical inversion in
 set_link_hw_format()" to the asoc tree
Date: Tue, 27 Feb 2018 05:50:15 +0100
Message-ID: <6cc613c5-a1e6-8873-9e0e-c408c99319b8@gmail.com>
References: <E1eqGmV-0005Rk-Jt@debutante>
 <20180226183407.22335-1-k.marinushkin@gmail.com>
 <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <e25d592b-0fab-68f8-d9e0-e5061c54f4e0@linux.intel.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pan Xiuli <xiuli.pan@linux.intel.com>, stable@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 02/27/18 03:30, Pierre-Louis Bossart wrote:
> On 2/26/18 10:34 AM, Kirill Marinushkin wrote:
>> Hello Mark Brown, Pan Xiuli,
>>
>> As far as I understand, the suggested commit *breaks* the functionality instead
>> of fixing it, and should not be applied. Please correct me if I am wrong.
>>
>>
>> 1. The existing functionality works correctly, nothing to fix here.
>>
>> Below is a comment from include/sound/soc-dai.h:77
>>
>> ~~~~
>> /*
>>   * DAI hardware clock masters.
>>   *
>>   * This is wrt the codec, the inverse is true for the interface
>>   * i.e. if the codec is clk and FRM master then the interface is
>>   * clk and frame slave.
>>   */
>> #define SND_SOC_DAIFMT_CBM_CFM        (1 << 12) /* codec clk & FRM master */
>> #define SND_SOC_DAIFMT_CBS_CFM        (2 << 12) /* codec clk slave & FRM master */
>> #define SND_SOC_DAIFMT_CBM_CFS        (3 << 12) /* codec clk master & frame slave */
>> #define SND_SOC_DAIFMT_CBS_CFS        (4 << 12) /* codec clk & FRM slave */
>> ~~~~
>>
>> According to the comment, the existing functionality works correctly "WRT the
>> interface". The suggested commit doesn't fix the behaviour: instead, it reverts
>> the logic to "WRT the codec". But the existing implementation is also valid.
>
> Look at all the machine drivers, they always use the mask by looking at the codec side. The comment on top means that the SOC side ('the interface') is the dual of the codec side.
>

Yes, you are right. Analyzing from the codec side makes more sense.

> This issue was found during the development of SOF (Sound Open Firmware) where we get the reverse of the intended behavior when using the same conventions in topology files as in machine drivers.
>
>>
>>
>> 2. The suggested commit breaks the existing ASoC.
>>
>> The existing functionality already works with several existing ASoC by
>> Intel. The suggested commit will break it for the following reason:
>>
>> The ALSA topology mechanism loads the binary topology file into ASoC. The
>> suggested commit modifies the parser, but the binaries are already created for
>> the existing functionality. As a result, all existing binaries will be parsed
>> incorrectly.
>
> I know there is a similar inversion in the alsa-lib topology files for Broadwell, the codec is marked as master when it really is slave. I don't know how Intel handled this on SKL.
>
> But you have a point that if people used this inversion in the past it'd break functionality on existing devices which retrieve topology information from ACPI tables and binary files.
>

Yes. The Broadwell conf files, which you mentioned, demonstrate that this functionality is already used as it is.

> Gah. Maybe we should keep this inversion then, document it and compensate for it in topology creating tools. Liam, what do you think?
>
>>
>>
>> 3. The suggested commit should not go into stable.
>>
>> For the reasons explained earlier, applying the suggested commit into stable
>> kernel will break the stable kernel.
>>
>> As I am not in the mailing list, I will not be able to stop Greg K-H
>> <gregkh@linuxfoundation.org> when he will ask "If you, or anyone else, feels it
>> should not be added to the stable tree, please let <stable@vger.kernel.org> know
>> about it."
>>
>> @Mark Brown could you please add me to the thread if such situation happens, so
>> that I could share my point for the stable patches.
>>
>> Best Regards,
>> Kirill
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
>
