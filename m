From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel][PATCH] ASoC: wm8960: add two kcontrols to select
	ADC left/right channel source
Date: Mon, 15 Jun 2015 18:51:22 +0100
Message-ID: <20150615175122.GL32730@opensource.wolfsonmicro.com>
References: <1434364473-27130-1-git-send-email-zidan.wang@freescale.com> <557EB444.9070204@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <557EB444.9070204@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Zidan Wang <zidan.wang@freescale.com>, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 15, 2015 at 01:17:24PM +0200, Lars-Peter Clausen wrote:
> On 06/15/2015 12:34 PM, Zidan Wang wrote:
>> Add two kcontrols to select ADC left/right channel source, one to select
>> the left channel source and one for the right channel source.
>>
>> Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
>> ---
<snip>
>>   static const int deemph_settings[] = { 0, 32000, 44100, 48000 };
>> @@ -279,6 +283,9 @@ SOC_SINGLE_TLV("Right Output Mixer Boost Bypass Volume",
>>   	       WM8960_BYPASS2, 4, 7, 1, bypass_tlv),
>>   SOC_SINGLE_TLV("Right Output Mixer RINPUT3 Volume",
>>   	       WM8960_ROUTMIX, 4, 7, 1, bypass_tlv),
>> +
>> +SOC_ENUM("ADC Left Channel Source", wm8960_enum[6]),
>> +SOC_ENUM("ADC Right Channel Source", wm8960_enum[7]),
>
> Since this affects the routing these should be DAPM controls. Otherwise 
> you might run into issues with a path being powered down even if it is 
> used.

I think the naming of these controls needs work.

This presently doesn't actually affect DAPM. You are changing
whether the output of the left ADC will be treated as the left or
right channel on the AIF, but in both cases the AIF and Left ADC
will be powered up.

This might change if the driver was changed to the newer style
AIF hookup, although I haven't looked in detail to see if it
would make sense to use a single widget for the AIF or one for
each channel as per the Arizona devices.

Thanks,
Charles
