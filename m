From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002205]: Everything seems ok,
	but there's no sound
Date: Wed, 28 Jun 2006 09:25:46 +0200
Message-ID: <ce468a9621de7dc8d80fe9af7c9bf2fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8036274
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jun 2006 09:25:46 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2205> 
======================================================================
Reported By:                rematch
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2205
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-13-2006 11:31 CEST
Last Modified:              06-28-2006 09:25 CEST
======================================================================
Summary:                    Everything seems ok, but there's no sound
Description: 
After loading snd-hda-intel modul, there's no sound on my acer travelmate
3012 laptop. 
OS is debian sid, kernel 2.6.16.20 SMP, alsa version 1.0.11.

======================================================================

----------------------------------------------------------------------
 rematch - 06-27-06 12:24 
----------------------------------------------------------------------
thank you

----------------------------------------------------------------------
 rematch - 06-28-06 09:25 
----------------------------------------------------------------------
tiwai, did you commit a patch? i rsynced today morning the hg, i tried
install it with hginstall (i had a few problem with the patch), and after
the compile no effect. 

atm:
** WARNING **: alsa_setup_mixer(): Failed to find mixer element: PCM
ALSA lib pcm_direct.c:819:(snd_pcm_direct_initialize_slave)
snd_pcm_hw_params_any failed
ALSA lib pcm_dmix.c:874:(snd_pcm_dmix_open) unable to initialize slave

** WARNING **: alsa_setup(): Failed to open pcm device (default): Invalid
argument

the strace output:
open("/dev/snd/controlC0", O_RDONLY)    = 8
close(8)                                = 0
open("/dev/snd/controlC0", O_RDWR)      = 8
ioctl(8, USBDEVFS_CONTROL, 0xafe8b488)  = 0
fcntl64(8, F_GETFL)                     = 0x2 (flags O_RDWR)
fcntl64(8, F_SETFL, O_RDWR|O_NONBLOCK)  = 0
ioctl(8, USBDEVFS_RELEASEINTERFACE, 0xafe8b574) = 0
ioctl(8, USBDEVFS_RELEASEINTERFACE, 0xafe8b574) = 0
[...]
ioctl(8, USBDEVFS_IOCTL, 0xafe8adf0)    = 0
ioctl(8, USBDEVFS_CONNECTINFO, 0xafe8b270) = 0
ioctl(8, USBDEVFS_IOCTL, 0xafe8adf0)    = 0
ioctl(8, USBDEVFS_DISCONNECT, 0xafe8b534) = 0
write(2, "\n** ", 4)                    = 4
write(2, "WARNING **: ", 12)            = 12
write(2, "alsa_setup_mixer(): Failed to find mixer element: PCM", 53) =
53
write(2, "\n", 1)                       = 1

tia.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-06 11:31 rematch        New Issue                                    
06-13-06 11:48 rematch        Issue Monitored: rematch                     
06-27-06 09:04 rematch        Note Added: 0010570                          
06-27-06 12:16 tiwai          Note Added: 0010583                          
06-27-06 12:24 rematch        Note Added: 0010584                          
06-28-06 09:25 rematch        Note Added: 0010611                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
