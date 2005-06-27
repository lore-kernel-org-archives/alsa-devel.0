From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000183]: Mic boost boosts mic playback and not recording
Date: Mon, 27 Jun 2005 15:57:04 +0200
Message-ID: <e183ed718fb9ac0fabf08f65a00a2e48@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8A7D51DD
	for <alsa-devel@alsa-project.org>; Mon, 27 Jun 2005 15:57:04 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001192.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=183> 
======================================================================
Reported By:                Schugy
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   183
Category:                   PCI - cmipci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     acknowledged
Distribution:               SuSE 8.2
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-04-2004 13:51 CEST
Last Modified:              06-27-2005 15:57 CEST
======================================================================
Summary:                    Mic boost boosts mic playback and not recording
Description: 
I've tried to record my voice with broadcast2000. The recording level is at
-30db (maybe 2db louder than without mic boost) while mic playback seems
to be boosted up by 500% to an audiable level.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001192 Microphone doesn't work in record and/o...
======================================================================

----------------------------------------------------------------------
 mlejeune - 04-27-04 17:33 
----------------------------------------------------------------------
Same thing here. Mic boost switch works only on monitoring, not recording
level, so mic input is unusable with standard mics. 

Alsa 1.0.4 (from sources) on vanilla 2.6.5 linux kernel.
CMI8738-MC6 chipset with cmipci driver.

----------------------------------------------------------------------
 tiwai - 04-30-04 11:43 
----------------------------------------------------------------------
well, unfortunately i can't find any relevant other register
bits for the mic boost...

----------------------------------------------------------------------
 Schugy - 05-23-04 19:45 
----------------------------------------------------------------------
Mic boost for recording isn't a hardware feature? Well, then we need a
dirty workaround anywhere in the alsa/oss-library or something similar
(feature request) to boost the volume of recorded sounds afterwards.
At the moment this card is unusable for mics.

Don't know whether it's useful to ask c-media for some information.

----------------------------------------------------------------------
 tiwai - 05-24-04 14:50 
----------------------------------------------------------------------
i have no idea unless the datasheet provides no information about it...

yes, please ask c-media.  i've got no response from them, but more
inquires may hit more frequently :)

----------------------------------------------------------------------
 thorstenhirsch - 07-24-04 19:47 
----------------------------------------------------------------------
Same thing here with a 0000:00:0c.0 Multimedia audio controller: C-Media
Electronics Inc CM8738 (rev 10) and kernel 2.6.7 (gentoo-dev-sources). The
mic boost is absolutely neccessary for netmeeting/teamspeak/skype.

I'm going to write a mail to C-Media and hope that they'll answer.

----------------------------------------------------------------------
 charles_levert - 04-07-05 06:25 
----------------------------------------------------------------------
I had not noticed this bug-issue before, maybe because of its title.
FWIW, here my take/experience on this.

  -- I own an Asus motherboard with integrated CMI8738 audio on it.

  -- I use Fedora Core on this machine, for better or for worse.
     More specifically, I have used:

     -- Red Hat 7.3 with the OSS cmpci driver.
     -- Red Hat 7.3 with several versions of the ALSA 0.9.* cmipci
driver.
     -- Fedora Core 1 with the OSS cmpci driver.
     -- Fedora Core 1 with several versions of the ALSA 1.0.* cmipci
driver.

I've been trying to zero in on the specific circumstances that cause this
problem.  I never got any response to my queries to either Asus or C-Media
about this (or more generally the technical documentation on how to
program their products).  I never use non-Free OSes on my own equipment so
I have never tried MS-Windows.  I have read the CMI8738 driver source code
of FreeBSD, NetBSD, and OpenBSD, though, but have not tried them on this
machine.

The only time recording ever worked for me was with Fedora Core 1 with the
OSS cmpci driver, but never right away.  It only occured, as if by magic,
after I played back and forth with the available settings and one
combination of settings I had gone through several times before suddendly
started working.  I have not been able to narrow this process down to a
minimal, systematic, and well-known sequence of setting combinations. 
Also, going back to that driver is not an option, since it caused
systematic kernel panics when I interrupted (aborted) midi playbacks right
in the middle of them.

Since then, with Fedora Core 1 with several versions of the ALSA 1.0.*
cmipci driver, using the same approach of playing back and forth with the
settings, the most I have ever gotten is to hear the audio input on the
audio output, but still without any sound being captured (i.e., the
recorded file ends up filled with silence and the "VU meter" for recording
never senses anything, or just noise level).

Recording never worked with Red Hat 7.3, regardless of driver.

I use "aumix" with the OSS cmpci driver and "alsamixer" with the ALSA
cmipci driver.

(I am aware of the "Mic As Center/LFE" setting and have tried all possible
combinations.  IIRC, the only one that ever worked had this off, which
would be the obvious and expected behavior.)

In summary, it is possible to make this hardware work (since I've seen
it), the question is how.  Doesn't a C-Media employee (ChenLi Tien)
regularly post on the devel mailing list?  I would hope that C-Media at
least provides its own employees with enough technical documentation to
program its own products.



bash# lspci -s 00:05.0 -vv -xxx
00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev
10)
	Subsystem: Asustek Computer, Inc. CMI8738 6ch-MX
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping+ SERR- FastB2B-
	Status: Cap+ 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort- <TAbort-
<MAbort- >SERR- <PERR-
	Latency: 32 (500ns min, 6000ns max)
	Interrupt: pin A routed to IRQ 5
	Region 0: I/O ports at 9800 [size=256]
	Capabilities: [c0] Power Management version 2
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 PME-Enable- DSel=0 DScale=0 PME-
00: f6 13 11 01 85 00 10 02 10 00 01 04 00 20 00 00
10: 01 98 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 43 10 e2 80
30: 00 00 00 00 c0 00 00 00 00 00 00 00 ff 01 02 18
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 01 00 02 06 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

bash# lspci -s 00:05.0 -v -n
00:05.0 Class 0401: 13f6:0111 (rev 10)
	Subsystem: 1043:80e2
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 5
	I/O ports at 9800 [size=256]
	Capabilities: [c0] Power Management version 2

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-04-04 13:51 Schugy         New Issue                                    
04-04-04 13:51 Schugy         Distribution              => SuSE 8.2        
04-04-04 13:51 Schugy         Kernel Version            => 2.4.25          
04-27-04 17:33 mlejeune       Note Added: 0000962                          
04-27-04 17:35 mlejeune       Issue Monitored: mlejeune                    
04-30-04 11:43 tiwai          Note Added: 0000982                          
05-23-04 19:45 Schugy         Note Added: 0001180                          
05-24-04 14:50 tiwai          Note Added: 0001183                          
07-24-04 19:47 thorstenhirsch Note Added: 0001471                          
04-07-05 00:12 jdthood        Status                   new => acknowledged 
04-07-05 00:12 jdthood        Resolution               open => not fixable 
04-07-05 06:25 charles_levert Note Added: 0004354                          
06-27-05 15:57 tiwai          Relationship added       related to 0001192  
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
