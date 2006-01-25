From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Wed, 25 Jan 2006 12:17:06 +0100
Message-ID: <b81527f27c5cbda53a9115a2d5d87769@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9AC52163
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 12:17:06 +0100 (MET)
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
Last Modified:              01-25-2006 12:17 CET
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
 Anho Ki - 01-18-06 23:42 
----------------------------------------------------------------------
with Ext.Amp. option turned on, 7,8 channels just work same as channel 1,2
with it turned off, 7,8 channels work as SB channels...

my patch is not from my idea, just do as moffa says in BTS#1090.
i don't know what i change is means... :)

anyway, i can't hear sounds from line-in or mic.
of course, i change HW & HW 1 to "HW IN 0"/"HW IN 1", but no sounds.

does anyone have ideas?
i enable on-board intel8x0 sound just for viewing TV. :(

----------------------------------------------------------------------
 Anho Ki - 01-25-06 12:17 
----------------------------------------------------------------------
i found the reason of poor sound quality,
there's some problem in my prodigy 7.1lt and my bt878 based tv tuner
card...

i upgrade bt878 based tv tuner card to cx88 based ATSC card :-)
and there're no quality matters...

how'bout applying patch i uploaded to alsa cvs?
(i know more tests must be done...)

any other progress?

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
01-17-06 16:39 tinez          Issue Monitored: tinez                       
01-18-06 23:42 Anho Ki        Note Added: 0007717                          
01-22-06 00:20 msmigiel       Issue Monitored: msmigiel                    
01-23-06 18:23 Demosthenes    Issue Monitored: Demosthenes                    
01-24-06 06:38 mccart         Issue Monitored: mccart                      
01-25-06 12:17 Anho Ki        Note Added: 0007780                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
