From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Mon, 22 Jun 2015 21:28:43 +0500
Message-ID: <558837BB.4040006@gmail.com>
References: <CACuU-+jBWck1e3tf--=G+X3xNAQm++JCxRzQFkDUJ4f5zwhgoQ@mail.gmail.com>
 <557E86DD.8020709@metafoo.de>
 <CAN8cciYApKja0e0U7Uy2YG2ySemfhvKfLGUueGyFx5ajjyqKBA@mail.gmail.com>
 <557EBEAA.70004@metafoo.de>
 <CAN8cciZ4B2X+o4AXdCGEEAFCcX+iWqyf+FvMkEkrSu3Vt8Vx8Q@mail.gmail.com>
 <557EDE22.7080808@metafoo.de>
 <CAN8ccibPTkiayx_9ETOwjw1dSF+UPsxjgcqWJR+mm149c69WBg@mail.gmail.com>
 <5587AE77.1020709@metafoo.de> <5587D845.4040309@ladisch.de>
 <CAN8ccibQvDmdydn3QjHH==mNNizWuH+FOwRMu_BFRYGAfu9ukw@mail.gmail.com>
 <5587FB52.9070401@gmail.com>
 <CAN8ccib-qYEFK95GYiN-PW9PLXkLZhC+Z2JbsLzdb7ye5aaFWA@mail.gmail.com>
 <55880452.7000100@gmail.com>
 <CAN8ccib_DS2kOLzHCj8v_H90VqNZsCk4h_4Gb6Vkb=nQw30L_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DE052604C3
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 18:28:45 +0200 (CEST)
Received: by wicgi11 with SMTP id gi11so80752237wic.0
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2015 09:28:46 -0700 (PDT)
In-Reply-To: <CAN8ccib_DS2kOLzHCj8v_H90VqNZsCk4h_4Gb6Vkb=nQw30L_w@mail.gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

22.06.2015 20:50, Raymond Yau wrote:
>  >>
>  >>  >>>
>  >>  >>> The ALSA API requires the driver to provide a cyclic sample
> buffer (or
>  >>  >>> something that behaves like one).
>  >>  >>>
>  >>  >>> However, not all hardware works this way.  USB and FireWire
> require the
>  >>  >>> driver to continually queue new packets, whose size and timing are
>  >>  >>> determined by the bus clock and are not directly related to the
> ALSA
>  >>  >>> ring buffer.  These drivers use double buffering; the actual DMA
>  >> happens
>  >>  >>> from those packets, not from the ring buffer.
>  >>  >>>
>  >>  >>
>  >>  >> If those queued packets/urb cannot be rewind, snd_pcm_rewindable
> should
>  >>  >> return zero for those driver
>  >>  >
>  >>  >
>  >>  > Not really.
>  >>  >
>  >>  > As I understand it, the kernel periodically converts a piece of the
>  >> ring buffer (located in RAM) into an URB, and it gets sent through the
>  >> USB bus. Parts of the buffer that are not yet converted to URB are
>  >> perfectly rewindable.
>  >>  >
>  >>  > In other words, for USB devices, the kernel already implements the
>  >> "low-latency background thread that makes unrewindable devices
>  >> rewindable" idea that I discussed (as a strawman proposal) here for
>  >> userspace:
>  >>  >
>  >>  >
>  >>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/080868.html
>  >>  >
>  >>
>  >> This mean that SNDRV_PCM_INFO_BATCH represent exact one period is not
>  >> correct for usb and firewire since hw_ptr does not increment in
> period size
>  >
>  >
>  > Well, according to the new definition, "SNDRV_PCM_INFO_BATCH on the
> other hand has become to mean that the device is only capable of
> reporting the audio pointer with a coarse granularity". In the USB case,
> we indeed have coarse granularity (6 ms in the worst case), but not as
> bad as one period.
>  >
>  >
>  >>
>  >> Do this mean .period_bytes_min of snd-usb-audio is incorrect since
>  >> .period_bytes_min should be at least size of urb/packet ?
>  >>
>  >
>  > I don't see anything wrong here. With the USB device that my
> colleague has here at work, the minimum period size is 48 samples, i.e.
> 1 ms, which looks exactly like one USB data packet.
>  >
>
> What is the smallest buffer time which your usb audio can playback
> without underrun using aplay with two periods (2ms or 12ms) ?
>

That device is at work, and is not mine. So, the test below has been 
done with a different USB device that I have at home, namely, ROTEL 
RA-1570 integrated amplifier. It has a menu option to select either 1.0 
or 2.0 USB audio class, I have set it to 1.0 to match that C-Media 
device. By default, with large-enough period size, it has avail 
granularity that jumps between 3 and 4 ms, and delay granularity of 1 ms 
(even if I select a better period size, like 960 frames).

