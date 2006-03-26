From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001898]: no sound from headphones or speakers on asus a6km laptop
Date: Sun, 26 Mar 2006 21:56:06 +0200
Message-ID: <504f285cb20ead4ddee7f1ffcaf2b203@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BEEBB1EA
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 21:56:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898> 
======================================================================
Reported By:                kiwi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1898
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 5 test3
Kernel Version:             2.6.15-1.2009.4.2_FC5
======================================================================
Date Submitted:             03-09-2006 00:30 CET
Last Modified:              03-26-2006 21:56 CEST
======================================================================
Summary:                    no sound from headphones or speakers on asus a6km
laptop
Description: 
The headphone port and the speakers just don't work. Seems like there is
some control hidden in the mixer which is muted. 
By setting the master and pcm volume at 100% I can hear just some static
on song beats only on headphones. Speakers always stay mute.
I can only get sound by attaching the headphones to line-in and enabling
"shared" surround mode.

Same issues with a knoppix 4.0.2.

======================================================================

----------------------------------------------------------------------
 kiwi - 03-24-06 19:22 
----------------------------------------------------------------------
It works for me too, I already said that in the original bugreport.

----------------------------------------------------------------------
 kiwi - 03-26-06 21:56 
----------------------------------------------------------------------
I tried the istructions from this old post:
http://sourceforge.net/mailarchive/forum.php?thread_id=8072079&forum_id=1752
and it WORKS!
I used this command: echo "7a 57c1" >
/proc/asound/card0/codec97#0/ac97#0-0+regs to enable bit 1 (counting from
0) of register 7a.
Note that to try that you will likely need to recompile alsa with
--debug=full.
I already did this before and didn't worked.  Weird. Maybe that time I
messed too much with other registers, or maybe it's because of the newer
alsa version (1.0.11rc4).
Lineout and headphones works too, and speakers automatically switch off
when I attach the headphones.
Note I only hear sound with External Amplifier checked (not muted).
Here is the registers dump when working:
# cat /proc/asound/card0/codec97#0/ac97#0-0+regs
0:00 = 5980
0:02 = 1313
0:04 = 0000
0:06 = 0000
0:08 = 0000
0:0a = 0000
0:0c = 0000
0:0e = 0040
0:10 = 0000
0:12 = 0000
0:14 = 0000
0:16 = 0000
0:18 = 0606
0:1a = 0707
0:1c = 0000
0:1e = 0000
0:20 = 0000
0:22 = 0000
0:24 = 0000
0:26 = 000f
0:28 = 05c7
0:2a = 01f5
0:2c = ac44
0:2e = ac44
0:30 = ac44
0:32 = bb80
0:34 = 0000
0:36 = 0000
0:38 = 0000
0:3a = 0824
0:3c = 0000
0:3e = 0000
0:40 = 0000
0:42 = 0000
0:44 = 0000
0:46 = 0000
0:48 = 0000
0:4a = 0000
0:4c = 0000
0:4e = 0000
0:50 = 0000
0:52 = 0000
0:54 = 0000
0:56 = 0000
0:58 = 0000
0:5a = 0000
0:5c = 0000
0:5e = 0000
0:60 = 0000
0:62 = 0000
0:64 = 0808
0:66 = 0808
0:68 = 0000
0:6a = 520f
0:6c = 0000
0:6e = 0025
0:70 = 0231
0:72 = 00a0
0:74 = 0043
0:76 = 0001
0:78 = 8102
0:7a = 57c1
0:7c = 414c
0:7e = 4720

Now I'm rebooting to see if this is reproducible.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-06 00:30 kiwi           New Issue                                    
03-09-06 00:30 kiwi           Distribution              => Fedora Core 5 test3
03-09-06 00:30 kiwi           Kernel Version            => 2.6.15-1.2009.4.2_FC5
03-09-06 16:26 kiwi           Issue Monitored: kiwi                        
03-09-06 16:41 kiwi           Note Added: 0008391                          
03-09-06 20:09 michele26x1    Note Added: 0008396                          
03-09-06 21:02 kiwi           Note Added: 0008397                          
03-11-06 14:35 hongqn         Issue Monitored: hongqn                      
03-12-06 15:49 kiwi           Note Added: 0008432                          
03-12-06 16:40 Rollsappletree Note Added: 0008433                          
03-13-06 10:10 u238           Note Added: 0008439                          
03-13-06 10:11 u238           Note Edited: 0008439                         
03-13-06 10:12 u238           Note Edited: 0008439                         
03-13-06 23:59 lbenini        Note Added: 0008469                          
03-23-06 13:56 lbenini        Note Added: 0008881                          
03-23-06 13:59 lbenini        Note Edited: 0008881                         
03-24-06 19:22 kiwi           Note Added: 0008934                          
03-26-06 21:56 kiwi           Note Added: 0008975                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
