From: Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: alsamixer on cvs
Date: Mon, 2 Sep 2002 21:40:37 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0209022137350.7932-100000@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

After installing a new cvs version I'm getting an assertion failure in 
alsamixer (or amix). 

# alsamixer
alsamixer: simple.c:869: simple_add1: Assertion `!simple->ctls[type].elem' 
failed.
Aborted

This is with these modules loaded and started happening last Friday:
# /sbin/lsmod
Module                  Size  Used by    Tainted: P  
snd-usb-midi            8688   0  (unused)
snd-seq-virmidi         5300   0  [snd-usb-midi]
snd-seq-midi-event      5836   0  [snd-usb-midi snd-seq-virmidi]
snd-seq                53196   0  [snd-usb-midi snd-seq-virmidi 
snd-seq-midi-event]
snd-intel8x0           23648   0 
snd-ac97-codec         31504   0  [snd-intel8x0]
snd-pcm                90144   0  [snd-intel8x0]
snd-timer              16640   0  [snd-seq snd-pcm]
snd-mpu401-uart         5420   0  [snd-intel8x0]
snd-rawmidi            19040   0  [snd-seq-virmidi snd-mpu401-uart]
snd-seq-device          5916   0  [snd-usb-midi snd-seq snd-rawmidi]
snd                    49064   0  [snd-usb-midi snd-seq-virmidi 
snd-seq-midi-event snd-seq snd-intel8x0 snd-ac97-codec snd-pcm snd-timer 
snd-mpu401-uart snd-rawmidi snd-seq-device]
soundcore               6468   0  [snd]

[the usb-midi modules are not doing anything at this point]
-- Fernando



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
