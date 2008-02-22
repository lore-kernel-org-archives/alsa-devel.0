From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: Re: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 16:19:28 +0200
Message-ID: <43e8c7320802220619x4dfc049cv1f38a6fb8b1cb7a8@mail.gmail.com>
References: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
	<47BEC97A.3030507@ladisch.de>
	<43e8c7320802220545m6ccf8c7fr13a9390563d7df7@mail.gmail.com>
	<47BED4C2.4020501@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.191])
	by alsa0.perex.cz (Postfix) with ESMTP id A15C4245F7
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 15:19:33 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so280258gvd.24
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 06:19:30 -0800 (PST)
In-Reply-To: <47BED4C2.4020501@ladisch.de>
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

It seems that retire_playback_sync_urb_hs gets called, but 'subs->feqm
= f;' never gets called

Here is the content of /proc/asound/card1/stream0 during playback:

vader:~# cat /proc/asound/card1/stream0
E-MU Systems, Inc. E-MU 0404 | USB at usb-0000:00:1d.7-6, high speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 3
    URBs = 4 [ 8 8 8 5 ]
    Packet Size = 298
    Momentary freq = 48000 Hz (0x6.0000)
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


On Fri, Feb 22, 2008 at 3:57 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> Adrian Stancu wrote:
>  > Using the original module, the momentary frequency is always stalled
>  > at 48000Hz during playback:
>  > vader:~# while sleep 0.3; do grep "Momentary freq"
>  > /proc/asound/card1/stream0; done
>  >     Momentary freq = 48000 Hz (0x6.0000)
>  >     Momentary freq = 48000 Hz (0x6.0000)
>  >     Momentary freq = 48000 Hz (0x6.0000)
>  >     Momentary freq = 48000 Hz (0x6.0000)
>  >     Momentary freq = 48000 Hz (0x6.0000)
>  >
>  >  note: I started playback after issuing the command.
>  > So maybe this particular type of interface does not report back
>  > correctly, thus confusing the driver?
>
>  This is possible.  Please try to put printk's into
>  retire_playback_sync_urb(_hs) to see whether these functions ever get
>  called, and whether the line "subs->freqm = f;" is reached.
>
>  Please show the entire contents of /proc/asound/card1/stream0 while the
>  device is playing.
>
>
>  Regards,
>  Clemens
>
