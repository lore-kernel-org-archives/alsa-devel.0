From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Tue, 23 May 2006 19:24:24 +0200
Message-ID: <cc9e55e13af766e16e6fe93785b04343@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5BFDE189
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2006 19:24:24 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1744> 
======================================================================
Reported By:                robertdavid
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1744
Category:                   PCI - ice1724
Reproducibility:            sometimes
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               Gentoo linux
Kernel Version:             2.6.14-archck-r7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-13-2006 22:16 CET
Last Modified:              05-23-2006 19:24 CEST
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
 Anho Ki - 04-23-06 22:43 
----------------------------------------------------------------------
sorry... i don't use prodigy 7.1lt anymore...
i bought prodigy 7.1(NOT LT), and sold 7.1LT...

the only problem for me was that i couldn't enable line-in.
7.1LT doesn't have ac97 codec, so maybe it needs another way to control
ADC.

i asked to Audiotrak, how i can use this stuff in linux,
but there're no answers. :(
their technical support is not good, and they have no plans to test it on
linux.
(not developing drivers, just testing...)

and their new product, Prodigy HD2, doesn't use its own driver anymore.
and it will use VIA's reference driver.
(then, it must store correct informations in EEPROM?)
in my opinion, we'd better use this new product or something from
others... :(
(i don't know whether they launch it over korea or only in korea)

anyway, with patch in here,
i could get correct outputs from all jacks(front, rear, c/s, bs, and
optical).

that's all i can say about...
i hope someone will work for this...

----------------------------------------------------------------------
 rlrevell - 05-23-06 19:24 
----------------------------------------------------------------------
Patch has been merged, the device is supported.

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
04-23-06 22:43 Anho Ki        Note Added: 0009444                          
05-23-06 19:24 rlrevell       Status                   new => resolved     
05-23-06 19:24 rlrevell       Resolution               open => fixed       
05-23-06 19:24 rlrevell       Assigned To               => rlrevell        
05-23-06 19:24 rlrevell       Note Added: 0009949                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
