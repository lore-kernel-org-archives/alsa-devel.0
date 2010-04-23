From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
	although poll returns POLLIN event
Date: Fri, 23 Apr 2010 15:45:44 +0800
Message-ID: <o2v4f3252891004230045v905bc0d3gc23c6de490779021@mail.gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<y2n4f3252891004212128x22c1be90pd22a4fa58a31a57c@mail.gmail.com>
	<4BD029CD.6030200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id F3085243D3
	for <alsa-devel@alsa-project.org>;
	Fri, 23 Apr 2010 09:45:45 +0200 (CEST)
Received: by pvh11 with SMTP id 11so1129183pvh.38
	for <alsa-devel@alsa-project.org>; Fri, 23 Apr 2010 00:45:44 -0700 (PDT)
In-Reply-To: <4BD029CD.6030200@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/4/22 Stefan Schoenleitner <dev.c0debabe@gmail.com>

> Raymond Yau wrote:
> > your program expect the driver support 2 periods per buffer but does not
> > expicitly set the period
> >
> > 8000 Hz , S16_LE and mono
>
> I am not sure why you think this is the case.
>
> The period size is set at line 170 with
> snd_pcm_hw_params_set_period_size().
>
> I'm setting up the sampling rate of 8000Hz in setup_pcm() starting at line
> 111.
> I either use snd_pcm_hw_params_set_rate_near() or
> snd_pcm_hw_params_set_rate(),
> depending on whether the PCM supports the exact rate or not.
>
> I set up the audio format SND_PCM_FORMAT_S16_LE at line 76 with
> snd_pcm_hw_params_set_format().
>
> And finally, I also set up the number of channels (mono) in line 85 with
> snd_pcm_hw_params_set_channels().
>
>
> Last but not least, snd_pcm_dump() shows that exactly these settings are
> actively used:
>
> ------------------------------------------------------------------------
> ALSA <-> PulseAudio PCM I/O Plugin
> Its setup is:
>  stream       : CAPTURE
>   [...]
>  format       : S16_LE
>  [...]
>   channels     : 1
>  rate         : 8000
>  exact rate   : 8000 (8000/1)
>   [...]
>  period_size  : 160
>  [...]
>  avail_min    : 160
> ------------------------------------------------------------------------
>
> In the above output you can see that the format, number of channels, rate,
> period size and
> avail_min are indeed set to correct values.
>


you output did not show the values of buffer size

PCM format is signed, linear, LE with 16 bits
PCM rate 1 - 192000 Hz
PCM period size: 64 - 699051
PCM buffer size: 480 - 163840
calculated buffer size: 640
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 640
  period_size  : 160
  period_time  : 20000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 160
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 640
  silence_threshold: 0
  silence_size : 0
  boundary     : 1342177280
avail min: 160
start threshold: 160 frames
stop threshold: 320 frames
PCM format is signed, linear, LE with 16 bits
PCM rate 1 - 192000 Hz
PCM period size: 64 - 699051
PCM buffer size: 480 - 163840
calculated buffer size: 640
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 640
  period_size  : 160
  period_time  : 20000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 160
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 640
  silence_threshold: 0
  silence_size : 0
  boundary     : 1342177280
avail min: 160
start threshold: 160 frames
stop threshold: 320 frames
capture fds: 1, playback fds: 1
capture poll fd: 3, playback poll fd: 8
capture struct: fd: 3, events: POLLIN POLLERR , revents: 0
playback struct: fd: 8, events: POLLIN POLLERR , revents: 0
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll: POLLIN  on capture device
read 160 frames
hexdump(): 320 bytes
0000    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0010    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0020    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
0030    00 00 02 00 04 00 ff ff ff ff fb ff f8 ff f9 ff
0040    f9 ff fe ff fc ff f9 ff f5 ff f8 ff 02 00 fe ff
0050    f7 ff ed ff f4 ff 01 00 fe ff ff ff f9 ff f4 ff
0060    f9 ff f6 ff f9 ff fb ff f6 ff fa ff fa ff fe ff
0070    00 00 fd ff fe ff fe ff fd ff fb ff fb ff fc ff
0080    fc ff fa ff fa ff f8 ff fd ff fe ff fa ff 00 00
0090    fa ff f6 ff fc ff fa ff fe ff 00 00 ff ff 00 00
00a0    fe ff fd ff fe ff fe ff 00 00 ff ff 01 00 fd ff
00b0    fb ff fd ff f8 ff fb ff 00 00 03 00 01 00 01 00
00c0    00 00 fa ff fb ff fe ff fb ff fc ff ff ff 00 00
00d0    04 00 05 00 02 00 01 00 fe ff 00 00 03 00 02 00
00e0    01 00 00 00 01 00 01 00 fe ff fc ff fc ff fc ff
00f0    fd ff fd ff 00 00 01 00 02 00 03 00 01 00 05 00
0100    fd ff f8 ff fb ff f8 ff fb ff fc ff f8 ff fd ff
0110    fd ff fe ff 02 00 01 00 00 00 00 00 fd ff 02 00
0120    03 00 01 00 ff ff fb ff 02 00 01 00 ff ff 04 00
0130    04 00 03 00 01 00 02 00 09 00 0f 00 0d 00 0c 00

