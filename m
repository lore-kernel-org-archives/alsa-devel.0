From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002008]: No Sound with snd-hda-intel driver Asus P5VDC-MX
Date: Sat, 22 Apr 2006 14:02:53 +0200
Message-ID: <362bef39788eba736d22d6762912a74a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 15FB717E
	for <alsa-devel@alsa-project.org>; Sat, 22 Apr 2006 14:02:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2008> 
======================================================================
Reported By:                mborsick
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2008
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Redhat/Fedora
Kernel Version:             2.6.16-1.2080 and with Xen
======================================================================
Date Submitted:             04-07-2006 00:43 CEST
Last Modified:              04-22-2006 14:02 CEST
======================================================================
Summary:                    No Sound with snd-hda-intel driver Asus P5VDC-MX
Description: 
Kernel is up-to-date Xen kernel.

Initial install did not recognize the sound on an ASUS P5VDC-MX
motherboard.
Motherboard has southbridge VIA VT8251. CODEC is Realtek ACL653 AC'97 6
channel
Audio. Tried the updated drivers in 002404, but was unsuccessful. Also
tried
drivers on VIA site and Realltek site. The last couple of tries show no
errors
in compiling, make, etc. However, as I am just above novice in
understanding
everything about Linux, this has thrown me for a loop.

======================================================================

----------------------------------------------------------------------
 buboleck - 04-09-06 01:21 
----------------------------------------------------------------------
:) yes please

----------------------------------------------------------------------
 buboleck - 04-22-06 14:02 
----------------------------------------------------------------------
Hi again. I'm glad to report that I got it to work. With kernel
gentoo-2.6.16-r3 and alsa-driver-1.0.11. Currently is working on x86_64, 2
chanels (I have to rearange to check for 4 and 6), maybe later I check on
i386 too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 00:43 mborsick       New Issue                                    
04-07-06 00:43 mborsick       Distribution              => Redhat/Fedora   
04-07-06 00:43 mborsick       Kernel Version            => 2.6.16-1.2080 and
with Xen
04-07-06 01:07 rlrevell       Note Added: 0009129                          
04-07-06 02:13 mborsick       Note Added: 0009130                          
04-07-06 02:35 rlrevell       Note Added: 0009131                          
04-07-06 06:38 mborsick       Note Added: 0009135                          
04-07-06 22:45 buboleck       Note Added: 0009156                          
04-07-06 22:47 buboleck       Note Edited: 0009156                         
04-07-06 22:49 buboleck       Note Edited: 0009156                         
04-07-06 23:06 rlrevell       Note Added: 0009157                          
04-07-06 23:16 buboleck       Issue Monitored: buboleck                    
04-07-06 23:26 buboleck       Note Added: 0009158                          
04-07-06 23:32 rlrevell       Note Added: 0009159                          
04-07-06 23:39 buboleck       Note Added: 0009160                          
04-07-06 23:40 buboleck       Note Edited: 0009160                         
04-07-06 23:43 buboleck       Note Edited: 0009160                         
04-07-06 23:46 buboleck       Note Edited: 0009160                         
04-07-06 23:47 rlrevell       Note Added: 0009161                          
04-07-06 23:52 buboleck       Note Added: 0009162                          
04-08-06 00:02 rlrevell       Note Added: 0009163                          
04-08-06 00:16 buboleck       Note Added: 0009164                          
04-08-06 00:19 buboleck       Note Added: 0009165                          
04-08-06 00:29 rlrevell       Note Added: 0009166                          
04-08-06 00:32 buboleck       Note Added: 0009167                          
04-08-06 00:41 rlrevell       Note Added: 0009168                          
04-08-06 00:42 buboleck       Note Added: 0009169                          
04-08-06 00:44 buboleck       Note Edited: 0009169                         
04-08-06 22:30 mborsick       Note Added: 0009173                          
04-09-06 01:21 buboleck       Note Added: 0009174                          
04-22-06 14:02 buboleck       Note Added: 0009434                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
