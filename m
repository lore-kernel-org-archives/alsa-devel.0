From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001973]: No sound after userspace doing something
Date: Fri, 31 Mar 2006 20:38:37 +0200
Message-ID: <eccd27b8d57e5d82522327a1d10121bf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CA10169
	for <alsa-devel@alsa-project.org>; Fri, 31 Mar 2006 20:38:37 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1973> 
======================================================================
Reported By:                alonbl
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1973
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.16
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-28-2006 14:19 CEST
Last Modified:              03-31-2006 20:38 CEST
======================================================================
Summary:                    No sound after userspace doing something
Description: 
I upgraded 2.6.15 to 2.6.16.
All worked OK in 2.6.15.

After boot there is no sound and no errors.
As root aplay do not work.
Stop start alsa/unload load modules does not help.

BUT!!! After executing alsaconf sound turned on (Until next reboot...)

Now... The strange thing...
After login into KDE with REGULAR user, sound stops working.
Doing alsaconf magic (WHILE in KDE session) and restart sound in KDE turns
sound on again...

Logut from KDE, relogin... No sound... alsaconf again works...

I've tried the in kernel ASLA and the same...
I've tried the user mode 1.0.10 and the same...

Can anyone confirm?
I use intel8x0 on IBM T42.

I am not sure which component this problem relate to... But it seems like
the kernel is the difference.
======================================================================

----------------------------------------------------------------------
 alonbl - 03-31-06 19:40 
----------------------------------------------------------------------
This issue was solved by recompilation and removing all the KDE ALSA
related stuff... I guess thaere were some leftovers of old alsa.

How do I close this issue?

----------------------------------------------------------------------
 rlrevell - 03-31-06 20:38 
----------------------------------------------------------------------
KDE or distro bug (mixer settings not being loaded or incorrect settings
loaded)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-28-06 14:19 alonbl         New Issue                                    
03-28-06 14:19 alonbl         Distribution              => gentoo          
03-28-06 14:19 alonbl         Kernel Version            => 2.6.16          
03-28-06 20:56 alonbl         Issue Monitored: alonbl                      
03-31-06 19:40 alonbl         Note Added: 0009046                          
03-31-06 20:38 rlrevell       Status                   new => closed       
03-31-06 20:38 rlrevell       Note Added: 0009047                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
