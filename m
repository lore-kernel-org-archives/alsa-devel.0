From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000432]: Impossible de se connecter : NODIALTONE
Date: Fri, 14 Jan 2005 22:12:49 +0100
Message-ID: <60165d6d890800b02eb72d936639aee2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D8E8C281
	for <alsa-devel@alsa-project.org>; Fri, 14 Jan 2005 22:12:49 +0100 (MET)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=432> 
======================================================================
Reported By:                Cyrille
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   432
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware 10
Kernel Version:             2.4.24
======================================================================
Date Submitted:             08-08-2004 19:02 CEST
Last Modified:              01-14-2005 22:12 CET
======================================================================
Summary:                    Impossible de se connecter : NODIALTONE
Description: 
I've got a TOSHIBA SATELITTE A30 222 laptop
Sound card and modem are based upon ATI IXP
But I'm not able to run modem in spite of the differents bug-report on
ALSA web site
(https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000422
-
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
 -
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000417
) and on Unixtrix.com (http://www.unixtrix.com/)

Even if I do like Ronis or Netstar say -bugtrack.alsa-project :
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000418
-, I'm always in the same situation : compilation is OK, modem driver OK
but I'm not able to connect : NODIALTONE
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0000422 snd-atiixp-modem driver: No CARRIER/DIA...
======================================================================

----------------------------------------------------------------------
 sashak - 08-25-04 19:11 
----------------------------------------------------------------------
There is similar problem - some BIOSes doesn't report valid MODEM_PRESENT
bit in ATI_REG_CMD register (reg 003, bit 27 - look in
'/proc/asound/card1/atiixp'). Device behaviuor in this case is identical
to reported here - DMA works ok, line still be disconnected.

Uploaded patch solves the problem.

----------------------------------------------------------------------
 netstar - 08-26-04 01:18 
----------------------------------------------------------------------
Additional problems with patch when applied to alsa CVS.  All conditions
necessary are met.

----------------------------------------------------------------------
 netstar - 08-26-04 18:54 
----------------------------------------------------------------------
Forget that, now working fine, congratulations.

----------------------------------------------------------------------
 Cyrille - 08-26-04 21:46 
----------------------------------------------------------------------
Concretrely, does it mean the current version of alsa driver will not run
with this hardware ?
Thanx

----------------------------------------------------------------------
 Cyrille - 08-26-04 21:47 
----------------------------------------------------------------------
Oups, I've got not see the last Netstar message...
I try to test it...

----------------------------------------------------------------------
 Cyrille - 08-27-04 15:41 
----------------------------------------------------------------------
Hello
I have try Sashak's tip but the upload patch don't solve the problem.
Always the same error message : NODIALTONE.
(with alsa-driver/lib/... 1.0.6 ; test with slmodem-2.9.9 unless patch and
with Ronis's patch).
At your mind, is there really no hope to run it ?

----------------------------------------------------------------------
 netstar - 08-28-04 04:24 
----------------------------------------------------------------------
It seems that the new patch fixes the issues.  Note:  The earlier 
"fixed" slmodem package on my site was actually broken, attaching a fixed
version to this page and updating the file on my site.

----------------------------------------------------------------------
 Cyrille - 08-28-04 13:49 
----------------------------------------------------------------------
Hi
I've tried the slmodemd-fixed with alsa-driver-1.0.6a and always same
situation : NO DIALTONE...
An idea ?

----------------------------------------------------------------------
 netstar - 08-28-04 19:49 
----------------------------------------------------------------------
You could first try to download the whole of ALSA-CVS, building and
installing.

----------------------------------------------------------------------
 sashak - 08-28-04 22:37 
----------------------------------------------------------------------
Also run ATX3 command before ATDT.

----------------------------------------------------------------------
 sashak - 01-14-05 22:12 
----------------------------------------------------------------------
Solved as reported in bug 816
(https://bugtrack.alsa-project.org/alsa-bug/view.php?id=816)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-08-04 19:02 Cyrille        New Issue                                    
08-08-04 19:02 Cyrille        Distribution              => Slackware 10    
08-08-04 19:02 Cyrille        Kernel Version            => 2.4.24          
08-08-04 19:02 Cyrille        Issue Monitored: Cyrille                     
08-25-04 19:04 sashak         File Added: atiixp_modem.patch                    
08-25-04 19:11 sashak         Note Added: 0001624                          
08-26-04 01:16 netstar        File Added: debugging.tar.gz                    
08-26-04 01:18 netstar        Note Added: 0001630                          
08-26-04 18:54 netstar        Note Added: 0001634                          
08-26-04 21:46 Cyrille        Note Added: 0001636                          
08-26-04 21:47 Cyrille        Note Added: 0001637                          
08-27-04 15:41 Cyrille        Note Added: 0001644                          
08-27-04 19:33 tiwai          Assigned To              tiwai => sashak     
08-28-04 04:24 netstar        Note Added: 0001660                          
08-28-04 04:33 netstar        File Added: slmodemd.tar.gz                    
08-28-04 04:40 netstar        File Added: slmodemd-fixed.tar.gz                 
  
08-28-04 13:49 Cyrille        Note Added: 0001661                          
08-28-04 19:49 netstar        Note Added: 0001662                          
08-28-04 22:37 sashak         Note Added: 0001663                          
08-29-04 12:10 sashak         Relationship added       has duplicate 0000422
01-14-05 22:12 sashak         Note Added: 0003210                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
