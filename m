From: Florian Schmidt <mista.tapas@gmx.net>
Subject: dmix, dsnoop, asym weirdness [no errors, no sound either]
Date: Sun, 1 Feb 2004 13:48:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040201134838.5753abf3.mista.tapas@gmx.net>
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


Ok, i have a hw mixing capable card, but i do have interest in getting
the dmix/dsnoop/asym thing working. Well, i defined a "pasymed" device
like this:


------.asoundrc start
#asym fun start here. we define one pcm device called "dmixed"
pcm.dmixed {
        ipc_key 1025
        type dmix
        slave.pcm "hw:0,0"
}

#one called "dsnooped" for capturing 
pcm.dsnooped {
        ipc_key 1026
        type dsnoop
        slave.pcm "hw:0,0"
}

#and this is the real magic
pcm.asymed {
        type asym
        playback.pcm "dmixed"
        capture.pcm "dsnooped"
}

#a quick plug plugin for above device to do the converting magic
pcm.pasymed {
        type plug
        slave.pcm "asymed"
}

#a ctl device to keep xmms happy
ctl.pasymed {
        type hw
        card 0
}
------.asoundrc end

Now i should be able to test that device "pasymed" with the aplay
command:

aplay -D pasymed foo.wav

This command does not give any error messages on my machine. It also
does not produce any sound. The soundfile is rather short and aplay
exits fine after the duration of the soundfile. So i figure it is played
back correctly. The question is though: Where is it played to? I have
three playback devices on my cs46xx soundcard:

tapas@mango:~$ cat /proc/asound/devices 
  1:       : sequencer
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
 33:       : timer

But i have only one speaker pair connected to the soundcard outs. I just
tested the two analoge outs [don't have any digital equipment for
digital out]. The pasymed signal doesn't come out anywhere.. I think
it's a dmix issue, because

aplay -D plug:dmix foo.wav

shows the exact same behaviour [no errors, no sound, normal termination
after duration of soundfile].. dsnoop is behaving weirdly, too. I just
recorded with

arecord -D pasymed -t wav -f cd foo.wav

and it records just a little chunk of audio repeated over and over. It
seems to be the first period that is in the buffer after opening the
device [for i get a file filled with silence when i start recording at a
silent point]. I put up the .wav at

http://mistatapas.ath.cx:8888/foo.wav

I get the exact same result with

aplay -D plug:dsnooped -t wav -f cd foo.wav





Here's some more info about my setup:

tapas@mango:~$ uname -a
Linux mango.fruits.de 2.4.22 #1 SMP Wed Nov 19 13:43:03 CET 2003 i686
GNU/Linux

tapas@mango:~$ cat /proc/asound/version 
Advanced Linux Sound Architecture Driver Version 1.0.1.
Compiled on Jan 22 2004 for kernel 2.4.22 (SMP) with versioned symbols.

tapas@mango:~$ cat /proc/asound/cards 
0 [CS46xx         ]: CS46xx - Sound Fusion CS46xx
                     Sound Fusion CS46xx at 0xcffef000/0xcfe00000, irq 5




Flo


-- 
signature :)



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