demangled poll:  on playback device
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll: POLLIN  on capture device
read 160 frames
hexdump(): 320 bytes
0000    0a 00 07 00 06 00 07 00 0d 00 08 00 05 00 05 00
0010    05 00 07 00 09 00 0b 00 07 00 04 00 03 00 03 00
0020    02 00 01 00 07 00 0a 00 0a 00 06 00 00 00 fc ff
0030    fe ff 05 00 05 00 08 00 0a 00 05 00 05 00 06 00
0040    06 00 08 00 06 00 05 00 03 00 00 00 02 00 02 00
0050    fb ff f7 ff fa ff ff ff ff ff 00 00 fd ff f7 ff
0060    f5 ff f9 ff fb ff ff ff 01 00 03 00 01 00 fe ff
0070    fe ff ff ff 00 00 04 00 02 00 f7 ff fa ff ff ff
0080    02 00 04 00 01 00 04 00 07 00 00 00 fc ff ff ff
0090    fc ff fb ff f9 ff fd ff ff ff ff ff 03 00 fe ff
00a0    f7 ff f7 ff f7 ff f6 ff f8 ff f7 ff f7 ff f8 ff
00b0    f6 ff fe ff fe ff fc ff fc ff fa ff fc ff fc ff
00c0    fb ff f7 ff ff ff 00 00 01 00 05 00 fb ff f8 ff
00d0    f2 ff f7 ff fa ff fa ff fd ff f9 ff f8 ff f9 ff
00e0    fe ff 00 00 01 00 01 00 ff ff fd ff ff ff 04 00
00f0    00 00 fb ff f7 ff f4 ff fa ff fe ff 03 00 01 00
0100    00 00 ff ff fc ff 01 00 03 00 fe ff f9 ff f8 ff
0110    fa ff fd ff 03 00 03 00 02 00 fe ff f9 ff fd ff
0120    00 00 fa ff f7 ff fd ff fe ff fd ff 01 00 00 00
0130    fa ff f8 ff f7 ff f4 ff f6 ff fa ff f9 ff fa ff

demangled poll:  on playback device
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll: POLLIN  on capture device
read 160 frames
hexdump(): 320 bytes
0000    fd ff ff ff 03 00 01 00 fb ff fb ff fd ff fd ff
0010    f9 ff fb ff fd ff ff ff 02 00 00 00 fe ff fb ff
0020    fb ff fc ff 00 00 01 00 fe ff fe ff ff ff ff ff
0030    00 00 02 00 ff ff ff ff 00 00 fc ff fe ff ff ff
0040    fe ff fe ff fd ff ff ff fe ff ff ff 00 00 01 00
0050    04 00 06 00 02 00 fd ff 03 00 02 00 02 00 01 00
0060    fd ff fd ff ff ff 03 00 02 00 05 00 04 00 01 00
0070    00 00 fc ff 00 00 05 00 06 00 05 00 03 00 00 00
0080    fd ff 01 00 04 00 06 00 06 00 01 00 03 00 fd ff
0090    fa ff 05 00 06 00 04 00 00 00 fd ff fe ff fa ff
00a0    f8 ff 01 00 0a 00 08 00 08 00 05 00 ff ff fe ff
00b0    01 00 05 00 0a 00 09 00 03 00 01 00 01 00 04 00
00c0    01 00 04 00 07 00 06 00 09 00 06 00 03 00 00 00
00d0    fd ff fc ff 01 00 04 00 02 00 06 00 07 00 06 00
00e0    05 00 03 00 02 00 06 00 0a 00 09 00 02 00 fd ff
00f0    fb ff fa ff fd ff ff ff 01 00 ff ff f9 ff f5 ff
0100    f3 ff f7 ff fb ff f7 ff f6 ff fc ff fb ff fd ff
0110    fd ff f6 ff f7 ff fc ff f9 ff fb ff fc ff f5 ff
0120    f6 ff f7 ff f3 ff f6 ff f8 ff f7 ff f6 ff f9 ff
0130    fc ff f6 ff f4 ff f6 ff f4 ff fa ff f8 ff f2 ff

demangled poll:  on playback device
demangled poll:  on capture device
demangled poll: POLLOUT  on playback device
wrote 160 frames
demangled poll: POLLIN  on capture device
could not read from capture device: Resource temporarily unavailable



>
> cheers,
> stefan
>
