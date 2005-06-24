From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001197]: Realtek ALC650 output problem
Date: Fri, 24 Jun 2005 18:41:47 +0200
Message-ID: <45ac16b07890ffe130ebbc76647ecffc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A6C7223D
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 18:41:47 +0200 (MEST)
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
Last Modified:              06-24-2005 18:41 CEST
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
 willits - 06-24-05 18:36 
----------------------------------------------------------------------
Yes, but when I enable Duplicate front, I have got only front and rear
speaker who work, no LFE or center. (These speaker are on the black
connector)

But I want to know If I can enable this feature of my soundcard :


White-Side:/proc/asound/card0/codec97#0 # cat ac97#0-0
0-0/0: Realtek ALC650E

Capabilities :
DAC resolution : 20-bit
ADC resolution : 18-bit
3D enhancement : Realtek 3D Stereo Enhancement --> I want to enable this

Current setup
Mic gain : +0dB [+0dB]
POP path : pre 3D
Sim. stereo : off
3D enhancement : off --> This is disabled

----------------------------------------------------------------------
 tiwai - 06-24-05 18:41 
----------------------------------------------------------------------
2.0 -> 5.1 isn't supported _on hardware_ with ALC650.  Only 2.0 -> 4.0 is
supported.  But, of course, you can do 2.0->5.1 on software, i.e. in
alsa-lib configuration.  It's your homework :)

About 3D control: See my earlier comments.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
