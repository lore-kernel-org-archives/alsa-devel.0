From: noreply@alsa-project.org
Subject: [ALSA - driver 0000006]: Machine locks up hard on rmmod snd_es1968
Date: Wed, 28 Jan 2004 12:40:14 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040128114014.F18DD30003@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate2.perex.cz (UNKNOWN@194.149.109.108.adsl.nextra.cz [194.149.109.108])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA09910
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2004 12:40:21 +0100
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


A BUGNOTE has been added to this bug.
======================================================================
http://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000006
======================================================================
Reporter:                   Hai
Handler:                    tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     6
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               SuSE 9.0
Kernel Version:             2.6.1-4-default
======================================================================
Date Submitted:             01-27-2004 21:49 CET
Last Modified:              01-28-2004 12:40 CET
======================================================================
Summary:                    Machine locks up hard on rmmod snd_es1968
Description: 
When my init scripts rmmod snd_es1968 on shutdown, the machine locks up
completely. SysRq-[TPUS] all do not work, only SysRq-[OB] work. This means
I get an hang on every shutdown/reboot
======================================================================

----------------------------------------------------------------------
 tiwai - 01-28-2004 12:25 CET 
----------------------------------------------------------------------
does it have a docking station?

also, please try the attached patch.  it will disable the
docking station and the hw volume.

----------------------------------------------------------------------
 Hai - 01-28-2004 12:40 CET 
----------------------------------------------------------------------
I had a docking station, but I lost it a few years ago. Will try the
patch.

However, I can see no point where you disable the interrupts from the chip
during shutdown. So I doubt synchronize_irq() in the shutdown path is
going to be enough.

OTOH, maybe I haven't read the soure thoroughly enough.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:49 Hai            New Bug                                      
01-28-04 11:37 tiwai          Assigned To               => tiwai           
01-28-04 11:37 tiwai          Status                   new => assigned     
01-28-04 12:25 tiwai          Bugnote Added: 0000015                       
01-28-04 12:26 tiwai          File Added: es1968-no-hwvol.dif                    
01-28-04 12:40 Hai            Bugnote Added: 0000016                       
======================================================================


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
