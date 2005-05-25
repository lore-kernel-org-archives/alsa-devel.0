From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001098]: aoss openal    gives too fast sound.
Date: Wed, 25 May 2005 05:24:03 +0200
Message-ID: <eb5350935b851591096485f158ba1ffe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4BBE81BF
	for <alsa-devel@alsa-project.org>; Wed, 25 May 2005 05:24:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1098> 
======================================================================
Reported By:                qwer1234
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1098
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             05-09-2005 17:09 CEST
Last Modified:              05-25-2005 05:24 CEST
======================================================================
Summary:                    aoss openal    gives too fast sound.
Description: 
Opanal layer gives too fast sound when I use aoss wrapper and I get this
error multiple times:

native_blitbuffer: select error occured

======================================================================

----------------------------------------------------------------------
 tiwai - 05-24-05 11:59 
----------------------------------------------------------------------
You can see the driver version in /proc/asound/version.

----------------------------------------------------------------------
 qwer1234 - 05-25-05 05:24 
----------------------------------------------------------------------
aoss armyops; works fine with alsa 1.0.9rc3a,
but openal doesn't give me any sound with alsa driver.
I think that this is openal bug, but I don't know that
for sure. I will try to debug openal. Mabey I will find out
what is wrong.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-09-05 17:09 qwer1234       New Issue                                    
05-09-05 17:15 qwer1234       Issue Monitored: qwer1234                    
05-17-05 17:52 tiwai          Note Added: 0004681                          
05-17-05 17:53 tiwai          Note Added: 0004682                          
05-18-05 00:38 qwer1234       Note Added: 0004685                          
05-18-05 00:41 qwer1234       Note Edited: 0004685                         
05-18-05 14:53 tiwai          Note Added: 0004687                          
05-18-05 14:55 tiwai          Note Added: 0004688                          
05-19-05 13:37 qwer1234       Note Added: 0004689                          
05-19-05 14:12 tiwai          Note Added: 0004690                          
05-19-05 16:59 qwer1234       Note Added: 0004694                          
05-24-05 11:59 tiwai          Note Added: 0004712                          
05-25-05 05:24 qwer1234       Note Added: 0004735                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
