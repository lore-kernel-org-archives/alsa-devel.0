From: bugtrack@alsa-project.org
Subject: [ALSA - firmware 0000982]: Sound output locked at 48khz (lower freqs play faster, sound higher)
Date: Sat, 12 Mar 2005 12:25:29 +0100
Message-ID: <c24fde258507b3fe9064d6f5e4288cd8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4A9B211B
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2005 12:25:29 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=982> 
======================================================================
Reported By:                Minami Manami
Assigned To:                
======================================================================
Project:                    ALSA - firmware
Issue ID:                   982
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-12-2005 12:19 CET
Last Modified:              03-12-2005 12:25 CET
======================================================================
Summary:                    Sound output locked at 48khz (lower freqs play
faster, sound higher)
Description: 
Exactly what it says. In Tuxracer @ 22khz sound, it plays very fast and
high pitched. When I switch it to 44khz, it sounds a bit more like normal,
but when compared to another computer, the sound is high and plays
slightly faster. Same with mpg123, mp3blaster, everything audio. Program
detects a 44.1Khz stream (with an mp3 file) but sound comes out at 48000
samples per second.

======================================================================

----------------------------------------------------------------------
 Minami Manami - 03-12-05 12:25 
----------------------------------------------------------------------
Turns out that dmesg didn't just say that... it also said:
Via 686a/8233/8235 audio driver 1.9.1-ac4-2.5
via82cxxx: Six Channel Audio available
PCI: Setting latency timer of device 000:00:11.5 to 64
ac97_codec: AC97 Audio Codec, id: ALG16 (ALC200/200P)
via82cxxx: board https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1 at
0x1400, IRQ 9
Then the rest follows.

In make menuconfig, the following options were enabled:
Device Drivers > Sound > ALSA > 
Sequencer Support
OSS Mixer API
OSS PCM API
OSS Sequencer API
Device Drivers > Sound > ALSA > Generic Devices
Dummy (/dev/null) soundcard
Device Drivers > Sound > ALSA > PCI Devices
VIA 82C686A/B, 8233/8235 AC97 Controller
Device Drivers > Sound > OSS > 
VIA 82C686 Audio Codec

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 12:19 Minami Manami  New Issue                                    
03-12-05 12:25 Minami Manami  Note Added: 0003895                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
