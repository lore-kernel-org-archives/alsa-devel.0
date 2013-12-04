From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A mode
Date: Wed, 4 Dec 2013 17:06:02 +0100
Message-ID: <CACQ1gAjYuhOUsCoDKFvYQcpRF1pxFHFxN=AO4Uoh2hJmW=kOgQ@mail.gmail.com>
References: <1386124624-22414-1-git-send-email-voice.shen@atmel.com>
 <1386124624-22414-3-git-send-email-voice.shen@atmel.com> <529F1424.7040501@gmail.com>
 <075e01cef109$136c56f0$3a4504d0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sound-owner@vger.kernel.org>
In-Reply-To: <075e01cef109$136c56f0$3a4504d0$@com>
Sender: linux-sound-owner@vger.kernel.org
To: Zhong Li <zql@glomationinc.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

2013/12/4 Zhong Li <zql@glomationinc.com>:
> Richard,
>
>> -----Original Message-----
>> From: linux-arm-kernel [mailto:linux-arm-kernel-
>> bounces@lists.infradead.org] On Behalf Of Richard Genoud
>> Sent: Wednesday, December 04, 2013 6:38 AM
>> To: Bo Shen
>> Cc: zql@glomationinc.com; nicolas.ferre@atmel.com; alsa-devel@alsa-
>> project.org; linux-sound@vger.kernel.org; broonie@kernel.org; linux-
>> arm-kernel@lists.infradead.org
>> Subject: Re: [PATCH 2/2] ASoC: sam9x5_wm8731: change to work in DSP A
>> mode
>>
>> On 04/12/2013 03:37, Bo Shen wrote:
>> > Change sam9x5 with wm8731 work in DSP A mode, this will fix the
>> > left/right channel swap issue.
>> >
>
>> >
>> Tested-by: Richard Genoud <richard.genoud@gmail.com> on at91sam9g35-ek
>> with 3.12-rc2 + "ASoC: wm8731: fix dsp mode configuration"
>>
>>
>> Thanks !
>>
>>
>
> Where can I get a snap shot of your kernel source?  My test still have the
> same issue after I applied the two patches.

I don't have a public git, but I just applied the patches :
"ASoC: wm8731: fix dsp mode configuration"
"ASoC: sam9x5_wm8731: change to work in DSP A mode"
"ASoC: atmel_ssc_dai: add dai trigger ops"
on top of 3.12-rc2
=> maybe you missed the third patch "ASoC: wm8731: fix dsp mode
configuration" which was not part of the serie.
(without it, you should have a left channel almost ok and a noisy right channel)

and if you want a git tree, you can still test with mark's :
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
branch sound_asoc/for-next or tag asoc-v3.13-rc2
