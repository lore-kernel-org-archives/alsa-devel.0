From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000536]: Sound no longer works on IBM ThinkPad 600x after waking from sleep
Date: Mon, 17 Jan 2005 11:01:10 +0100
Message-ID: <5a3b4a11725b86f6b7a02cbd168fa498@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 36E6C193
	for <alsa-devel@alsa-project.org>; Mon, 17 Jan 2005 11:01:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=536> 
======================================================================
Reported By:                bkendig
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   536
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC2
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-24-2004 16:23 CEST
Last Modified:              01-17-2005 11:01 CET
======================================================================
Summary:                    Sound no longer works on IBM ThinkPad 600x after
waking from sleep
Description: 
After booting this laptop, sound works fine; but after putting the system
to sleep and waking it, sound will no longer work until the system is
rebooted.  No error messages are displayed.

This is an IBM ThinkPad 600x, which has a feature where it will cut power
to the PCI bus to save battery when the bus is not being used.  I believe
this is what's killing ALSA.

This system is running Fedora Core 2 with kernel version 2.6.9-rc2, but
the problem has occurred with every version of 2.6 since its release.

The sound modules can not be unloaded because the system believes they're
still in use. "/sbin/rmmod snd_cs46xx" returns "ERROR: Module snd_cs46xx
is in use".


======================================================================

----------------------------------------------------------------------
 tiwai - 10-01-04 17:07 
----------------------------------------------------------------------
It's a known problem of cs46xx driver with TP.

The driver should be able to be unloaded after resume.
The driver is in use most likley because some apps (e.g. mixer
or sound-server) is using it indeed.  Check which apps opening
/dev/snd/* and /dev/mixer*, /dev/dsp*, etc via fuser.

----------------------------------------------------------------------
 jdthood - 01-17-05 11:01 
----------------------------------------------------------------------
This is a duplicate of
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305.

> The sound modules can not be unloaded because the system believes
> they're still in use. "/sbin/rmmod snd_cs46xx" returns "ERROR:
> Module snd_cs46xx is in use".

You have to kill all applications that have sound devices open.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 16:23 bkendig        New Issue                                    
09-24-04 16:23 bkendig        Distribution              => FC2             
09-24-04 16:23 bkendig        Kernel Version            => 2.6.9-rc2       
10-01-04 17:07 tiwai          Note Added: 0002002                          
01-17-05 11:01 jdthood        Note Added: 0003228                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
