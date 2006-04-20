From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000842]: plug:multi:ladspa chain causes "aplay: pcm_params.c:146: snd_pcm_hw_param_get_min: Assertion `!snd_interval_empty(i)' failed."
Date: Thu, 20 Apr 2006 15:40:23 +0200
Message-ID: <a3cd8c8352758e127919a4689eaa2e13@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1DB9A21E
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 15:40:24 +0200 (MEST)
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
Status:                     new
======================================================================
Date Submitted:             01-22-2005 19:40 CET
Last Modified:              04-20-2006 15:40 CEST
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
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
