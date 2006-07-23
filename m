From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001651]: ac3 passthrough not really
	work with ac3dec
Date: Sun, 23 Jul 2006 18:44:48 +0200
Message-ID: <270ffc9bee238fce0b0096162c742be5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA8F617E
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 18:44:48 +0200 (MEST)
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


A NOTE has been added to this issue.
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
Status:                     assigned
Distribution:               
Kernel Version:             2.4.31
======================================================================
Date Submitted:             12-14-2005 09:44 CET
Last Modified:              07-23-2006 18:44 CEST
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
 pzad - 12-14-05 10:53 
----------------------------------------------------------------------
IEC958 Optical Raw - this is just multiplexer switch.
If there is MM - this means spdif output comes from DSP and from normal
playback device.
If there is OO - spdif output comes from iec958 (or spdif) device.

Please do, what I suggest you in previous note.
Your problem is "Audigy Analog/Digital Output Jack" control.

----------------------------------------------------------------------
 jcdutton - 07-23-06 18:44 
----------------------------------------------------------------------
Which sound card are you using?
cat /proc/asound/cards
cat /proc/asound/version

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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
