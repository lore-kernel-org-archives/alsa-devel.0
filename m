From: Werner Schweer <ws@seh.de>
Subject: Re: bugs in usb midi alsa code?
Date: Sat, 9 Nov 2002 13:45:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211091345.05395.ws@seh.de>
References: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
Reply-To: ws@seh.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from seh.de (betty.seh.de [195.145.22.40])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA28555
	for <alsa-devel@alsa-project.org>; Sat, 9 Nov 2002 13:44:05 +0100
In-Reply-To: <Pine.HPX.4.33n.0211070857080.1450-100000@studcom.urz.uni-halle.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 07 November 2002 09:10, Clemens Ladisch wrote:
> Fernando Pablo Lopez-Lezcano wrote:
> > OSS emulation (raw midi interface):
> >   Midi input and output works fine on the first port,
> > ALSA:
> >   input does not seem to work at all.
>
> Werner Schweer wrote:
> > same on my Roland/Edirol UA100 (audio + 2 midi ports).
>
> Martin Langer wrote:
> > last but not least: same on my Evolution MK-249C keyboard
>
> I don't think the bug is in the snd-usb-audio driver because OSS input
> seems to be working.
>
> Please try the following with the rawmidi program in alsa-lib/test:
> OSS:         rawmidi -v -I /dev/midix
> ALSA direct: rawmidi -v -I /dev/snd/midiCxD0
> ALSA Lib:    rawmidi -v -i hw:x,0
> ALSA Lib:    rawmidi -v -i hw:x,0,0
>
> Did you update alsa-lib together with alsa-kernel? Are you sure you have
> the correct version of libasound installed, and your programs are using
> it?

My System: Roland UA100 usb audio/midi device; ALSA cvs from today (saturday)
(driver + lib), new compiled app

I'm using devfs and when i switch on the ua100 i get the following
messages:

      hub.c: new USB device 00:1d.0-2, assigned address 4
      snd-usb-midi: created 3 output and 3 input ports
      devfs_register(unknown): could not append to parent, err: -17
      devfs_register(unknown): could not append to parent, err: -17
      devfs_register(unknown): could not append to parent, err: -17
      devfs_register(unknown): could not append to parent, err: -17

err -17 -> file exists
And really there is a /dev/sound/unknown (major/minor 14/18).

Recording from /dev/snd/midiC1D0 ("cat /dev/snd/midiC1D0") --> works.
(Only one midi port is visible).
ALSA Lib:    rawmidi -v -i hw:x,0           --> works
ALSA Lib:    rawmidi -v -i hw:x,0,0         --> works

Recording from alsa sequencer ports of UA100 did not work.
With older version of ALSA i got the midi ports on the UA100 working but
not the audio part.

What my app does is:

      snd_seq_port_subscribe_t* subs;
      snd_seq_port_subscribe_alloca(&subs);
      snd_seq_port_subscribe_set_dest(subs, &musePort);
      snd_seq_port_subscribe_set_sender(subs, &adr);
      int error = snd_seq_subscribe_port(alsaSeq, subs);

But no events are arriving from subscribed input port. This worked for previous
ALSA versions.

cat /proc/asound/seq/clients says:

Client info
  cur  clients : 4
  peak clients : 4
  max  clients : 192

Client   0 : "System" [Kernel]
  Port   0 : "Timer" (Rwe-)
  Port   1 : "Announce" (R-e-)
    Connecting To: 128:0
Client  72 : "External MIDI 1" [Kernel]
  Port   0 : "UA-100 Port 0" (RWeX)
    Connecting To: 128:0
    Connected From: 128:0
  Port   1 : "UA-100 Port 1" (RWeX)
    Connecting To: 128:0
    Connected From: 128:0
  Port   2 : "UA-100 Port 2" (RWeX)
    Connecting To: 128:0
    Connected From: 128:0
Client 128 : "MusE Sequencer" [User]
  Port   0 : "MusE Port 0" (RWe-)
    Connecting To: 72:0, 72:1, 72:2
    Connected From: 0:1, 72:0, 72:1, 72:2
  Output pool :
    Pool size          : 500
    Cells in use       : 0
    Peak cells in use  : 0
    Alloc success      : 0
    Alloc failures     : 0
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 9
    Alloc success      : 9
    Alloc failures     : 0
Client 129 : "organ" [User]
  Port   0 : "organ-1" (-We-)
  Input pool :
    Pool size          : 200
    Cells in use       : 0
    Peak cells in use  : 1
    Alloc success      : 68
    Alloc failures     : 0




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
