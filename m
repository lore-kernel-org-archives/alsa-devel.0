From: bugtrack@alsa-project.org
Subject: [ALSA - tools 0000436]: How to have sound to Digital and Analog at the same time ?
Date: Tue, 9 Nov 2004 16:16:51 +0100
Message-ID: <92a4e908597db47ff21e6306b1525a1d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1ACA7244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:16:52 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=436> 
======================================================================
Reported By:                tho_x_tran
Assigned To:                perex
======================================================================
Project:                    ALSA - tools
Issue ID:                   436
Category:                   ac3dec
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-12-2004 20:36 CEST
Last Modified:              11-09-2004 16:16 CET
======================================================================
Summary:                    How to have sound to Digital and Analog at the same
time ?
Description: 
I play Xine and Watch TV at the same time, and Xine audio can only go to
Digital Opt out while TV sound goes to Analog front speakers only.  How
can I make it go to both devices AT THE SAME TIME for all applications.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-01-04 22:53 
----------------------------------------------------------------------
Basically it's a job of application.
ALSA doesn't decode AC3 by itself.
So, apps should send both AC3-analog and AC3-passthru signals to
different PCM (if possible).  And, this is not always possible
on many motherboards...

----------------------------------------------------------------------
 perex - 09-07-04 16:38 
----------------------------------------------------------------------
Application problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-12-04 20:36 tho_x_tran     New Issue                                    
08-12-04 20:36 tho_x_tran     File Added: asound.conf                      
09-01-04 22:53 tiwai          Note Added: 0001678                          
09-07-04 16:38 perex          Status                   assigned => resolved
09-07-04 16:38 perex          Resolution               open => fixed       
09-07-04 16:38 perex          Note Added: 0001712                          
11-09-04 16:16 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
