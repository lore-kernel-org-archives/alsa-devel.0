From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000742]: Control devices created before driver ready for devices to be opened
Date: Thu, 23 Dec 2004 12:05:06 +0100
Message-ID: <eefd0cd6a1cfec6388cbdb430639afd2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 348B2262
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2004 12:05:07 +0100 (MET)
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
Last Modified:              12-23-2004 12:05 CET
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
 jdthood - 12-23-04 10:42 
----------------------------------------------------------------------
I have tried the patch but it does not solve the problem.  I still need a
"sleep 1" in the dev script; otherwise "alsactl restore" is not
effective.

The following snippets from my syslog may be helpful to you.

BEFORE applying your patch:

Dec 23 08:18:44 thanatos udev[27880]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 46 applied, 'controlC0' becomes
'snd/%k'
Dec 23 08:18:44 thanatos udev[27880]: creating device node
'/dev/snd/controlC0'
Dec 23 08:18:44 thanatos udev[27888]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 50 applied, 'timer' becomes
'snd/%k'
Dec 23 08:18:44 thanatos udev[27888]: creating device node
'/dev/snd/timer'
[... other lines unrelated to sound ...]
Dec 23 08:18:44 thanatos kernel: PCI: Found IRQ 11 for device
0000:00:06.0
Dec 23 08:18:44 thanatos kernel: PCI: Sharing IRQ 11 with 0000:00:02.0
Dec 23 08:18:44 thanatos kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Dec 23 08:18:45 thanatos udev[27974]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 49 applied, 'midiC0D0' becomes
'snd/%k'
Dec 23 08:18:45 thanatos udev[27974]: creating device node
'/dev/snd/midiC0D0'
Dec 23 08:18:45 thanatos udev[27981]: creating device node '/dev/midi'
Dec 23 08:18:45 thanatos udev[27998]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0p' becomes
'snd/%k'
Dec 23 08:18:45 thanatos udev[27986]: creating device node '/dev/dmmidi'
Dec 23 08:18:45 thanatos udev[27998]: creating device node
'/dev/snd/pcmC0D0p'
Dec 23 08:18:45 thanatos udev[28006]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0c' becomes
'snd/%k'
Dec 23 08:18:45 thanatos udev[28006]: creating device node
'/dev/snd/pcmC0D0c'
Dec 23 08:18:45 thanatos udev[28018]: creating device node '/dev/dsp'
Dec 23 08:18:45 thanatos udev[28028]: creating device node '/dev/audio'
Dec 23 08:18:45 thanatos udev[28038]: creating device node '/dev/mixer'


AFTER applying your patch:

Dec 23 10:22:47 thanatos udev[21027]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 50 applied, 'timer' becomes
'snd/%k'
Dec 23 10:22:47 thanatos udev[21027]: creating device node
'/dev/snd/timer'
Dec 23 10:22:47 thanatos kernel: PCI: Found IRQ 11 for device
0000:00:06.0
Dec 23 10:22:47 thanatos kernel: PCI: Sharing IRQ 11 with 0000:00:02.0
Dec 23 10:22:47 thanatos kernel: PCI: Sharing IRQ 11 with 0000:01:00.0
Dec 23 10:22:47 thanatos udev[21045]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 46 applied, 'controlC0' becomes
'snd/%k'
Dec 23 10:22:47 thanatos udev[21045]: creating device node
'/dev/snd/controlC0'
Dec 23 10:22:48 thanatos udev[21059]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 49 applied, 'midiC0D0' becomes
'snd/%k'
Dec 23 10:22:48 thanatos udev[21059]: creating device node
'/dev/snd/midiC0D0'
Dec 23 10:22:48 thanatos udev[21067]: creating device node '/dev/midi'
Dec 23 10:22:48 thanatos udev[21079]: creating device node '/dev/dmmidi'
Dec 23 10:22:48 thanatos udev[21087]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0p' becomes
'snd/%k'
Dec 23 10:22:48 thanatos udev[21087]: creating device node
'/dev/snd/pcmC0D0p'
Dec 23 10:22:48 thanatos udev[21099]: configured rule in
'/etc/udev/rules.d/udev.rules' at line 48 applied, 'pcmC0D0c' becomes
'snd/%k'
Dec 23 10:22:48 thanatos udev[21099]: creating device node
'/dev/snd/pcmC0D0c'
Dec 23 10:22:48 thanatos udev[21107]: creating device node '/dev/dsp'
Dec 23 10:22:48 thanatos udev[21119]: creating device node '/dev/audio'
Dec 23 10:22:48 thanatos udev[21127]: creating device node '/dev/mixer'

----------------------------------------------------------------------
 tiwai - 12-23-04 12:05 
----------------------------------------------------------------------
This can't be fixed from the driver side.  It's a problem of udev.
udev is triggered assynchronously from the modprobe caller. As a result,
alsactl is called before udev is finished.

Unfortunately, there is no way to synchronize udev operation.  The
solution would be to use hotplug to configure the sound stuff instead of
static init script.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-04 16:24 jdthood        New Issue                                    
12-22-04 16:59 tiwai          Note Added: 0002909                          
12-22-04 17:00 tiwai          File Added: control-device-fix.diff               
    
12-23-04 10:42 jdthood        Note Added: 0002911                          
12-23-04 12:05 tiwai          Note Added: 0002912                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
