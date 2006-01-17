From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Tue, 17 Jan 2006 11:13:58 +0100
Message-ID: <2b3478c7e30eeed32e23025b8a14deea@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D805E165
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2006 11:13:58 +0100 (MET)
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
Last Modified:              01-17-2006 11:13 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001090 Support for new Prodigy 7.1 LT
======================================================================

----------------------------------------------------------------------
 Anho Ki - 01-17-06 09:38 
----------------------------------------------------------------------
I made a small patch.

eeprom data returned to original prodigy's,
and using GPIO 5 to switch hp amp.

spdif optical output is works,
(i don't know it works correctly, but there's a light from optical jack :)
)
and external amp. setting is works, too.

when turn on ext.amp, 7,8 channel works as hp channel
turn it off, 7,8 channel may work as sb channel...
(not tested... does anyone use surround system? plz test it)

after applying this patch, i feel sound quality is a little poor than
before...
:(

----------------------------------------------------------------------
 robertdavid - 01-17-06 11:13 
----------------------------------------------------------------------
I have tryed that,you are right, it sounds litlle worse.
Dont know what you did, but it looks like link 7,8 output to 1,2 because
if I play mplayer w/o your patch I can hear only the truth 1,2 channel
(AC3 5.1), but If I use patch I can hear everything in 1,2 channel, so its
look like downmixed all to 1,2.. 
music is OK, but still little slower that it shoul be,, dont know it is
XMMS mistake, or driver.. But w/o the patch it sounds better (I have good
H.P. so I could hear it)
With AMP turned down nothing works, its like to swich off the soundcard..

I have 5.1 surround system but still never heard any sound from center,
rear..
What is exactly mutli track peak??

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
01-15-06 19:18 Anho Ki        Note Added: 0007667                          
01-17-06 01:21 Anho Ki        Note Added: 0007694                          
01-17-06 01:48 rlrevell       Relationship added       related to 0001090  
01-17-06 09:24 Anho Ki        File Added: prodigy71.patch                    
01-17-06 09:24 Anho Ki        Issue Monitored: Anho Ki                     
01-17-06 09:38 Anho Ki        Note Added: 0007695                          
01-17-06 11:13 robertdavid    Note Added: 0007696                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
