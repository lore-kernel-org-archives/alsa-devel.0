From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001548]: "alsa-play: xrun of at least 0.009 msecs. resetting stream" : inopportune small pauses while playing
Date: Sat, 7 Jan 2006 16:57:20 +0100
Message-ID: <14afbd34938b8a28e4db601e38c7c0fa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F3543116
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2006 16:57:20 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1548> 
======================================================================
Reported By:                moncnam
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1548
Category:                   PCI - intel8x0m
Reproducibility:            random
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               debian sarge 3.1
Kernel Version:             2.6.13-rc7
======================================================================
Date Submitted:             11-12-2005 10:58 CET
Last Modified:              01-07-2006 16:57 CET
======================================================================
Summary:                    "alsa-play: xrun of at least 0.009 msecs. resetting
stream" : inopportune small pauses while playing
Description: 
whatever the player i use (alsaplayer, xmms, mplayer) i experience small
pause while playing (half of a second)
using mplayer, i can see the following message appearing when the pause
occur
<<alsa-play: xrun of at least 0.009 msecs. resetting stream>>
the playing doesn't stop, it continue well, just a small pause
i have no other messages in `dmesg` or in syslog
======================================================================

----------------------------------------------------------------------
 rlrevell - 01-07-06 09:00 
----------------------------------------------------------------------
ALSA does provide mixing by default since version 1.0.9.

Try deleting the .asoundrc and it should work.

----------------------------------------------------------------------
 moncnam - 01-07-06 16:57 
----------------------------------------------------------------------
okay, thanx, 
unfortunatelly, i have alsa 109 : 
<<
$ cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b (Thu Jul 28
12:20:13 2005 UTC).
$ cat /etc/debian_version
3.1
$ uname -a
Linux station 2.6.13-rc7 #9 Sun Oct 30 23:30:01 CET 2005 i686 GNU/Linux
>>
i will wait a little before switching to 109 with a new kernel

now, everything is working except thunderbird which outputs in 441000
(scrippy sound with 48000 filter) : i will try to revert all to 441000

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-05 10:58 moncnam        New Issue                                    
11-12-05 10:58 moncnam        Distribution              => debian sarge 3.1
11-12-05 10:58 moncnam        Kernel Version            => 2.6.13-rc7      
11-21-05 23:56 sashak         Note Added: 0006779                          
11-22-05 00:04 moncnam        Note Added: 0006781                          
11-22-05 00:31 sashak         Note Added: 0006783                          
11-22-05 00:31 sashak         Assigned To              sashak =>           
11-22-05 00:43 moncnam        Note Added: 0006784                          
01-04-06 22:38 moncnam        Note Added: 0007456                          
01-07-06 02:14 sashak         Note Added: 0007503                          
01-07-06 03:58 moncnam        Note Added: 0007505                          
01-07-06 04:04 moncnam        Note Added: 0007506                          
01-07-06 09:00 rlrevell       Note Added: 0007509                          
01-07-06 16:57 moncnam        Note Added: 0007516                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
