From: thomas chen <tchen61@gmail.com>
Subject: Re: I2S frame configuration
Date: Mon, 08 Dec 2014 13:03:17 -0500
Message-ID: <5485E7E5.7020406@gmail.com>
References: <5485C5CA.8030402@gmail.com> <5485D96C.3020900@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com
 [209.85.192.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B3666260488
 for <alsa-devel@alsa-project.org>; Mon,  8 Dec 2014 19:03:25 +0100 (CET)
Received: by mail-qg0-f44.google.com with SMTP id z60so3825237qgd.17
 for <alsa-devel@alsa-project.org>; Mon, 08 Dec 2014 10:03:25 -0800 (PST)
In-Reply-To: <5485D96C.3020900@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Thanks for the info... so it is possible for Asoc to handle such format...

So where does one specify number of bits in a FRAME/WORD (epsecially if =

we were to be master instead of slave ?)

and, how does one specify number of bits to ignore (before the valid data)

and also how many valid bits (ie size of data word) ???

Thanks...




On 12/8/2014 12:01 PM, Clemens Ladisch wrote:
> thomas chen wrote:
>> I am working on a ALSA interface to a particular codec over I2S
>>
>> the audio stream format is a bit peculiar...
>>
>> there are 24 BCLK cycle between transition of FSYNC...   howver, there a=
re only 16 bit that are valid
>>
>> bit 0: ignore
>> bit 1-16:   valid pcm data (MSB....LSB)
>> bit 17-23: ignore
> This is the 'original' I=B2S format.  The format where the sample begins
> with the 1st BCLK usually is called left-justified (and uses the
> opposite FSYNC polarity).
>
> Having ignored bits is common.  (Typically, there are 32 BCLK cycles per
> sample.)
>
> In ASoC, this would be SND_SOC_DAIFMT_I2S and SND_SOC_DAIFMT_LEFT_J.
>
>
> Regards,
> Clemens
