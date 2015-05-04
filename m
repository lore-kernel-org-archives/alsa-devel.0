From: Sergej Sawazki <ce3a@gmx.de>
Subject: Re: [RFC PATCH] ASoC: wm8741: Add differential mono
 mode support
Date: Mon, 04 May 2015 21:03:56 +0200
Message-ID: <5547C29C.9020905@gmx.de>
References: <1430504037-7170-1-git-send-email-ce3a@gmx.de>
 <20150504112537.GA15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 71A8B2605A4
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 21:04:04 +0200 (CEST)
In-Reply-To: <20150504112537.GA15510@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, ckeepax@opensource.wolfsonmicro.com, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Am 04.05.2015 um 13:25 schrieb Mark Brown:
> On Fri, May 01, 2015 at 08:13:57PM +0200, Sergej Sawazki wrote:
>
>> +static const struct snd_kcontrol_new wm8741_snd_controls_mono_right[] = {
>> +	SOC_SINGLE_TLV("Fine Playback Volume Right", WM8741_DACRLSB_ATTENUATION,
>> +		1, 255, 1, dac_tlv_fine),
>> +	SOC_SINGLE_TLV("Playback Volume Right", WM8741_DACRMSB_ATTENUATION,
>> +		0, 511, 1, dac_tlv),
>> +};
>
> Please follow the control naming standard in ControlNames.txt: all
> volume controls must have Volume as the last word in the name.

Thanks for this information. I would suggest "Right Fine Playback
Volume". Where "Right" is the "CHANNEL" from ControlNames.txt.
However, there is no "Right" in the "CHANNEL" section.
What do you think?

>>   	.name = "wm8741",
>>   	.playback = {
>>   		.stream_name = "Playback",
>> -		.channels_min = 2,  /* Mono modes not yet supported */
>> +		.channels_min = 1,
>>   		.channels_max = 2,
>
> This should be varying with the platform data: in the mono modes we
> can't do stereo and I suspect the stereo modes may have issues with
> mono.

I think this should be always ".channels_min = 2". In "mono mode"
the DAC plays either the right or the left channel, however the I2S
signal is expected to be stereo.

Sergej
