From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000782]: Poor digital aidio quality
Date: Sun, 16 Jan 2005 14:57:34 +0100
Message-ID: <0b1a86bba08bd9784c3dc4a703c70dcf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8C2CD244
	for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2005 14:57:34 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=782> 
======================================================================
Reported By:                ddemmer
Assigned To:                fmoraes
======================================================================
Project:                    ALSA - driver
Issue ID:                   782
Category:                   PCI - emu10k1x
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core
Kernel Version:             2.6.9-1.681_FC3.i686
======================================================================
Date Submitted:             01-03-2005 16:20 CET
Last Modified:              01-16-2005 14:57 CET
======================================================================
Summary:                    Poor digital aidio quality
Description: 
Attempting to play MP3 files with RealPlay or xmms using ALSA output
results in scratchy, erratic, slow (Realplay) or speeded up (xmms) sound.
I can change the xmms configuration to use libOSS.so instead of libALSA
which fixes the problem.

The gnome "Detect Sound Card" utility works fine and plays it's sound
fine.

The gnome volume control does not affect the output level when using
libOSS.

I have by now muted everything in the alsamixer except the Master volume.

Playing a CD works fine.
======================================================================

----------------------------------------------------------------------
 fmoraes - 01-16-05 14:57 
----------------------------------------------------------------------
Can you try with ALSA 1.0.8?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-03-05 16:20 ddemmer        New Issue                                    
01-03-05 16:20 ddemmer        Distribution              => Fedora Core     
01-03-05 16:20 ddemmer        Kernel Version            => 2.6.9-1.681_FC3.i686
01-03-05 16:49 stransky       Issue Monitored: stransky                    
01-04-05 13:43 ddemmer        Issue Monitored: ddemmer                     
01-04-05 13:43 ddemmer        Issue End Monitor: ddemmer                    
01-16-05 14:57 fmoraes        Note Added: 0003217                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
