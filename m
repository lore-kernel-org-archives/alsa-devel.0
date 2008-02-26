From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Tue, 26 Feb 2008 10:38:35 +0200
Message-ID: <43e8c7320802260038x17c2c350wade07dcd4f32cb3e@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEF8FE.4030408@ladisch.de>
	<43e8c7320802220846g7d7c8b61jb29e8ca3028d2c24@mail.gmail.com>
	<47BEFFFC.8030301@ladisch.de>
	<43e8c7320802220902j3a4ff3a1wdae77ec25f2d3785@mail.gmail.com>
	<47C2B822.7000507@ladisch.de>
	<43e8c7320802251032j7541ac02t1459ef83d95dfd4e@mail.gmail.com>
	<47C3C07B.2040104@ladisch.de>
	<43e8c7320802252353p2798488at87163c75a4511c4f@mail.gmail.com>
	<47C3CA77.5070104@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 769E91038AE
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 09:38:37 +0100 (CET)
Received: by ik-out-1112.google.com with SMTP id b32so1773602ika.0
	for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2008 00:38:36 -0800 (PST)
In-Reply-To: <47C3CA77.5070104@ladisch.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

OK, I tried playing the stereo file but still getting the same error:
deathu@vader:~/Desktop$ aplay -D hw:1 testtone192.wav
Playing WAVE 'testtone192.wav' : Signed 16 bit Little Endian, Rate
192000 Hz, Stereo
aplay: set_params:918: Sample format non available


For the four channel 96kHz file, aplay complains that it's not in PCM format.
deathu@vader:~/Desktop$ aplay -D hw:1 testtone4.wav
aplay: test_wavefile:749: can't play not PCM-coded WAVE-files

Well, my test file contained a single constant frequency tone; it is
still there while I play the 192k file through plughw:1,0, but burried
under:
- periodic series of clicks
- other high frequency tones

Here is  /proc/asound/card1/stream0 while playing through plughw:1,0:
E-MU Systems, Inc. E-MU 0404 | USB at usb-0000:00:1d.7-6, high speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 10
    URBs = 8 [ 16 16 16 16 16 16 16 16 ]
    Packet Size = 586
    Momentary freq = 192000 Hz (0x18.0000)
  Interface 1
    Altset 1
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 2
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 3
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 4
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 5
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 88200
  Interface 1
    Altset 6
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 88200
  Interface 1
    Altset 7
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 8
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000
  Interface 1
    Altset 9
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 176400
  Interface 1
    Altset 10
    Format: 0x20
    Channels: 2
    Endpoint: 1 OUT (ASYNC)
    Rates: 192000
  Interface 1
    Altset 11
    Format: 0x20
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 12
    Format: 0x20
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 44100
  Interface 1
    Altset 13
    Format: 0x20
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 14
    Format: 0x20
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 48000
  Interface 1
    Altset 15
    Format: 0x20
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 88200
  Interface 1
    Altset 16
    Format: 0x20
    Channels: 4
    Endpoint: 1 OUT (ASYNC)
    Rates: 96000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 44100
  Interface 2
    Altset 2
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 44100
  Interface 2
    Altset 3
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 48000
  Interface 2
    Altset 4
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 48000
  Interface 2
    Altset 5
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 88200
  Interface 2
    Altset 6
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 88200
  Interface 2
    Altset 7
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 96000
  Interface 2
    Altset 8
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 96000
  Interface 2
    Altset 9
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 176400
  Interface 2
    Altset 10
    Format: 0x20
    Channels: 2
    Endpoint: 2 IN (ASYNC)
    Rates: 192000
  Interface 2
    Altset 11
    Format: 0x20
    Channels: 4
    Endpoint: 2 IN (ASYNC)
    Rates: 44100
  Interface 2
    Altset 12
    Format: 0x20
    Channels: 4
    Endpoint: 2 IN (ASYNC)
    Rates: 44100
  Interface 2
    Altset 13
    Format: 0x20
    Channels: 4
    Endpoint: 2 IN (ASYNC)
    Rates: 48000
  Interface 2
    Altset 14
    Format: 0x20
    Channels: 4
    Endpoint: 2 IN (ASYNC)
    Rates: 48000
  Interface 2
    Altset 15
    Format: 0x20
    Channels: 4
    Endpoint: 2 IN (ASYNC)
    Rates: 88200
  Interface 2
    Altset 16
    Format: 0x20
    Channels: 4
    Endpoint: 2 IN (ASYNC)
    Rates: 96000




On Tue, Feb 26, 2008 at 10:14 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > deathu@vader:~/Desktop$ sox testtone96.wav -r 192000 testtone192.wav
>  > deathu@vader:~/Desktop$ aplay -D hw:1 testtone192.wav
>  > Playing WAVE 'testtone192.wav' : Signed 16 bit Little Endian, Rate 192000 Hz, Mono
>  > aplay: set_params:918: Sample format non available
>
>  The device doesn't support mono.
>  Try "sox testtone96.wav -r 192000 -c 2 testtone192.wav".
>
>
>  > I receive totally damaged audio (wrong frequency, lots of artifacts)
>
>  What frequency?  What is shown /proc/asound/card1/stream0 while playing
>  this file?  Does something similar happen with a four-channel 96 kHz
>  file? ("sox testtone96.wav -c 4 testtone4.wav")
>
>
>  Regards,
>  Clemens
>
