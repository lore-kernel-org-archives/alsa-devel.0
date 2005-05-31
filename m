From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000006]: Machine locks up hard on rmmod snd_es1968
Date: Tue, 31 May 2005 18:02:15 +0200
Message-ID: <8ed07d31b819993706adf7b4644fbe40@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5E2221CC
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6> 
======================================================================
Reported By:                Hai
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   6
Category:                   PCI - es1968
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               SuSE 9.0
Kernel Version:             2.6.1-4-default
Resolution:                 suspended
Fixed in Version:           
======================================================================
Date Submitted:             01-27-2004 21:49 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    Machine locks up hard on rmmod snd_es1968
Description: 
When my init scripts rmmod snd_es1968 on shutdown, the machine locks up
completely. SysRq-[TPUS] all do not work, only SysRq-[OB] work. This means
I get an hang on every shutdown/reboot
======================================================================

----------------------------------------------------------------------
 tiwai - 01-28-04 15:23 
----------------------------------------------------------------------
the irq should be disabled in snd_es1968_reset(), which is called
before synchronize_irq().

as mentioned, the purpose of the patch is to disable the docking
station and the hw volume features, i suspect as the culprit.

----------------------------------------------------------------------
 perex - 03-09-04 18:43 
----------------------------------------------------------------------
No input from user.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-04 21:49 Hai            New Issue                                    
01-28-04 11:37 tiwai          Status                   new => assigned     
01-28-04 11:37 tiwai          Assigned To               => tiwai           
01-28-04 12:25 tiwai          Note Added: 0000015                          
01-28-04 12:26 tiwai          File Added: es1968-no-hwvol.dif                   

01-28-04 12:40 Hai            Note Added: 0000016                          
01-28-04 15:23 tiwai          Note Added: 0000017                          
03-09-04 18:43 perex          Status                   assigned => resolved
03-09-04 18:43 perex          Resolution               open => suspended   
03-09-04 18:43 perex          Assigned To              tiwai => perex      
03-09-04 18:43 perex          Note Added: 0000553                          
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
