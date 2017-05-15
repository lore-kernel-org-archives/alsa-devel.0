From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] ALSA: firewire-tascam: Fix infinite loop in snd_tscm_stream_get_rate()
Date: Mon, 15 May 2017 16:22:50 +0200
Message-ID: <CAMuHMdXOkx3XcqH3LS--5Z9Gbfdftgvrbsz8MhH-4k3rqSmxRw@mail.gmail.com>
References: <1494836350-28790-1-git-send-email-geert@linux-m68k.org> <fab2c28e-4ed2-8995-d11e-a843195103b2@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fab2c28e-4ed2-8995-d11e-a843195103b2@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: alsa-devel@alsa-project.org

Hi Sakamoto-san,

On Mon, May 15, 2017 at 4:07 PM, Takashi Sakamoto
<o-takashi@sakamocchi.jp> wrote:
> On May 15 2017 17:19, Geert Uytterhoeven wrote:
>> Obviously the intention was to put a limit on the maximum number of
>> operations.  However, for this to work, the check should be
>> "&& trials++ < 5", not "|| trials++ < 5".
>>
>> Fixes: 35efa5c489de63a9 ("ALSA: firewire-tascam: add streaming
>> functionality")
>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>> Compile-tested only.
>>
>> Triggered by a false-positive warning from gcc-4.1.2:
>>
>>     warning: =E2=80=98err=E2=80=99 may be used uninitialized in this fun=
ction
>> ---
>>  sound/firewire/tascam/tascam-stream.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/firewire/tascam/tascam-stream.c
>> b/sound/firewire/tascam/tascam-stream.c
>> index f1657a4e0621ef49..e433b92ac6904db5 100644
>> --- a/sound/firewire/tascam/tascam-stream.c
>> +++ b/sound/firewire/tascam/tascam-stream.c
>> @@ -84,7 +84,7 @@ int snd_tscm_stream_get_rate(struct snd_tscm *tscm,
>> unsigned int *rate)
>>         unsigned int trials =3D 0;
>>         int err;
>>
>> -       while (data =3D=3D 0x0 || trials++ < 5) {
>> +       while (data =3D=3D 0x0 && trials++ < 5) {
>>                 err =3D get_clock(tscm, &data);
>>                 if (err < 0)
>>                         return err;
>
> Yep. It looks a bug.
>
> ...However, removal of the bug causes issue that the driver fails to star=
t a
> pair of capture/playback PCM substream when application requests them mos=
tly
> the same time, like jackd process.
>
> I think I did apply the bug as a makeshift workaround, then forgot itself
> when developing the driver... I'd like to have a bit time for further
> investigation, then post my fix in this development period.

Probably you need a small delay in the loop?
Why else do you #include <linux/delay.h>? ;-)

> Please let me keep this patch pending.

OK.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
