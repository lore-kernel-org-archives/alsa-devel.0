From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PulseAudio and SNDRV_PCM_INFO_BATCH
Date: Wed, 24 Jun 2015 13:51:46 +0800
Message-ID: <CAN8cciYYW70PG8uf_ykK736+UdHbqyg4auzRTwGOw4+imSJuyg@mail.gmail.com>
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
 <558837BB.4040006@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f41.google.com (mail-oi0-f41.google.com
 [209.85.218.41])
 by alsa0.perex.cz (Postfix) with ESMTP id EC9742604E5
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2015 07:51:47 +0200 (CEST)
Received: by oiyy130 with SMTP id y130so22879211oiy.0
 for <alsa-devel@alsa-project.org>; Tue, 23 Jun 2015 22:51:46 -0700 (PDT)
In-Reply-To: <558837BB.4040006@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, adam@spicenitz.org
Cc: Tanu Kaskinen <tanu.kaskinen@linux.intel.com>, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arun Raghavan <arun@accosted.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

>>  >>  >>> However, not all hardware works this way.  USB and FireWire
>> require the
>>  >>  >>> driver to continually queue new packets, whose size and timing
are
>>  >>  >>> determined by the bus clock and are not directly related to the
>> ALSA
>>  >>  >>> ring buffer.  These drivers use double buffering; the actual DMA
>>  >> happens
>>  >>  >>> from those packets, not from the ring buffer.
>>  >>  >>>
>>  >>  >>
>>  >>  >> If those queued packets/urb cannot be rewind, snd_pcm_rewindable
>> should
>>  >>  >> return zero for those driver
>>  >>  >
>>  >>  >
>>  >>  > Not really.
>>  >>  >
>>  >>  > As I understand it, the kernel periodically converts a piece of
the
>>  >> ring buffer (located in RAM) into an URB, and it gets sent through
the
>>  >> USB bus. Parts of the buffer that are not yet converted to URB are
>>  >> perfectly rewindable.
>>  >>  >
>>  >>  > In other words, for USB devices, the kernel already implements the
>>  >> "low-latency background thread that makes unrewindable devices
>>  >> rewindable" idea that I discussed (as a strawman proposal) here for
>>  >> userspace:
>>  >>  >
>>  >>  >
>>  >>
>>
http://mailman.alsa-project.org/pipermail/alsa-devel/2014-September/080868.html
>>  >>  >
>>  >>
>>  >> This mean that SNDRV_PCM_INFO_BATCH represent exact one period is not
>>  >> correct for usb and firewire since hw_ptr does not increment in
>> period size
>>  >
>>  >
>>  > Well, according to the new definition, "SNDRV_PCM_INFO_BATCH on the
>> other hand has become to mean that the device is only capable of
>> reporting the audio pointer with a coarse granularity". In the USB case,
>> we indeed have coarse granularity (6 ms in the worst case), but not as
>> bad as one period.
>>  >
>>  >
>>  >>
>>  >> Do this mean .period_bytes_min of snd-usb-audio is incorrect since
>>  >> .period_bytes_min should be at least size of urb/packet ?
>>  >>
>>  >
>>  > I don't see anything wrong here. With the USB device that my
>> colleague has here at work, the minimum period size is 48 samples, i.e.
>> 1 ms, which looks exactly like one USB data packet.
>>  >
>>
>> What is the smallest buffer time which your usb audio can playback
>> without underrun using aplay with two periods (2ms or 12ms) ?
>>
>
> That device is at work, and is not mine. So, the test below has been done
with a different USB device that I have at home, namely, ROTEL RA-1570
integrated amplifier. It has a menu option to select either 1.0 or 2.0 USB
audio class, I have set it to 1.0 to match that C-Media device. By default,
with large-enough period size, it has avail granularity that jumps between
3 and 4 ms, and delay granularity of 1 ms (even if I select a better period
size, like 960 frames).

Seem time diff vary from 2 to 4 ms

> Available: 3410, loop iteration: 130983, diff: 4427, timestamp diff: 3000
usec
> Available: 3554, loop iteration: 136790, diff: 5807, timestamp diff: 4000
usec
> Available: 3698, loop iteration: 139699, diff: 2909, timestamp diff: 2000
usec
>

Avail diff can be odd number too

Available: 2353, loop iteration: 100900, diff: 4262, timestamp diff: 3010
usec
> Available: 2497, loop iteration: 105000, diff: 4100, timestamp diff: 2991
usec
> Available: 2641, loop iteration: 109291, diff: 4291, timestamp diff: 2999
usec
> Available: 2785, loop iteration: 113714, diff: 4423, timestamp diff: 3000
usec
> Available: 2977, loop iteration: 117955, diff: 4241, timestamp diff: 3000
usec

https://bugs.freedesktop.org/show_bug.cgi?id=86262

The driver does not ensure granularity must be less than period size

granularity can be larger than period size

So it is not just coarse but inaccurate

min_period_size: 6 frames, dir: 0
FIFO size is 0
Hardware PCM card 1 'Scarlett 18i8 USB' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 8
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 4096
  period_size  : 64
  period_time  : 1333
  tstamp_mode  : NONE
  tstamp_type  : MONOTONIC
  period_step  : 1
  avail_min    : 64
  period_event : 0
  start_threshold  : 64
  stop_threshold   : 4096
  silence_threshold: 0
  silence_size : 0
  boundary     : 4611686018427387904
  appl_ptr     : 0
  hw_ptr       : 0
Playing silence
Available: 0, loop iteration: 0, diff: 0, timestamp diff: 3 usec
Available: 66, loop iteration: 9066, diff: 9066, timestamp diff: 1395 usec
Available: 132, loop iteration: 11289, diff: 2223, timestamp diff: 1622 usec
Available: 192, loop iteration: 13351, diff: 2062, timestamp diff: 1625 usec
Available: 258, loop iteration: 15600, diff: 2249, timestamp diff: 1625 usec
Available: 325, loop iteration: 17822, diff: 2222, timestamp diff: 1625 usec
Available: 385, loop iteration: 20092, diff: 2270, timestamp diff: 1626 usec
Available: 451, loop iteration: 22045, diff: 1953, timestamp diff: 1625 usec
Available: 512, loop iteration: 24239, diff: 2194, timestamp diff: 1630 usec
Available: 578, loop iteration: 26305, diff: 2066, timestamp diff: 1619 usec
Available: 644, loop iteration: 28447, diff: 2142, timestamp diff: 1626 usec
