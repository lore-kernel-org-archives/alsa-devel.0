From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Sat, 14 Jan 2006 18:09:03 +0100
Message-ID: <6c278327e4b79b623dcce6880804b25f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 131A8F9
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2006 18:09:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1744> 
======================================================================
Reported By:                robertdavid
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1744
Category:                   PCI - ice1724
Reproducibility:            sometimes
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Gentoo linux
Kernel Version:             2.6.14-archck-r7
======================================================================
Date Submitted:             01-13-2006 22:16 CET
Last Modified:              01-14-2006 18:09 CET
======================================================================
Summary:                    Audiotrak Prodigy 7.1LT is still unusable, only H.P.
chanel work and sound is quick...
Description: 
Im very glad that was added support for Prodigy, but there is still only
two channel working (7,8), the others are silent (tryed all volume
settings).
The sound from 7,8 chanel is good in case of quality, but is faster than
it should be (turn off Multi Track Rate Locking didnt do anything).
I've tryed mpalyer and XMMS, both the same.
I've compiled form CVS and keep it as it was (patched 13.1.2006 to support
Prodigy 7.1LT) 
======================================================================

----------------------------------------------------------------------
 robertdavid - 01-14-06 00:29 
----------------------------------------------------------------------
I have also make a progress,,
in alsa mizer set up 'Multi Track Rate Locking' false 
than set up 44100 sample rate and it becames paly nearly normal,
I could say NEARLY becasuse I check the timings of music and find out that
one minute of song last 1:05 min. but it is better than one minute in
30-40sec...

Next I made the front channel play, but very silent, I have to turn my AMP
up very much to produce normal sound...

Didnt get to play more than 2 channels of 5.1 chanel wideo, H.P. line is
downmixed so If i use head phones or plug front speakers to H.P. line it
is OK (you should hear the woices etc.)
chanel 1,2 play but only true, silent stereo (in movie play only 2
chanels, so no voices etc.)
I still never heard any sound of 3-6 channel (rear,SW,C)



----------------------------------------------------------------------
 robertdavid - 01-14-06 18:09 
----------------------------------------------------------------------
and dont know how to get input line-in play to H.P. or speakers

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-13-06 22:16 robertdavid    New Issue                                    
01-13-06 22:16 robertdavid    Distribution              => Gentoo linux    
01-13-06 22:16 robertdavid    Kernel Version            => 2.6.14-archck-r7
01-14-06 00:13 drfindley      File Added: asound.state                     
01-14-06 00:15 drfindley      Note Added: 0007650                          
01-14-06 00:16 drfindley      Issue Monitored: drfindley                    
01-14-06 00:28 robertdavid    Note Added: 0007651                          
01-14-06 00:29 robertdavid    Note Edited: 0007651                         
01-14-06 18:09 robertdavid    Note Added: 0007654                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
