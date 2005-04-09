From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000737]: Background noise in master when no playing sound on Asus A7N8X Deluxe (nforce 2)
Date: Sat, 9 Apr 2005 17:26:21 +0200
Message-ID: <c6e570e38240c078d9d88397770ae83d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 03E81220
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 17:26:21 +0200 (MEST)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=737> 
======================================================================
Reported By:                keymon
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   737
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     feedback
Distribution:               Debian
Kernel Version:             2.6.6
======================================================================
Date Submitted:             12-21-2004 09:28 CET
Last Modified:              04-09-2005 17:26 CEST
======================================================================
Summary:                    Background noise in master when no playing sound on
Asus A7N8X Deluxe (nforce 2)
Description: 
Quoting http://www.nvnews.net/vbulletin/printthread.php?t=35148:

Every Asus A7N8X Deluxe Rev 2.0 Board has a problem with a weird "whining"
"whirring" or "buzzing" "static" noise coming out of the speakers AND out
of the motherboard itself. 

When speakers are connected and the volume is turned up to normal levels,
the noise is very loud, approx 20% of the signal.

This noise appear when the card is not playing sound and there is low CPU
using. As soon as you play sound, noise stops. If you pause xmms or any
player, noise returns.

Muting all the channels does not stop the noise, but if you exec: "alsactl
power 0 off" &https://bugtrack.alsa-project.org/alsa-bug/view.php?id=161;noise
stops!, but you have to exec "alsactl power 0 on"
to use the card again. The driver could do the same than "alsactl power 0
off" when it isn't playing sound.

If you use the lastest nforce drivers (1.0-0283 or newer) noise stops.


======================================================================

----------------------------------------------------------------------
 tiwai - 12-21-04 18:40 
----------------------------------------------------------------------
Please show /proc/asound/card0/codec97#0/ac97#0-0* files?

You can try to flip bits of POWER ac97 register (0x26) by writing to
ac97#0-0+regs proc file above such as:

   # echo 26 803f > /proc/asound/card0/codec97#0/ac97#0-0+regs

This feature is enabled only when compiled with debug option (e.g.
--with-debug=full).  Read the previous value, and change some bits.

Try first to turn bit 15 (0x8000) on.  This can be an EAPD control.
Bit 14 (0x4000) is HP power down, Bit 8 and 9 (0x0300) are ADC/DAC power
down.  Also, bit 10 is analog mixer (vref).  In the power-down code in
ac97_codec.c, all these bits are turned on.

If it's EAPD, you can control via 'External Amplifier' mixer swithc, too. 
Other bits are essential, so in general you shouldn't turn off during the
operation.

----------------------------------------------------------------------
 jdthood - 04-09-05 17:26 
----------------------------------------------------------------------
Submitter: You were asked to provide additional information.
Can you please provide it?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-21-04 09:28 keymon         New Issue                                    
12-21-04 09:28 keymon         Distribution              => Debian          
12-21-04 09:28 keymon         Kernel Version            => 2.6.6           
12-21-04 09:28 keymon         Issue Monitored: keymon                      
12-21-04 18:40 tiwai          Note Added: 0002900                          
04-09-05 17:26 jdthood        Note Added: 0004423                          
04-09-05 17:26 jdthood        Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
