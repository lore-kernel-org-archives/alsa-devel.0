From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000906]: OSS mixer does not work
Date: Mon, 14 Feb 2005 23:30:15 +0100
Message-ID: <ea29b01eee03f1ce1cc4f793e23a168f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 516E624F
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 23:30:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=906> 
======================================================================
Reported By:                adaviel
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   906
Category:                   PCI - ca0106
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 1
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-13-2005 07:02 CET
Last Modified:              02-14-2005 23:30 CET
======================================================================
Summary:                    OSS mixer does not work
Description: 
OSS-based mixers such as aumix or xmixer will not
work. aumix says "no device found". A second sound device on the same PC
configured as snd-card-1 appears to work as /dev/mixer1
Alsamixer appears to work on both the Audigy and Intel devices
(at the time of writing I do not have physical access to the device
to verify sound output)
======================================================================

----------------------------------------------------------------------
 tiwai - 02-14-05 16:27 
----------------------------------------------------------------------
Do you have /dev/mixer with a proper permission?

----------------------------------------------------------------------
 adaviel - 02-14-05 23:30 
----------------------------------------------------------------------
lrwxrwxrwx    1 root     root          /dev/mixer -> /dev/mixer0
crw-rw-rw-    1 root     root      14, /dev/mixer0
crw-rw-rw-    1 root     root      14, /dev/mixer1

card 0 is ca0106
card 1 is Intel ich5 which seems to work OK

I want to use the vrvs.org/Mbone tool "rat" which needs full-duplex
audio at (usually) 8kHz o 16kHz with microphone/speakers
I cannot get any input on the VU meter with any input selected in
alsamixer or
with "capture into playback" set high. The input levels won't move in
alsamixer
for any inputs e.g. "AC97 in". I don't see "mic in" - but I'm not very
familiar with ALSA or with this card. It's what a user found in a store
when
they wanted to retrofit sound to an older PC running RedHat 7.3.

When I use OSS "play" on a WAV file the sound is very choppy and the rate
sounds
wrong. When I try aplay it's not choppy but the rate is still odd.
However mpg123 sounds OK on an MP3 file. Will this card work for me in
Rat,
or is it only really good for playing DVDs/CDs ?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-05 07:02 adaviel        New Issue                                    
02-13-05 07:02 adaviel        Distribution              => Fedora Core 1   
02-13-05 07:02 adaviel        Kernel Version            => 2.4.22          
02-14-05 16:27 tiwai          Note Added: 0003600                          
02-14-05 23:30 adaviel        Note Added: 0003614                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
