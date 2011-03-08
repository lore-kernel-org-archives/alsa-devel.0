From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: snd_pcm_hw_params_set_buffer_time_near: invalid
	argument
Date: Tue, 8 Mar 2011 21:25:25 +0800
Message-ID: <AANLkTikfSbTD_LVXcZJcRKrYc91ySxwVwpkVZdfPpGJq@mail.gmail.com>
References: <AANLkTik5sX_DWLsN3y_7ANpoF5rgeCNZY7gm=+rFhCsy@mail.gmail.com>
	<AANLkTimfZwH+dqsPZaifekmmctrARdE0DoK5nHoW1Fu_@mail.gmail.com>
	<AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE7BB103820
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 14:25:25 +0100 (CET)
Received: by fxm11 with SMTP id 11so5151330fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Mar 2011 05:25:25 -0800 (PST)
In-Reply-To: <AANLkTinNhknw6h81zkqhhXQwYyrKGs0mVjYpjYvZuNa=@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
List-Id: alsa-devel@alsa-project.org

2011/3/8 Jean-Yves Avenard <jyavenard@gmail.com>

> On 7 March 2011 23:24, Raymond Yau <superquad.vortex2@gmail.com> wrote:
>
> > This seem to be bug in alsa-lib as I can reproduce using
> alsa-lib/test/pcm.c
> > with buffer time 120000 and my hda codec support both 11025Hz and 22050Hz
> >
> > using buffer time 160000 is OK
>
> Yes.. It's hard to understand why 120ms wouldn't be okay, but 160ms would.
>
> Could you check is 400ms works for you ? I found this to be a value
> that generally do not work when using 44.1kHz 6 channels audio.
>
> For the time being, I made my application use 500ms buffer; this is
> what many media players are using (including mplayer) , so I'm
> guessing it would be fine under most circumstances otherwise we would
> have heard about it before.
>
> Jean-Yves
>

It seem that hda-intel does not really has AZX_MAX_BUF_SIZE 1024x1024x1024
on 32bits machine , buffer bytes was reduced to 64K bytes  at the beginning
by "Rule 23"

Does linux kernel allow ALSA allocate 2/3 of system memory for sound buffer
on a machine iwth 1.5Gbytes memory

64Kbytes is only 371ms of S16_LE 44100Hz stereo


ACCESS = 00000000ffffffffffffffff -> 0000000000000009
FORMAT = 00000000ffffffffffffffff -> 0000000000000404
SUBFORMAT = 00000000ffffffffffffffff -> 0000000000000001
SAMPLE_BITS = [0 4294967295] -> [0 4294967295]
FRAME_BITS = [0 4294967295] -> [0 4294967295]
CHANNELS = [0 4294967295] -> [2 8]
RATE = [0 4294967295] -> [8000 192000]
PERIOD_TIME = [0 4294967295] -> [0 4294967295]
PERIOD_SIZE = [0 4294967295] -> [0 4294967295]
PERIOD_BYTES = [0 4294967295] -> [128 536870912]
PERIODS = [0 4294967295] -> [2 32]
BUFFER_TIME = [0 4294967295] -> [0 4294967295]
BUFFER_SIZE = [0 4294967295] -> [0 4294967295]
BUFFER_BYTES = [0 4294967295] -> [128 1073741824]
TICK_TIME = [0 4294967295] -> [0 4294967295]
Rule 0 [f8ae36f2]: FORMAT = 404 -> 404
Rule 1 [f8ae351b]: SAMPLE_BITS = [0 4294967295] -> [16 32]
Rule 2 [f8ae365f]: SAMPLE_BITS = [16 32] -> [16 32]
Rule 3 [f8ae361d]: FRAME_BITS = [0 4294967295] -> [32 256]
Rule 4 [f8ae35d9]: FRAME_BITS = [32 256] -> [32 256]
Rule 5 [f8ae35d9]: FRAME_BITS = [32 256] -> [32 256]
Rule 6 [f8ae365f]: CHANNELS = [2 8] -> [2 8]
Rule 7 [f8ae35d9]: RATE = [8000 192000] -> [8000 192000]
Rule 8 [f8ae35d9]: RATE = [8000 192000] -> [8000 192000]
Rule 9 [f8ae365f]: PERIODS = [2 32] -> [2 32]
Rule 10 [f8ae365f]: PERIOD_SIZE = [0 4294967295] -> [0 2147483647]
Rule 11 [f8ae35d9]: PERIOD_SIZE = [0 2147483647] -> [4 134217728]
Rule 12 [f8ae3595]: PERIOD_SIZE = [4 134217728] -> [4 134217728]
Rule 13 [f8ae361d]: BUFFER_SIZE = [0 4294967295] -> [8 4294967295]
Rule 14 [f8ae35d9]: BUFFER_SIZE = [8 4294967295] -> [8 268435456]
Rule 15 [f8ae3595]: BUFFER_SIZE = [8 268435456] -> [8 268435456]
Rule 16 [f8ae3595]: PERIOD_BYTES = [128 536870912] -> [128 536870912]
Rule 17 [f8ae3595]: BUFFER_BYTES = [128 1073741824] -> [128 1073741824]
Rule 18 [f8ae35d9]: PERIOD_TIME = [0 4294967295] -> (20 4294967295]
Rule 19 [f8ae35d9]: BUFFER_TIME = [0 4294967295] -> (41 4294967295]
Rule 20 [f8ae5fa6]: BUFFER_BYTES = [128 1073741824] -> [128 1073741824]
Rule 21 [f8ae5fa6]: PERIOD_BYTES = [128 536870912] -> [128 536870912]
Rule 22 [f8ae5fa6]: CHANNELS = [2 8] -> [2 8]
Rule 23 [f8ae34e2]: BUFFER_BYTES = [128 1073741824] -> [128 65536]
Rule 24 [f8ae34bd]: RATE = [8000 192000] -> [8000 192000]
