From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001850]: source available
Date: Sat, 18 Mar 2006 22:02:43 +0100
Message-ID: <3da56bb9822e4bc5526029ae16cf4757@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CD90D1D8
	for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2006 22:02:43 +0100 (MET)
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
Last Modified:              03-18-2006 22:02 CET
======================================================================
Summary:                    source available
Description: 
can't start layla24
======================================================================

----------------------------------------------------------------------
 coz - 03-16-06 14:54 
----------------------------------------------------------------------
Hello, yes the driver compiles without any problems.
 i reinstalled dapper. I have downloded these files;
alsa-driver-1.0.11rc3
alsa-source_1.0.10+1.0.11rc3
alsa-firmware-1.0.11rc3
alsa-tools-1.0.11rc3
alsa-utils-1.0.11rc3
 in which order are these installed?
Can I then follow your sites how to listed under Layla24?
   The second how to on your site, listed under Layla24 talks of hotplug
scripts but according to ubuntu scripts/init has been removed because it
is taken care of by kernel.
 So at least that part of the how to is out of date.
 I apologize for my ingorance around this issue. i am in no way trying to
tax your patience. I am sure that this is not exactly what you like to
do.
Ardour, apparently my client is aware of this and one reason he wasnts his
layla card with ubuntu.
 I have donwloade it to take a look at it. 
Thanks

----------------------------------------------------------------------
 pochini - 03-18-06 22:02 
----------------------------------------------------------------------
You can compile them in any order. I don't know what 
alsa-source_1.0.10+1.0.11rc3 is. If the notes I wrote I refer to the
official alsa releases only (the files downloadable from
alsa-project.org).
The hotplug interface is in the kernel, but it needs userspace programs to
work. Those hutlplug script are the official scripts but you can use any
other implementation. It is important that they look for firmware files
inside /lib/firmware/ . Btw, are you sure the driver can't find the
firmware (does "dmegs" show "Firmware not available" error message ?) ?

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
