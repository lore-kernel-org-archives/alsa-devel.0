From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000876]: Crashes on suspend or standby
Date: Thu, 3 Feb 2005 02:19:29 +0100
Message-ID: <bb41c96f3600403b7370ce603d95b7fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E57CD215
	for <alsa-devel@alsa-project.org>; Thu,  3 Feb 2005 02:19:29 +0100 (MET)
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
Status:                     new
Distribution:               SuSE
Kernel Version:             2.6.7
======================================================================
Date Submitted:             02-01-2005 19:56 CET
Last Modified:              02-03-2005 02:19 CET
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
 sleepkreep - 02-02-05 23:16 
----------------------------------------------------------------------
Sorry, I specified the wrong kernel version.  My kernel version is
2.6.5-7.111.30 .  I am using an ESS ES1978 card with snd-es1968 driver.  I
will try the latest version of alsa and report back.

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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-01-05 19:56 sleepkreep     New Issue                                    
02-01-05 19:56 sleepkreep     Distribution              => SuSE            
02-01-05 19:56 sleepkreep     Kernel Version            => 2.6.7           
02-02-05 10:51 tiwai          Note Added: 0003479                          
02-02-05 23:16 sleepkreep     Note Added: 0003491                          
02-03-05 02:19 sleepkreep     Note Added: 0003492                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
