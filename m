From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Breakage in pcm_lib.c
Date: Sun, 26 Apr 2009 11:21:44 -0400
Message-ID: <9e4733910904260821xd2d8790me58993df9f530c6f@mail.gmail.com>
References: <9e4733910904251756y6534d2d0x6c201d00cbc728d9@mail.gmail.com>
	<9e4733910904251848q4d64c413ld5af61019edae647@mail.gmail.com>
	<alpine.LNX.2.00.0904261000520.25064@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 1299124392
	for <alsa-devel@alsa-project.org>;
	Sun, 26 Apr 2009 17:21:45 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3701789qyk.16
	for <alsa-devel@alsa-project.org>; Sun, 26 Apr 2009 08:21:45 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0904261000520.25064@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Grant Likely <grant.likely@secretlab.ca>, Takashi Iwai <tiwai@suse.de>, alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Apr 26, 2009 at 4:12 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Sat, 25 Apr 2009, Jon Smirl wrote:
>
>> This appears to be a bug in this code...
>>
>> =A0 =A0 =A0 =A0if (delta < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta +=3D runtime->period_size * runtime=
->periods;
>>
>> it was adding, buffer_size. But buffer_size is not correct when the
>> periods don't evenly fit into the buffer
>
> Could you show real values what you're getting here with your driver?

root@phyCORE:~ aplay phone.wav
mpc5200-psc-ac97 f0002200.sound: psc_dma_startup(substream=3Dc792d700)
mpc5200-psc-ac97 f0002200.sound: psc_dma_pcm_open(substream=3Dc792d700)
Playing WAVE 'phone.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Ster=
eo
mpc5200-psc-ac97 f0002200.sound:
psc_ac97_hw_analog_params(substream=3Dc792d700) p_size=3D5513
p_bytes=3D44104 periods=3D3 buffer_size=3D22050  buffer_bytes=3D176400
channels=3D2 rate=3D44100 format=3D11
boundary 22050
boundary 1 1445068800
stac9766: ac97_analog_prepare rate 44100
rate is bb80 5622
mpc5200-psc-ac97 f0002200.sound: psc_dma_trigger(substream=3Dc792d700,
cmd=3D1) stream_id=3D0
psc_dma_pcm_pointer pos 5513
hw_ptr_interrupt 5513 new_hw_ptr 5513
delta 0 buffer_size 22050
old_hw_ptr 0 new_hw_ptr 5513
rate 44100 HZ 300
jdelta 50 jiffies -79179 runtime->hw_ptr_jiffies -79229
Saved jiffies a -79179
psc_dma_pcm_pointer pos 11026
hw_ptr_interrupt 11026 new_hw_ptr 11026
delta 0 buffer_size 22050
old_hw_ptr 5513 new_hw_ptr 11026
rate 44100 HZ 300
jdelta 38 jiffies -79141 runtime->hw_ptr_jiffies -79179
Saved jiffies a -79141
psc_dma_pcm_pointer pos 16539
hw_ptr_interrupt 16539 new_hw_ptr 16539
delta 0 buffer_size 22050
old_hw_ptr 11026 new_hw_ptr 16539
rate 44100 HZ 300
jdelta 37 jiffies -79104 runtime->hw_ptr_jiffies -79141
Saved jiffies a -79104
psc_dma_pcm_pointer pos 0
hw_ptr_interrupt 22052 new_hw_ptr 0
delta -22052 buffer_size 22050
ALSA sound/core/pcm_lib.c:241: PCM: Unexpected hw_pointer value
(stream=3D0, pos=3D0, intr_ptr=3D22052)
old_hw_ptr 16539 new_hw_ptr 22052
rate 44100 HZ 300
jdelta 38 jiffies -79066 runtime->hw_ptr_jiffies -79104
Saved jiffies a -79066
psc_dma_pcm_pointer pos 5513
hw_ptr_interrupt 27565 new_hw_ptr 27563
delta -2 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 49613
rate 44100 HZ 300
jdelta 37 jiffies -79029 runtime->hw_ptr_jiffies -79066
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D5513,
delta=3D27561, period=3D5513, jdelta=3D37/187/0)
Saved jiffies a -79029
psc_dma_pcm_pointer pos 11026
hw_ptr_interrupt 27565 new_hw_ptr 33076
delta 5511 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 33076
rate 44100 HZ 300
jdelta 38 jiffies -78991 runtime->hw_ptr_jiffies -79029
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D11026,
delta=3D11024, period=3D5513, jdelta=3D38/74/0)
Saved jiffies a -78991
psc_dma_pcm_pointer pos 16539
hw_ptr_interrupt 27565 new_hw_ptr 38589
delta 11024 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 38589
rate 44100 HZ 300
jdelta 37 jiffies -78954 runtime->hw_ptr_jiffies -78991
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D16539,
delta=3D16537, period=3D5513, jdelta=3D37/112/0)
Saved jiffies a -78954
psc_dma_pcm_pointer pos 0
hw_ptr_interrupt 27565 new_hw_ptr 22050
delta -5515 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 44100
rate 44100 HZ 300
jdelta 38 jiffies -78916 runtime->hw_ptr_jiffies -78954
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D0,
delta=3D22048, period=3D5513, jdelta=3D38/149/0)
Saved jiffies a -78916
psc_dma_pcm_pointer pos 5513
hw_ptr_interrupt 27565 new_hw_ptr 27563
delta -2 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 49613
rate 44100 HZ 300
jdelta 37 jiffies -78879 runtime->hw_ptr_jiffies -78916
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D5513,
delta=3D27561, period=3D5513, jdelta=3D37/187/0)
Saved jiffies a -78879
psc_dma_pcm_pointer pos 11026
hw_ptr_interrupt 27565 new_hw_ptr 33076
delta 5511 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 33076
rate 44100 HZ 300
jdelta 38 jiffies -78841 runtime->hw_ptr_jiffies -78879
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D11026,
delta=3D11024, period=3D5513, jdelta=3D38/74/0)
Saved jiffies a -78841
psc_dma_pcm_pointer pos 16539
hw_ptr_interrupt 27565 new_hw_ptr 38589
delta 11024 buffer_size 22050
old_hw_ptr 22052 new_hw_ptr 38589
rate 44100 HZ 300
jdelta 37 jiffies -78804 runtime->hw_ptr_jiffies -78841
ALSA sound/core/pcm_lib.c:269: PCM: hw_ptr skipping! [Q] (pos=3D16539,
delta=3D16537, period=3D5513, jdelta=3D37/112/0)
Saved jiffies a -78804
 Aborted by signal Interrupt...
