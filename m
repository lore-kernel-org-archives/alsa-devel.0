From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Wed, 25 Feb 2004 00:10:52 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402250010.AAA06565@liam2.demon.co.uk>
References: <Pine.HPX.4.33n.0402241856320.5168-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402241856320.5168-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch <clemens@ladisch.de> wrote:
>
>If you get correct output when you run "amidi -p virtual -d" and
>aconnect your keyboard to that port, then it may be a bug in
>arecordmidi.  I'll test when I'm at home.
>

This is what I get:

  $ amidi -p virtual -d &
 
  $ pmidi -l
    Port     Client name                       Port name
    64:0     Rawmidi 0 - Sound Blaster 16 M    Sound Blaster 16 MPU-401
    65:0     Emu8000 WaveTable                 Emu8000 Port 0
    65:1     Emu8000 WaveTable                 Emu8000 Port 1
    65:2     Emu8000 WaveTable                 Emu8000 Port 2
    65:3     Emu8000 WaveTable                 Emu8000 Port 3
    66:0     OPL3 FM synth                     OPL3 FM Port
    72:0     Virtual Raw MIDI 1-0              VirMIDI 1-0
    73:0     Virtual Raw MIDI 1-1              VirMIDI 1-1
    74:0     Virtual Raw MIDI 1-2              VirMIDI 1-2
    75:0     Virtual Raw MIDI 1-3              VirMIDI 1-3
   128:0     Client-128                        Virtual RawMIDI

 The MIDI keyboard is on port 64:0:

 $ aconnect 64:0 128:0

playing various notes on the MIDI keyboard gives correct MIDI output in ASCII:

   90 29 4A
   90 29 00
   90 2D 4C
      2D 00
   90 2B 5A
   90 2B 00
   90 28 59
   90 28 00
   90 24 26
      24 00
      24 51
   90 24 00
   90 24 63
      24 00
   90 24 75
   90 24 00
   90 24 7B
   90 24 00
      24 65
   90 24 00
      24 50
   90 24 00
   90 24 3D
   90 24 00
   90 24 47
   90 24 00
   90 24 44
   90 24 00
   90 24 3A
   90 24 00
   90 26 6B
   90 26 00
      28 68
   90 28 00
      29 5F
      2B 68
   90 29 00
      29 65
   90 2B 00
      28 5E
      29 00
   90 26 69
      28 00
      24 70
   etc  

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
