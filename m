From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001393]: HDSP 9652 name under /proc/asound/cards shows 'default'
Date: Sat, 3 Sep 2005 00:24:04 +0200
Message-ID: <e285c45bb03ae6e0507f37b43c8d0e41@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4419A171
	for <alsa-devel@alsa-project.org>; Sat,  3 Sep 2005 00:24:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1393> 
======================================================================
Reported By:                Mark Knecht
Assigned To:                charbonnel
======================================================================
Project:                    ALSA - driver
Issue ID:                   1393
Category:                   PCI - RME HDSP
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.12-gentoo-r9 and 2.6.13-gentoo
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-03-2005 00:16 CEST
Last Modified:              09-03-2005 00:24 CEST
======================================================================
Summary:                    HDSP 9652 name under /proc/asound/cards shows
'default'
Description: 
mark@lightning ~ $ cat /proc/asound/cards
0 [CK804          ]: NFORCE - NVidia CK804
                     NVidia CK804 with ALC850 at 0xda103000, irq 185
1 [default        ]: H-DSP - Hammerfall DSP
                     RME Hammerfall HDSP 9652 at 0xda000000, irq 217
mark@lightning ~ $

The HDSP should identify itself with a name other than 'default'.

Cheers.
======================================================================

----------------------------------------------------------------------
 rlrevell - 09-03-05 00:23 
----------------------------------------------------------------------
Already fixed in CVS.

----------------------------------------------------------------------
 rlrevell - 09-03-05 00:24 
----------------------------------------------------------------------
fixed in CVS

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-03-05 00:16 Mark Knecht    New Issue                                    
09-03-05 00:16 Mark Knecht    Distribution              => Gentoo          
09-03-05 00:16 Mark Knecht    Kernel Version            => 2.6.12-gentoo-r9 and
2.6.13-gentoo
09-03-05 00:23 rlrevell       Note Added: 0006027                          
09-03-05 00:24 rlrevell       Status                   assigned => resolved
09-03-05 00:24 rlrevell       Resolution               open => fixed       
09-03-05 00:24 rlrevell       Note Added: 0006028                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
