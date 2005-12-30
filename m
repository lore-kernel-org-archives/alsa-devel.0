From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001020]: Driver only records left channel when requested to record in stereo from Line-In
Date: Fri, 30 Dec 2005 05:15:09 +0100
Message-ID: <1ca44cc69e5203cf5f6ab56d7fe3c22f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 03B2F193
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2005 05:15:09 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1020> 
======================================================================
Reported By:                David Klusacek
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1020
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-29-2005 14:13 CEST
Last Modified:              12-30-2005 05:15 CET
======================================================================
Summary:                    Driver only records left channel when requested to
record in stereo from Line-In
Description: 

When recording analog source, only one channel is really being captured,
while the other returns some garbage (usually zeroes), regardless of the
program being used for recording. As it appears on at least three
different soundcards (snd-ens1371, snd-via82xx and snd-intel8x0 (intel
records left and omits right channel)), I think that the cause might have
something to do with the pcm core. 

Note also, that drivers for ens1371 and via82xx worked well in the older
(0.5.10b) versions of ALSA.


======================================================================

----------------------------------------------------------------------
 David Klusacek - 03-30-05 19:28 
----------------------------------------------------------------------
Of course that I checked the cable (and it is working since it works with
old kernel and old alsa). I even tried three diffrent machines, hence the
bug is quite independent of CPU and chipset used. 

Unfortunately I do not have any /etc/asound.state file on my machine (what
is it good for, anyway?). If you doubt about my mixer setting I attached
the output of amixer program  (file amixer.out). Hope this helps.

----------------------------------------------------------------------
 rlrevell - 12-30-05 05:15 
----------------------------------------------------------------------
Any updates on this?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-05 14:13 David Klusacek New Issue                                    
03-29-05 14:13 David Klusacek Kernel Version            => 2.6.11          
03-29-05 17:14 tiwai          Note Added: 0004248                          
03-29-05 20:14 David Klusacek Note Added: 0004257                          
03-29-05 20:19 tiwai          Note Added: 0004258                          
03-30-05 19:28 David Klusacek Note Added: 0004272                          
03-30-05 19:29 David Klusacek File Added: amixer.out                       
12-30-05 05:15 rlrevell       Note Added: 0007237                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
