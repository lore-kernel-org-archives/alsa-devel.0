From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001232]: Microphone in front bracket - very low volume
Date: Fri, 13 Jan 2006 00:15:10 +0100
Message-ID: <452265fc79a864d76966f231f1f09374@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D1B4B144
	for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2006 00:15:10 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1232> 
======================================================================
Reported By:                jirka
Assigned To:                rlrevell
======================================================================
Project:                    ALSA - driver
Issue ID:                   1232
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               latest Ubuntu, RedHat (I tried them both)
Kernel Version:             2.6.10
Resolution:                 fixed
Fixed in Version:           1.0.9
======================================================================
Date Submitted:             07-04-2005 16:47 CEST
Last Modified:              01-13-2006 00:15 CET
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
01-13-06 00:15 rlrevell       Status                   new => resolved     
01-13-06 00:15 rlrevell       Fixed in Version          => 1.0.9           
01-13-06 00:15 rlrevell       Resolution               open => fixed       
01-13-06 00:15 rlrevell       Assigned To               => rlrevell        
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