mpc5200-psc-ac97 f0002200.sound: psc_dma_trigger(substream=3Dc792d700,
cmd=3D0) stream_id=3D0
mpc5200-psc-ac97 f0002200.sound: psc_dma_shutdown(substream=3Dc792d700)
mpc5200-psc-ac97 f0002200.sound: psc_dma_pcm_close(substream=3Dc792d700)
root@phyCORE:~ mpc5200-psc-ac97: timeout on ac97 write

>
> The buffer_size is always a wrap point. For example:
>
> buffer_size =3D 4096
> period_size =3D 1536
>
> hw_ptr_interrupt =3D> 1536, 3072, 4608
>
> For example, if we receive update_hw_interrupt for second period
> late when pos (.pointer callback) =3D 100 and hw_ptr_interrupt =3D 3072 (=
hw_base
> is 0 at the moment):
>
> new_hw_ptr =3D 100
> hw_ptr_interrupt =3D 3072
> delta =3D -2972
>
> delta +=3D buffer_size -> delta =3D 1124 =A0 =A0- seems correct
>
> Apparently, your .pointer callback returns wrong values.

The .pointer computation code is in sound/soc/fsl/mpc5200_psc_i2s.c
I was adding AC97 support to that driver. But the i2s is broken too.

psc_ac97_hw_analog_params(substream=3Dc792d700) p_size=3D5513
p_bytes=3D44104 periods=3D3 buffer_size=3D22050  buffer_bytes=3D176400
channels=3D2 rate=3D44100 format=3D11

How does this add up? period size is 5513 and buffer_size is 22050.
5513 * 4 =3D 22052 which doesn't fit. That's why periods is equal to 3.


>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (delta < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw_ptr_error(substream,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
"Unexpected hw_pointer value "
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
"(stream=3D%i, pos=3D%ld,
>> intr_ptr=3D%ld)\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
substream->stream, (long)pos,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
(long)hw_ptr_interrupt);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* rebase to interrupt po=
sition */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw_base =3D new_hw_ptr =
=3D hw_ptr_interrupt;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* align hw_base to buffe=
r_size */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw_base -=3D hw_base % ru=
ntime->buffer_size;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0delta =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hw_base +=3D runtime->per=
iod_size * runtime->periods;
>>
>> same here
>
> hw_base is always aligned to buffer_size (start of ring buffer)
>
>> =A0 =A0 =A0 =A0delta =3D jiffies - s->jiffies; /* s->jiffies recorded at=
 DMA
>> interrrupt at end of buffer */
>> =A0 =A0 =A0 =A0delta =3D delta * runtime->rate / HZ;
>
> Using jiffies to correct stream position seems correct to me.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
>



-- =

Jon Smirl
jonsmirl@gmail.com
