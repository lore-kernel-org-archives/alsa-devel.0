From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001064]: snd_hda_intel does not recognize acl880 sound chip
Date: Fri, 8 Jul 2005 12:03:10 +0200
Message-ID: <62be0809b956f2e0c4f9cc8a9f5383e3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10D81166
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 12:03:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1064> 
======================================================================
Reported By:                jwiegley
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1064
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian-pure64
Kernel Version:             2.6.12-rc2
======================================================================
Date Submitted:             04-18-2005 20:42 CEST
Last Modified:              07-08-2005 12:03 CEST
======================================================================
Summary:                    snd_hda_intel does not recognize acl880 sound chip
Description: 
I bought a Shuttle ST20G5 box. Sound doesn't get detected or
seem to work with manual load.

chipset:
  ATI Xpress 200 northbridge
  ULI 1573 southbridge

The documentation says the sound is:
  Realtek ALC880

alsaconf detects nothing
manually loading snd_hda_intel also doesn't print anything in the
log files; though it does seem to load all the snd stuff just fine.
======================================================================

----------------------------------------------------------------------
 Christoph - 07-04-05 23:39 
----------------------------------------------------------------------
Tried the last CVS version today, same result.

ALSA sound/pci/hda/hda_intel.c:461: azx_get_response timeout
ALSA sound/pci/hda/hda_intel.c:461: azx_get_response timeout
ALSA sound/pci/hda/hda_intel.c:461: azx_get_response timeout
ALSA sound/pci/hda/hda_intel.c:461: azx_get_response timeout
...

----------------------------------------------------------------------
 tiwai - 07-08-05 12:03 
----------------------------------------------------------------------
The timeout implies that the irq isn't handled correctly.  It's often
related with ACPI.  Try pci=noacpi or acpi=off boot option for testing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 20:42 jwiegley       New Issue                                    
04-18-05 20:42 jwiegley       File Added: ST20G5lspci.txt                    
04-18-05 20:42 jwiegley       Distribution              => Debian-pure64   
04-18-05 20:42 jwiegley       Kernel Version            => 2.6.12-rc2      
04-19-05 17:34 tiwai          Category                 PCI - azx => PCI -
hda-intel
04-19-05 17:38 tiwai          Note Added: 0004523                          
06-09-05 16:20 Ballbreaker    Issue Monitored: Ballbreaker                    
06-12-05 20:52 jwiegley       Note Added: 0005001                          
06-15-05 14:39 tiwai          Note Added: 0005026                          
07-04-05 23:27 Christoph      Issue Monitored: Christoph                    
07-04-05 23:39 Christoph      Note Added: 0005388                          
07-08-05 12:03 tiwai          Note Added: 0005413                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
