From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Mon, 12 May 2014 10:52:38 +0600
Message-ID: <53705396.3070406@gmail.com>
References: <5356A9B6.9060405@gmail.com>	<5358FCF0.2040701@ladisch.de>	<53597BA2.8080201@gmail.com>	<5359FE72.8050605@canonical.com>	<535A6C96.7040109@gmail.com>	<CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>	<535B83E4.5050303@gmail.com>	<CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>	<535E908C.4030509@gmail.com>	<CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>	<535FDEA8.7010206@gmail.com>	<CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>	<5364CE4D.7040506@gmail.com>	<CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>	<536E26A4.1060002@gmail.com>
 <CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040708020706040109000407"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C9313264EAA
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 06:56:08 +0200 (CEST)
Received: by mail-la0-f41.google.com with SMTP id e16so1550883lan.0
 for <alsa-devel@alsa-project.org>; Sun, 11 May 2014 21:56:08 -0700 (PDT)
In-Reply-To: <CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: sergemp@mail.ru, artur.stat@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------040708020706040109000407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

12.05.2014 09:11, Raymond Yau wrote:
> https://bugs.launchpad.net/ubuntu/+source/pulseaudio/+bug/1188425
>
> I: [pulseaudio] alsa-sink.c: Successfully opened device a52:0.
> I: [pulseaudio] alsa-sink.c: Selected mapping 'Digital Surround 5.1
> (IEC958/AC3)' (iec958-ac3-surround-51).
> I: [pulseaudio] alsa-sink.c: Cannot enable timer-based scheduling,
> falling back to sound IRQ scheduling.
> I: [pulseaudio] alsa-sink.c: Successfully enabled mmap() mode.
>
> Seem only hw device report whether it support disable period wake-up
>
> ioplug did not support disable period wake-up and you need A52 plugin t=
o
> provide a parameter to disable the period wakeup of the slave

No, or maybe "not yet". PulseAudio will not try to enable timer-based=20
scheduling on a52 anyway, because of the following source lines.

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/a=
lsa-util.c#n245
http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/alsa/a=
lsa-util.c#n1393

> do you mean pulseaudio can disable period wakeup of the hda-intel
> through extplug ?

Yes. That's a difference between ioplug and extplug. But I don't really=20
care about disabling period interrupts.

>
> D: [alsa-sink] alsa-util.c: PCM state is RUNNING
> I: [alsa-sink] alsa-sink.c: Starting playback.
> I: [alsa-sink] (alsa-lib)pcm_hw.c: SNDRV_PCM_IOCTL_START failed (-77)
>
> does SNDRV_PCM_IOCTL_START fail mean pcm state is no longer running ?

Note that this comes from pcm_hw.c. As PulseAudio does not use the hw:=20
device in this particular use case, I have to conclude that it comes=20
through the a52 or ioplug code. I am not really familiar with this code.

>
>  >
>  > Instead of what you are proposing above, I wrote a loop that
> repeatedly calls snd_pcm_rewindable() 7000000 times and prints the
> result if it differs from the previous one. With snd-hda-intel (PCH), h=
w
> plugin, stereo, S16_LE, 48 kHz, 6 periods, and a period size of 1024, I
> get this:
>  >
>  > Rewindable: 6119, loop iteration: 0
>  > Rewindable: 5119, loop iteration: 5389434
>
> the method can be improved
>
> instead of wake up in half period time to check the value of
> snd_pcm_rewindable()
>
> 1) set the timer to wakeup at 1/16 period time intervals,  if the value=
s
> does not change , this mean that it does not provide accuracy of 1/16 o=
f
> period time and you can know whether it support 1/8 when the next wakeu=
p
> occur at 1/8 period time, ...until you get 16 values for the first peri=
od
>
> 2) if the value of snd_pcm_rewindable change at every 1/16 period time
> intervals , set the timer to wakeup at 1/256 period time at the second
> period

No need to do this. I have already made enough conclusions.=20
Unfortunately, I forgot to attach the new test program (intentionally=20
modified to produce an underrun), doing it now.

The output here is:

$ ./a.out
Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 4
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1024
   period_event : 0
   start_threshold  : 1024
   stop_threshold   : 4096
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 0
   hw_ptr       : 0
Playing silence
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 4
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1024
   period_event : 0
   start_threshold  : 1024
   stop_threshold   : 4096
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 4096
   hw_ptr       : 0
