From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000742]: Control devices created before driver ready for devices to be opened
Date: Wed, 22 Dec 2004 16:24:14 +0100
Message-ID: <b7c0bca6d64c00cd00e1851578157f4a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 254091F7
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2004 16:24:15 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              12-22-2004 16:24 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-04 16:24 jdthood        New Issue                                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
