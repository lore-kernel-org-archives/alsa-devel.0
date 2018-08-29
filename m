From: Matt Flax <flatmax@flatmax.org>
Subject: Re: [PATCH 2/3] ASoC: cs4265: Add native 32bit I2S
 transport
Date: Wed, 29 Aug 2018 10:26:47 +1000
Message-ID: <3fc05e94-cfd2-c9e0-9e7c-c9157e5c47ad@flatmax.org>
References: <20180826225844.13754-1-flatmax@flatmax.org>
 <20180826225844.13754-2-flatmax@flatmax.org>
 <20180827082843.GU32322@imbe.wolfsonmicro.main>
 <20180828185652.GJ2414@sirena.org.uk>
 <cbf11383-f9f5-22a3-6fa0-e097462716f2@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.flatmax.org (mx.flatmax.org [13.55.16.222])
 by alsa0.perex.cz (Postfix) with ESMTP id DB79826779D
 for <alsa-devel@alsa-project.org>; Wed, 29 Aug 2018 02:26:52 +0200 (CEST)
In-Reply-To: <cbf11383-f9f5-22a3-6fa0-e097462716f2@flatmax.org>
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
To: Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On 29/08/18 09:31, Matt Flax wrote:
>
>
> On 29/08/18 04:56, Mark Brown wrote:
>> On Mon, Aug 27, 2018 at 09:28:43AM +0100, Charles Keepax wrote:
>>
>>> Are you sure this is correct? The datasheet for the part only
>>> says it supports up to 24-bit audio and I thought the defines
>>> SNDRV_PCM_FMTBIT_S24_LE and U24 are expected to have 32-bits
>>> in the slot whilst on the bus.
>> No, they're not.=A0 They're expected to be 32 bit in memory and 24 bit on
>> the bus.
>>
>
> If this is the case, then I would assume that 32bit formats are forced =

> through ALSA plughw.
>
> If operation is forced through plughw, then this patch is necessary to =

> allow native 32 operation on the bus. The codec drops the 8 LSBs =

> during operation as it reads/writes the 24 MSBs.
>

Just to confirm this patch is necessary to support 32 bit audio formats =

naively with the cs4265 codec. I did the following tests.

Without the codec patch, limiting to 24 and 16 bit formats :
$ aplay -v tone.48k.1s.2ch.32bit.wav
aplay: set_params:1233: Sample format non available
Available formats:
- S16_LE
- S24_LE

With the codec patch, 32 bits are allowed on the I2S bus it plays as =

expected :
$ aplay -v tone.48k.1s.2ch.32bit.wav
Playing WAVE 'tone.48k.1s.2ch.32bit.wav' : Signed 32 bit Little Endian, =

Rate 48000 Hz, Stereo
