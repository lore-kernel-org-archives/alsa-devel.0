From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v2 1/5] sound: sam9x5_wm8731: machine driver for
 at91sam9x5 wm8731 boards
Date: Tue, 9 Jul 2013 10:19:45 +0200
Message-ID: <CACQ1gAgJyTSdxAKK7uwG-ybE2ddC90podM3+tOAqQwZUspsU8Q@mail.gmail.com>
References: <1373290193-25300-1-git-send-email-richard.genoud@gmail.com>
 <1373290193-25300-2-git-send-email-richard.genoud@gmail.com> <20130708150721.GK27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130708150721.GK27646@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

2013/7/8 Mark Brown <broonie@kernel.org>:
> On Mon, Jul 08, 2013 at 03:29:49PM +0200, Richard Genoud wrote:
>
>> + *             Nicolas Ferre <nicolas.ferre@atmel.com>
>> + *
>> + * Based on sam9g20_wm8731.c by:
>> + * Sedji Gaouaou <sedji.gaouaou@atmel.com>
>
> The obvious question here is of course if we can use the same driver for
> both of them.
I haven't got a g20 to test that, but that's the goal.
For now, g20 is still non-DT, so I think it's best to have a DT-only
driver like this one for the 9x5 family (9g15, 9g25, 9x25, 9g35,
9x25).
When the g20 will move to DT completely, we can drop sam9g20_wm8731.c
and adjust sam9x5_wm8731.c (mainly master clock and widgets it seems)
By the way, maybe g45 could use that also (and SAMA5 ?)

>
>> +     codec_dai->driver->playback.rates &= SNDRV_PCM_RATE_8000 |
>> +             SNDRV_PCM_RATE_32000 |
>> +             SNDRV_PCM_RATE_48000 |
>> +             SNDRV_PCM_RATE_96000;
>> +     codec_dai->driver->capture.rates &= SNDRV_PCM_RATE_8000 |
>> +             SNDRV_PCM_RATE_32000 |
>> +             SNDRV_PCM_RATE_48000 |
>> +             SNDRV_PCM_RATE_96000;
>
> You definitely shouldn't be fiddling with a driver's constant static
> data.  You want to be using snd_pcm_hw_constraint() APIs to set
> additional constraints intead.
Ok, I'll change that.


Thanks !

-- 
for me, ck means con kolivas and not calvin klein... does it mean I'm a geek ?