Rewindable: 4096, loop iteration: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 4
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1024
   period_event : 0
   start_threshold  : 1024
   stop_threshold   : 4096
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 4096
   hw_ptr       : 1048
Rewindable: 3048, loop iteration: 1288389
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 4
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1024
   period_event : 0
   start_threshold  : 1024
   stop_threshold   : 4096
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 4096
   hw_ptr       : 2049
Rewindable: 2047, loop iteration: 3010739
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 4
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1024
   period_event : 0
   start_threshold  : 1024
   stop_threshold   : 4096
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 4096
   hw_ptr       : 3092
Rewindable: 1004, loop iteration: 5251015
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 4
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   period_step  : 1
   avail_min    : 1024
   period_event : 0
   start_threshold  : 1024
   stop_threshold   : 4096
   silence_threshold: 0
   silence_size : 0
   boundary     : 4611686018427387904
   appl_ptr     : 4096
   hw_ptr       : 4136
Rewindable: -40, loop iteration: 7807909
This means Too many levels of symbolic links


>
>  >
>  > So snd_pcm_rewindable() can return weird values that are updated
> every period size or so. As such, I wouldn't believe its return value
> out of the box even for hw devices. At loop iteration 5389433, the CPU
> chewed enough time for almost one period, but snd_pcm_rewindable() said
> that almost 6 periods are rewindable. Probably a missing sync_ptr()
> somewhere, or a documentation bug.
>  >
>  > With snd_pcm_avail() inserted (which does synchronize the position)
> before each call to snd_pcm_rewindable(), I get:
>  >
>  > Rewindable: 6119, loop iteration: 0
>  > Rewindable: 6112, loop iteration: 2
>  > Rewindable: 6104, loop iteration: 42
>  > Rewindable: 6096, loop iteration: 76
>  > Rewindable: 6088, loop iteration: 125
>  > Rewindable: 6080, loop iteration: 173
>  > Rewindable: 6072, loop iteration: 222
>  > Rewindable: 6064, loop iteration: 270
>  >
>  > (and an underrun in the end).
>  >
>  > With 4 channels:
>  >
>  > Rewindable: 6112, loop iteration: 0
>  > Rewindable: 6108, loop iteration: 2
>  > Rewindable: 6104, loop iteration: 14
>  > Rewindable: 6100, loop iteration: 36
>  > Rewindable: 6096, loop iteration: 58
>  > Rewindable: 6092, loop iteration: 63
>  >
>  > With 8 channels:
>  >
>  > Rewindable: 6104, loop iteration: 0
>  > Rewindable: 6098, loop iteration: 1
>  > Rewindable: 6096, loop iteration: 2
>  > Rewindable: 6094, loop iteration: 9
>  > Rewindable: 6092, loop iteration: 24
>  > Rewindable: 6090, loop iteration: 32
>  > Rewindable: 6088, loop iteration: 41
>  >
>  > So on my snd-hda-intel, the granularity of the pointer is 32 bytes.
>  >
>  > For Haswell HDMI (on another snd-hda-intel), stereo, S16_LE:
>  >
>  > Rewindable: 6128, loop iteration: 0
>  > Rewindable: 6112, loop iteration: 129
>  > Rewindable: 6096, loop iteration: 339
>  > Rewindable: 6080, loop iteration: 551
>  > Rewindable: 6064, loop iteration: 753
>  > Rewindable: 6048, loop iteration: 966
>  > Rewindable: 6032, loop iteration: 1180
>  >
>  > so the resulting granularity is 64 bytes.
>  >
>  > An unfortunate observation is that, without snd_pcm_avail(), even on
> hw just after an underrun snd_pcm_rewindable() can return negative
> numbers such as -16 or -25 that lead to nonsense error codes (EBUSY or
> ENOTTY).
>  >
>
> pcm_rewind2.c use period size instead of buffer size as start_threshold
> , pcm is already started before you fill the buffer full and pcm can be
> stopped at underrun if your program does not use boundary as stop_thres=
hold
>
> this affect your timing if your test program behave like pcm_rewind2.c

I agree with the above. As long as it serves as a testcase for a bug, it=20
is good.

