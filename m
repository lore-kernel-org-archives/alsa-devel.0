From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001662]: No audio output in a laptop with hda-intel....
Date: Sat, 4 Mar 2006 10:45:16 +0100
Message-ID: <83f09f1886456a1827676c3deb771064@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D514111F
	for <alsa-devel@alsa-project.org>; Sat,  4 Mar 2006 10:45:16 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1662> 
======================================================================
Reported By:                shl
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1662
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.6.13.4
======================================================================
Date Submitted:             12-20-2005 11:18 CET
Last Modified:              03-04-2006 10:45 CET
======================================================================
Summary:                    No audio output in a laptop with hda-intel....
Description: 
Hy, I managed to install the hda-intel on my laptop but my big problem is
:
The speakers inside the laptop work correctly but everytime I try to plug
a headset or some external speaker in the output used normally for it, I'd
the same result : no sound in the laptop'speakers AND no sound at all in
the external speakers. So after looking a long long time about that
problem, I didn't find anything. So maybe the function is not yet
implemented ? If it's the case, is it possible to do it because it'll be
very usefull for a lot of people ! Thanks for advance and don't hesitate
to send me a mail if I missed something ...


======================================================================

----------------------------------------------------------------------
 nutz - 03-04-06 03:32 
----------------------------------------------------------------------
man i love you!

we've been trying to fix this issue for months - a friend of mine and me
on his laptop.
thank you soooooooooo much!!!!
finally this system is a-okay. thanks thanks thanks thanks thanks!

----------------------------------------------------------------------
 er-ku - 03-04-06 10:45 
----------------------------------------------------------------------
Actually, you can help the developers make the module autodetect the card.
All you have to do is to provide a tiny bit of information they need.
Here's how:

1) go to terminal, and run "lspci" in it. You'll get a list of your PCI
devices.

2) find your audio device in it. An example:
0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High
Definition Audio Controller (rev 04)

note the numbers at the beginning of the line.

3) run the commands:
"lspci -vs num:num" and "lcpci -nvs num:num" , where "num:num" are the
numbers you noted previously (without "0000:", and without the trailing
number after the dot). You should get something like this:

$ lspci -vs 00:1b
00:1b.0 Class 0403: Intel Corp.: Unknown device 2668 (rev 04)
    Subsystem: Fujitsu Limited.: Unknown device 1326
    Flags: bus master, fast devsel, latency 0, IRQ 17
    Memory at b0000000 (64-bit, non-prefetchable) [size=16k]
    Capabilities: <available only to root>

$ lspci -nvs 00:1b
00:1b.0 Class 0403: 8086:2668 (rev 04)
    Subsystem: 10cf:1326
    Flags: bus master, fast devsel, latency 0, IRQ 17
    Memory at b0000000 (64-bit, non-prefetchable) [size=16k]
    Capabilities: <available only to root>

4) paste the output as a comment here, in this bugreport. Also, please
check if all the controls in  mixer are working as expected, and tell if
they are.

After you do all this, you may expect the driver to work automagically,
without tweaking the modules.d/alsa next time.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 11:18 shl            New Issue                                    
12-20-05 11:18 shl            Distribution              => Gentoo Linux    
12-20-05 11:18 shl            Kernel Version            => 2.6.13.4        
12-20-05 11:19 shl            Issue Monitored: shl                         
12-20-05 11:19 shl            Issue End Monitor: shl                       
12-23-05 01:59 shl            Issue Monitored: shl                         
12-23-05 02:04 shl            Note Added: 0007130                          
01-08-06 13:54 JeanJean       Note Added: 0007525                          
01-08-06 14:06 JeanJean       Note Edited: 0007525                         
03-04-06 03:32 nutz           Note Added: 0008345                          
03-04-06 10:45 er-ku          Note Added: 0008347                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
