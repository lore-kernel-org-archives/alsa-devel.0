From: patrick reardon <swpatrick@earthlink.net>
Subject: possible problems with rc6 aplay
Date: Sun, 15 Dec 2002 15:59:54 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DFCFB5A.9B34D27C@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hi everyone:

i'm running on a PIII with kernel 2.4.18 and Alsa 0.9.0rc6 and a Hammerfall 9636 card. 
Alsa has been working fine for the last year, or so it seems.  recently a scsi CD burner
was installed.  i have some recordings of live performances made with "arecord", version
0.9.0beta8a.  they play back just fine, but when i tried to burn them to CD, they were low
by about 2 to 3 half steps.  

Joerg Shilling suggested that Alsa was writing the wrong headers.  so i upgraded to rc6
and on the first try on each of the old WAV files, "aplay" also played them too slowly. 
however, on subsequent runs, everything was fine again.  i don't understand this behaviour
at all.

someone on LAU suggested that since it was too low by about 2-3 half steps, data was being
recorded at 48000 but Alsa thought it was at 44100.  

info in /proc/asound/hammerfall/rme9652:

------------snip-------------
.
.
Latency: 4096 samples (2 periods of 16384 bytes)
Hardware pointer (frames): 0
Passthru: no
Clock mode: autosync
Pref. sync source: ADAT1

IEC958 input: Coaxial
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 Dolby: off
IEC958 sample rate: error flag set

ADAT Sample rate: 44100Hz
.
.
---------snip-----------------


for months up until about an hour ago the ADAT sample rate read 48000.  in that hour i
changed my .asoundrc from 


-----------snip---------------
pcm.hammerfall {	#"hammerfall" is the alias for "snd-rme9652" in /etc/modules.conf
	type hw
	card0
}

ctl.hammerfall {
	type hw
	card0
}
-----------snip---------------


to the following


-----------snip---------------

pcm.rme9652 {   #changed from "hammerfall" to "rme9652" on 12.15.2002
   type hw
   card 0
}

ctl.rme9652 {   #same as above comment
   type hw
   card 0
}
---------snip-----------------


after the .asoundrc change i recorded a fresh WAV and burned it to CD but with the same
problem -- too slow.  also, with the new .asoundrc, version rc6 plays WAV's recorded with
the old .asoundrc and version rc6 a little too fast.  i'm at a loss for new ideas to debug
this.

can anyone enlighten me about this, or does anyone know where i can download some
reference WAV files (for example, a middle C tone) to check whether the burning problem
might involve Alsa or whether it's something else in my setup?

any pointers would be greatly appreciated.

tia,
patrick


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
