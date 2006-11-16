From: Richi Plana <richip@richip.dhs.org>
Subject: Re: Frequency Problems with 0d8c:0201 and	snd-usb-audio
Date: Thu, 16 Nov 2006 11:23:28 -0700
Message-ID: <1163701408.3406.41.camel@richip.dhs.org>
References: <1163613613.3406.14.camel@richip.dhs.org>
	<1163668222.21027.276016817@webmail.messagingengine.com>
	<1163696903.3406.29.camel@richip.dhs.org>
	<1163697994.10962.276090935@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <1163697994.10962.276090935@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-11-16 at 18:26 +0100, Clemens Ladisch wrote:

> Your device claims to support both 44.1 and 48 kHz.
> 
> What kind of distortion?

As objectively as I can describe it: the audio played at 48 kHz seems to
be coming out at the right speed, but the sound itself is played at a
higher pitch. It's as if each sample block is sent and received at the
correct interval, but actual data from the block is being played back at
a higher rate. It feels like either the DAC is playing at a higher rate
but each block comes at the correct intervals ... or the data isn't
getting to the processor fast enough so it tries to play the bursts as
quickly as it can.

Sorry, I'm not a sound engineer.

> What are the contents of /proc/asound/card0/stream0 while some
> 48 kHz stream is playing?

Here's the content when playing at 44100 Hz:

=========================================================================
PnP Audio Device         at usb-0000:00:13.2-2, full speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 2
    URBs = 3 [ 8 8 8 ]
    Packet Size = 196
    Momentary freq = 44100 Hz (0x2c.199a)
  Interface 1
    Altset 1
    Format: 0x2
    Channels: 8
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 2
    Format: 0x2
    Channels: 2
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 3
    Format: 0x2
    Channels: 4
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 4
    Format: 0x2
    Channels: 6
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 5
    Format: 0x2
    Channels: 2
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: 0x2
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 44100, 48000
=========================================================================

... and at 48000 Hz:

=========================================================================
PnP Audio Device         at usb-0000:00:13.2-2, full speed : USB Audio

Playback:
  Status: Running
    Interface = 1
    Altset = 5
    URBs = 3 [ 8 8 6 ]
    Packet Size = 392
    Momentary freq = 48000 Hz (0x30.0000)
  Interface 1
    Altset 1
    Format: 0x2
    Channels: 8
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 2
    Format: 0x2
    Channels: 2
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 3
    Format: 0x2
    Channels: 4
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 4
    Format: 0x2
    Channels: 6
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 44100, 48000
  Interface 1
    Altset 5
    Format: 0x2
    Channels: 2
    Endpoint: 6 OUT (ADAPTIVE)
    Rates: 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: 0x2
    Channels: 2
    Endpoint: 5 IN (ASYNC)
    Rates: 44100, 48000
=========================================================================

The diff:

=========================================================================
<     Altset = 2
<     URBs = 3 [ 8 8 8 ]
<     Packet Size = 196
<     Momentary freq = 44100 Hz (0x2c.199a)
---
>     Altset = 5
>     URBs = 3 [ 8 8 6 ]
>     Packet Size = 392
>     Momentary freq = 48000 Hz (0x30.0000)
=========================================================================

I hope it tells you something because it's pretty meaningless to me.

> I guess the problem is that ALSA's default channel order isn't the same
> as that defined in the USB audio specification, and ALSA doesn't yet
> remap the channels for USB devices.

So it's likely that the physical ports are wired correctly and it's just
the mixer that's getting things mixed up? Ah well, a minor annoyance.
I'm sure that feature will get into ALSA one of these days. Maybe I'll
even pick up on it one of these days if I ever find the time.

Thanks!
--

Richi


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
