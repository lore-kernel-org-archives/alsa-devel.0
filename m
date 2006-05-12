From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002106]: Sound card snd-hda-intel emits NO sound
Date: Fri, 12 May 2006 16:11:55 +0200
Message-ID: <91eecf8179117c67f757a989cd633585@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C962C175
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 16:11:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2106> 
======================================================================
Reported By:                louisvd
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2106
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 5
Kernel Version:             2.6.16-1.2111_FC5smp
======================================================================
Date Submitted:             05-08-2006 21:00 CEST
Last Modified:              05-12-2006 16:11 CEST
======================================================================
Summary:                    Sound card snd-hda-intel emits NO sound
Description: 
Hi

I was merrily running Fedora Core 4 and after upgrading the kernel to
2.6.16 my sound no longer worked under Linux (it works under Windows). 
After a lot of battling I figured I may as well upgrade to FC5 now.  A
clean install, out of the box, and the sound STILL did not work.  I've
applied every available patch to date and no luck.  Tonight I installed
the Alsa 1.0.11 driver, lib and util tarballs -- all installed
successfully -- but there is STILL no sound produced.

Everything LOOKS normal.  There are no errors that I can detect.  In the X
and console versions of Alsamixer I have ALL the devices displayed and
unmuted with the volumes at max. I've removed the sound lines from
modprobe.conf and am running with alsasound and that didn't help either --
even though it says the driver has been loaded.

FYI, the OSS Volume control calls it a Realtek ALC260.  lspci refers to it
as Intel Corporation 82801G (ICH7 Family) High Definition Audio Controller
(rev 01).


Please help.
======================================================================

----------------------------------------------------------------------
 louisvd - 05-12-06 00:40 
----------------------------------------------------------------------
I see from below that the model is set to NULL and enable is set to N.

1.  How do I make alsasound script set the model=auto?
2.  Should enable=N?  How do I make it set to Y?
3.  I get no errors.  The OS thinks the card had loaded.  However,
regardless of where the volume controls are, no sound plays.

[root@vandyl init.d]# ls -l /sys/module/snd_hda_intel/parameters/
total 0
-r--r--r-- 1 root root 4096 May 12 00:37 enable
-r--r--r-- 1 root root 4096 May 12 00:37 id
-r--r--r-- 1 root root 4096 May 12 00:37 index
-r--r--r-- 1 root root 4096 May 12 00:36 model
-r--r--r-- 1 root root 4096 May 12 00:37 position_fix
-r--r--r-- 1 root root 4096 May 12 00:37 probe_mask
-r--r--r-- 1 root root 4096 May 12 00:37 single_cmd
[root@vandyl init.d]# cat /sys/module/snd_hda_intel/parameters/enable
N
[root@vandyl init.d]# cat /sys/module/snd_hda_intel/parameters/id
<NULL>
[root@vandyl init.d]# cat /sys/module/snd_hda_intel/parameters/index
-1
[root@vandyl init.d]# cat /sys/module/snd_hda_intel/parameters/model
<NULL>
[root@vandyl init.d]# cat
/sys/module/snd_hda_intel/parameters/position_fix
0
[root@vandyl init.d]# cat /sys/module/snd_hda_intel/parameters/probe_mask
-1
[root@vandyl init.d]# cat /sys/module/snd_hda_intel/parameters/single_cmd
N

----------------------------------------------------------------------
 tiwai - 05-12-06 16:11 
----------------------------------------------------------------------
It's not alsasound script but somewhere else to set up the module option. 
Usually /etc/modprobe.d/* or /etc/modprobe.conf* file.

The enable option is a place holder for snd-hda-intel driver just for
compatibility.  It's anyway ignored.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-08-06 21:00 louisvd        New Issue                                    
05-08-06 21:00 louisvd        Distribution              => Fedora Core 5   
05-08-06 21:00 louisvd        Kernel Version            => 2.6.16-1.2111_FC5smp
05-10-06 16:16 tiwai          Note Added: 0009722                          
05-10-06 16:52 louisvd        Note Added: 0009731                          
05-10-06 16:55 tiwai          Note Added: 0009732                          
05-10-06 20:02 louisvd        Note Added: 0009751                          
05-12-06 00:40 louisvd        Note Added: 0009770                          
05-12-06 10:31 UMMO           Issue Monitored: UMMO                        
05-12-06 16:11 tiwai          Note Added: 0009778                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
