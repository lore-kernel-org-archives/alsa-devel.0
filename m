From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001850]: source available
Date: Mon, 13 Mar 2006 22:38:23 +0100
Message-ID: <8ca0425f15ce9284713a6905f27f572b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF7E81CF
	for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2006 22:38:23 +0100 (MET)
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
Last Modified:              03-13-2006 22:38 CET
======================================================================
Summary:                    source available
Description: 
can't start layla24
======================================================================

----------------------------------------------------------------------
 coz - 03-13-06 19:49 
----------------------------------------------------------------------
hello, ALL suggestions, including a guy that actually is part of the Ubuntu
team who walked me through the installation, were unsuccesful. This
layla24 is in excellent working condition. RUns fine on XP.
 Try to install the drivers for ubuntu dapper and all I get is "---no
soundcard found---" 
   I realize this is not a common card in use since it is considered pro
sound, however wouldn't it be just as easy having a single install package
that will install the drivers?
  I am not aprogrammer so forgive the naive statement, but nvivida has a
package that installs, just a copnfig enable does the trick. i am not
clear why this is not like that.
  unfortunately this is for a client. He wants his layla14 installed on
ubuntu Dapper, even after telling him there are nohighend apps for
recording in linux.
He has insisted.
 However, i still cannot get the darn thing to work.
 The system recognizes the chip on the layla24 card and that is is.
It does not recognize the card at all.
 Thanks

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
