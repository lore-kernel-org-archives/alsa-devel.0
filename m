From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001292]: Audigy 2 ZS Notebook initialization hangs kernel.
Date: Sun, 30 Oct 2005 21:07:25 +0100
Message-ID: <78e5c18f0473c8e696756889335f02ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2337E193
	for <alsa-devel@alsa-project.org>; Sun, 30 Oct 2005 21:07:26 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1292> 
======================================================================
Reported By:                tomch
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1292
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable/experimental
Kernel Version:             2.6.13-rc4
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-29-2005 23:14 CEST
Last Modified:              10-30-2005 21:07 CET
======================================================================
Summary:                    Audigy 2 ZS Notebook initialization hangs kernel.
Description: 
When Emu10k1 option in kernel is disabled, it boots just fine.
If support is compiled in, boot hangs just after displaing: Audigy2
value:Special config.

I don't know anything about kernel programming, but i could help with
additional informations or try to debug this.
======================================================================

----------------------------------------------------------------------
 jcdutton - 10-30-05 21:07 
----------------------------------------------------------------------
Fixed in CVS 30-10-2005

The Audigy2 ZS Notebook no longer crashes the kernel.
The card is not properly recognised.
TODO: The sound is badly distorted, so more work need to be done to fix
that.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 23:14 tomch          New Issue                                    
07-29-05 23:14 tomch          Distribution              => Debian
unstable/experimental
07-29-05 23:14 tomch          Kernel Version            => 2.6.13-rc4      
07-31-05 03:51 buckvitulli    Issue Monitored: buckvitulli                    
08-01-05 01:04 jpeak          Issue Monitored: jpeak                       
10-30-05 21:07 jcdutton       Status                   new => closed       
10-30-05 21:07 jcdutton       Note Added: 0006576                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
