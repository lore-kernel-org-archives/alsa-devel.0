From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001979]: Missing symbols in oss mixer code
Date: Sat, 1 Apr 2006 17:20:01 +0200
Message-ID: <f982c1cbf293840b22f33f18cfe7531c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 394CE18B
	for <alsa-devel@alsa-project.org>; Sat,  1 Apr 2006 17:20:02 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1979> 
======================================================================
Reported By:                zx80user
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1979
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-29-2006 23:03 CEST
Last Modified:              04-01-2006 17:20 CEST
======================================================================
Summary:                    Missing symbols in oss mixer code
Description: 
Attempting to load the snd-pcm-oss module and the snd-pcm-mixer modules
fails due to missing symbols.


======================================================================

----------------------------------------------------------------------
 Raymond - 03-30-06 10:00 
----------------------------------------------------------------------
What is the output of ruuning "amixer" ?

----------------------------------------------------------------------
 Raymond - 04-01-06 17:20 
----------------------------------------------------------------------
create the volume controls before snd_card_register()

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 23:03 zx80user       New Issue                                    
03-29-06 23:04 zx80user       Issue Monitored: zx80user                    
03-29-06 23:05 zx80user       Note Added: 0009019                          
03-30-06 10:00 Raymond        Note Added: 0009024                          
04-01-06 17:20 Raymond        Note Added: 0009056                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
