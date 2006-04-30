From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002069]: No sound on via SPDIF out, very low volume on analog out (MSI K8NGM2-FID with ACL880)
Date: Sun, 30 Apr 2006 15:00:05 +0200
Message-ID: <d46c61228cd188aee486503efcda9e7d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BA151142
	for <alsa-devel@alsa-project.org>; Sun, 30 Apr 2006 15:00:06 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2069> 
======================================================================
Reported By:                gtmkramer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2069
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 4
Kernel Version:             2.6.16-1.2069_FC4smp
======================================================================
Date Submitted:             04-25-2006 20:43 CEST
Last Modified:              04-30-2006 15:00 CEST
======================================================================
Summary:                    No sound on via SPDIF out, very low volume on analog
out (MSI K8NGM2-FID with ACL880)
Description: 
On my new MSI K8NGM2-FID motherboard with a Realtek ACL880 a get only sound
from the analog output (although the volume is very low).

The codec is not properly recognized:
hda_codec: Unknown model for ALC880, trying auto-probe from BIOS...

I've tried with various model= settings to no avail.
======================================================================

----------------------------------------------------------------------
 gtmkramer - 04-27-06 20:37 
----------------------------------------------------------------------
I just had a crazy idea. I tried to get spdif working through the alsa-oss
layer and it works! (??). So with mplayer somefile.ts -ao oss -ac hwac3 I
do get the spdif output to work though not through the alsa driver. Very
odd.

Any ideas what can cause this?

----------------------------------------------------------------------
 gtmkramer - 04-30-06 15:00 
----------------------------------------------------------------------
With this small patch/hack I let the alsa driver properly detect my onboard
ALC880 and let it autoconfigure (for now). With autoconfigure I do get a
headphones for which there is no connector. Do I need to make a new
(mixer)model for this board?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-25-06 20:43 gtmkramer      New Issue                                    
04-25-06 20:43 gtmkramer      File Added: codec.tar.gz                     
04-25-06 20:43 gtmkramer      Distribution              => Fedora Core 4   
04-25-06 20:43 gtmkramer      Kernel Version            => 2.6.16-1.2069_FC4smp
04-27-06 18:34 gtmkramer      Note Added: 0009533                          
04-27-06 18:40 gtmkramer      Note Added: 0009534                          
04-27-06 20:37 gtmkramer      Note Added: 0009535                          
04-30-06 14:57 gtmkramer      File Added: patch-msi-k8ngm2-fid.patch            
       
04-30-06 15:00 gtmkramer      Note Added: 0009548                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
