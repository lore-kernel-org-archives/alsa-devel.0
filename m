From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000709]: Recording doesnt work
Date: Tue, 11 Jan 2005 16:53:47 +0100
Message-ID: <c22021500f2f4fd91e3f42d05ac8f764@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 03DE4290
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 16:53:47 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=709> 
======================================================================
Reported By:                tigermb
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   709
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             12-05-2004 16:33 CET
Last Modified:              01-11-2005 16:53 CET
======================================================================
Summary:                    Recording doesnt work
Description: 
Soundcard: Multimedia audio controller: VIA Technologies, Inc.
VT8233/A/8235/8237 AC97 Audio Controller (rev 60)

The recording doesnt work.
When trying to record, nuthing happens. No errors. Although gnome-meeting
got an error and wonders if i have permission to device. But i tried it
under root and i get the same error. arecord give no error, but just
doesnt do anything.
======================================================================

----------------------------------------------------------------------
 tigermb - 12-08-04 17:01 
----------------------------------------------------------------------
I installed mandrakes latest kernel whether to see that helped. And the
problem is gone now. I guess some mandrake thing somehow blocked the
device. I guess it wasnt a bug. 
I'm sorry to have bothered you with this.

----------------------------------------------------------------------
 tiwai - 12-08-04 20:10 
----------------------------------------------------------------------
OK, now closing.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-05-04 16:33 tigermb        New Issue                                    
12-05-04 16:34 tigermb        Issue Monitored: tigermb                     
12-06-04 20:59 tiwai          Note Added: 0002735                          
12-06-04 23:24 tigermb        File Added: asound.state                     
12-06-04 23:25 tigermb        Note Added: 0002738                          
12-07-04 14:32 tiwai          Note Added: 0002747                          
12-07-04 17:59 tigermb        Note Added: 0002750                          
12-07-04 18:01 tigermb        Note Added: 0002751                          
12-07-04 18:22 tigermb        File Added: strace.log                       
12-07-04 18:23 tigermb        Note Added: 0002752                          
12-07-04 18:28 tiwai          Note Added: 0002754                          
12-07-04 22:21 tigermb        Note Added: 0002767                          
12-08-04 12:10 tiwai          Note Added: 0002777                          
12-08-04 17:01 tigermb        Note Added: 0002788                          
12-08-04 20:10 tiwai          Status                   new => resolved     
12-08-04 20:10 tiwai          Resolution               open => not an issue
12-08-04 20:10 tiwai          Assigned To               => tiwai           
12-08-04 20:10 tiwai          Note Added: 0002793                          
12-08-04 20:10 tiwai          Assigned To              tiwai =>            
01-11-05 16:53 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
