From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000359]: Alsa always uses card0 and does not use card1, even when card0 is a modem
Date: Wed, 5 Jan 2005 23:34:33 +0100
Message-ID: <be1a45e5b15a7aff6656374a184bbcf4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B44DA305
	for <alsa-devel@alsa-project.org>; Wed,  5 Jan 2005 23:34:33 +0100 (MET)
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
Last Modified:              01-05-2005 23:34 CET
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
 pzad - 07-02-04 14:34 
----------------------------------------------------------------------
Try to use module option like this in modules.conf

options snd-intel8x0 index=0
options snd-intel8x0m index=1

This will swap soundcards and modem will be second.

----------------------------------------------------------------------
 jdthood - 01-05-05 23:34 
----------------------------------------------------------------------
Quite a few users have encountered this problem: the modem driver or, e.g.,
the snd-bt87x driver happens to initialize first, grabs index 0 and
becomes the default sound card.

It would be nice if we could prevent this from happening by means of
module load options.  Is there some way of loading a module such that it
is made to grab the first available index greater than 0?  What I have in
mind is something like this:

    options snd-bt87x index_excluded=0

-- 
Thomas Hood

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-04 16:26 davidsrsb      New Issue                                    
07-01-04 16:26 davidsrsb      Distribution              => Slackware 10.0  
07-01-04 16:26 davidsrsb      Kernel Version            => 2.4.26          
07-02-04 14:34 pzad           Note Added: 0001374                          
01-05-05 23:34 jdthood        Note Added: 0003090                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
