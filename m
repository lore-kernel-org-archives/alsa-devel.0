From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000649]: alsaplayer only works as root
Date: Sun, 14 Nov 2004 15:37:08 +0100
Message-ID: <82dbf3569b983806c471fe744450d085@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8F9CB220
	for <alsa-devel@alsa-project.org>; Sun, 14 Nov 2004 15:37:08 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=649> 
======================================================================
Reported By:                mthoro
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   649
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             11-14-2004 15:37 CET
Last Modified:              11-14-2004 15:37 CET
======================================================================
Summary:                    alsaplayer only works as root
Description: 
changed permissions on snd devices to 777.  player only works after login
as root.  after login as user in audio group, player will not work even if
I log back in as root.  I have to reboot and login as root to get the
player to work again. gnome cd player works okay, but the alsaplayer is
great!
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-14-04 15:37 mthoro         New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
