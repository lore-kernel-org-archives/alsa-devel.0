From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001744]: Audiotrak Prodigy 7.1LT is still unusable, only H.P. chanel work and sound is quick...
Date: Wed, 8 Mar 2006 20:45:47 +0100
Message-ID: <7387909d63c44f601b144edd9f5aa876@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D785E1C5
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2006 20:45:47 +0100 (MET)
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
Last Modified:              03-08-2006 20:45 CET
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
 robertdavid - 01-26-06 23:40 
----------------------------------------------------------------------
I dont think it's only your TV-card, what makes the sound bad, I feel the
sound litlle bit strange, maybe its my subjective feeling,,

Did you tryed other chanels? 5.1, just plug in stereo to rear, centr
channel (if you dont have 5.1 system)

I dont know how strong is the headphone AMP and how could be boost under
windows, but I thinkt its not souch powerfull as it should be, I cant use
more than 100% master, 70% PCM, if more the sound becames "cracky" and I
dont think its soch as much loud (I have H.P. Sennheiser HD200 64ohm) and
this card should be done for H.P. like this... Im not deaf but sometimes
feel that I want turn the wolume little up..

How can I fiddle with the wolume settings in driver?? Im not a programmer
but undestand elektonics, and I think this is because there is set higher
level of input to AMP than it should be, and than turn the AMP little
up,,, 

And there realy need to be synchronized the sound with real time,, its not
xmms mistake, it does also mplayer

----------------------------------------------------------------------
 robertdavid - 03-08-06 20:45 
----------------------------------------------------------------------
I found out that if I set sampling freq to 24k the sound speed is as long
as it should be.. (dont heat any sound quality demage?!?! in less than 22k
the demage can be heard)

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
