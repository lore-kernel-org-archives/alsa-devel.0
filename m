From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001197]: Realtek ALC650 output problem
Date: Thu, 23 Jun 2005 11:56:47 +0200
Message-ID: <cba7d086cdb0a10ee1f231e9d60df793@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 58E95216
	for <alsa-devel@alsa-project.org>; Thu, 23 Jun 2005 11:56:47 +0200 (MEST)
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
Last Modified:              06-23-2005 11:56 CEST
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
 jcdutton - 06-23-05 11:23 
----------------------------------------------------------------------
I have the ALC650 chip, and the output is also wrong for me.
I will investigate why when I get a moment and then fix the driver.

----------------------------------------------------------------------
 pzad - 06-23-05 11:56 
----------------------------------------------------------------------
I have via8233a + alc650d - and output using surround51 is OK for me with
alsa 1.0.9b.

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
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
