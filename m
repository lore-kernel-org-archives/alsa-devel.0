From: Francesco Abbate <segfault@email.it>
Subject: Re: problems with ALSA and SDL
Date: Sun, 1 Feb 2004 21:42:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040201214248.0b8f0ce9.segfault@email.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


It seems that I'm the only guy who is trying to use an AWE64
without OSS emulation.

I've tried "asfxload" with my AWE64 and it doesn't work. Probably
this is due to my ignorance since I've only a basic understanding
of PCM playback and none about MIDI (with ALSA I mean).

The question is the following :
I load all the ALSA modules, both for the sequencer and PCM.
In fact the ouput of "pmidi -l" gives:
-----------------
 Port     Client name                       Port name
 64:0     Rawmidi 0 - MPU-401 (UART) 0-0    MPU-401 (UART) 0-0
 65:0     Emu8000 WaveTable                 Emu8000 Port 0
 65:1     Emu8000 WaveTable                 Emu8000 Port 1
 65:2     Emu8000 WaveTable                 Emu8000 Port 2
 65:3     Emu8000 WaveTable                 Emu8000 Port 3
 66:0     OPL3 FM synth                     OPL3 FM Port
-----------------
Then, when I try to load the soundfont with

./asfxload synthgm.sbk

I get :
No Emux synth hwdep device is found.

I've verified with the source code that the problem is at
the very beginning when the program call

snd_hwdep_open(&hwdep, name, 0)

I've tried with -D "hw:0,2" but the result is the same.
I've also verified that a basic "sequencer program" works
but just without playing any sound, of course.

I didn't like to bother the devel ML with such kind of problems
but there is no documentation about "sound font loading without
OSS emulation".
-- 
Francesco Abbate


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
