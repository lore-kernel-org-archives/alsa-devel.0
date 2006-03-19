From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001850]: source available
Date: Sun, 19 Mar 2006 16:05:32 +0100
Message-ID: <8b0d4f6cfb8a949355ceaeeadff2d1f3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98DD01DC
	for <alsa-devel@alsa-project.org>; Sun, 19 Mar 2006 16:05:32 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1850> 
======================================================================
Reported By:                coz
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1850
Category:                   PCI - echoaudio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               ubuntu/breezy/Debian
Kernel Version:             2.6.12.10.386
======================================================================
Date Submitted:             02-16-2006 13:05 CET
Last Modified:              03-19-2006 16:05 CET
======================================================================
Summary:                    source available
Description: 
can't start layla24
======================================================================

----------------------------------------------------------------------
 pochini - 03-18-06 22:07 
----------------------------------------------------------------------
You can compile them in any order. I don't know what
alsa-source_1.0.10+1.0.11rc3 is. The notes I wrote are about the official
alsa releases only (ie. the files downloadable from alsa-project.org).
The hotplug interface is in the kernel, but it needs userspace programs to
work. Those hotlplug scripts are the official scripts but you can use any
other implementation. It is important that they look for firmware files
inside /lib/firmware/ . Btw, are you sure the driver can't find the
firmware (does "dmegs" show "Firmware not available" error message ?) ?



----------------------------------------------------------------------
 coz - 03-19-06 16:05 
----------------------------------------------------------------------
Hello,
 the alsa source package, in fact all packages were downloaded from the
official alsa site/ftp
   As I mentioned, I have no idea where to begin with this. i have gotten,
along with yur directions, conflicting procedures. Iread that the driver
has to be installed first, then the lib , then the tools etc.
  I will continue to look for help on some of the forums and irc channels.
I really hate to keep bothering you.
thanks
coz

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-06 13:05 coz            New Issue                                    
02-16-06 13:05 coz            Distribution              => ubuntu/breezy/Debian
02-16-06 13:05 coz            Kernel Version            => 2.6.12.10.386   
02-18-06 13:34 pochini        Note Added: 0008119                          
02-20-06 03:30 coz            Note Added: 0008140                          
02-20-06 22:02 pochini        Note Added: 0008150                          
03-13-06 19:49 coz            Note Added: 0008456                          
03-13-06 22:38 pochini        Note Added: 0008465                          
03-13-06 23:02 johnrigg       Note Added: 0008466                          
03-16-06 14:54 coz            Note Added: 0008605                          
03-18-06 22:02 pochini        Note Added: 0008676                          
03-18-06 22:07 pochini        Note Edited: 0008676                         
03-19-06 16:05 coz            Note Added: 0008690                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
