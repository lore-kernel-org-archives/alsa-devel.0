From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000742]: Control devices created before driver ready for devices to be opened
Date: Thu, 23 Dec 2004 12:25:55 +0100
Message-ID: <913d7cc09d26b141bbf72fa931bcc5c4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1678526B
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2004 12:25:56 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=742> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   742
Category:                   CORE - control
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-22-2004 16:24 CET
Last Modified:              12-23-2004 12:25 CET
======================================================================
Summary:                    Control devices created before driver ready for
devices to be opened
Description: 
"alsactl restore" is run by a dev script, which is run by udev, which is
run by hotplug, which is run by the kernel when /dev/snd/controlC0 is
created.  Multiple users are reporting that this fails.  However, "alsactl
restore" does not fail when run from the command line.  It helps to add a
"sleep" to the dev script.  This leads one to the conclusion that there is
a race condition: the driver is creating the device file before it is
ready for the file to be opened.

In Debian bug report
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=279325 the submitter
reports this behavior:
>     /usr/sbin/alsactl: set_controls:986: snd_ctl_open error: No such
device
> This is the code which fails, from set_controls() in
> alsa-utils-1.0.7/alsactl/alsactl.c:
>
>        sprintf(name, "hw:%d", card);
>        err = snd_ctl_open(&handle, name, 0);
>        if (err < 0) {
>                error("snd_ctl_open error: %s", snd_strerror(err));
>                return err;
>        }

I get messages like this in my syslog:
> Dec 22 15:05:09 thanatos kernel:
> ALSA /usr/src/modules/alsa-driver/alsa-kernel/p
ci/cs46xx/cs46xx_lib.c:413:
> cs46xx: failure waiting for FIFO command to complete

-- 
Thomas Hood
======================================================================

----------------------------------------------------------------------
 tiwai - 12-23-04 12:05 
----------------------------------------------------------------------
This can't be fixed from the driver side.  It's a problem of udev.
udev is triggered assynchronously from the modprobe caller. As a result,
alsactl is called before udev is finished.

Unfortunately, there is no way to synchronize udev operation.  The
solution would be to use hotplug to configure the sound stuff instead of
static init script.

----------------------------------------------------------------------
 jdthood - 12-23-04 12:25 
----------------------------------------------------------------------
> This can't be fixed from the driver side. It's a problem of udev.
> udev is triggered assynchronously from the modprobe caller.

No, it is run by hotplug.  It really does need to be fixed in the kernel.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-04 16:24 jdthood        New Issue                                    
12-22-04 16:59 tiwai          Note Added: 0002909                          
12-22-04 17:00 tiwai          File Added: control-device-fix.diff               
    
12-23-04 10:42 jdthood        Note Added: 0002911                          
12-23-04 12:05 tiwai          Note Added: 0002912                          
12-23-04 12:25 jdthood        Note Added: 0002913                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
