From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001933]: Headphones work, but sound isn't muted when they are plugged in
Date: Fri, 17 Mar 2006 22:59:50 +0100
Message-ID: <53eb61bf4c2ff748e8c23346d86bb1c7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D08671A9
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2006 22:59:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1933> 
======================================================================
Reported By:                jer
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1933
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.12
======================================================================
Date Submitted:             03-17-2006 01:01 CET
Last Modified:              03-17-2006 22:59 CET
======================================================================
Summary:                    Headphones work, but sound isn't muted when they are
plugged in
Description: 
On a Dell Inspiron B120 laptop the headphones do not disengage the
speakers.  I have already submitted a patch to the patch_sigmatel.c
maintainer and to the alsa-dev mailing list, but decided that it would
help if I also submitted a bug report as well.  I am including a patch in
the additional information section.

The codec chip in question here is a stac9200 which prior to this patch
doesn't support headphones.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-17-06 12:01 
----------------------------------------------------------------------
To be sure, I uploaded a newer patch included your fix (only the first
chunk) in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1843.

----------------------------------------------------------------------
 jer - 03-17-06 22:59 
----------------------------------------------------------------------
I just tried removing the call you mentioned.  Still works fine, I may have
needed to use that since I don't believe in the 1.0.10 code it was being
called in init as it appears to be now.  Anyway, I will test your full
patch a little later this evening and let you know.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-17-06 01:01 jer            New Issue                                    
03-17-06 01:01 jer            File Added: sigmatel.patch                    
03-17-06 01:01 jer            Distribution              => Ubuntu Breezy   
03-17-06 01:01 jer            Kernel Version            => 2.6.12          
03-17-06 01:03 jer            Issue Monitored: jer                         
03-17-06 01:26 tiwai          Note Added: 0008625                          
03-17-06 01:55 jer            Note Added: 0008626                          
03-17-06 02:38 jer            Note Added: 0008629                          
03-17-06 02:57 jer            File Added: sigmatel.11rc3.patch                  
 
03-17-06 02:59 jer            Note Added: 0008631                          
03-17-06 11:43 tiwai          Note Added: 0008636                          
03-17-06 12:01 tiwai          Note Added: 0008639                          
03-17-06 22:59 jer            Note Added: 0008663                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
