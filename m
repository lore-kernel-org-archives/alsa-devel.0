From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000757]: Noisy recording for oss emulation
Date: Fri, 30 Dec 2005 23:05:28 +0100
Message-ID: <6a1774748b1f9929f4d83b246ddd02e6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1C66919A
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 23:05:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=757> 
======================================================================
Reported By:                tomasz_janowski
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   757
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 2
Kernel Version:             2.6.8.1
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-29-2004 07:49 CET
Last Modified:              12-30-2005 23:05 CET
======================================================================
Summary:                    Noisy recording for oss emulation
Description: 
I noticed that when I use arecord for recording on the VT82C686 AC97 Audio
sound card the sound is very good, but using the rec (OSS) program I
always have some additional sounds - static - during recording. I have on
the same computer the Ensoniq ES1371 card and almost identical setup for
it but I haven't similar problems with OSS emulation.
======================================================================

----------------------------------------------------------------------
 jdthood - 09-14-05 16:12 
----------------------------------------------------------------------
Submitter: Is this problem fixed in more recent ALSA versions?

----------------------------------------------------------------------
 rlrevell - 12-30-05 23:05 
----------------------------------------------------------------------
No response

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-29-04 07:49 tomasz_janowskiNew Issue                                    
12-29-04 07:49 tomasz_janowskiDistribution              => Fedora Core 2   
12-29-04 07:49 tomasz_janowskiKernel Version            => 2.6.8.1         
12-29-04 07:50 tomasz_janowskiFile Added: xx.wav                           
12-29-04 07:51 tomasz_janowskiNote Added: 0002992                          
09-14-05 16:12 jdthood        Note Added: 0006177                          
12-30-05 23:05 rlrevell       Status                   new => closed       
12-30-05 23:05 rlrevell       Note Added: 0007276                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
