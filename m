From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000742]: Control devices created before driver ready for devices to be opened
Date: Mon, 31 Jan 2005 19:05:01 +0100
Message-ID: <37f9152e77ce2580789069942bc464b3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E9A8C235
	for <alsa-devel@alsa-project.org>; Mon, 31 Jan 2005 19:05:01 +0100 (MET)
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
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-22-2004 16:24 CET
Last Modified:              01-31-2005 19:05 CET
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
 jdthood - 12-23-04 20:39 
----------------------------------------------------------------------
FYI here is how my syslog looks now (with your second patch):

Dec 23 20:26:05 thanatos udev[28891]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 50 applied, 'timer' becomes
'snd/%k'
Dec 23 20:26:05 thanatos udev[28891]: creating device node
'/dev/snd/timer'
Dec 23 20:26:06 thanatos kernel: PCI: Found IRQ 11 for device
0000:00:06.0
Dec 23 20:26:06 thanatos kernel: PCI: Sharing IRQ 11 with 0000:00:02.0
Dec 23 20:26:06 thanatos kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Dec 23 20:26:06 thanatos udev[28910]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 49 applied, 'midiC0D0' becomes
'snd/%k'
Dec 23 20:26:06 thanatos udev[28910]: creating device node
'/dev/snd/midiC0D0'
Dec 23 20:26:06 thanatos udev[28918]: creating device node '/dev/midi'
Dec 23 20:26:06 thanatos udev[28928]: creating device node '/dev/dmmidi'
Dec 23 20:26:07 thanatos udev[28936]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0p' becomes
'snd/%k'
Dec 23 20:26:07 thanatos udev[28936]: creating device node
'/dev/snd/pcmC0D0p'
Dec 23 20:26:07 thanatos udev[28948]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0c' becomes
'snd/%k'
Dec 23 20:26:07 thanatos udev[28948]: creating device node
'/dev/snd/pcmC0D0c'
Dec 23 20:26:07 thanatos udev[28958]: creating device node '/dev/dsp'
Dec 23 20:26:07 thanatos udev[28966]: creating device node '/dev/audio'
Dec 23 20:26:07 thanatos udev[28978]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 46 applied, 'controlC0' becomes
'snd/%k'
Dec 23 20:26:07 thanatos udev[28978]: creating device node
'/dev/snd/controlC0'
Dec 23 20:26:07 thanatos udev[28988]: creating device node '/dev/mixer'

----------------------------------------------------------------------
 tiwai - 12-27-04 15:28 
----------------------------------------------------------------------
Thanks for the confirmation.  The patch was applied to CVS.

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
12-23-04 14:56 tiwai          Note Added: 0002922                          
12-23-04 14:57 tiwai          File Added: control-device-fix2.diff              
     
12-23-04 20:31 jdthood        Note Added: 0002928                          
12-23-04 20:39 jdthood        Note Added: 0002929                          
12-27-04 15:28 tiwai          Status                   new => resolved     
12-27-04 15:28 tiwai          Resolution               open => fixed       
12-27-04 15:28 tiwai          Assigned To               => tiwai           
12-27-04 15:28 tiwai          Note Added: 0002963                          
12-27-04 15:28 tiwai          Assigned To              tiwai =>            
01-31-05 19:05 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
