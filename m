From: Damien Zammit <damien.zammit@gmail.com>
Subject: [PATCH] snd-usb-audio: bootup sequence provided for
	new device - Digidesign Mbox 2
Date: Wed, 19 Aug 2009 03:52:17 +1000
Message-ID: <98ec50f0908181052y6b4bd592x9776a6c9a0efcbe2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 4EAF0247BB
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Aug 2009 19:52:19 +0200 (CEST)
Received: by ewy20 with SMTP id 20so3759234ewy.46
	for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2009 10:52:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Digidesign Mbox 2 support for Linux - Damien Zammit 19/08/2009

dczammit@flop:~$ dmesg
[132064.931715] ALSA sound/usb/usbaudio.c:3279: Sending Digidesign
Mbox 2 boot sequence...
[132064.934474] ALSA sound/usb/usbaudio.c:3306: device initialised!
[132064.937473] ALSA sound/usb/usbaudio.c:3315: mbox2_boot: new boot
length = 646
[132064.945769] ALSA sound/usb/usbaudio.c:2814: 36:2:2: add audio endpoint 0x3
[132064.950765] ALSA sound/usb/usbaudio.c:2814: 36:2:3: add audio endpoint 0x3
[132064.957314] ALSA sound/usb/usbaudio.c:2814: 36:3:2: add audio endpoint 0x4
[132064.961622] ALSA sound/usb/usbaudio.c:2814: 36:3:3: add audio endpoint 0x4
[132064.964575] ALSA sound/usb/usbaudio.c:2814: 36:3:6: add audio endpoint 0x4
[132064.971046] ALSA sound/usb/usbaudio.c:2814: 36:4:2: add audio endpoint 0x85
[132064.973545] ALSA sound/usb/usbaudio.c:2814: 36:4:3: add audio endpoint 0x85
[132064.979576] ALSA sound/usb/usbaudio.c:2814: 36:5:2: add audio endpoint 0x86
[132064.982522] ALSA sound/usb/usbaudio.c:2814: 36:5:3: add audio endpoint 0x86
[132064.986584] ALSA sound/usb/usbmidi.c:1357: created 1 output and 1
input ports
[132064.986955] usbcore: registered new interface driver snd-usb-audio
dczammit@flop:~$

dczammit@flop:~$ ls /proc/asound/M2/
id  midi0  pcm0c  pcm0p  pcm1c  pcm1p  pcm2p  stream0  stream1
stream2  usbbus  usbid
dczammit@flop:~$

dczammit@flop:~$ cat /proc/asound/M2/stream0
Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed : USB Audio

Playback:
  Status: Stop
  Interface 2
    Altset 2
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 2
    Altset 3
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 3 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 5
    Altset 2
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 5
    Altset 3
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 6 IN (SYNC)
    Rates: 8000 - 48000 (continuous)
dczammit@flop:~$

dczammit@flop:~$ cat /proc/asound/M2/stream1
Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed : USB Audio #1

Playback:
  Status: Stop
  Interface 3
    Altset 2
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 3
    Altset 3
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 4
    Altset 2
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 8000 - 48000 (continuous)
  Interface 4
    Altset 3
    Format: 0x20 (24 bits)
    Channels: 2
    Endpoint: 5 IN (SYNC)
    Rates: 8000 - 48000 (continuous)
dczammit@flop:~$

dczammit@flop:~$ cat /proc/asound/M2/stream2
Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed : USB Audio #2

Playback:
  Status: Stop
  Interface 3
    Altset 6
    Format: 0x2 (16 bits)
    Channels: 2
    Endpoint: 4 OUT (SYNC)
    Rates: 8000 - 48000 (continuous)
dczammit@flop:~$

I fixed the broken pipes!!  I can get speaker-test working, but I dont
get any sound...

1)
Is format 0x20 (S24_3LE) supported yet?  I can't get it to work with
jackd version 0.116.2

2)
Which interfaces/altsettings should I disable?  I can't quite get the
sound to come out.


Damien
