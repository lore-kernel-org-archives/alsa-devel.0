From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001046]: after some time, the alsa system is not accessible
Date: Sat, 31 Dec 2005 00:16:26 +0100
Message-ID: <4ed7a4ccfa15cc83e2492f4572bfa19f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC06C16A
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 00:16:26 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1046> 
======================================================================
Reported By:                wilsotc
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1046
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               gentoo
Kernel Version:             2.6.11-r5
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-12-2005 16:05 CEST
Last Modified:              12-31-2005 00:16 CET
======================================================================
Summary:                    after some time, the alsa system is not accessible
Description: 
If I remote SSH an aplay command, the problem can occur.

This command:
ssh USERNAME@host.com 'aplay /usr/kde/3.3/share/sounds/KDE_Notify.wav'

from a remote system can cause the problem to occur.  The command will
produce audio for weeks, then subsequent commands will cause an error that
looks like this:

ALSA lib confmisc.c:550:(snd_determine_driver) could not open control for
card 0
ALSA lib conf.c:3463:(_snd_config_evaluate) function snd_func_card_driver
returned error: Permission denied
ALSA lib confmisc.c:387:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3463:(_snd_config_evaluate) function snd_func_concat
returned error: Permission denied
ALSA lib confmisc.c:945:(snd_func_refer) error evaluating name
ALSA lib conf.c:3463:(_snd_config_evaluate) function snd_func_refer
returned error: Permission denied
ALSA lib conf.c:3932:(snd_config_expand) Evaluate error: Permission
denied
ALSA lib pcm.c:2068:(snd_pcm_open_noupdate) Unknown PCM default

the user is a member of the audio group as evidenced by the many
successful audio commands prior to the error.
======================================================================

----------------------------------------------------------------------
 wilsotc - 05-03-05 22:01 
----------------------------------------------------------------------
I have to run the hourly crontab job:
0 * * * *       chmod g+rw /dev/snd/*

To change my audio rights from this:
calvin root # ls -la /dev/snd/
total 0
drwxrwxr-x  1 root audio       0 Dec 31  1969 .
drwxr-xr-x  1 root root        0 Dec 31  1969 ..
crw-------  1 root audio 116,  0 Dec 31  1969 controlC0
crw-------  1 root audio 116,  8 Dec 31  1969 midiC0D0
crw-------  1 root audio 116, 24 Dec 31  1969 pcmC0D0c
crw-------  1 root audio 116, 16 Dec 31  1969 pcmC0D0p
crw-------  1 root audio 116, 17 Dec 31  1969 pcmC0D1p
crw-------  1 root audio 116, 18 Dec 31  1969 pcmC0D2p
crw-------  1 root audio 116,  1 Dec 31  1969 seq
crw-------  1 root audio 116, 33 Dec 31  1969 timer

back to this:
calvin root # ls -la /dev/snd/
total 0
drwxrwxr-x  1 root audio       0 Dec 31  1969 .
drwxr-xr-x  1 root root        0 Dec 31  1969 ..
crw-rw----  1 root audio 116,  0 Dec 31  1969 controlC0
crw-rw----  1 root audio 116,  8 Dec 31  1969 midiC0D0
crw-rw----  1 root audio 116, 24 Dec 31  1969 pcmC0D0c
crw-rw----  1 root audio 116, 16 Dec 31  1969 pcmC0D0p
crw-rw----  1 root audio 116, 17 Dec 31  1969 pcmC0D1p
crw-rw----  1 root audio 116, 18 Dec 31  1969 pcmC0D2p
crw-rw----  1 root audio 116,  1 Dec 31  1969 seq
crw-rw----  1 root audio 116, 33 Dec 31  1969 timer

I am using ALSA 1.0.8 on Gentoo Linux with Kernel 2.6.10-r6
*  media-sound/alsa-headers
      Latest version available: 1.0.8
      Latest version installed: 1.0.8
      Size of downloaded files: 1,881 kB
      Homepage:    http://www.alsa-project.org/
      Description: Header files for Advanced Linux Sound Architecture
kernel modules
*  media-sound/alsa-utils
      Latest version available: 1.0.8
      Latest version installed: 1.0.8
      Size of downloaded files: 219 kB
      Homepage:    http://www.alsa-project.org/
      Description: Advanced Linux Sound Architecture Utils (alsactl,
alsamixer, etc.)
*  media-sound/alsa-driver
      Latest version available: 1.0.8
      Latest version installed: [ Not Installed ]
      Size of downloaded files: 1,881 kB
      Homepage:    http://www.alsa-project.org/
      Description: Advanced Linux Sound Architecture kernel modules
*  media-libs/alsa-lib
      Latest version available: 1.0.8
      Latest version installed: 1.0.8
      Size of downloaded files: 666 kB
      Homepage:    http://www.alsa-project.org/
      Description: Advanced Linux Sound Architecture Library

The rights seem to disappear randomly when I run an aplay command via SSH
from another host.

I'm using devfsd not udev

----------------------------------------------------------------------
 rlrevell - 12-31-05 00:16 
----------------------------------------------------------------------
devfs has been removed from the kernel

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-12-05 16:05 wilsotc        New Issue                                    
04-12-05 16:05 wilsotc        Distribution              => gentoo          
04-12-05 16:05 wilsotc        Kernel Version            => 2.6.11-r5       
04-12-05 16:25 tiwai          Note Added: 0004446                          
05-03-05 22:01 wilsotc        Note Added: 0004585                          
12-31-05 00:16 rlrevell       Status                   new => closed       
12-31-05 00:16 rlrevell       Note Added: 0007312                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
