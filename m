From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001064]: snd_hda_intel does not recognize acl880 sound chip
Date: Tue, 19 Apr 2005 17:38:08 +0200
Message-ID: <45ce6678f823bf6629a65a098c0b9023@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B376118C
	for <alsa-devel@alsa-project.org>; Tue, 19 Apr 2005 17:38:08 +0200 (MEST)
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
Last Modified:              04-19-2005 17:38 CEST
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
 tiwai - 04-19-05 17:38 
----------------------------------------------------------------------
It seems that the device has an unknown controller by ALI.

Try to add the corresponding PCI IDs (10b9:5461) to azx_ids[] in
pci/hda_intel.c, in case the chipset is compatible with Intel ICH6/7.

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
