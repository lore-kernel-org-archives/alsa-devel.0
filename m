From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000359]: Alsa always uses card0 and does not use card1, even when card0 is a modem
Date: Fri, 7 Jan 2005 18:59:18 +0100
Message-ID: <2ef14988398c1b0b228a7dff9600804f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 07F7A2E1
	for <alsa-devel@alsa-project.org>; Fri,  7 Jan 2005 18:59:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=359> 
======================================================================
Reported By:                davidsrsb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   359
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.0
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-01-2004 16:26 CEST
Last Modified:              01-07-2005 18:59 CET
======================================================================
Summary:                    Alsa always uses card0 and does not use card1, even
when card0 is a modem
Description: 
PC is laptop with AC97 DAA (Si3036 modem) detected as card0 and sound is
Intel 8x0 as card1. Alsamixer has to be run with -c1 option to avoid "no
mixer elems" error (like bug 338)
KDE has no sound ( same as bug 353)
======================================================================

----------------------------------------------------------------------
 jdthood - 01-07-05 18:28 
----------------------------------------------------------------------
Please read https://bugzilla.ubuntu.com/show_bug.cgi?id=1293 .

----------------------------------------------------------------------
 jdthood - 01-07-05 18:59 
----------------------------------------------------------------------
> The problem is that the current "numbering" concept doesn't match
> with the idea of hotplug. We need either stop using numbers, or
> introduce the mangling of physical and logical device numbers.


I agree that a general solution is for sound applications to select
cards by type or id rather than by index.  However, it remains the
fact that some existing applications open card
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0.  So GNU/Linux
distributors would like to set things up so that modems and TV cards
don't grab index 0.

My proposed solution is to apply the following patch and then use:

    options snd-bt87x index=-2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-04 16:26 davidsrsb      New Issue                                    
07-01-04 16:26 davidsrsb      Distribution              => Slackware 10.0  
07-01-04 16:26 davidsrsb      Kernel Version            => 2.4.26          
07-02-04 14:34 pzad           Note Added: 0001374                          
01-05-05 23:34 jdthood        Note Added: 0003090                          
01-06-05 17:48 phormix        Note Added: 0003092                          
01-07-05 18:10 tiwai          Note Added: 0003108                          
01-07-05 18:28 jdthood        Note Added: 0003112                          
01-07-05 18:59 jdthood        Note Added: 0003114                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
