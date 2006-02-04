From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001632]: suse 10.0,  yast, no ad1986a listed,  in your soundcard list,  NO AD1986A  listed,.... asus, nothing,....
Date: Sat, 4 Feb 2006 02:19:21 +0100
Message-ID: <24b000781990cb2920e43e1c1dbc2acf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8C02D19F
	for <alsa-devel@alsa-project.org>; Sat,  4 Feb 2006 02:19:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1632> 
======================================================================
Reported By:                rsrtfm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1632
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               suse 10.0, super, opensuse
Kernel Version:             2.6.13
======================================================================
Date Submitted:             12-10-2005 04:29 CET
Last Modified:              02-04-2006 02:19 CET
======================================================================
Summary:                    suse 10.0,  yast, no ad1986a listed,  in your
soundcard list,  NO AD1986A  listed,.... asus, nothing,....
Description: 
suse 10.0,  yast, no ad1986a listed,  in your soundcard list,  NO AD1986A 
listed,.... asus, nothing,....

plus,  nic, needs nforce , nvidia driver,  chipset supposed to do sound
and nic,... but on asus board a8n-vm csm ,  6150, 430,....

anyway , should , list the ad1986a, and be able to select it.

so far I have no sound!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! it's been 4 weeks.
ehm,...what did you say,.. I can't hear anything,....
where do I donate , my money, and anger?
thanks, Robert Schultz
======================================================================

----------------------------------------------------------------------
 juliancola - 12-12-05 04:59 
----------------------------------------------------------------------
I have the same problem with FC4 and RHEL 4 ES, ASUS A8R-MVP onboard sound
chip AD1986A. At first time, I installed RHEL 4 ES ...the system hang at
"initialize hardware... network storage". Then I install FC4 , the hang
problem is gone, but system still can't detect my sound device....
When I used alsa-1.0.9b-driver , alsaconf can't dectect the AD1986A chip.
When I used alsa-1.0.10-driver , alsaconf can dectect one HD Audio.
But when I reboot system , it's hang on "initialize hardware ... network
storage audio" ......
Is this bug??

----------------------------------------------------------------------
 rbenech - 02-04-06 02:19 
----------------------------------------------------------------------
I concur that the default installation and upgraded installations
(alsa-1.0.9-23.i586.rpm) do not support the AD1986A driver.  Kernel
modules for previous AD18??? series drivers do not work.  I'm available
for testing.  I'll try the lasted from source, but I havn't found any
mention of AD1985 chipset.  I'm concerned that AD says that there is linux
support for this chipset - where?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-10-05 04:29 rsrtfm         New Issue                                    
12-10-05 04:29 rsrtfm         Distribution              => suse 10.0, super,
opensuse
12-10-05 04:29 rsrtfm         Kernel Version            => 2.6.13          
12-12-05 04:59 juliancola     Note Added: 0006982                          
02-04-06 02:15 rbenech        Issue Monitored: rbenech                     
02-04-06 02:19 rbenech        Note Added: 0007907                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
