From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001391]: The driver of the sound card onboard to a motherboard is not found.
Date: Fri, 2 Sep 2005 19:18:36 +0200
Message-ID: <4534b81df1f59214182138125b1d5d27@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7C9EE176
	for <alsa-devel@alsa-project.org>; Fri,  2 Sep 2005 19:18:36 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1391> 
======================================================================
Reported By:                moja93xp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1391
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedoracore 4, SUSE 9.3
Kernel Version:             2.6
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             09-02-2005 03:15 CEST
Last Modified:              09-02-2005 19:18 CEST
======================================================================
Summary:                    The driver of the sound card onboard to a
motherboard is not found.
Description: 
C-Media CM9739A carried in the mother board of the Linux server which I am
using There is no ALSA driver. 
I want you to make a formal correspondence driver from the ALSA.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-02-05 19:18 
----------------------------------------------------------------------
It's snd-intel8x0 driver.  Try alsaconf, for example.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-02-05 03:15 moja93xp       New Issue                                    
09-02-05 03:15 moja93xp       Distribution              => Fedoracore 4, SUSE
9.3
09-02-05 03:15 moja93xp       Kernel Version            => 2.6             
09-02-05 19:18 tiwai          Status                   new => resolved     
09-02-05 19:18 tiwai          Resolution               open => not an issue
09-02-05 19:18 tiwai          Assigned To               => tiwai           
09-02-05 19:18 tiwai          Note Added: 0006014                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
