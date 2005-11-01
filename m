From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001469]: Japanese characters are broken with alsaconf
Date: Tue, 1 Nov 2005 18:25:30 +0100
Message-ID: <d9896cc2bb6951a6a216197f0bcc6baf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6B59C10C
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2005 18:25:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1469> 
======================================================================
Reported By:                speedking
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1469
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             10-05-2005 18:01 CEST
Last Modified:              11-01-2005 18:25 CET
======================================================================
Summary:                    Japanese characters are broken with alsaconf
Description: 
"alsaconf" displays broken characters for k/d button messages while using
Japanese.
======================================================================

----------------------------------------------------------------------
 speedking - 10-20-05 17:03 
----------------------------------------------------------------------
It looks like we have to install ncurses.  Can download it at
http://www.gnu.org/software/ncurses/ncurses.html but it's very complicated
to install it. I tried multiple things but I'm not sure I did correctly.
It does not work the way I have it installed.  Any help you could offer on
installing it for RHEL3 U5 would be appreciated.

----------------------------------------------------------------------
 speedking - 11-01-05 18:25 
----------------------------------------------------------------------
Tiwai,

I've got the 'ncurses' library built but how do I "pass the proper
configure option for that"?  Do I need to rebuild 'alsaconf' with a
specific option to get it to pull in the 'ncurses' library?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-05-05 18:01 speedking      New Issue                                    
10-05-05 18:36 tiwai          Note Added: 0006431                          
10-19-05 17:47 speedking      Note Added: 0006493                          
10-19-05 18:11 tiwai          Note Added: 0006494                          
10-19-05 18:13 speedking      Note Added: 0006495                          
10-20-05 17:03 speedking      Note Added: 0006507                          
11-01-05 18:25 speedking      Note Added: 0006597                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
