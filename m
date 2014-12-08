From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: I2S frame configuration
Date: Mon, 08 Dec 2014 20:37:58 +0100
Message-ID: <5485FE16.1040005@metafoo.de>
References: <5485C5CA.8030402@gmail.com> <5485D96C.3020900@ladisch.de>
 <5485E7E5.7020406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-158.synserver.de (smtp-out-158.synserver.de
 [212.40.185.158])
 by alsa0.perex.cz (Postfix) with ESMTP id 21E7326049B
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 20:38:02 +0100 (CET)
In-Reply-To: <5485E7E5.7020406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: thomas chen <tchen61@gmail.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 12/08/2014 07:03 PM, thomas chen wrote:
>
> Thanks for the info... so it is possible for Asoc to handle such format...

Yes, its not a special format, it is just plain and simple I2S like it is =

supported by the majority of all drivers/devices.

>
> So where does one specify number of bits in a FRAME/WORD (epsecially if we
> were to be master instead of slave ?)

That's typically specified in the format that is used, e.g. in your case =

SNDRV_PCM_FORMAT_S24_3LE. This is not necessarily ideal for all cases, but =

has work well enough so far.

>
> and, how does one specify number of bits to ignore (before the valid data)

There are no bits to ignore the valid data. I2S has a delay of 1 bit clock =

cycle between the first bit of the sample and the frame sync signal. So the =

data bit that is transmitted on the same clock cycle as the frame sync is =

actually the last bit of the previous sample. So in your case your sample =

has 16 valid bits followed by 8 ignored bits.

>
> and also how many valid bits (ie size of data word) ???

You can set a snd_pcm_hw_constraint_msbits() constraint to tell userspace =

that only a certain amount of bits are actually going to be used.

If you are using ASoC you can do this by setting the sig_bits property on =

your snd_soc_dai_driver.

- Lars

>
> Thanks...
>
>
>
>
> On 12/8/2014 12:01 PM, Clemens Ladisch wrote:
>> thomas chen wrote:
>>> I am working on a ALSA interface to a particular codec over I2S
>>>
>>> the audio stream format is a bit peculiar...
>>>
>>> there are 24 BCLK cycle between transition of FSYNC...   howver, there
>>> are only 16 bit that are valid
>>>
>>> bit 0: ignore
>>> bit 1-16:   valid pcm data (MSB....LSB)
>>> bit 17-23: ignore
>> This is the 'original' I=B2S format.  The format where the sample begins
>> with the 1st BCLK usually is called left-justified (and uses the
>> opposite FSYNC polarity).
>>
>> Having ignored bits is common.  (Typically, there are 32 BCLK cycles per
>> sample.)
>>
>> In ASoC, this would be SND_SOC_DAIFMT_I2S and SND_SOC_DAIFMT_LEFT_J.
>>
>>
>> Regards,
>> Clemens
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
