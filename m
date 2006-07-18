From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000469]: volume of sblive mic
	recording too low
Date: Tue, 18 Jul 2006 20:26:52 +0200
Message-ID: <9955bb68385840601e83cf7fc8d27034@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 134AC1A7
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:26:53 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=469> 
======================================================================
Reported By:                wouter
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   469
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             08-28-2004 01:36 CEST
Last Modified:              07-18-2006 20:26 CEST
======================================================================
Summary:                    volume of sblive mic recording too low
Description: 
The recordings made with the Mic input on my sblive (5.1) are substantially
lower in volume than direct playback output. If fact, they are too low to
be really useful in for instance video conferencing, barely reaching 1/4
in the VU meter of the gnomemeeting voip program - with Mic boost on.

Setting "Capture" to anything but zero stops any sound from being
captured.

"AC97 Capture" seems to be controlling the volume of the recording, but it
is too low even with the slider on 100%.

People on the users mailinglist seem to indicate that "Capture" actually
should work, which it doesn't.
======================================================================

----------------------------------------------------------------------
 pzad - 09-07-04 09:40 
----------------------------------------------------------------------
What ac97 uses your sb live ???
Check /proc/asound/card*/codec97#*/ac97#?-? file for your card.

----------------------------------------------------------------------
 wouter - 09-07-04 16:47 
----------------------------------------------------------------------
[senta:~] cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: SigmaTel STAC9708/11

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 SDAC DSA=0
Extended status  : SDAC

----------------------------------------------------------------------
 pzad - 09-16-04 10:22 
----------------------------------------------------------------------
On my audigy "capture" control works as expected.

Could you attach content of (ac97 codec register dump)
/proc/asound/card*/codec97#*/ac97#?-?+reg
when "capture" is 0 and capture works
and
/proc/asound/card*/codec97#*/ac97#?-?+reg
when "capture" is not 0 and capture doesn't work ???

----------------------------------------------------------------------
 wouter - 09-16-04 16:00 
----------------------------------------------------------------------
I attached the resgister values. The only difference is setting "Capture"
from 0% (recording working) to 100% (recording not working).

----------------------------------------------------------------------
 pzad - 09-17-04 10:35 
----------------------------------------------------------------------
AC97 registers are OK. I don't know where is the problem. I will look
closer to others AC97 registers this weekend.

Last thing, attach outputs of alsactl (can_capture.state,
cannot_capture.state)
when "capture" is 0 and capture works
alsactl -f can_capture.state store
and
when "capture" is not 0 and capture doesn't work ???
alsactl -f cannot_capture.state store

----------------------------------------------------------------------
 wouter - 09-18-04 01:39 
----------------------------------------------------------------------
Hmm... please discard the last attachment (09-18-04 01:33 can_capture.txt),
I was distracted and really need to clean up my messy home directory.

----------------------------------------------------------------------
 wouter - 09-18-04 01:48 
----------------------------------------------------------------------
For what it's worth, sliding the "Capture" from 0% to 1% while recording
produces a little pop before muting the record source, which seems to
indicate something is modified; it's not a gradual change, like for
instance sliding the "AC97 Capture" or any normal volume slider is.

----------------------------------------------------------------------
 rlrevell - 12-30-05 03:53 
----------------------------------------------------------------------
Any improvement with later releases?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-28-04 01:36 wouter         New Issue                                    
08-28-04 01:36 wouter         File Added: amixer.txt                       
08-28-04 01:36 wouter         Distribution              => Debian          
08-28-04 01:36 wouter         Kernel Version            => 2.6.8           
09-07-04 09:40 pzad           Note Added: 0001704                          
09-07-04 16:47 wouter         Note Added: 0001716                          
09-16-04 10:22 pzad           Note Added: 0001767                          
09-16-04 15:58 wouter         File Added: can_capture.txt                    
09-16-04 15:58 wouter         File Added: cannot_capture.txt                    
09-16-04 16:00 wouter         Note Added: 0001774                          
09-17-04 10:35 pzad           Note Added: 0001777                          
09-18-04 01:33 wouter         File Added: can_capture.txt                    
09-18-04 01:39 wouter         Note Added: 0001780                          
09-18-04 01:40 wouter         File Added: can_capture.state                    
09-18-04 01:41 wouter         File Added: cannot_capture.state                  
 
09-18-04 01:48 wouter         Note Added: 0001781                          
12-30-05 03:53 rlrevell       Note Added: 0007192                          
07-18-06 20:21 pzad           Assigned To              pzad =>             
07-18-06 20:26 jcdutton       Assigned To               => jcdutton        
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
