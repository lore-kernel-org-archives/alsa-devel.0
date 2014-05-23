From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: On non-rewindability of resamplers
Date: Fri, 23 May 2014 10:03:39 +0800
Message-ID: <CAN8cciZGaFs2dPq0FJzhqyrtn9-irGBv6wmTjG1aRcJcCviuHg@mail.gmail.com>
References: <5356A9B6.9060405@gmail.com> <5358FCF0.2040701@ladisch.de>
 <53597BA2.8080201@gmail.com> <5359FE72.8050605@canonical.com>
 <535A6C96.7040109@gmail.com>
 <CAN8ccibLsqb6oxai=+XOAhZ1dPwZmVVD2r3teDsz2a2_CthoOA@mail.gmail.com>
 <535B83E4.5050303@gmail.com>
 <CAN8ccibXtR=jc3NJjFMn88stytAhSxjNqbD5QsREDppbKDNg9Q@mail.gmail.com>
 <535E908C.4030509@gmail.com>
 <CAN8ccib7E7SQFo=Ro5Hksaj74Nn9NtHA1VSQpKX3ARHQDE_QHQ@mail.gmail.com>
 <535FDEA8.7010206@gmail.com>
 <CAN8cciYoR25LDZnr6R9Bn_ek4rX1q8XoRPT+H4Mpp3ecZJF85w@mail.gmail.com>
 <5364CE4D.7040506@gmail.com>
 <CAN8cciYB-vD0Oeigv=rGt1XDSZvqGm_KpyV_HwARCg8LLFEQjg@mail.gmail.com>
 <536E26A4.1060002@gmail.com>
 <CAN8ccibugnc_8FEf_184PTWGBHdt4Wa0Af=A8AwT1_uFSJZX_g@mail.gmail.com>
 <53705396.3070406@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f45.google.com (mail-qg0-f45.google.com
 [209.85.192.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 316B7265634
 for <alsa-devel@alsa-project.org>; Fri, 23 May 2014 04:03:41 +0200 (CEST)
Received: by mail-qg0-f45.google.com with SMTP id z60so7116647qgd.32
 for <alsa-devel@alsa-project.org>; Thu, 22 May 2014 19:03:39 -0700 (PDT)
In-Reply-To: <53705396.3070406@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>
Cc: sergemp@mail.ru, artur.stat@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>No need to do this. I have already made enough conclusions.
> Unfortunately, I forgot to attach the new test program (intentionally

> modified to produce an underrun), doing it now.
>
> The output here is:

> Hardware PCM card 2 'HDA Intel PCH' device 0 subdevice 0
> Its setup is:
>   stream       : PLAYBACK
>   access       : RW_INTERLEAVED
>   format       : S16_LE
>   subformat    : STD
>   channels     : 4
>   rate         : 48000
>   exact rate   : 48000 (48000/1)
>   msbits       : 16
>   buffer_size  : 4096
>   period_size  : 1024
>   period_time  : 21333
>   tstamp_mode  : NONE
>   period_step  : 1
>   avail_min    : 1024
>   period_event : 0
>   start_threshold  : 1024
>   stop_threshold   : 4096
>   silence_threshold: 0
>   silence_size : 0
>   boundary     : 4611686018427387904
>   appl_ptr     : 4096
>   hw_ptr       : 4136
> Rewindable: -40, loop iteration: 7807909
> This means Too many levels of symbolic links
>

appl_ptr is 40 samples behind hw_ptr since your program stop writing data
to the sound card and perform rewind , snd_pcm_state was change from
runnning (3) to xrun (4)

The appl_ptr  can be placed in any position in the ring buffer for the
application to write data but the sound card fetch data from this ring
buffer sequentially, however snd_pcm_write() assume the maximum distance
between appl_ptr and hwptr is only one buffer

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_intel.c?id=2ae66c26550cd94b0e2606a9275eb0ab7070ad0e

Do you mean hwptr does not decrease by one period when you use arbitrary
period sizes for hda-Intel  ?

e.g.  48 samples (192 bytes) when using 1ms period time and  stereo instead
of 4 channels

you program seen hang when using pulse plugin

(  11.615|   0.000) I: [pulseaudio] sink-input.c:     application.language
= "C"
(  11.615|   0.000) I: [pulseaudio] sink-input.c:     window.x11.display =
":0"
(  11.615|   0.000) I: [pulseaudio] sink-input.c:
application.process.machine_id = "6ca4132d684a1184ca3cfd3b51bb2316"
(  11.615|   0.000) I: [pulseaudio] sink-input.c:
application.process.session_id = "c2"
(  11.615|   0.000) I: [pulseaudio] sink-input.c:
module-stream-restore.id = "sink-input-by-application-name:ALSA plug-in
[pcm_rewindable]"
(  11.615|   0.000) I: [pulseaudio] protocol-native.c: Requested
tlength=85.33 ms, minreq=21.33 ms
(  11.615|   0.000) D: [pulseaudio] protocol-native.c: Early requests mode
enabled, configuring sink latency to minreq.
(  11.615|   0.000) D: [pulseaudio] protocol-native.c: Requested
latency=21.33 ms, Received latency=80.00 ms
(  11.615|   0.000) D: [pulseaudio] memblockq.c: memblockq requested:
maxlength=4194304, tlength=46080, base=4, prebuf=4096, minreq=15360
maxrewind=0
(  11.615|   0.000) D: [pulseaudio] memblockq.c: memblockq sanitized:
maxlength=4194304, tlength=46080, base=4, prebuf=4096, minreq=15360
maxrewind=0
(  11.615|   0.000) I: [pulseaudio] protocol-native.c: Final latency 320.00
ms = 80.00 ms + 2*80.00 ms + 80.00 ms
(  11.615|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: Requested volume:
0:  71% 1:  71%
(  11.615|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c:            in dB:
0: -9.00 dB 1: -9.00 dB
(  11.615|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: Got hardware
volume: 0:  71% 1:  71%
(  11.615|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c:               in
dB: 0: -9.00 dB 1: -9.00 dB
(  11.615|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: Calculated
software volume: 0: 100% 1: 100% (accurate-enough=yes)
(  11.615|   0.000) D: [alsa-sink-Intel ICH]
alsa-sink.c:                      in dB: 0: 0.00 dB 1: 0.00 dB
(  11.615|   0.000) D: [alsa-sink-Intel ICH] sink.c: Volume not changing
(  11.616|   0.000) D: [pulseaudio] core-subscribe.c: Dropped redundant
event due to change event.
(  11.620|   0.004) D: [alsa-sink-Intel ICH] protocol-native.c: Requesting
rewind due to end of underrun.
(  11.620|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: Requested to
rewind 14112 bytes.
(  11.620|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: Limited to 13856
bytes.
(  11.620|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: before: 3464
(  11.620|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: after: 3464
(  11.620|   0.000) D: [alsa-sink-Intel ICH] alsa-sink.c: Rewound 13856
bytes.
(  11.620|   0.000) D: [alsa-sink-Intel ICH] sink.c: Processing rewind...
(  11.620|   0.000) D: [alsa-sink-Intel ICH] sink.c: latency = 15434
(  11.620|   0.000) D: [alsa-sink-Intel ICH] sink-input.c: Have to rewind
13856 bytes on render memblockq.
(  11.620|   0.000) D: [alsa-sink-Intel ICH] source.c: Processing rewind...
(  11.624|   0.004) D: [alsa-sink-Intel ICH] protocol-native.c: Implicit
underrun of 'ALSA Playback'
(  11.624|   0.000) D: [alsa-sink-Intel ICH] sink.c: Found underrun 6516
bytes ago (7596 bytes ahead in playback buffer)
(  11.630|   0.005) D: [alsa-sink-Intel ICH] sink.c: Found underrun 6516
bytes ago (7596 bytes ahead in playback buffer)
(  11.630|   0.000) D: [alsa-sink-Intel ICH] sink.c: Found underrun 6516
bytes ago (7596 bytes ahead in playback buffer)
(  11.646|   0.016) D: [alsa-sink-Intel ICH] sink.c: Found underrun 6516
bytes ago (7596 bytes ahead in playback buffer)
(  11.647|   0.000) D: [alsa-sink-Intel ICH] sink.c: Found underrun 6516
bytes ago (7596 bytes ahead in playback buffer)
(  11.652|   0.005) D: [alsa-sink-Intel ICH] sink.c: Found underrun 8436
bytes ago (5676 bytes ahead in playback buffer)
(  11.663|   0.010) D: [alsa-sink-Intel ICH] sink.c: Found underrun 10356
bytes ago (3756 bytes ahead in playback buffer)
(  11.667|   0.004) D: [alsa-sink-Intel ICH] sink.c: Found underrun 10356
bytes ago (3756 bytes ahead in playback buffer)
(  11.667|   0.000) D: [alsa-sink-Intel ICH] sink.c: Found underrun 10356
bytes ago (3756 bytes ahead in playback buffer)
(  11.674|   0.006) D: [alsa-sink-Intel ICH] sink.c: Found underrun 12276
bytes ago (1836 bytes ahead in playback buffer)
(  12.272|   0.598) E: [alsa-sink-Intel ICH] alsa-sink.c: ALSA woke us up
to write new data to the device, but there was actually nothing to write!
(  12.272|   0.598) E: [alsa-sink-Intel ICH] alsa-sink.c: Most likely this
is a bug in the ALSA driver 'snd_intel8x0'. Please report this issue to the
ALSA developers.
(  12.272|   0.598) E: [alsa-sink-Intel ICH] alsa-sink.c: We were woken up
with POLLOUT set -- however a subsequent snd_pcm_avail() returned 0 or
another value < min_avail.


> Sorry, there is no userspace API for that. The only way to get the
minimum period size is via snd_pcm_hw_params_get_period_size_min, which
obtains the result in terms of frames.

Have you set channels, rate and format first and you have to call
snd_pcm_hw_params_get_period_size_min before you set the period size   ?
http://git.qemu.org/?p=qemu.git;a=blob;f=hw/audio/ac97.c;hb=HEAD

http://git.qemu.org/?p=qemu.git;a=blob;f=hw/audio/hda-codec.c;hb=HEAD

However those emulated AC97 and HDA sound card inside virtual machine won't
transfer audio like the real sound card, it mainly depend on the backend
audio driver of the host

http://git.qemu.org/?p=qemu.git;a=tree;f=audio;hb=HEAD

Can your program use period size but pulseaudio server user period time,
all rates supported by the sink (at least  default rate and alternate rate
used by pulseaudio) ?

the supported channels ( at least 2 and 6 which is commonly used)

>
>
> How do I test this? Could you please post some userspace test code or a
kernel patch, together with the instructions?
>

Attach the patch to dump the values of the audio function group capability

There are three cases

1) delay in analog output > delay in digital output  e.g, idt codecs
2) delay in analog output < delay in digital output e.g. adi codecs
3) no delay in audio widgets ,  digital output and analog output have no
delay difference when output delay in audio  function group is non zero ?

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda?id=9a08160bdbe3148a405f72798f76e2a5d30bd243

Audio send to both Analog and digital  output at the same time when iec958
default pcm switch is on

It is unlikely for ordinary user to measure the delay without using
oscilloscope since the Analog speaker and digital receiver also have delay


>>  > The whole construction should support rewinds, with the
>> non-rewindable remainder being one JACK period (which may be different
from one ALSA period). If the JACK period is 256 samples, this plugin
should behave very much like one voice of ymfpci.
>>

does support snd_pcm_rewind imply support snd_pcm_forward ?


          (err = snd_pcm_ioplug_set_param_minmax(&jack->io,
SND_PCM_IOPLUG_HW_PERIOD_BYTES, 128, 64*1024)) < 0 ||

Like pulse plugin which use same period bytes min as snd-hda-intel

The application can use arbitrary period size but hwptr  seem not always
change at one period time,  this is much worse than those drivers with
SNDRV_PCM_INFO_BATCH


>
> No. PulseAudio can, in theory, rewind fixed-latency sinks, but it will
never usefully rewind this one (i.e. will truncate all rewind requests to
0), because it never sets max_rewind, and thus max_rewind gets defaulted to
0:
>
>
http://cgit.freedesktop.org/pulseaudio/pulseaudio/tree/src/pulsecore/sink.c#n337
>
> PulseAudio here uses a different rendering strategy from the ALSA sink.
For the ALSA sink, PulseAudio renders aggressively as much as possible and
then rewinds if necessary. For the JACK sink, PulseAudio renders only the
minimum required portion of data and only when strictly necessary (when
JACK has asked for it).

what other events pulseaudio need to rewind beside

1) change in volume of sink/source
2) change in volume of streams
3) change in latency
4) sync slaves of combined sinks

>The defaults are:
>  ; default-fragments = 4
> ; default-fragment-size-msec = 25
>

Do you mean if volume change is delayed by one buffer( 0.1 seconds ) is
still unacceptable if the user choose 4 x 25ms buffer time for the sink ?
