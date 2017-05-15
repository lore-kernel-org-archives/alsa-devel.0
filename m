From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/2] ALSA: firewire-tascam: Fix infinite loop in
 snd_tscm_stream_get_rate()
Date: Mon, 15 May 2017 23:40:12 +0900
Message-ID: <6d8977cb-05c9-b237-2f2d-8b0ab8077bc6@sakamocchi.jp>
References: <1494836350-28790-1-git-send-email-geert@linux-m68k.org>
 <fab2c28e-4ed2-8995-d11e-a843195103b2@sakamocchi.jp>
 <CAMuHMdXOkx3XcqH3LS--5Z9Gbfdftgvrbsz8MhH-4k3rqSmxRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXOkx3XcqH3LS--5Z9Gbfdftgvrbsz8MhH-4k3rqSmxRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arnd Bergmann <arnd@arndb.de>, Clemens Ladisch <clemens@ladisch.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On May 15 2017 23:22, Geert Uytterhoeven wrote:
>>> diff --git a/sound/firewire/tascam/tascam-stream.c
>>> b/sound/firewire/tascam/tascam-stream.c
>>> index f1657a4e0621ef49..e433b92ac6904db5 100644
>>> --- a/sound/firewire/tascam/tascam-stream.c
>>> +++ b/sound/firewire/tascam/tascam-stream.c
>>> @@ -84,7 +84,7 @@ int snd_tscm_stream_get_rate(struct snd_tscm *tscm,
>>> unsigned int *rate)
>>>         unsigned int trials = 0;
>>>         int err;
>>>
>>> -       while (data == 0x0 || trials++ < 5) {
>>> +       while (data == 0x0 && trials++ < 5) {
>>>                 err = get_clock(tscm, &data);
>>>                 if (err < 0)
>>>                         return err;
>>
>> Yep. It looks a bug.
>>
>> ...However, removal of the bug causes issue that the driver fails to start a
>> pair of capture/playback PCM substream when application requests them mostly
>> the same time, like jackd process.
>>
>> I think I did apply the bug as a makeshift workaround, then forgot itself
>> when developing the driver... I'd like to have a bit time for further
>> investigation, then post my fix in this development period.
>
> Probably you need a small delay in the loop?
> Why else do you #include <linux/delay.h>? ;-)

I know PDI1394L40 (link layer) has quirks inconvenient to us. 
Furthermore, the behaviour of on-board FPGAs with unique firmwares are 
in black boxes to me.

I prefer deliberate approach for this kind of work, reverse engineering.


Regards

Takashi Sakamoto
