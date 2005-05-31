From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000816]: No connexion sound & long time to connect
Date: Tue, 31 May 2005 18:02:00 +0200
Message-ID: <6d84ea5c2992210d5ce506c0bfc9bd05@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CBC4E1B6
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:02:00 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=816> 
======================================================================
Reported By:                Cyrille
Assigned To:                sashak
======================================================================
Project:                    ALSA - driver
Issue ID:                   816
Category:                   PCI - atiixp-modem
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Slackware
Kernel Version:             2.4.26
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-13-2005 22:51 CET
Last Modified:              05-31-2005 18:02 CEST
======================================================================
Summary:                    No connexion sound & long time to connect
Description: 
Hi,
On my Toshiba Satellite A30 laptop with ATI IXP MODEM I have finally
succeeded to run my modem (1002:434d  ATI) on a slackware 10.0 with 2.4.26
kernel.
(I'm using it at this time)
But, 2 little bugs :
- first : no sound during numbering & connexion
- second : there's a long time (20 secondes approximtively) before
connexion (after ATDT command).

I give you this info :

I use :
- slmodem-2.9.10
- alsa-1.0.7
- connexion with kppp (KDE 3.2)

=======================
root@tromatism:/home/cyrille# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: IXP [ATI IXP], device 0: ATI IXP AC97 [ATI IXP AC97]
  Subdevices: 1/1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
card 1: Modem [ATI IXP Modem], device 0: ATI IXP MC97 [ATI IXP MC97]
  Subdevices: 0/1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
======================


Can you explain the problem ?
Should I wait the alsa-driver 1.0.8 ?

Cheers,
Cyrille
======================================================================

----------------------------------------------------------------------
 Cyrille - 01-17-05 20:52 
----------------------------------------------------------------------
Hello
I've got download the alsa-* 1.0.8 and it's seem work fine
Thanx a lot !
Cheers
Cyrille

----------------------------------------------------------------------
 tiwai - 01-18-05 19:20 
----------------------------------------------------------------------
Closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-13-05 22:51 Cyrille        New Issue                                    
01-13-05 22:51 Cyrille        Distribution              => Slackware       
01-13-05 22:51 Cyrille        Kernel Version            => 2.4.26          
01-14-05 21:59 sashak         Note Added: 0003209                          
01-17-05 20:52 Cyrille        Note Added: 0003239                          
01-18-05 19:20 tiwai          Status                   assigned => resolved
01-18-05 19:20 tiwai          Resolution               open => fixed       
01-18-05 19:20 tiwai          Note Added: 0003259                          
05-31-05 18:02 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
