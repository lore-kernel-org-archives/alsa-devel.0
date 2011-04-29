From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Alsa-plugins: Pulse: Fix snd_pcm_avail
 returning 0 in some cases
Date: Fri, 29 Apr 2011 10:32:10 +0800
Message-ID: <BANLkTimq_7_YZFEK0BH4xcRMF=KQw9nwtA@mail.gmail.com>
References: <4DB02F8A.4040001@canonical.com>
	<BANLkTikb0uuEw9-gbbGW6Kcf0LkPHsgxdw@mail.gmail.com>
	<4DB67BD3.7090706@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EA8671039A7
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Apr 2011 04:32:11 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2589708fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2011 19:32:10 -0700 (PDT)
In-Reply-To: <4DB67BD3.7090706@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Maarten Lankhorst <m.b.lankhorst@gmail.com>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On 2011-04-20 12:09, Maarten Lankhorst wrote:
>* Hi David,
*>*
*>* Op 20-04-11 09:33, David Henningsson schreef:
*>>* On 2011-04-19 18:12, Maarten Lankhorst wrote:
*>>>* Hi all,
*>>>*
*>>>* For wine I was investigating a bug with pulseaudio, it seems
*>>>* alsa-plugins' pulse driver ignores underruns.


*If you follow the instruction in
http://colin.guthr.ie/2010/09/compiling-and-running-pulseaudio-from-git/

to run a more advanced client application and define DEBUG_TIMING in
alsa-sink.c

you can test it with

aplay -Dpulse --period-time=10000 any.wav

and

aplay -Dhw:0,0 --period-time=10000 any.wav

The period time "10ms" which work with "hw:0,0", may not work with
"pulse" any more
since PA server is expecting the sound card to run accurately at 5ms
period time**

aplay -Dpulse -v --period-time=10000 any.wav
Playing WAVE 'any.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : PLAYBACK

  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 2
  rate         : 44100
  exact rate   : 44100 (44100/1)
  msbits       : 16
  buffer_size  : 22050
  period_size  : 441

  period_time  : 10000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 441
  period_event : 0
  start_threshold  : 1323
  stop_threshold   : 1323
  silence_threshold: 0
  silence_size : 0

  boundary     : 1387266048



D: alsa-sink.c: Wrote 928 bytes (of possible 928 bytes)
D: alsa-sink.c: avail: 63804
D: alsa-sink.c: 9.82 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms

D: alsa-sink.c: Buffer time: 10 ms; Sleep time: 4 ms; Process time: 5 ms
D: alsa-sink.c: avail: 63868
D: alsa-sink.c: 9.46 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms
D: alsa-sink.c: Buffer time: 10 ms; Sleep time: 4 ms; Process time: 5 ms

D: alsa-sink.c: avail: 63900
D: alsa-sink.c: 9.27 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms
*


when using aplay to play those audio which are not the default sample
rate/ channels of PA server
such as 48000Hz and mono (e.g. /usr/share/sounds/alsa/*.wav"

5ms seem not enough for resampling/enable logging

underrun occur (avail 66552 > buffer size 65536) and PA server abort

D: alsa-sink.c: 9.46 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms
D: alsa-sink.c: Buffer time: 10 ms; Sleep time: 4 ms; Process time: 5 ms
D: alsa-sink.c: avail: 64288
D: alsa-sink.c: 7.07 ms left to play; inc threshold = 0.00 ms; dec
threshold = 100.00 ms
D: alsa-sink.c: Wrote 516 bytes (of possible 516 bytes)
D: alsa-sink.c: avail: 66552
Trace/breakpoint trap



*>>*
*>>* Hmm, doesn't wine come with a native pulse driver these days?
*>* Nope, but distros patch in a buggy winepulse driver, wine is working on
*>* rearchitecting its driver model, so that a pulseaudio driver might be
*>* added after that, but the current winepulse driver was a bad
*>* copy/replace job of the wrong sound driver. :)

*winepulse is almost useless if it does not support mixer and midi

> My main point is that the underrun is often obsolete when the message

> reached the application, because more data has already been written,
> therefore reporting it to the app does more harm than good.
> At least until the underrun callback (and PA protocol) supports sending

> the position of underrun, together with the underrun message. If we had
> that position, we could compare that with the current write pointer to
> determine whether the underrun is actually obsolete or not.

Refer to the output in "Running a Client Application"
If seem that underrun is unavoidable , as you should notice that
"paplay -vv" also get "Stream underrun" at the end

it is not granunette that snd_pcm_close() must be called after
snd_pcm_drain() or snd_pcm_drop()

src/paplay -vv /usr/share/sounds/ia_ora-startup.wav
Opening a playback stream with sample specification 's16le 2ch
22050Hz' and channel map 'front-left,front-right'.
Connection established.

Stream successfully created.
Buffer metrics: maxlength=4194304, tlength=176400, prebuf=174640, minreq=1764
Using sample spec 's16le 2ch 22050Hz', channel map 'front-left,front-right'.
Connected to device alsa_output.pci-0000_00_1b.0.analog-stereo (0, not
suspended).

Stream started.
Stream underrun.
Playback stream drained.: 1007045 usec.
Draining connection to server.
*
*
