From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000536]: Sound no longer works on IBM ThinkPad 600x after waking from sleep
Date: Fri,  1 Oct 2004 17:07:44 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041001150744.02B052D0C1@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6E72A24B
	for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2004 17:07:44 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000536
======================================================================
Reported By:                bkendig
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     536
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               FC2
Kernel Version:             2.6.9-rc2
======================================================================
Date Submitted:             09-24-2004 16:23 CEST
Last Modified:              10-01-2004 17:07 CEST
======================================================================
Summary:                    Sound no longer works on IBM ThinkPad 600x after waking from sleep
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
 tiwai - 10-01-2004 17:07 CEST 
----------------------------------------------------------------------
It's a known problem of cs46xx driver with TP.

The driver should be able to be unloaded after resume.
The driver is in use most likley because some apps (e.g. mixer
or sound-server) is using it indeed.  Check which apps opening
/dev/snd/* and /dev/mixer*, /dev/dsp*, etc via fuser.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-24-04 16:23 bkendig        New Bug                                      
09-24-04 16:23 bkendig        Distribution              => FC2             
09-24-04 16:23 bkendig        Kernel Version            => 2.6.9-rc2       
10-01-04 17:07 tiwai          Bugnote Added: 0002002                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
