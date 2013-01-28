From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: Re: M-Audio Audiophile 192 (ice1724)'s broken spdif
 capture
Date: Mon, 28 Jan 2013 22:25:53 +0100
Message-ID: <5106ECE1.7040608@gmail.com>
References: <CAF+J8LeejgAx6vs0Ee8svWpmGYyk3-7SK+mE1ev-bWXYy-7v6Q@mail.gmail.com>
 <51042EE5.5070900@perex.cz>
 <7adcf466397b198e2e079e35b47686bc.squirrel@mail.insite.cz>
 <CAF+J8LduUEPqaguteL0oyiACXa4jVXGTVVTCm4Tw=jMxRTmLWA@mail.gmail.com>
 <510644E5.1040505@perex.cz> <5106747A.5070803@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 12B98265372
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 22:25:56 +0100 (CET)
Received: by mail-bk0-f47.google.com with SMTP id jc3so1637359bkc.20
 for <alsa-devel@alsa-project.org>; Mon, 28 Jan 2013 13:25:55 -0800 (PST)
In-Reply-To: <5106747A.5070803@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Am 28.01.2013 13:52, schrieb Pavel Hofman:
> On 28.1.2013 10:29, Jaroslav Kysela wrote:
>> Date 27.1.2013 16:49, Jonas Petersen wrote:
>>> in ap192_ak4114_init() of revo.c I see this:
>>>
>>> ---- static const unsigned char ak4114_init_vals[] = { AK4114_RST |
>>> AK4114_PWN | AK4114_OCKS0 | AK4114_OCKS1, AK4114_DIF_I24I2S,
>>> AK4114_TX1E, AK4114_EFH_1024 | AK4114_DIT | AK4114_IPS(1), 0, 0 };
>>> static const unsigned char ak4114_init_txcsb[] = { 0x41, 0x02,
>>> 0x2c, 0x00, 0x00 }; ----
>>>
>>> Something wrong here maybe?
>>>
>>> I noticed that the ak4114_init_vals array has 6 values but in
>>> ap192_ak4114_init() 7 values get written to ak4114.regmap.
>> Looking to the AK4114 datasheet. I would try the clock mode 2
>> (CM1=1,CM0=0) and also, check if there is a 11.2896Mhz crystal used
>> for the reference clock (XTL1, XTL0). Also, the note in revo.c that
>> the input rate reported by AK4114 is unstable, clearly shows that the
>> clock logic is screwed (misconfigured).
>
> The crystal is not used
> http://www.nix.ru/autocatalog/m_audio_midiman_sound/34397_2245_draft.jpg
> . IME ak411x cards without the auxiliary Xiling fpga do not provide the
> independent clock from ak411X and thus cannot report the input rate
> correctly. That is why I do not make use of the value in the driver
> (ak->check_flags = AK4114_CHECK_NO_RATE)
>
> Jonas, please could you check if ak4114 pins XTL0/1 (10, 11) are
> connected to logical high? They should be :)

Physically they're both on ground. I don't know what active state that 
chip has though.
