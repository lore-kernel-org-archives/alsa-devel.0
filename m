From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000334]: EMU10K1, capturing audio is impossible
Date: Tue, 9 Nov 2004 16:13:43 +0100
Message-ID: <2b380f62000281da680c7ddf7bcd9bcb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id EEE7C244
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:13:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=334> 
======================================================================
Reported By:                netslayer
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   334
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.7rc love-sources
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             06-13-2004 23:30 CEST
Last Modified:              11-09-2004 16:13 CET
======================================================================
Summary:                    EMU10K1, capturing audio is impossible
Description: 
I have an Audigy (EMU10K2 -- on EMU10K1 drivers). It has worked perfectly
in 0.9.8, and in 1.0.x I can playback audio fine, but capturing seems
impossible.

In 0.9.8 I was able to select a capture source in alsamixer by selecting
it with the space bar. The source had "---" areas above it that meant it
had the capture ability. In 1.0.x that whole functionality is gone, and I
see no more way to capture audio. 

I have all my sources up to 100%, and when I plug in an audio to source
into LINE IN on the Audigy, I hear nor can record anything. If I unmute
LINE IN in alsamixer, then I hear pass through audio, which I don't want.
I want to be able to record it, but not hear it through a pass through. 

I know several people with this problem, and I myself have a few of these
cards dedicated to MythTV PVR boxes, and this problem makes it impossible
to upgrade ALSA... It's been 6 months since I tried this, and since nobody
reported it, I thought I would. 
======================================================================

----------------------------------------------------------------------
 pzad - 08-30-04 12:04 
----------------------------------------------------------------------
Not response for 2 weeks.

----------------------------------------------------------------------
 tiwai - 11-09-04 16:13 
----------------------------------------------------------------------
No response from reporter.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-13-04 23:30 netslayer      New Issue                                    
06-13-04 23:30 netslayer      Distribution              => Gentoo          
06-13-04 23:30 netslayer      Kernel Version            => 2.6.7rc love-sources
06-14-04 01:38 netslayer      Note Added: 0001305                          
06-14-04 08:19 pzad           Note Added: 0001306                          
06-28-04 09:15 pzad           Status                   new => assigned     
06-28-04 09:15 pzad           Assigned To               => pzad            
08-06-04 15:01 pzad           Note Added: 0001540                          
08-06-04 15:02 pzad           Status                   assigned => feedback
08-06-04 15:02 pzad           Description Updated                          
08-06-04 15:02 pzad           Steps to Reproduce Updated                    
08-06-04 15:02 pzad           Additional Information Updated                    
08-30-04 12:04 pzad           Status                   feedback => resolved
08-30-04 12:04 pzad           Resolution               open => not an issue
08-30-04 12:04 pzad           Note Added: 0001667                          
11-09-04 16:13 tiwai          Status                   resolved => closed  
11-09-04 16:13 tiwai          Note Added: 0002327                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
