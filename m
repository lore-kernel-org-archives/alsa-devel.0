From: Will <walsac2@liam2.demon.co.uk>
Subject: Re: [PATCH] add aplaymidi & arecordmidi utils
Date: Tue, 24 Feb 2004 17:12:44 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402241712.RAA29352@liam2.demon.co.uk>
References: <Pine.HPX.4.33n.0402231010240.20713-100000@studcom.urz.uni-halle.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0402231010240.20713-100000@studcom.urz.uni-halle.de>
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
>add aplaymidi & arecordmidi utilities
>

 I'm getting empty MIDI files containing only the MIDI header.

 $ arecordmidi -l
   Port    Client name                      Port name
   64:0    Rawmidi 0 - Sound Blaster 16 MPU Sound Blaster 16 MPU-401

 $ cat /proc/asound/card0/midi0
   Sound Blaster 16 MPU-401

   Output 0
     Tx bytes     : 9856
   Input 0
     Rx bytes     : 205806

 $ arecordmidi -p 64:0 music.mid
   <Ctrl-C>

 $ cat /proc/asound/card0/midi0
   Sound Blaster 16 MPU-401

   Output 0
     Tx bytes     : 9856
   Input 0
     Rx bytes     : 205946

 $ ls -l music.mid
   -rw-r--r--    1 uab1  gab1          34 Feb 24 17:07 music.mid

 $ file music.mid
   music.mid:  Standard MIDI data

 $ od -c music.mid
   000000  77  84 104 100   0   0   0   6   0   0   0   1   1 128  77  84
            M   T   h   d  \0  \0  \0 006  \0  \0  \0 001 001 200   M   T
   000010 114 107   0   0   0  12   0 255  81   3   7 161  32 150  96 255
            r   k  \0  \0  \0  \f  \0 377   Q 003  \a 241     226   ` 377
   000020  47   0
            /  \0
 
Any ideas?  I can record MIDI files ok using the old OSS sound drivers
and OSS sequencer software.

William


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
