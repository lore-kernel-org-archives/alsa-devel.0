From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000842]: plug:multi:ladspa chain causes
	"aplay: pcm_params.c:146: snd_pcm_hw_param_get_min: Assertion
	`!snd_interval_empty(i)' failed."
Date: Sun, 6 Aug 2006 01:37:35 +0200
Message-ID: <e948dcf57f7e4a43492f9cfb7b515e7d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 45D2813C
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Aug 2006 01:37:35 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=842> 
======================================================================
Reported By:                roothorick
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   842
Category:                   1_pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             01-22-2005 19:40 CET
Last Modified:              08-06-2006 01:37 CEST
======================================================================
Summary:                    plug:multi:ladspa chain causes "aplay:
pcm_params.c:146: snd_pcm_hw_param_get_min: Assertion `!snd_interval_empty(i)'
failed."
Description: 
For reference, my primary soundcard has a CMI8738 chipset with two DACs.

My .asoundrc contains the following PCM definitions:

pcm.pfront {
        type plug
        slave.pcm "front"
}

pcm.prear {
        type plug
        slave.pcm "rear"
}

pcm.prearinv {
        type plug
        slave.pcm {
                type ladspa
                slave.pcm "prear"
                plugins [
                        {       
                                label inv
                        }
                ]
        }
}

pcm.surround40fixbass {
        type multi
        slaves.0.pcm "pfront"
        slaves.0.channels 2
        slaves.1.pcm "prearinv"
        slaves.1.channels 2
        bindings [
                { slave 0; channel 0 }
                { slave 0; channel 1 }
                { slave 1; channel 0 }
                { slave 1; channel 1 }
        ]
        master 0
}

pcm.psurround40fixbass {
        type plug
        slave.pcm "surround40fixbass"
}

Using MPlayer, I created two .wav files for test purposes: test-2ch.wav (2
channels), and test-4ch.wav (4 channels). I then attempted several
different tests (I'm posting the most notable here):

roothorick@prodigy ~/tmp $ aplay -D pfront test-2ch.wav
Playing WAVE 'test-2ch.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
# Sound plays from front speakers. Expected behavior.

roothorick@prodigy ~/tmp $ aplay -D prearinv test-2ch.wav
Playing WAVE 'test-2ch.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
# Sound plays from rear speakers. Expected behavior.

roothorick@prodigy ~/tmp $ aplay -D surround40 test-4ch.wav
Playing WAVE 'test-4ch.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Channels 4
# Sound plays from all four speakers. Expected behavior.

roothorick@prodigy ~/tmp $ aplay -D surround40fixbass test-4ch.wav
Playing WAVE 'test-4ch.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Channels 4
# Sound plays from only front speakers. Was expecting sound from all four
speakers.

roothorick@prodigy ~/tmp $ aplay -D psurround40fixbass test-4ch.wav
Playing WAVE 'test-4ch.wav' : Signed 16 bit Little Endian, Rate 44100 Hz,
Channels 4
aplay: pcm_params.c:146: snd_pcm_hw_param_get_min: Assertion
`!snd_interval_empty(i)' failed.
Aborted by signal Aborted...
# No sound is ever produced. Was expecting sound from all four speakers.
======================================================================

----------------------------------------------------------------------
 roothorick - 03-25-06 22:36 
----------------------------------------------------------------------
Still happens with ALSA lib 1.0.11rc3. This was tested on a different card
however (SB PCI 512 -- emu10k1).

----------------------------------------------------------------------
 tiwai - 04-20-06 15:40 
----------------------------------------------------------------------
I fixed some bugs regarding multi plugin recently, so hopefully it got
fixed in 1.0.11-final.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-05 19:40 roothorick     New Issue                                    
01-22-05 19:42 roothorick     Note Added: 0003377                          
05-30-05 13:42 perex          Category                 ordinary pcm => pcm -
digital audio
03-22-06 04:27 rlrevell       Note Added: 0008840                          
03-25-06 22:36 roothorick     Note Added: 0008953                          
04-20-06 15:40 tiwai          Note Added: 0009390                          
08-06-06 01:37 Adrian Bunk    Status                   new => resolved     
08-06-06 01:37 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
