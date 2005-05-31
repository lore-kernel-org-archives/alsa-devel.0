From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000876]: Crashes on suspend or standby
Date: Tue, 31 May 2005 18:04:15 +0200
Message-ID: <011b6239b572d2875dc889ff99850803@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4CB681B4
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:04:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=876> 
======================================================================
Reported By:                sleepkreep
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   876
Category:                   CORE - control
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               SuSE
Kernel Version:             2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-01-2005 19:56 CET
Last Modified:              05-31-2005 18:04 CEST
======================================================================
Summary:                    Crashes on suspend or standby
Description: 
When using APM to standby or suspend the computer, alsa crashes.  As far as
I can tell, The alsa deamon doesn't crash, but the sound driver does. I
can't determine if this is actually the case. I haven't tried it with
acpi, but I imagine the result would be the same.  Currently I have SuSE's
powersave deamon shutting down alsa on suspend or standby, and then
restarting it on resume.  This works fine, but all my apps that were
running crash with alsa's shutdown.  This is annoying. I can't find
anybody with the same problem.  
======================================================================

----------------------------------------------------------------------
 sleepkreep - 02-03-05 02:19 
----------------------------------------------------------------------
Problem Solved.  Turns out in Yast sound configuration the power management
option wasn't configurable.  So after I configured it in the config file,
adding use_pm=1, it works. There are still a few problems with the apps,
but I think they are bugs in the apps themselves.  XMMS deosn't resume
playing after resuming suspend, but it will if I restart the current file.
 I have to restart amarok if using the arts deamon but amarok works fine
if using the xine engine.  That's all that I've noticed so far.  This is
also after I updated to 1.0.8. Keep up the good work guys.

----------------------------------------------------------------------
 tiwai - 02-04-05 13:11 
----------------------------------------------------------------------
The resume problem of xmms is the problem of xmms ALSA output plugin.
It got fixed in the xmms CVS version, AFAIK.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-05 19:56 sleepkreep     New Issue                                    
02-01-05 19:56 sleepkreep     Distribution              => SuSE            
02-01-05 19:56 sleepkreep     Kernel Version            => 2.6.7           
02-02-05 10:51 tiwai          Note Added: 0003479                          
02-02-05 23:16 sleepkreep     Note Added: 0003491                          
02-03-05 02:19 sleepkreep     Note Added: 0003492                          
02-04-05 13:11 tiwai          Status                   new => resolved     
02-04-05 13:11 tiwai          Resolution               open => fixed       
02-04-05 13:11 tiwai          Assigned To               => tiwai           
02-04-05 13:11 tiwai          Note Added: 0003502                          
02-04-05 13:11 tiwai          Assigned To              tiwai =>            
05-31-05 18:04 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
