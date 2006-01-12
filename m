From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001232]: Microphone in front bracket - very low volume
Date: Fri, 13 Jan 2006 00:14:49 +0100
Message-ID: <333b69b76f0ee2d2a0c27473a9ca554e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5ADEA144
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 00:14:49 +0100 (MET)
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


The following issue has been set as DUPLICATE OF issue 0001346.
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
Last Modified:              01-13-2006 00:14 CET
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
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001346 Nforce3-250 has no working support for ...
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

----------------------------------------------------------------------
 alchemyx - 08-18-05 23:03 
----------------------------------------------------------------------
I can confirm same issue with my hardware - Gigabyte K8NS motherboard with
Nforce3-250 chipset and using i8x0 driver. It happens only with front
panel mic. But there is no problem when using nvsound module from nvidia
(but that driver sucks in everything else).

----------------------------------------------------------------------
 vsu - 08-19-05 12:31 
----------------------------------------------------------------------
I see that you have the Realtek ALC850 codec.  This codec has a separate
input for the front-panel microphone, and there is a bit in a non-standard
register (register 0x76, bit 15) which must be set to 0 to enable that
input.

I have made a patch which adds a mixer control for this bit; the patch was
committed to ALSA CVS on 25 Apr 2005 and is included in alsa-driver-1.0.9
release.  When you upgrade your ALSA drivers to that (or newer) release,
you should see a switch named "Mic Front Input" in alsamixer; unmute this
switch to use the microphone input on the front panel.  Note that the
motherboard connector is not disabled by this switch - signals from both
inputs will be mixed.  The switch is not enabled by default to avoid
picking up noise if the front input is not used.

For the record, I had this problem with the ASUS A8V motherboard, which
has Realtek ALC850 too.

----------------------------------------------------------------------
 alchemyx - 08-19-05 17:37 
----------------------------------------------------------------------
It did solve that issue. Thank you! By the way I see some nice changes in
drivers (like easy choosing channels number, great).

----------------------------------------------------------------------
 jirka - 08-20-05 09:36 
----------------------------------------------------------------------
I don't have time now to test the change, but if alchemyx says it's working
I think it will work for me too. I thought I had the 1.0.9 version but now
I found that my version is 1.0.9a so it probably makes a difference.

I think you can select this bug as solved and #0001346 too. Thanks for
great support and high quality software.

----------------------------------------------------------------------
 alchemyx - 08-21-05 03:25 
----------------------------------------------------------------------
Keep in mind that versions appeared in following order:

2005-05-27  	ALSA 1.0.9 final release
2005-06-02  	ALSA 1.0.9a release
2005-06-07  	ALSA 1.0.9b release
2005-08-20  	ALSA 1.0.10rc1 release

So if you have 1.0.9a it includes fixes from 1.0.9 also. I was testing
with 1.0.9b and there was everything fine.

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
08-18-05 23:03 alchemyx       Note Added: 0005860                          
08-18-05 23:04 alchemyx       Issue Monitored: alchemyx                    
08-19-05 12:31 vsu            Note Added: 0005867                          
08-19-05 17:37 alchemyx       Note Added: 0005871                          
08-20-05 09:36 jirka          Note Added: 0005872                          
08-21-05 03:25 alchemyx       Note Added: 0005886                          
01-13-06 00:14 rlrevell       Relationship added       duplicate of 0001346
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