>
> static snd_pcm_sframes_t snd_pcm_hw_rewindable(snd_pcm_t *pcm)
>
> {
>          return snd_pcm_mmap_hw_avail(pcm);
>    }
>
> if this function return the safe value, Do you mean it must hw_sync the
> pointer and  should return zero if snd_pcm_mmap_hw_avail is negative an=
d
> check the pcm state  to return negative error code ?

Answering by parts.

Must hw_sync the pointer - yes.

Should return zero if snd_pcm_mmap_hw_avail is negative - not sure, for=20
two reasons. First, I am not sure if snd_pcm_mmap_hw_avail is indeed=20
allowed to return negative values due to yet-undetected xruns. Second,=20
negative snd_pcm_mmap_hw_avail means an xrun, so I am not sure whether 0=20
is a valid return code here.

Should check the pcm state to return negative error code - yes at least=20
for non-xrun states such as SND_PCM_STATE_SUSPENDED or=20
SND_PCM_STATE_DISCONNECTED, and I am not sure whether to return 0 or=20
-EPIPE on a known xrun.

Also I am not sure about interaction with a very large stop_threshold=20
(i.e. settings that ignore underruns), and the above (except hw_sync) is=20
for playback only. We need a separate discussion about capture, but I am=20
not yet ready to start it.

>
>  >
>  >>
>  >>
> http://www.alsa-project.org/~tiwai/writing-an-alsa-driver/ch05s07.html#=
pcm-interface-interrupt-handler-boundary
>  >>
>  >> High frequency timer interrupts
>  >>
>  >> This happens when the hardware doesn't generate interrupts at the
> period boundary but issues timer interrupts at a fixed timer rate (e.g.
> es1968 or ymfpci drivers).
>
> both es1968 and ymfpci use ac97 codec, there is an external clock sourc=
e
> (oscillator) to provide the timing to both sound chips(ac97 controller)
> and ac97 codec to sync the transfer of audio through ac97 link at 48000=
Hz
>
> it depends on whether the chip can count the clock ticks to provide a
> timer interrupt
>
>  >>
>  >> I am also confuse about ymfpci really use timer interrupts.
>  >
>  >
>  > Well, that's easy. According to your own words, the card sends an
> interrupt every 256 samples and has no real notion of the user-defined
> period size. From ALSA viewpoint, this 256-sample interrupt is just a
> timer (but not a timer that is managed through functions that have
> "timer" in the name).
>
> Unlike other hardware-mixing sound cards desgined for playing game ,
> the multi voices of ymfpci is designed for playing MIDI which MIDI note=
s
> of a sound are usually start at same tempo
>
> some subdevices can have unpredictable delay if is it not the subdevice
> which start the hardware
>
> it depends on whether the hardware can provide registers for the driver
> to start each subdevice independently when receiving
> SNDRV_PCM_TRIGGER_START in pcm_trigger callback

OK

>  >
>  >>  > hw_ptr granularity is defined only by period_bytes_min (and
>  >> additional constraints if any).
>  >
>  >
>  > Well, this disagrees with my experiments. For S16_LE stereo,
> snd_pcm_hw_params_get_period_size_min() says 32 samples for both PCH an=
d
> HDMI, while the measured granularity is different (8 and 16 samples).
>
> should you use period_bytes_min instead of period_size_min ?
>
> 128 bytes / (8 x 2)  =3D 8 samples for 8 channels
>
> for 6 channels playback , the period does not fit exactly the pcie
> playload size 128 bytes

Will retest later today.

>
>
>  >
>  >>  >
>  >>  > PulseAudio has the following consideration here: if the card can=
not
>  >> report the position accurately, we need to disable the timestamp-ba=
sed
>  >> scheduling, as this breaks module-combine-sink (or any successor of=
 it),
>  >> because it relies on very accurate estimations of the actual sample=
 rate
>  >> ratio between two non-identical cards.
>  >>  >
>  >>
>  >> https://bugs.freedesktop.org/show_bug.cgi?id=3D47899
>  >
>  >
>  > This is something to investigate, I am not ready to provide any
> useful comment. Although in comment #2 bluetooth is mentioned, and this
> is indeed an example where even somewhat accurate timing information is
> not available.
>
>  >>
>
>  >> if you want to hear sound from two snd-hda-intel at the same time u=
sing
>  >> combined sink, you may need driver provide the output delay in hda =
codec
>  >>
>  >> 7.3.4.5 Audio Function Group Capabilities
>  >>
>  >> Output Delay is a four bit value representing the number of samples
>  >> between when the sample is received from the Link and when it appea=
rs as
>  >> an analog signal at the pin. This may be a =E2=80=9Ctypical=E2=80=9D=
 value. If this is
