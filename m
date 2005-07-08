From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001232]: Microphone in front bracket - very low volume
Date: Fri, 8 Jul 2005 16:18:01 +0200
Message-ID: <008a9727e1b3f54908afd4c4bfaf4836@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 70E3A18B
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 16:18:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1232> 
======================================================================
Reported By:                jirka
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1232
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               latest Ubuntu, RedHat (I tried them both)
Kernel Version:             2.6.10
======================================================================
Date Submitted:             07-04-2005 16:47 CEST
Last Modified:              07-08-2005 16:18 CEST
======================================================================
Summary:                    Microphone in front bracket - very low volume
Description: 
I have mainboard MicroStar K8N Neo2 Platinum-54G - nForce3 Ultra (it's
nforce ultra chipset with integrated sound chip). This board has 7.1 audio
and audio can be recorded via "sound in" jack (stereo jack connector) or
"microphone" jack. These input jacks are placed on the back side of the
case (on the mainboard). When I connect microphone to this jack and turn
it on, it works great. But there is an option to connect some "sound
bracket" to this board. You can buy computer case which has some input
jacks on the front side and connect the cable from them to your mainboard.
So you get two more jacks. One for phones and one for microphone. If you
have headset (for internet telephony) with earphones and microphone, you
don't need to connect them to the back side of your case. You connect them
to the front side.

And this is a problem. If I connect my microphone to the front "sound
bracket", the volume is very very low. If I connect it to the back jack
(integrated on motherboard), it works normally (I can record with normal
volume). 

I think this is not a configuration problem. I tried every combination in
alsamixer and nothing helps. Always front jack has very low audio. If I
record something using it, I need set very high volume to hear something,
if I play it.

Lots of people has these computer cases with front bracket and  think it's
very confusing when it works normally in Windows and in Linux you cannot
use the front connector.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 12:13 
----------------------------------------------------------------------
Can you record from the front mic?  I mean, not the passthru but record to
a file.  It might be that the front mic is a separate secondary mic, which
has to be handled differently.

Anyway, more detailed h/w information is required.  Please attach (upload)
/proc/asound/card0/codec97#0/* files and /etc/asound.state file.

----------------------------------------------------------------------
 jirka - 07-08-05 16:18 
----------------------------------------------------------------------
I´ve uploaded files you wanted. Recording to a file works ok. There is no
difference if I select mic1 or mic2 in alsamixer (maybe part of problem?),
it always records the sound.. The only difference is in the loudness of
the sound. If microphone is connected to motherboard connector, volume is
¨normal¨. When it is in the front bracket, volume is very low (you have to
turn volume to the maximum on amplifier to hear it).

MICROPHONE IN BOARD/alsamixer MIC1 - normal volume
MICROPHONE IN BOARD/alsamixer MIC2 - normal volume
MICROPHONE IN FRONT BRACKET/alsamixer MIC1 - very low volume
MICROPHONE IN FRONT BRACKET/alsamixer MIC2 - very low volume

I also tried to turn off the 20dB mic boost. The results:

MICROPHONE IN BOARD/alsamixer MIC1 - lower volume (but you can still hear
it)
MICROPHONE IN BOARD/alsamixer MIC2 - lower volume (but you can still hear
it)
MICROPHONE IN FRONT BRACKET/alsamixer MIC1 - very very very low volume
(you have to turn volume to the maximum on amplifier and put you ear on
the speaker)
MICROPHONE IN FRONT BRACKET/alsamixer MIC2 - same as above

Hope this helps. 

p.s. I´m leaving for holidays, so I cannot answer next 14 days.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-05 16:47 jirka          New Issue                                    
07-04-05 16:47 jirka          Distribution              => latest Ubuntu, RedHat
(I tried them both)
07-04-05 16:47 jirka          Kernel Version            => 2.6.10          
07-08-05 12:13 tiwai          Note Added: 0005416                          
07-08-05 15:31 jirka          File Added: ac97_0_0                         
07-08-05 15:31 jirka          File Added: ac97_0_0_regs                    
07-08-05 15:34 jirka          File Added: asound.state                     
07-08-05 16:18 jirka          Note Added: 0005432                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
