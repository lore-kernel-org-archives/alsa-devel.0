From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000842]: plug:multi:ladspa chain causes "aplay: pcm_params.c:146: snd_pcm_hw_param_get_min: Assertion `!snd_interval_empty(i)' failed."
Date: Mon, 30 May 2005 13:42:25 +0200
Message-ID: <f5919066c1e9723b440ca3412fb1f743@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D69011C7
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 13:42:25 +0200 (MEST)
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


The following issue has been UPDATED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=842> 
======================================================================
Reported By:                roothorick
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   842
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             01-22-2005 19:40 CET
Last Modified:              05-30-2005 13:42 CEST
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
 roothorick - 01-22-05 19:42 
----------------------------------------------------------------------
I forgot to mention that using MPlayer exhibits exactly the same behavior.
FWIW.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-22-05 19:40 roothorick     New Issue                                    
01-22-05 19:42 roothorick     Note Added: 0003377                          
05-30-05 13:42 perex          Category                 ordinary pcm => pcm -
digital audio
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
