From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000787]: Headphone == Master if plugged
Date: Tue, 11 Jan 2005 16:21:44 +0100
Message-ID: <f3a245cb2b84e6011598aaab2e0714aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 17C812D4
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:21:44 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=787> 
======================================================================
Reported By:                Nafallo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   787
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Ubuntu Linux 5.10 (hoary)
Kernel Version:             2.6.9
======================================================================
Date Submitted:             01-06-2005 02:04 CET
Last Modified:              01-11-2005 16:21 CET
======================================================================
Summary:                    Headphone == Master if plugged
Description: 
When I'm using headphones the master volume meter changes to headphones
volume meter, making me unable to use gnome-hotkeys to turn the volume
up/down (i.e. they change master that's inactivated by headphones).
======================================================================

----------------------------------------------------------------------
 Nafallo - 01-07-05 21:07 
----------------------------------------------------------------------
I would vote for binding them together, with or without hiding (risc of
confusing existing users).

----------------------------------------------------------------------
 tiwai - 01-11-05 16:21 
----------------------------------------------------------------------
OK, the attached is the patch to add a new quirk value "bind_hp".
Pass ac97_quirk=bind_hp.  If this works, let me know the PCI subsystem IDs
(lspci -nv output).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-06-05 02:04 Nafallo        New Issue                                    
01-06-05 02:04 Nafallo        Distribution              => Ubuntu Linux 5.10
(hoary)
01-06-05 02:04 Nafallo        Kernel Version            => 2.6.9           
01-06-05 02:13 Nafallo        Issue Monitored: Nafallo                     
01-07-05 18:21 tiwai          Note Added: 0003109                          
01-07-05 21:07 Nafallo        Note Added: 0003121                          
01-11-05 16:21 tiwai          Note Added: 0003154                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
