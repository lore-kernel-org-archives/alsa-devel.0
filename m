From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000800]: Sound is Corrupted or terribe quality.
Date: Wed, 8 Jun 2005 16:11:29 +0200
Message-ID: <9999d60ab272683a4abea3bd79d1a82f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 518841F3
	for <alsa-devel@alsa-project.org>; Wed,  8 Jun 2005 16:11:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=800> 
======================================================================
Reported By:                abonilla
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   800
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.9
======================================================================
Date Submitted:             01-10-2005 03:20 CET
Last Modified:              06-08-2005 16:11 CEST
======================================================================
Summary:                    Sound is Corrupted or terribe quality.
Description: 
Sound goes out just like if the jack was not propperly plugged. bad Sound
Quality.
======================================================================

----------------------------------------------------------------------
 pforai - 05-31-05 16:28 
----------------------------------------------------------------------
i can confirm that, same hw, same problem. it seems a little bit odd
because tiwai fixed a problem with the playback buffer a long time ago -
it was in alsa 1.12 cvs afair. now  i'm using 1.0.9 release(switched to
that because of distro packet mgmnt sys) and the playback quality ist bad
again (but not as bad as it was in 1.0.7).



----------------------------------------------------------------------
 tiwai - 06-08-05 16:11 
----------------------------------------------------------------------
And what about position_fix option?  No influence?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-10-05 03:20 abonilla       New Issue                                    
01-10-05 03:20 abonilla       Distribution              => Debian          
01-10-05 03:20 abonilla       Kernel Version            => 2.6.9           
01-10-05 14:56 tiwai          Note Added: 0003134                          
03-16-05 13:27 jdthood        Note Added: 0003956                          
03-18-05 18:23 tiwai          Note Added: 0004003                          
03-18-05 23:35 allefant       Issue Monitored: allefant                    
03-18-05 23:36 allefant       Issue End Monitor: allefant                    
03-19-05 12:42 jdthood        Note Added: 0004036                          
05-24-05 13:37 jdthood        Note Added: 0004725                          
05-24-05 13:37 jdthood        Note Edited: 0004725                         
05-24-05 14:12 tiwai          Note Added: 0004728                          
05-24-05 14:15 jdthood        Note Edited: 0004725                         
05-31-05 16:27 pforai         Note Added: 0004836                          
05-31-05 16:28 pforai         Note Edited: 0004836                         
06-08-05 16:11 tiwai          Note Added: 0004947                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
