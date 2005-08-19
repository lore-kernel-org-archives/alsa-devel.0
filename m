From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001232]: Microphone in front bracket - very low volume
Date: Fri, 19 Aug 2005 17:37:44 +0200
Message-ID: <a9f68b5886cc9b537869ab6d27afb7e9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C1FA01DA
	for <alsa-devel@alsa-project.org>; Fri, 19 Aug 2005 17:37:44 +0200 (MEST)
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
Last Modified:              08-19-2005 17:37 CEST
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
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