======= testing hw:3 =======
min_period_size: 48 frames, dir: 0
FIFO size is 0
Hardware PCM card 3 'Rotel PC-USB' device 0 subdevice 0
Its setup is:
   stream       : PLAYBACK
   access       : RW_INTERLEAVED
   format       : S16_LE
   subformat    : STD
   channels     : 2
   rate         : 48000
   exact rate   : 48000 (48000/1)
   msbits       : 16
   buffer_size  : 4096
   period_size  : 1024
   period_time  : 21333
   tstamp_mode  : NONE
   tstamp_type  : MONOTONIC
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
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 1 usec
Available: 192, loop iteration: 32070, diff: 32070, timestamp diff: 3923 
usec
Available: 336, loop iteration: 37315, diff: 5245, timestamp diff: 4003 usec
Available: 480, loop iteration: 42710, diff: 5395, timestamp diff: 3999 usec
Available: 624, loop iteration: 48292, diff: 5582, timestamp diff: 3999 usec
Available: 768, loop iteration: 53880, diff: 5588, timestamp diff: 4000 usec
Available: 912, loop iteration: 57858, diff: 3978, timestamp diff: 3000 usec
Available: 1056, loop iteration: 62125, diff: 4267, timestamp diff: 3000 
usec
Available: 1200, loop iteration: 66536, diff: 4411, timestamp diff: 3000 
usec
Available: 1344, loop iteration: 70679, diff: 4143, timestamp diff: 3001 
usec
Available: 1488, loop iteration: 75091, diff: 4412, timestamp diff: 2999 
usec
Available: 1632, loop iteration: 79368, diff: 4277, timestamp diff: 3000 
usec
Available: 1776, loop iteration: 83675, diff: 4307, timestamp diff: 3000 
usec
Available: 1920, loop iteration: 87964, diff: 4289, timestamp diff: 3000 
usec
Available: 2064, loop iteration: 92384, diff: 4420, timestamp diff: 2999 
usec
Available: 2208, loop iteration: 96638, diff: 4254, timestamp diff: 3001 
usec
Available: 2353, loop iteration: 100900, diff: 4262, timestamp diff: 
3010 usec
Available: 2497, loop iteration: 105000, diff: 4100, timestamp diff: 
2991 usec
Available: 2641, loop iteration: 109291, diff: 4291, timestamp diff: 
2999 usec
Available: 2785, loop iteration: 113714, diff: 4423, timestamp diff: 
3000 usec
Available: 2977, loop iteration: 117955, diff: 4241, timestamp diff: 
3000 usec
Available: 3074, loop iteration: 122323, diff: 4368, timestamp diff: 
2999 usec
Available: 3266, loop iteration: 126556, diff: 4233, timestamp diff: 
3001 usec
Available: 3410, loop iteration: 130983, diff: 4427, timestamp diff: 
3000 usec
Available: 3554, loop iteration: 136790, diff: 5807, timestamp diff: 
4000 usec
Available: 3698, loop iteration: 139699, diff: 2909, timestamp diff: 
2000 usec
Available: 3842, loop iteration: 145320, diff: 5621, timestamp diff: 
4000 usec
Available: 3986, loop iteration: 149502, diff: 4182, timestamp diff: 
3000 usec


This command produces no xruns with a 48 kHz stereo S16_LE file:

aplay --buffer-size 96 --period-size 48 -D hw:3 test1.wav

$ cat /proc/asound/PCUSB/pcm0p/sub0/info
card: 3
device: 0
subdevice: 0
stream: PLAYBACK
id: USB Audio
name: USB Audio
subname: subdevice #0
class: 0
subclass: 0
subdevices_count: 1
subdevices_avail: 0

$ cat /proc/asound/PCUSB/pcm0p/sub0/hw_params
access: RW_INTERLEAVED
format: S16_LE
subformat: STD
channels: 2
rate: 48000 (48000/1)
period_size: 48
buffer_size: 96

$ cat /proc/asound/PCUSB/pcm0p/sub0/sw_params
tstamp_mode: NONE
period_step: 1
avail_min: 48
start_threshold: 96
stop_threshold: 96
silence_threshold: 0
silence_size: 0
boundary: 6917529027641081856

After several minutes, aplay did not report any xruns, and the sound is 
still clean:

$ cat /proc/asound/PCUSB/pcm0p/sub0/status
state: RUNNING
owner_pid   : 2505
trigger_time: 4025.921768556
tstamp      : 0.000000000
delay       : 145
avail       : 0
avail_max   : 48
-----
hw_ptr      : 25506151
appl_ptr    : 25506247

The minimum reported period size at 48 kHz is 48 frames.

-- 
Alexander E. Patrakov
