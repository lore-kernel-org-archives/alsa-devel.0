From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002217]: Problems with ASUS A6Km
Date: Sat, 24 Jun 2006 09:12:40 +0200
Message-ID: <f9c3f22cf427e0109a1394ff34befe7d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5B982248
	for <alsa-devel@alsa-project.org>;
	Sat, 24 Jun 2006 09:12:41 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2217> 
======================================================================
Reported By:                mafm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2217
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-18-2006 05:06 CEST
Last Modified:              06-24-2006 09:12 CEST
======================================================================
Summary:                    Problems with ASUS A6Km
Description: 
I have the same problems described here:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898 , but I'm
opening a new report because I can't find a way to add a comment there.

I tried that asus-a6km-fix.diff but it doesn't work, in fact it doesn't
appear to have any effect at all.
======================================================================

----------------------------------------------------------------------
 mafm - 06-23-06 16:23 
----------------------------------------------------------------------
I got it working with 1.0.11 and 1.0.12, so I'll repeat the steps to make
it clear:

0- These instructions work for me in ASUS A6KM-Q0012H model (note that
slightly different configurations seem to lead to slightly different
problems with ACPI, sound, things that work with some BIOS versions but
not with other, etc).  In my case, the problem was that to get any kind of
sound being emitted I had to connect the headphones and put Master and PCM
volumes at > 70% values, and then I got to hear something, but with a lot
of distorsion, making it unusable.  Most/all A6KM models seem to have this
issue.  The output of lspci -v is:
---------------------------------------------------------------------------
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]
AC'97 Sound Controller (rev a0)
        Subsystem: ASUSTeK Computer Inc. Unknown device 1103
        Flags: bus master, medium devsel, latency 64, IRQ 22
        I/O ports at e400 [size=256]
        I/O ports at e000 [size=128]
        Capabilities: [48] Power Management version 2
---------------------------------------------------------------------------

1- If you're using up to 2.6.17 vanilla kernels (as opposed to kernels
including additional patches, most distributions do this, as well as
snapshots in kernel.org site), you'll need the patch attached (grabbed
from https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898 ).  Apply
the patch with:
---------------------------------------------------------------------------
# cd /usr/src/linux-VERSION/sound
# patch -p1 < /PATH/asus-a6km-fix.diff
---------------------------------------------------------------------------
Then configure and compile as usual.

2- At this point I had it still working as before.  As opposed to comments
in other bug reports, in my case I don't need to mess with echo commands
to alter registers of the cards, nor altering surround configurations or
anything like that (in fact, I couldn't get it working with any of those
tricks).  Instead, what I had to do is to enable External Amplifier, in
KDE mixer is in the Switches tab.  Note that the alsamixer interface is a
bit confusing: it's a switch, so "MM" means muted, and when enabled shows
"00" (when using alsamixer I thought that it was another regular slider,
so since I could only get it to show MM or 00 I thought that it was
another symptom of the driver not setting up the device properly).

3- Please comment here whether this works for you or not, including
meaningful information (in the case that it's not working, pleae include
kernel versions and who distributes it, alsa version that the kernel use,
exact model of the laptop, output of the device with lspci -v, etc), so
hopefully ALSA guys can put the instructions in their site, maybe I make a
guide with configuration instructions for this laptop, etc.

----------------------------------------------------------------------
 eNTi - 06-24-06 09:12 
----------------------------------------------------------------------
i'm honestly not sure, what you want me to check. yes i've ONCE made my
speakers work and the external amplifier setting had to be turned on.

the patch you've posted, is already in 2.6.17, so there won't be any
changes of course. just check the files for yourself, i wonder, that you
didn't get any errors, from your patch.

i've currently compiled another vanilla 2.6.17 kernel and still had no
luck whatsoever with that stupid sound chip. i'm starting to think, that
i'll never buy another asus notebook again, they really suck hard. broken
sound, broken bios/acpi. sucky touchpad... next time i'll pay the 1000
bucks extra for an ibm :(.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-18-06 05:06 mafm           New Issue                                    
06-18-06 16:51 ryswic         Issue Monitored: ryswic                      
06-19-06 15:49 mafm           Issue Monitored: mafm                        
06-19-06 15:50 mafm           Note Added: 0010315                          
06-20-06 19:46 tiwai          Note Added: 0010345                          
06-20-06 20:16 mafm           Note Added: 0010354                          
06-21-06 21:37 eNTi           Note Added: 0010405                          
06-21-06 22:24 rlrevell       Note Added: 0010406                          
06-21-06 22:33 mafm           Note Added: 0010407                          
06-21-06 22:48 eNTi           Note Added: 0010408                          
06-22-06 00:10 mafm           Note Added: 0010410                          
06-23-06 15:27 mafm           Note Added: 0010451                          
06-23-06 15:55 mafm           File Added: asus-a6km-fix.diff                    
06-23-06 16:23 mafm           Note Added: 0010454                          
06-24-06 09:12 eNTi           Note Added: 0010467                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
