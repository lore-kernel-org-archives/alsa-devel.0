From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000742]: Control devices created before driver ready for devices to be opened
Date: Thu, 23 Dec 2004 13:03:22 +0100
Message-ID: <52385474cc651ea08d4887742a6405d0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 9960126B
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2004 13:03:22 +0100 (MET)
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
Last Modified:              12-23-2004 13:03 CET
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
 jdthood - 12-23-04 13:01 
----------------------------------------------------------------------
"/usr/sbin/alsactl: set_controls:986: snd_ctl_open error: No such device"

Details: I added "2>&1 | /usr/bin/logger -t $0" to the dev.d script.  Here
is what appears in the syslog:

Dec 23 12:55:23 thanatos udev[872]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 50 applied, 'timer' becomes
'snd/%k'
Dec 23 12:55:23 thanatos udev[872]: creating device node '/dev/snd/timer'
Dec 23 12:55:24 thanatos kernel: PCI: Found IRQ 11 for device
0000:00:06.0
Dec 23 12:55:24 thanatos kernel: PCI: Sharing IRQ 11 with 0000:00:02.0
Dec 23 12:55:24 thanatos kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Dec 23 12:55:24 thanatos udev[888]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 46 applied, 'controlC0' becomes
'snd/%k'
Dec 23 12:55:24 thanatos udev[888]: creating device node
'/dev/snd/controlC0'
Dec 23 12:55:24 thanatos /etc/dev.d/snd/controlC0/alsa-base.dev:
/usr/sbin/alsactl: set_controls:986: snd_ctl_open error: No such device
Dec 23 12:55:24 thanatos udev[901]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 49 applied, 'midiC0D0' becomes
'snd/%k'
Dec 23 12:55:24 thanatos udev[901]: creating device node
'/dev/snd/midiC0D0'
Dec 23 12:55:24 thanatos udev[909]: creating device node '/dev/midi'
Dec 23 12:55:25 thanatos udev[919]: creating device node '/dev/dmmidi'
Dec 23 12:55:25 thanatos udev[930]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0p' becomes
'snd/%k'
Dec 23 12:55:25 thanatos udev[930]: creating device node
'/dev/snd/pcmC0D0p'
Dec 23 12:55:25 thanatos udev[942]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0c' becomes
'snd/%k'
Dec 23 12:55:25 thanatos udev[942]: creating device node
'/dev/snd/pcmC0D0c'
Dec 23 12:55:25 thanatos udev[950]: creating device node '/dev/dsp'
Dec 23 12:55:25 thanatos udev[961]: creating device node '/dev/audio'
Dec 23 12:55:25 thanatos udev[970]: creating device node '/dev/mixer'

----------------------------------------------------------------------
 jdthood - 12-23-04 13:03 
----------------------------------------------------------------------
> I found the problematic part.

:)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-04 16:24 jdthood        New Issue                                    
12-22-04 16:59 tiwai          Note Added: 0002909                          
12-22-04 17:00 tiwai          File Added: control-device-fix.diff               
    
12-23-04 10:42 jdthood        Note Added: 0002911                          
12-23-04 12:05 tiwai          Note Added: 0002912                          
12-23-04 12:25 jdthood        Note Added: 0002913                          
12-23-04 12:35 tiwai          Note Added: 0002914                          
12-23-04 12:47 tiwai          Note Added: 0002915                          
12-23-04 12:48 jdthood        Note Added: 0002916                          
12-23-04 12:52 jdthood        Note Added: 0002917                          
12-23-04 12:54 tiwai          Note Added: 0002918                          
12-23-04 13:01 tiwai          Note Added: 0002919                          
12-23-04 13:01 jdthood        Note Added: 0002920                          
12-23-04 13:03 jdthood        Note Added: 0002921                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
