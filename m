From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001651]: ac3 passthrough not really
	work with ac3dec
Date: Sun, 23 Jul 2006 18:45:21 +0200
Message-ID: <8623e8eff210ef2ce08c8a538d00df3c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D99E521D
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 18:45:21 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1651> 
======================================================================
Reported By:                tycordinal
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   1651
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.4.31
======================================================================
Date Submitted:             12-14-2005 09:44 CET
Last Modified:              07-23-2006 18:45 CEST
======================================================================
Summary:                    ac3 passthrough not really work with ac3dec
Description: 
using the following from alsa-tools to play ac3 as passthrough:
ac3dec -C oneac3file.ac3 


the ac3dec is able to "open" the spdif device "iec958:{AES...}" and did
not report any error and keep on running, but the ac3 decoder (creative
ddts-100), connected to the "spdif output" from the card, did not switch
to dolby mode, and no sound come out from speaker.

one interesting thing is, when I run this:
ac3dec -6 oneac3file.ac3 

As this is software decoding to PCM, I can hear the left/right channels
from the front stereo jacket, as they also output on the "spdif output".
Therefore, I believe the "spdif output" on the card is indeed working,
just that for this card we might need to write some different AES command
to open the spdif output?

I am not sure if the alsa config files in /usr/share/alsa have to change
or maybe some "switches" in emu10k1_main.c needs to apply for the "spdif
output" to  really behave as "iec958" device to passthough ac3 stream to
external decoder.

Thanks.





======================================================================

----------------------------------------------------------------------
 jcdutton - 07-23-06 18:44 
----------------------------------------------------------------------
Which sound card are you using?
cat /proc/asound/cards
cat /proc/asound/version

----------------------------------------------------------------------
 jcdutton - 07-23-06 18:45 
----------------------------------------------------------------------
Please provide the requested feedback.


Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-14-05 09:44 tycordinal     New Issue                                    
12-14-05 09:44 tycordinal     Kernel Version            => 2.4.31          
12-14-05 10:05 tycordinal     Note Added: 0007031                          
12-14-05 10:15 tycordinal     Note Added: 0007032                          
12-14-05 10:16 tycordinal     Note Added: 0007033                          
12-14-05 10:30 pzad           Note Added: 0007034                          
12-14-05 10:31 tycordinal     Note Added: 0007035                          
12-14-05 10:53 pzad           Note Added: 0007036                          
07-18-06 14:43 jcdutton       Status                   new => assigned     
07-18-06 14:43 jcdutton       Assigned To               => jcdutton        
07-23-06 18:44 jcdutton       Note Added: 0011196                          
07-23-06 18:45 jcdutton       Note Added: 0011197                          
07-23-06 18:45 jcdutton       Status                   assigned => feedback
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
