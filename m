From: Geoff Beasley <songshop@bizmedia.com.au>
Subject: Resending ...can anyone suggest someone who can help ?
Date: Thu, 20 Jan 2005 09:36:11 +1100
Message-ID: <200501200936.11434.songshop@bizmedia.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

Excuse me if I'm on the wrong list, but I really need to solve this puzzle 
quickly. Clemens has gracefully sent me an .asoundrc to combine my 2 C-Ports 
(ice1712) into a multidevice, but alas I cannot get it to work. I attach 
my .asound file made from Clemens template; can someone check it for errors 
for me ?

Here's the .asoundrc file I made :-

 pcm.cport1 {
         type hw
         card 0
 }
 pcm.cport2 {
         type hw
         card 1
 }

 pcm.multi20 {
         type multi
 
         slaves.a.pcm cport1
         slaves.a.channels 10
         slaves.b.pcm cport2
         slaves.b.channels 10
 
         bindings [
                 { slave a channel 0 }
                 { slave a channel 1 }
                 { slave a channel 2 }
                 { slave a channel 3 }
                 { slave a channel 4 }
                 { slave a channel 5 }
                 { slave a channel 6 }
                 { slave a channel 7 }
                 { slave a channel 8 }
                 { slave a channel 9 }          
                 { slave b channel 0 }
                 { slave b channel 1 }
                 { slave b channel 2 }
                 { slave b channel 3 }
                 { slave b channel 4 }
                 { slave b channel 5 }
                 { slave b channel 6 }
                 { slave b channel 7 }
                 { slave b channel 8 }
                 { slave b channel 9 }
        ]
}

pcm.multi24 {
         type multi
 
         slaves.a.pcm cport1
         slaves.a.channels 12
         slaves.b.pcm cport2
         slaves.b.channels 12
 
         bindings [
                 { slave a channel 0 }
                 { slave a channel 1 }
                 { slave a channel 2 }
                 { slave a channel 3 }
                 { slave a channel 4 } 
                 { slave a channel 5 }
                 { slave a channel 6 }
                 { slave a channel 7 }
                 { slave a channel 8 }
                 { slave a channel 9 } 
                 { slave a channel 10 }
                 { slave a channel 11 } 
                 { slave b channel 0 }
                 { slave b channel 1 }
                 { slave b channel 2 }
                 { slave b channel 3 }
                 { slave b channel 4 }
                 { slave b channel 5 }
                 { slave b channel 6 }
                 { slave b channel 7 }
                 { slave b channel 8 }
                 { slave b channel 9 }
                 { slave b channel 10 }
                 { slave b channel 11 }
         ]
 }

pcm.both {
         type plug
         slave.pcm {
                 type asym
                 playback.pcm "multi20"
                 capture.pcm "multi24"
         }
 }
 
 ctl.both {
         type hw
         card 0
 }
 


And here's what happens when I try to run jack:-


root@lindaw:~# jackd  -d alsa -d both [-p 512 ]
jackd 0.99.0
Copyright 2001-2003 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

loading driver ..
creating alsa driver ... both|both|1024|2|48000|0|0|nomon|swmeter|-|32bit
configuring for 48000Hz, period = 1024 frames, buffer = 2 periods
You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a hardware device
instead rather than using the plug layer. Usually the name of the
hardware device that corresponds to the first soun
You appear to be using the ALSA software "plug" layer, probably
a result of using the "default" ALSA device. This is less
efficient than it could be. Consider using a hardware device
instead rather than using the plug layer. Usually the name of the
hardware device that corresponds to the first soun
ALSA lib pcm.c:1178:(snd_pcm_link) SNDRV_PCM_IOCTL_LINK failed: Operation 
alread       y in progress
jackd: pcm.c:5957: snd_pcm_mmap_commit: Assertion `frames <= 
snd_pcm_mmap_avail(       pcm)' failed.

Qjack control can use both C-Ports individually perfectly. 

Do multi devices work without added latency ?
Am I close ?

Thanks for any input !

Using alsa driver , lib & utils 1.0.6 on slackware 10 c/w 
audioslack ll kernel 2.4.27.  & alsa firmware 1.0.7


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
