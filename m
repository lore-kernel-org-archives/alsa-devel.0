From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000811]: 1.0.8-rc2 base/treble adjustment does not work with "tone" button enabled
Date: Thu, 13 Jan 2005 06:22:21 +0100
Message-ID: <f1fd2d50810e51c6ba91cd8cb22fd245@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C6BEA2F1
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 06:22:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=811> 
======================================================================
Reported By:                vinyvat
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   811
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             01-12-2005 18:58 CET
Last Modified:              01-13-2005 06:22 CET
======================================================================
Summary:                    1.0.8-rc2 base/treble adjustment does not work with
"tone" button enabled
Description: 
With 1.8.0-rc2, using any alsa mixer apps (alsamixer, kmix,
gnome-alsa-mixer), the base/treble adjustment does nothing even when I
make sure the "Tone" button is clicked.

Reproduce:
/etc/init.d/alsa start
alsaplayer # to play some music
alsamixer

adjust base/treble - no difference in sound, even when "tone" is enabled.
======================================================================

----------------------------------------------------------------------
 vinyvat - 01-13-05 06:22 
----------------------------------------------------------------------
Please close this bug. Cannot reproduce any more with 1.0.8-rc2 ( maybe was
too late at night ? )

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-12-05 18:58 vinyvat        New Issue                                    
01-12-05 18:58 vinyvat        Kernel Version            => 2.6.8.1         
01-13-05 06:22 vinyvat        Note Added: 0003181                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
