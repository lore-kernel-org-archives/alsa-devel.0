From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001549]: Any chance for SPDIF support soon with the ALC880?
Date: Wed, 4 Jan 2006 17:31:30 +0100
Message-ID: <64d5eb76f7012ea223c7aa67f63985e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09710154
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:31:30 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1549> 
======================================================================
Reported By:                dvlierop
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1549
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             11-12-2005 11:05 CET
Last Modified:              01-04-2006 17:31 CET
======================================================================
Summary:                    Any chance for SPDIF support soon with the ALC880?
Description: 
On my Shuttle ST20G5 I don't get any digital output at all so I guess It's
not supported. Any outlook for SPDIF support? (or is it already included
and is something wrong with my system?)

Specs: Shuttle ST20G5 barebone with Realtek ALC880, AMD Athlon 64 3000+
======================================================================

----------------------------------------------------------------------
 dvlierop - 01-02-06 21:53 
----------------------------------------------------------------------
That file is empty! Is this of any help for you?

[diedenrezi@ShuttleST20G5 ~]$ ls /proc/asound/card0 -l
total 0
-r--r--r--  1 root root 0 Jan  2 21:52 codec#0
-r--r--r--  1 root root 0 Jan  2 21:52 id
-rw-r--r--  1 root root 0 Jan  2 21:52 oss_mixer
dr-xr-xr-x  4 root root 0 Jan  2 21:52 pcm0c
dr-xr-xr-x  3 root root 0 Jan  2 21:52 pcm0p
dr-xr-xr-x  3 root root 0 Jan  2 21:52 pcm1p

----------------------------------------------------------------------
 tiwai - 01-04-06 17:31 
----------------------------------------------------------------------
These proc files are not empty although ls shows so.  Just cat it.

Which option did it work correctly indeed?  Inform it together with the
output of "lspci -nv".

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 11:05 dvlierop       New Issue                                    
11-14-05 11:07 perex          Note Added: 0006715                          
11-14-05 11:07 perex          Assigned To              tiwai => perex      
11-14-05 11:07 perex          Status                   assigned => feedback
11-18-05 18:32 dvlierop       Note Added: 0006755                          
01-02-06 20:43 rlrevell       Note Added: 0007388                          
01-02-06 21:53 dvlierop       Note Added: 0007390                          
01-04-06 17:31 tiwai          Note Added: 0007442                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
