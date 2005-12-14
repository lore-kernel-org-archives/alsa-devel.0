From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001651]: ac3 passthrough not really work with ac3dec
Date: Wed, 14 Dec 2005 10:31:34 +0100
Message-ID: <f3ab6389ce7d6c780c6d164c9b9e39c3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 11A401B1
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2005 10:31:35 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1651> 
======================================================================
Reported By:                tycordinal
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1651
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.4.31
======================================================================
Date Submitted:             12-14-2005 09:44 CET
Last Modified:              12-14-2005 10:31 CET
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
 pzad - 12-14-05 10:30 
----------------------------------------------------------------------
IEC958 Optical Raw - this looks correct.

Problem can be with "Audigy Analog/Digital Output Jack".

Looks like Audigy 4 works diffrently as others Audigy *.

Try to find file /usr/share/alsa/conf/cards/Audigy2.conf.

In this file find this

{
     name "Audigy Analog/Digital Output Jack"
     lock true
     preserve true
     value 1
} 

and change it to

{
     name "Audigy Analog/Digital Output Jack"
     lock true
     preserve true
     value 0
}

----------------------------------------------------------------------
 tycordinal - 12-14-05 10:31 
----------------------------------------------------------------------
interesting things:

when doing ac3dec -6 oneac3file.ac3 ,
there is sound coming out from the spdif output, and when i use alsamixer
to make "IEC958 Optical Raw" from "MM" to become "OO", the sound stop
coming out. When I make it as "MM", the sound come back again. In this
case, alsamixer can toggled the sound output, if spdif output is playing
digital stereo.

when doing ac3dec -C oneac3file.ac3,
alsamixer show "IEC958 Optical Raw" as "OO" , and there is no dolby light
on the decoder (creative DDTS-100). when I make it "MM", there is still no
dolby light.  when I exit alsamixer and run alsamixer again, "IEC958
Optical Raw" has become "OO". In this case, alsamixer cannot help to get
ac3 passthough from the spdif output, because it cannot really make
"IEC958 Optical Raw" as "MM", even though it seems it can. After ac3dec
finished, "IEC958 Optical Raw" back to "MM" again, as shown by running
alsamixer again.

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
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
