From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000306]: compiles, but no sound comes out
Date: Fri, 14 Jan 2005 00:53:48 +0100
Message-ID: <7c097b4770ffc4de56c088bab4a5d1fd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2A99B307
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2005 00:53:49 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=306> 
======================================================================
Reported By:                Quietti
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   306
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             self-compiled 2.6.6 vanilla.
======================================================================
Date Submitted:             05-25-2004 20:35 CEST
Last Modified:              01-14-2005 00:53 CET
======================================================================
Summary:                    compiles, but no sound comes out
Description: 
This is a plain vanilla kernel 2.6.6, which uses ALSA 1.0.4.

The kernel compiles fine, the snd_powermac module loads without any error,
but no sound comes up.

Running alsamixer gives me a mixer screen where none of the sliders can be
moved.
======================================================================

----------------------------------------------------------------------
 Quietti - 01-07-05 00:30 
----------------------------------------------------------------------
'hwinfo' mentions the following about the sound hardware of this vintage
iMac:

11: None 00.0: 0401 Multimedia audio controller
  [Created at prom.409]
  Unique ID: AT0p.4TqZ9X2iLH0
  Parent ID: LxCh.xWNNVcdS2SF
  Hardware Class: sound
  Model: "Apple Integrated Sound (burgundy)"
  Vendor: int 0x0401 "Apple"
  Device: int 0x0012 "Integrated Sound (burgundy)"
  PROM id: pci@80000000/mac-io@10/davbus@14000/sound
  IRQ: 17 (1 event)
  Driver Info https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0:
    Driver Status: dmasound is not active
    Driver Activation Cmd: "modprobe dmasound"
  Config Status: cfg=new, avail=yes, need=no, active=unknown
  Attached to: https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7
(Unclassified device)

07: PCI 10.0: ff00 Unclassified device
  [Created at pci.244]
  Unique ID: LxCh.xWNNVcdS2SF
  SysFS ID: /devices/pci0000:00/0000:00:10.0
  SysFS BusID: 0000:00:10.0
  Hardware Class: unknown
  Model: "Apple Paddington Mac I/O"
  Vendor: pci 0x106b "Apple Computer Inc."
  Device: pci 0x0017 "Paddington Mac I/O"
  Driver: "macio"
  PROM id: pci@80000000/mac-io@10
  Memory Range: 0x80800000-0x8087ffff (rw,non-prefetchable)
  Config Status: cfg=new, avail=yes, need=no, active=unknown

----------------------------------------------------------------------
 Quietti - 01-14-05 00:53 
----------------------------------------------------------------------
These CVS repositorie appear to contain Apple's own open source drivers:

http://cvs.opendarwin.org/index.cgi/src/AppleOnboardAudio/
http://cvs.opendarwin.org/index.cgi/src/IOAudioFamily/

Note that some files must be unhidden from the Attic to appear visible.

Comparing those to what you have should at least allow you to see what
might be wrong in the current ALSA code.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-25-04 20:35 Quietti        New Issue                                    
05-25-04 20:35 Quietti        File Added: asound.state                     
05-25-04 20:35 Quietti        Distribution              => Debian          
05-25-04 20:35 Quietti        Kernel Version            => self-compiled 2.6.6
vanilla.
05-25-04 20:38 Quietti        Issue Monitored: Quietti                     
05-28-04 21:18 tiwai          Note Added: 0001274                          
05-28-04 21:37 Quietti        Note Added: 0001275                          
07-25-04 20:16 Quietti        Note Added: 0001473                          
09-08-04 06:32 Quietti        Note Added: 0001726                          
10-20-04 00:38 Quietti        Note Added: 0002209                          
01-06-05 18:14 Quietti        Note Added: 0003093                          
01-06-05 18:27 rlrevell       Note Added: 0003094                          
01-06-05 19:43 Quietti        Note Added: 0003095                          
01-07-05 00:00 Quietti        Note Added: 0003096                          
01-07-05 00:19 Quietti        Note Added: 0003097                          
01-07-05 00:30 Quietti        Note Added: 0003098                          
01-14-05 00:53 Quietti        Note Added: 0003206                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