>  >> 0, the widgets along the critical path should be queried, and each
>  >> individual widget must report its individual delay.
>  >>
>  >> Figure 85. Audio Function Group Capabilities Response Format
>  >>
>  >> 7.3.4.6 Audio Widget Capabilities
>  >>
>  >> Delay indicates the number of sample delays through the widget. Thi=
s may
>  >> be 0 if the delay value in the Audio Function Parameters is supplie=
d to
>  >> represent the entire path.
>  >>
>  >>
> http://git.kernel.org/cgit/linux/kernel/git/tiwai/hda-emu.git/tree/code=
cs
>  >>
>  >> some hda codecs report delay in audio output/input widgets and the
>  >> ranges of delay vary from 3 to 13 samples, hda_proc.c did not show
>  >> output/input delay in the audio function group
>  >
>
> Did snd_hda_param_read(codec, codec->afg,  AC_PAR_AUDIO_FG_CAP) return
> any values for your hda codecs ?
>
> what is critical path ?

How do I test this? Could you please post some userspace test code or a=20
kernel patch, together with the instructions?

> since some driver can enable/disable loopback mixing which the audio
> pass through less widgets when loopback mixing is disabled
>
> some idt codecs have a 5 bands equalizer in the path of Port D(not in
> the pin complex widget or mixer widget but setup using vendor specific
> verb to audio function group or vendor specific widget) but not in the
> path of Port A (headphone)
>
>
>  >
>  > Interesting, implementable for someone with the skills in this area,
> but probably not relevant for the above freedesktop bug. What you are
> talking about is just a constant offset in the snd_pcm_delay() return
> values. That's bad, but I guess not bad enough for PulseAudio to
> stutter. What PulseAudio doesn't tolerate is jitter.
>
> The two hda controllers of the reporter does not use same buffer size
> (buffer time)
>
> Do the timer based scheduling  wakeup 20ms before the the buffer is
> empty ? the timer eventually wakeup at different time if buffer time of
> two hda-controllers are not the same
>
> does this mean the pulseaudio still keep the audio data until the
> pulseaudio client close the stream ?

Not ready to answer this yet.

