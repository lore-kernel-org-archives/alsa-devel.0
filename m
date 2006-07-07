From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002170]: No S/PDIF controls on STAC
	9200
Date: Fri, 7 Jul 2006 12:48:18 +0200
Message-ID: <fa19cb59a7631e028c971822eccba2f5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4A492273
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 12:48:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2170> 
======================================================================
Reported By:                mini
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2170
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-29-2006 12:34 CEST
Last Modified:              07-07-2006 12:48 CEST
======================================================================
Summary:                    No S/PDIF controls on STAC 9200
Description: 
I know this laptop (Dell XPS M1710) has S/PDIF out, but there is no ALSA
control for it in alsamixer.
======================================================================

----------------------------------------------------------------------
 mini - 07-06-06 23:22 
----------------------------------------------------------------------
YEEESSS! That was it!

I rmmod'ed the snd-hda-intel module, unplugged the AC, and modprobed it
again. Now:

Node 0x09 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x01451012: [Jack] SPDIF Out at Ext Rear
    Conn = Optical, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 2
     0x05* 0x0a

I still don't get a control in gnome-volume-control, but alsamixer gives
me one.

Off to test tomorrow.

I think this bug can be closed - I think I'm having a hardware (grounding)
issue.

----------------------------------------------------------------------
 tiwai - 07-07-06 12:48 
----------------------------------------------------------------------
Wow, it's interesting that the default pin configuration is rewritten so
dynamically by BIOS.

Does SPDIF work on battery once after the driver recognizes?  If yes, we
can add a  static pin configuration table to enable SPDIF regardless of
power state...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-29-06 12:34 mini           New Issue                                    
05-29-06 12:34 mini           Distribution              => Ubuntu Dapper   
05-29-06 12:34 mini           Kernel Version            => 2.6.15          
07-02-06 23:54 mini           Note Added: 0010795                          
07-06-06 19:46 tiwai          Note Added: 0010873                          
07-06-06 23:12 mini           Note Added: 0010884                          
07-06-06 23:22 mini           Note Added: 0010885                          
07-07-06 12:48 tiwai          Note Added: 0010906                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
