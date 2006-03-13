From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001850]: source available
Date: Mon, 13 Mar 2006 23:02:07 +0100
Message-ID: <514875322ecea4d5469223789ca4fb18@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47D4E1CF
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 23:02:07 +0100 (MET)
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
Last Modified:              03-13-2006 23:02 CET
======================================================================
Summary:                    source available
Description: 
can't start layla24
======================================================================

----------------------------------------------------------------------
 pochini - 03-13-06 22:38 
----------------------------------------------------------------------
After you try to load the module, type "dmesg" and check if there are error
messages.

alsa is distributed as sources. If you want binary drivers, ask Ubuntu.
It's impossible for me to provide binary drivers. Nvidia is a different
case because they don't disclose the sources (and IMHO it doesn't comply
with the GPL, but this is another story).

The most common problem with the drivers for Echoaudio cards is that the
user forgets to install alsa-firmware. And did alsa-driver compile and
install without problems ?

----------------------------------------------------------------------
 johnrigg - 03-13-06 23:02 
----------------------------------------------------------------------
No high end apps for recording on Linux?
http://ardour.org

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
