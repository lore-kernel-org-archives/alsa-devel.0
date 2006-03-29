From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001976]: System timer frequency 1000Hz
Date: Wed, 29 Mar 2006 18:49:41 +0200
Message-ID: <e978d166bad923d11c7f69b03e5ab9e8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 40B42132
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 18:49:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1976> 
======================================================================
Reported By:                ISBear
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1976
Category:                   PCI - cs4281
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               LFS 6.1 modified
Kernel Version:             2.6.16
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2006 11:30 CEST
Last Modified:              03-29-2006 18:49 CEST
======================================================================
Summary:                    System timer frequency 1000Hz
Description: 
When I set in kernel config timer frequency 1024Hz,
sound card not detects during boot.
"never read ISV3 and ISV4 from AC'97"
This is because of hard-coded in cs4281.c timeout length 100.
In stable 1.0.10 release there are HZ variable.
With this card successfully detects.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-29-06 18:49 
----------------------------------------------------------------------
Fixed on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 11:30 ISBear         New Issue                                    
03-29-06 11:30 ISBear         Distribution              => LFS 6.1 modified
03-29-06 11:30 ISBear         Kernel Version            => 2.6.16          
03-29-06 18:49 tiwai          Status                   new => resolved     
03-29-06 18:49 tiwai          Resolution               open => fixed       
03-29-06 18:49 tiwai          Assigned To               => tiwai           
03-29-06 18:49 tiwai          Note Added: 0009000                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
