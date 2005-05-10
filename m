From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000851]: Ali M1535 controller, AC'97 0 does not respond
Date: Tue, 10 May 2005 22:09:25 +0200
Message-ID: <0396f01c789270754234533f51379873@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E44CA2ED
	for <alsa-devel@alsa-project.org>; Tue, 10 May 2005 22:09:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=851> 
======================================================================
Reported By:                omargosh
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   851
Category:                   PCI - ali5451
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora FC3
Kernel Version:             2.6.10
======================================================================
Date Submitted:             01-27-2005 21:46 CET
Last Modified:              05-10-2005 22:09 CEST
======================================================================
Summary:                    Ali M1535 controller, AC'97 0 does not respond
Description: 
My Ali5451 rev 1 based card (embedded in an Ali M1535 controller) is not
detected.

dmesg shows:

PCI: Found IRQ 9 for device 0000:00:04.0
AC'97 0 does not respond - RESET
AC'97 0 access is not valid [0x0], removing mixer.
ali mixer creating error.
ALI 5451: probe of 0000:00:04.0 failed with error -5
======================================================================

----------------------------------------------------------------------
 jdthood - 04-13-05 22:10 
----------------------------------------------------------------------
Submitter: Do you have any new information about this problem?

----------------------------------------------------------------------
 omargosh - 05-10-05 22:09 
----------------------------------------------------------------------
No I dont, I was never able to get ALSA working with the M1535 chipset,
currently using OSS Trident support.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-27-05 21:46 omargosh       New Issue                                    
01-27-05 21:46 omargosh       Distribution              => Fedora FC3      
01-27-05 21:46 omargosh       Kernel Version            => 2.6.10          
01-28-05 22:40 omargosh       Note Added: 0003437                          
04-13-05 22:10 jdthood        Note Added: 0004483                          
05-10-05 22:09 omargosh       Note Added: 0004635                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
