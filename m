From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001304]: Speaker test hangs
Date: Sat, 31 Dec 2005 21:38:01 +0100
Message-ID: <e0f7743494e758215869bb9ac739643b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4D76C167
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2005 21:38:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1304> 
======================================================================
Reported By:                herby
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1304
Category:                   speakertest
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             08-03-2005 02:46 CEST
Last Modified:              12-31-2005 21:38 CET
======================================================================
Summary:                    Speaker test hangs
Description: 
After applying the patch to the library that took out the check for a
proper "start_threshold" (file .../alsa-lib/src/pcm/pcm.c around lines 834
or so), I attempted to try a speaker test again.  It hung right after
outputting "0 - Front Left".  I did an strace and the results are included
in the file attached.  I attempted to vary the sample rate (to 44.1 kHz)
with little luck.  The wierd thing is that I can execute 'aplay' (with the
default device) and get a '.wav' file to play nicely.  I can even get a
multi-channel (4 to be exact) ".wav" file to go thru 'aplay'.  Why
speaker-test doesn't work is beyond me.  The problem is that I appear to
use similar techniques in my own programming as speaker-test, and my
program doesen't do that well.  Being as how speaker-test IS part of ALSA,
I thought I would submit the bug report against it.

If other tests need be preformed, I'd be VERY happy to do them.
======================================================================

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:24 
----------------------------------------------------------------------
Any improvement in later releases?

----------------------------------------------------------------------
 herby - 12-31-05 21:38 
----------------------------------------------------------------------
I had no problems with later versions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 02:46 herby          New Issue                                    
08-03-05 02:46 herby          File Added: speaker-trace                    
08-03-05 12:18 tiwai          Note Added: 0005621                          
08-04-05 03:21 herby          Note Added: 0005638                          
08-04-05 14:10 jcdutton       Note Added: 0005648                          
08-04-05 20:21 herby          Note Added: 0005652                          
08-09-05 06:58 herby          Note Added: 0005718                          
08-12-05 08:12 herby          Note Added: 0005765                          
08-12-05 15:47 tiwai          Note Added: 0005773                          
12-30-05 23:24 rlrevell       Note Added: 0007288                          
12-31-05 21:38 herby          Note Added: 0007360                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
