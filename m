From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000709]: Recording doesnt work
Date: Tue, 7 Dec 2004 22:21:39 +0100
Message-ID: <0e68ee8302a298b4ae63468aef7fbcb6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DEDC83B5
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 22:21:39 +0100 (MET)
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
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-05-2004 16:33 CET
Last Modified:              12-07-2004 22:21 CET
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
 tiwai - 12-07-04 18:28 
----------------------------------------------------------------------
The attached strace shows obviously that the device is blocked.
It's being used by other applications.  It's not a bug at all.

If you get the I/O error (this appears after a certain wait time), it
means the DMA doesn't run properly.  Tuning the "Input Source Select"
often helps in the case of via82xx.

Also, make sure that you have no strange /etc/asound.conf and ~/.asoundrc
for testing.  Use the only default configuration.

----------------------------------------------------------------------
 tigermb - 12-07-04 22:21 
----------------------------------------------------------------------
It is strange. Even when i dont run X and dont run any sound related
programs, its still blocked.

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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
