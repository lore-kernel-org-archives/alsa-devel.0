From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH] ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask
Date: Wed, 27 May 2015 14:04:32 +0200
Message-ID: <5565B2D0.6080506@maciej.szmigiero.name>
References: <5560AB9D.1010807@maciej.szmigiero.name>	<s5h382j29ey.wl-tiwai@suse.de>	<55647D25.80807@maciej.szmigiero.name> <s5hk2vvctx6.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hk2vvctx6.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <daniel@zonque.org>, Wolfram Sang <wsa@the-dreams.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Matt Reimer <mreimer@sdgsystems.com>
List-Id: alsa-devel@alsa-project.org

W dniu 26.05.2015 16:09, Takashi Iwai pisze:
> At Tue, 26 May 2015 16:03:17 +0200,
> Maciej S. Szmigiero wrote:
>>
>> Hello Takashi,
>>
>> W dniu 26.05.2015 07:29, Takashi Iwai pisze:
>>> At Sat, 23 May 2015 18:32:29 +0200,
>>> Maciej S. Szmigiero wrote:
>>>>
>>>> snd_soc_pcm_stream.formats is a bitmask of SNDRV_PCM_FMTBIT_*,
>>>> not of SNDRV_PCM_FORMAT_* (which are sequential integers),
>>>> however some of ASoC CODEC drivers use these values instead.
>>>>
>>>> Found out by sparse on 0-day kernel tester.
>>>>
>>>> Signed-off-by: Maciej Szmigiero <mail@maciej.szmigiero.name>
>>>
>>> Wow, that made me wonder how these drivers could actually work.
>>
>> Maybe, by coincidence, the wrong defines contained enough bits
>> set to actually select some common, working format with their
>> controllers?
> 
> Well, FORMAT_S16_LE = 2, and FORMAT_S18_3LE = 40.  So bits 1, 3 and 5
> are set, which corresponds to U8, S16_BE and U16_BE.  Hmm.
> 
>>> BTW, how did you detect it?  Any static analyzer like sparse or
>>> smatch?  sparse didn't detect it at the last time I tried, IIRC...
>>
>> I've received an e-mail from "kbuild test robot" at
>> "0-DAY kernel test infrastructure" that automated testing there
>> using sparse found this issue on wm9713 and stac9766 CODECs.
>>
>> The exact warning was:
>>>> sound/soc/codecs/stac9766.c:324:28: sparse: incorrect type in initializer (different base types)
>>    sound/soc/codecs/stac9766.c:324:28:    expected unsigned long long [unsigned] [usertype] formats
>>    sound/soc/codecs/stac9766.c:324:28:    got restricted snd_pcm_format_t [usertype] <noident>
>>
>> What is important the warning doesn't show unless a check build
>> is made with CF=-D__CHECK_ENDIAN__ .
> 
> Ah, thanks, that was the missing piece.
> 
>> Upon checking I've found the same issue also in two other CODECs,
>> which aren't normally being built on x86_64 (target architecture
>> for above automated build) even when SND_SOC_ALL_CODECS is selected.
> 
> Oh it'd be great if you submit fixes :)

The fixes for these two remaining CODECs were included in the patch
(I've meant that these two weren't in the automated checking report
I've received).

Upon looking again at it the "0-DAY kernel test infrastructure"
have to be using some limited config, since all of the CODECs
with this issue are being built/checked in allyesconfig
(it selects the required dependences for them even on x86_64).

> thanks,
> 
> Takashi
> 

Thanks,
Maciej Szmigiero
