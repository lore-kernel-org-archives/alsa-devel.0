From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001197]: Realtek ALC650 output problem
Date: Mon, 27 Jun 2005 13:58:23 +0200
Message-ID: <e9b5140ce01b9ea5d875b4b7b43b2693@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BB9441DD
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 13:58:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1197> 
======================================================================
Reported By:                willits
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1197
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.11
======================================================================
Date Submitted:             06-16-2005 15:07 CEST
Last Modified:              06-27-2005 13:58 CEST
======================================================================
Summary:                    Realtek ALC650 output problem
Description: 
I have got a realtek ALC650 AC97 soundcard on my motherboard Abit BE7.
The problem is that I have got 5.1 speakers, and for have my subwoofer and
central speaker work, I need to put them on the "line in" connector
instead of the black connector (the black connector doesn't work).

I haven't got this problem with Windows.
======================================================================

----------------------------------------------------------------------
 tiwai - 06-24-05 18:41 
----------------------------------------------------------------------
2.0 -> 5.1 isn't supported _on hardware_ with ALC650.  Only 2.0 -> 4.0 is
supported.  But, of course, you can do 2.0->5.1 on software, i.e. in
alsa-lib configuration.  It's your homework :)

About 3D control: See my earlier comments.

----------------------------------------------------------------------
 willits - 06-27-05 13:58 
----------------------------------------------------------------------
I don't want 3D control (I have got 5.1 speaker that done this work).
I am searching in the alsa configuration, but I didn't really understand
the file alsa.conf, how I can get 2.0->5.1 by software ?

In the /usr/share/alsa/alsa.conf file, there are this :

defaults.ctl.card 0
defaults.pcm.card 0
defaults.pcm.device 0
defaults.pcm.subdevice -1
defaults.pcm.front.card defaults.pcm.card
defaults.pcm.front.device defaults.pcm.device
defaults.pcm.rear.card defaults.pcm.card
defaults.pcm.rear.device defaults.pcm.device
defaults.pcm.center_lfe.card defaults.pcm.card
defaults.pcm.center_lfe.device defaults.pcm.device
defaults.pcm.side.card defaults.pcm.card
defaults.pcm.side.device defaults.pcm.device
defaults.pcm.surround40.card defaults.pcm.card
defaults.pcm.surround40.device defaults.pcm.device
defaults.pcm.surround41.card defaults.pcm.card
defaults.pcm.surround41.device defaults.pcm.device
defaults.pcm.surround50.card defaults.pcm.card
defaults.pcm.surround50.device defaults.pcm.device
defaults.pcm.surround51.card defaults.pcm.card
defaults.pcm.surround51.device defaults.pcm.device
defaults.pcm.surround71.card defaults.pcm.card
defaults.pcm.surround71.device defaults.pcm.device
defaults.pcm.iec958.card defaults.pcm.card
defaults.pcm.iec958.device defaults.pcm.device
defaults.pcm.modem.card defaults.pcm.card
defaults.pcm.modem.device defaults.pcm.device
defaults.rawmidi.card 0
defaults.rawmidi.device 0
defaults.rawmidi.subdevice -1
defaults.hwdep.card 0
defaults.hwdep.device 0
defaults.timer.class 2
defaults.timer.sclass 0
defaults.timer.card 0
defaults.timer.device 0
defaults.timer.subdevice 0

--> In this, I have seen that : 

defaults.pcm.surround51.card defaults.pcm.card
defaults.pcm.surround51.device defaults.pcm.device

But I didn't know how I can configure Alsa-lib for use this (surround51).

If you can help me

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-16-05 15:07 willits        New Issue                                    
06-16-05 15:07 willits        Kernel Version            => 2.6.11          
06-16-05 15:13 pzad           Note Added: 0005056                          
06-16-05 15:19 willits        Note Added: 0005057                          
06-16-05 15:21 pzad           Note Added: 0005058                          
06-16-05 15:25 willits        Note Added: 0005059                          
06-16-05 15:43 pzad           Note Added: 0005060                          
06-16-05 16:10 willits        Note Added: 0005062                          
06-16-05 16:11 willits        File Added: test.state                       
06-17-05 15:10 tiwai          Note Added: 0005075                          
06-17-05 20:32 willits        Note Added: 0005079                          
06-17-05 20:34 willits        Note Added: 0005080                          
06-22-05 18:12 tiwai          Note Added: 0005139                          
06-23-05 11:17 willits        Note Added: 0005168                          
06-23-05 11:23 willits        Note Added: 0005169                          
06-23-05 11:23 jcdutton       Note Added: 0005170                          
06-23-05 11:56 pzad           Note Added: 0005172                          
06-23-05 12:01 tiwai          Note Added: 0005174                          
06-23-05 19:21 willits        Note Added: 0005192                          
06-23-05 19:26 willits        Note Added: 0005193                          
06-23-05 22:42 pzad           Note Added: 0005196                          
06-24-05 14:37 willits        Note Added: 0005220                          
06-24-05 14:54 tiwai          Note Added: 0005221                          
06-24-05 15:07 jcdutton       Note Added: 0005225                          
06-24-05 15:19 tiwai          Note Added: 0005227                          
06-24-05 15:24 willits        Note Added: 0005228                          
06-24-05 16:15 tiwai          Note Added: 0005232                          
06-24-05 16:24 tiwai          Note Added: 0005233                          
06-24-05 17:27 willits        Note Added: 0005241                          
06-24-05 17:28 willits        File Added: ICH4.conf                        
06-24-05 17:28 willits        File Added: ICH.conf                         
06-24-05 17:59 tiwai          Note Added: 0005245                          
06-24-05 18:23 willits        Note Added: 0005246                          
06-24-05 18:25 willits        Note Edited: 0005246                         
06-24-05 18:31 tiwai          Note Added: 0005247                          
06-24-05 18:36 willits        Note Added: 0005248                          
06-24-05 18:41 tiwai          Note Added: 0005249                          
06-27-05 13:58 willits        Note Added: 0005271                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
