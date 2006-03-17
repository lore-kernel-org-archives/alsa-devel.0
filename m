From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001813]: STAC9750 not recognised by hda-intel
Date: Fri, 17 Mar 2006 01:03:46 +0100
Message-ID: <66f26e17a2613dd4ab1c7f1a6118e322@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A5F481BB
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 01:03:46 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1813> 
======================================================================
Reported By:                hsheppard
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1813
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo Linux
Kernel Version:             2.6.16-rc1
Resolution:                 duplicate
Duplicate:                  1843
Fixed in Version:           
======================================================================
Date Submitted:             02-03-2006 17:09 CET
Last Modified:              03-17-2006 01:03 CET
======================================================================
Summary:                    STAC9750 not recognised by hda-intel
Description: 
I have a Dell Inspiron 630M (AKA Dell XPS140) that has an ICH6 controller
and a STAC9750 HDaudio codec. ALSA currently recognises the codec as a
9200-series, not the 9750.

As such, the internal speakers and mic-in jacks do not work and the mixer
is looking extremely spartan (see attachment).
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001843 regression: no sound with sigmatel stac...
======================================================================

----------------------------------------------------------------------
 tiwai - 03-15-06 15:42 
----------------------------------------------------------------------
STAC9750 must be identical with STAC9200.  Actually there are no more mixer
controls than that.

The silent output is a different problem, a known bug found in the current
code.

----------------------------------------------------------------------
 tiwai - 03-17-06 01:03 
----------------------------------------------------------------------
Try the patch in #1843 with the latest CVS version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-03-06 17:09 hsheppard      New Issue                                    
02-03-06 17:09 hsheppard      File Added: alsamixer.png                    
02-03-06 17:09 hsheppard      Distribution              => Gentoo Linux    
02-03-06 17:09 hsheppard      Kernel Version            => 2.6.16-rc1      
02-03-06 17:10 hsheppard      Issue Monitored: hsheppard                    
02-03-06 17:20 hsheppard      File Added: codec.txt                        
02-03-06 17:21 hsheppard      File Added: lspci-v.txt                      
02-04-06 15:20 af             Issue Monitored: af                          
02-04-06 21:17 gsmet          Issue Monitored: gsmet                       
03-01-06 19:22 adoroar        Issue Monitored: adoroar                     
03-15-06 15:42 tiwai          Note Added: 0008555                          
03-17-06 01:03 tiwai          Relationship added       duplicate of 0001843
03-17-06 01:03 tiwai          Duplicate ID             0 => 1843           
03-17-06 01:03 tiwai          Status                   assigned => resolved
03-17-06 01:03 tiwai          Resolution               open => duplicate   
03-17-06 01:03 tiwai          Note Added: 0008623                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
