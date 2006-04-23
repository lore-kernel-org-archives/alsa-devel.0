From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Sun, 23 Apr 2006 12:42:24 +0200
Message-ID: <bc00cae044206562e1e646c5ff1a04e1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D878B17E
	for <alsa-devel@alsa-project.org>; Sun, 23 Apr 2006 12:42:24 +0200 (MEST)
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
Last Modified:              04-23-2006 12:42 CEST
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
 Demosthenes - 03-29-06 18:02 
----------------------------------------------------------------------
Hi, I haven't had much time to play with this card recently and have been
making do with the support added in #1090. However I have just applied the
patch from here and I am very pleased with the result. Sound can now be
played out of the front channel with good volume and much better quality
than was previously possible for me (out of the front channel).

Before I was getting all my sound from the headphone channel and although
it is possible that the sound now produced sounds slightly different to
before (I think I would struggle to think there was any difference if I
wasn't looking for it) I would not say the sound is of worse quality.

The way the external amplifier switch is used to control the headphone
channel is perfect for my use which would be connecting either stereo
speakers or headphones to the card.

I think this is a definite step up from before and should be added to alsa
CVS.

With regards to the quality issues people are having, can you elaborate on
how it sounds worse. If we could get some more people to test this for the
perceived quality issues (there were plenty in the other thread) that
would also be helpful.

----------------------------------------------------------------------
 Demosthenes - 04-23-06 12:42 
----------------------------------------------------------------------
Just another request that the patch from here be added to ALSA CVS.

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
01-26-06 23:40 robertdavid    Note Added: 0007794                          
03-08-06 20:45 robertdavid    Note Added: 0008385                          
03-08-06 20:50 robertdavid    Note Edited: 0008385                         
03-24-06 23:21 jimgleason     Issue Monitored: jimgleason                    
03-29-06 18:02 Demosthenes    Note Added: 0008997                          
04-23-06 12:42 Demosthenes    Note Added: 0009442                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
