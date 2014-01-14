From: LANGLOIS Olivier PIS -EXT <olivier.pis.langlois@transport.alstom.com>
Subject: Re: [ISSUE] crackles and clicks
Date: Tue, 14 Jan 2014 15:59:48 +0000
Message-ID: <89F8E4011FD7234ABFE48744E300CBC206BC449B@041-DB3MPN1-093.041d.mgd.msft.net>
References: <CA+T9nP9VBdW6T8o3=5hFJpMXpHGz59VOGva2+8g8xoPw6Xa8+g@mail.gmail.com>
 <s5hy52kt71z.wl%tiwai@suse.de>
 <89F8E4011FD7234ABFE48744E300CBC206BC3EF2@041-DB3MPN1-093.041d.mgd.msft.net>
 <20140114144224.GC23764@tamtam.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from as-smtp1.itc.alstom.com (as-smtp1.itc.alstom.com
 [159.245.16.36])
 by alsa0.perex.cz (Postfix) with ESMTP id A31A3261AED
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2014 16:59:58 +0100 (CET)
In-Reply-To: <20140114144224.GC23764@tamtam.fritz.box>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

> -----Original Message-----
> From: Daniel Mack [mailto:daniel@zonque.org]
> Sent: Tuesday, January 14, 2014 9:42 AM
> > If this can help in the investigation of your problem, I can experience
> crackles and clicks during pcm playback on my small hpmini notebook. I have
> kinda nailed down the source of the crackles and clicks.
> >
> > It turns out that when my Wifi card is on but not connected, I have the
> crackles and clicks. If I connect to a Wifi network or close the Wifi, the
> crackles and clicks go away. I have not had the time check the Wifi driver
> code yet but my explanation of the behavior is that in that specific state,
> some wifi IRQ handler is taking too much time and stop my sound device irqs
> to be timely serviced.
> >
> > My advice, is try to unload as much as possible kernel driver modules that
> may interfere with your audio playback and see if your crackles and clicks go
> away. For reference, here is my HW, in case you have the same Wifi
> Adapter....
> >
>
> I'm not sure whether you're on the right track here.
>
> Which program are you using for this? How are the buffer sizes configured?
> Are you seeing XRUNs?
>
> And are you sure the audio distortion doesn't relate to bad USB power?
> Please check with a different PC as well, and for tests, put a
> powered(!) USB hub inbetween your PC and the DAC.
>
>
>
> Daniel

I experience the audible clicks with VLC but I have reproduced it with aplay as well. The clicks that I hear corresponds to underruns. For the records, this is not happening with a USB device. I have a Intel HDA sound card. I did chime in the discussion to point out that the problem could come from something else than ALSA or the sound card driver. Here is the output of my aplay session. This makes me doubt my hypothesis. I'll check the cpu usage while the Wifi is on but not connected or see if running aplay in real-time prio makes things any better.

Note that the underrun duration printed in the output sound fishy...

underrun!!! (at least 1856093977.967 ms long)

lano1106@hpmini ~/Music $ aplay -v -c1 sine.wav
Playing WAVE 'sine.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Plug PCM: Rate conversion PCM (48000, sformat=S32_LE)
Converter: linear-interpolation
Protocol version: 10002
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 15052
  period_size  : 940
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 940
  period_event : 0
  start_threshold  : 15052
  stop_threshold   : 15052
  silence_threshold: 0
  silence_size : 0
  boundary     : 986447872
Slave: Soft volume PCM
Control: PCM Playback Volume
min_dB: -51
max_dB: 0
resolution: 256
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Slave: Direct Stream Mixing PCM
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 16384
  stop_threshold   : 16384
  silence_threshold: 0
  silence_size : 0
  boundary     : 1073741824
Hardware PCM card 0 'HDA Intel' device 0 subdevice 0
Its setup is:
  stream       : PLAYBACK
  access       : MMAP_INTERLEAVED
  format       : S32_LE
  subformat    : STD
  channels     : 2
  rate         : 48000
  exact rate   : 48000 (48000/1)
  msbits       : 32
  buffer_size  : 16384
  period_size  : 1024
  period_time  : 21333
  tstamp_mode  : ENABLE
  period_step  : 1
  avail_min    : 1024
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 1073741824
  silence_threshold: 0
  silence_size : 1073741824
  boundary     : 1073741824
  appl_ptr     : 0
  hw_ptr       : 40810501
underrun!!! (at least 1856093977.967 ms long)


________________________________
CONFIDENTIALITY : This e-mail and any attachments are confidential and may be privileged. If you are not a named recipient, please notify the sender immediately and do not disclose the contents to another person, use it for any purpose or store or copy the information in any medium.
