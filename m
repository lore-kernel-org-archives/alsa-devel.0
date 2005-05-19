From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001114]: Redline depends on terminal height
Date: Thu, 19 May 2005 14:18:45 +0200
Message-ID: <8700213d083b9b87ed37a17721d7b60a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2135D225
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2005 14:18:46 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1114> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Issue ID:                   1114
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             05-17-2005 22:33 CEST
Last Modified:              05-19-2005 14:18 CEST
======================================================================
Summary:                    Redline depends on terminal height
Description: 
The submitter of Debian bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=309337 says the
following:

I noticed that that running alsamixer on a 50-line xterm, red appears on
my volume controls between 79 and 81. On a 24-line xterm, it appears
between 71 and 73. This seems slightly odd, though I don't know if
there's any way to tell what PC soundcard mixers happen to put out. :)
======================================================================

----------------------------------------------------------------------
 tiwai - 05-19-05 14:18 
----------------------------------------------------------------------
Yes, it depends on the terminal height.  The red line starts over "almost"
80% but it can't be exat in the lower height (resolution).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-17-05 22:33 jdthood        New Issue                                    
05-19-05 14:18 tiwai          Status                   new => resolved     
05-19-05 14:18 tiwai          Resolution               open => won't fix   
05-19-05 14:18 tiwai          Assigned To               => tiwai           
05-19-05 14:18 tiwai          Note Added: 0004692                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
