From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001850]: source available
Date: Sat, 25 Mar 2006 12:04:37 +0100
Message-ID: <419834970a550a2b71b529aa783d6cc2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D2C84184
	for <alsa-devel@alsa-project.org>; Sat, 25 Mar 2006 12:04:37 +0100 (MET)
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
Last Modified:              03-25-2006 12:04 CET
======================================================================
Summary:                    source available
Description: 
can't start layla24
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 02:48 
----------------------------------------------------------------------
What is CONFIG_FW_LOADER set to in your kernel config?

----------------------------------------------------------------------
 pochini - 03-25-06 12:04 
----------------------------------------------------------------------
You can also try to enable debugging in alsa-driver by passing the
"--with-debug=full" option to configure. It make the driver print a lot of
stuff in the system logs. Maybe when you load the module it prints
something useful.
Also, make sure the modules are installed (dir
/lib/modules/2.6.14.2/kernel/sound/pci/echoaudio/ (you kernel version may
differ)) and the firmware binaries are installed (dir /lib/firmware/ea/).
Type "modprobe snd-<yourcard>" and then "dmesg" to see the debug messages.
You may need to unload the modules if they're already loaded. Use "lsmod"
to the the list and "modprobe -r <name>" to onload a module.

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
03-20-06 22:10 pochini        Note Added: 0008725                          
03-22-06 02:38 coz            Note Added: 0008781                          
03-22-06 02:48 rlrevell       Note Added: 0008787                          
03-25-06 12:04 pochini        Note Added: 0008945                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