>
>  >
>  >> Other pulseaudio modules seen does not support rewind (e.g. jack,
>  >> tunnel, Bluetooth,...
>  >>
>  >> http://git.alsa-project.org/?p=3Dalsa-plugins.git;a=3Dtree
>  >>
>  >> Other alsa plugins (e.g. Jack, oss,...) seem not support rewind
>  >
>  >
>  > Jack is interesting here: it is the only ioplug-based plugin which
> sets mmap_rw =3D 1. As such, ALSA treats it as something that has mmapp=
ed
> buffer with the same semantics as an ordinary hardware sound card, and
> performs rewinds using this buffer. There is also a "hardware" position
> callback. The actual transfer of samples from that buffer to JACK is
> performed in a separate realtime thread which is implicitly created in
> jack_activate(). The porition is updated every JACK period.
>  >
>  > The whole construction should support rewinds, with the
> non-rewindable remainder being one JACK period (which may be different
> from one ALSA period). If the JACK period is 256 samples, this plugin
> should behave very much like one voice of ymfpci.
>
> https://github.com/jackaudio/jack2/blob/master/linux/alsa/alsa_driver.c
>
> jackd server does not use snd_pcm_rewind, support non-interleaved mode
> sound cards and sound cards with 10 or more channels (e.g iec1712, hdsp
> and hammerfall, ...) more than two playback ports
>
> the jack client has no info about how many periods or channels used by
> jackd server
>
> http://jackaudio.org/routing_alsa
>
> jack client only specify how many channels and which playback ports
>
> you can specify the stereo output to the grey jack if the jackd server
> use 8 channels playback or mix the stereo output  to the right channel
>
> http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/modules/jack=
/module-jack-sink.c
>
> seem module-jack-sink.c use fixed latency
>
> does it mean that pulseaudio only rewind those sink which support
> dynamic latency ? i.e. it won't rewind the sink if the sink used fixed
> latency

No. PulseAudio can, in theory, rewind fixed-latency sinks, but it will=20
never usefully rewind this one (i.e. will truncate all rewind requests=20
to 0), because it never sets max_rewind, and thus max_rewind gets=20
defaulted to 0:

http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/pulsecore/sink=
.c#n337

PulseAudio here uses a different rendering strategy from the ALSA sink.=20
For the ALSA sink, PulseAudio renders aggressively as much as possible=20
and then rewinds if necessary. For the JACK sink, PulseAudio renders=20
only the minimum required portion of data and only when strictly=20
necessary (when JACK has asked for it).

Note that, in PulseAudio, sink inputs also have buffers (in the form of=20
memblockq, that's where pa_sink_render reads from), and client rewinds=20
can be done using these buffers even if the sink itself is not rewindable=
.

--=20
Alexander E. Patrakov

--------------040708020706040109000407
Content-Type: text/x-csrc;
 name="pcm_rewindable.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pcm_rewindable.c"

/*
 *  This extra small demo sends silence to your speakers if all your ALSA plugins support rewinds properly.
 */

#include <asoundlib.h>

#include <stdio.h>
#include <stdlib.h>

const char* device = "hw:2";
const int channels = 4;
const snd_pcm_sframes_t period_size = 1024;
const int periods = 4;
const int rate = 48000;


int main(int argc, char* argv[])
{
        int err;
        unsigned int j;
	short *silence;
	snd_pcm_sframes_t rewindable = 1;

        snd_pcm_t *handle;
	snd_output_t *out = NULL;

	snd_pcm_hw_params_t *params;
	snd_pcm_sw_params_t *swparams;

	snd_pcm_hw_params_alloca(&params);
	snd_pcm_sw_params_alloca(&swparams);

	snd_output_stdio_attach(&out, stderr, 0);
	silence = calloc(period_size * periods, sizeof(short) * channels);

	if ((err = snd_pcm_open(&handle, device, SND_PCM_STREAM_PLAYBACK, 0)) < 0) {
		fprintf(stderr, "Playback open error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err =   snd_pcm_hw_params_any(handle, params) < 0 ||
		snd_pcm_hw_params_set_rate_resample(handle, params, 1) < 0 ||
		snd_pcm_hw_params_set_access(handle, params, SND_PCM_ACCESS_RW_INTERLEAVED) < 0 ||
		snd_pcm_hw_params_set_format(handle, params, SND_PCM_FORMAT_S16) < 0 ||
		snd_pcm_hw_params_set_channels(handle, params, channels) < 0 ||
		snd_pcm_hw_params_set_rate(handle, params, rate, 0) < 0 ||
		snd_pcm_hw_params_set_period_size(handle, params, period_size, 0) < 0 ||
		snd_pcm_hw_params_set_periods(handle, params, periods, 0) < 0 ||
		snd_pcm_hw_params(handle, params) < 0;
	if (err) {
		fprintf(stderr, "Playback hwparams error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	err =   snd_pcm_sw_params_current(handle, swparams) < 0 ||
		snd_pcm_sw_params_set_start_threshold(handle, swparams, period_size) < 0 ||
		snd_pcm_sw_params_set_avail_min(handle, swparams, period_size) < 0 ||
		snd_pcm_sw_params(handle, swparams) < 0;
	if (err) {
		fprintf(stderr, "Playback swparams error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	snd_pcm_dump(handle, out);
	fprintf(stderr, "Playing silence\n");
	fflush(stderr);
	memset(silence, 0, period_size * periods * sizeof(short) * channels);
	err = snd_pcm_writei(handle, silence, period_size * periods);
	if (err < 0) {
		fprintf(stderr, "Playback error: %s\n", snd_strerror(err));
		exit(EXIT_FAILURE);
	}

	j = 0;
	while (rewindable > 0) {
		snd_pcm_sframes_t rewindable1 = snd_pcm_rewindable(handle);
		if (rewindable != rewindable1) {
			fprintf(stderr, "===================\n");
			snd_pcm_dump(handle, out);
			fprintf(stderr, "Rewindable: %d, loop iteration: %d\n", (int)rewindable1, j);
			if (rewindable1 < 0)
				fprintf(stderr, "This means %s\n", snd_strerror(rewindable1));
		}
		rewindable = rewindable1;
		j++;
	}
	snd_pcm_drop(handle);
	snd_pcm_close(handle);

	free(silence);
	return 0;
}

--------------040708020706040109000407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------040708020706040109000407--
