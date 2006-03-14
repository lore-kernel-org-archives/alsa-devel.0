From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001890]: Only the PCM channel in alsa mixer, unmuted, no sound at all
Date: Tue, 14 Mar 2006 17:17:22 +0100
Message-ID: <9136136f3a1e60fb5ff7ff6cad22034e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2ED081C3
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 17:17:22 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0001631.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1890> 
======================================================================
Reported By:                arielo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1890
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             Linux haifa 2.6.15-16-686 #1 SMP PREEMPT Mon Feb 20
17:26:04 UTC 2006 i686 GNU/Linux
======================================================================
Date Submitted:             03-04-2006 18:19 CET
Last Modified:              03-14-2006 17:06 CET
======================================================================
Summary:                    Only the PCM channel in alsa mixer, unmuted, no
sound at all
Description: 
Alsamixer shows only one channel called PCM. It's unmuted, and the volume
at its maximum. There is no sound at all, even though there is no error
reported by the system.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001921 Unsupported Sound Card
related to          0001631 Audiophile USB will not capture.
======================================================================

----------------------------------------------------------------------
 sk0rp10 - 03-14-06 00:25 
----------------------------------------------------------------------
Same hardware and same issue reported for Sony VAIO FE series and SZ
series.

----------------------------------------------------------------------
 tiwai - 03-14-06 14:55 
----------------------------------------------------------------------
Try the patch below.  It's to ALSA CVS version.
If nothing is changed, pass "model=vaio" module option.

Would be nice if you can test the recording, too.

----------------------------------------------------------------------
 sk0rp10 - 03-14-06 15:16 
----------------------------------------------------------------------
now sound output works, also with headphones,great work. Here is the
alsamixer status:

Playback : Master , PCM
Capture: PCM (disabled) , CD , Mic (disabled) , Capture , HP ("L R CAPTUR"
written in red on top of  disabled control) , Unknown (disabled)

Mic volume  Control  is disabled, so I can't test capture.

----------------------------------------------------------------------
 tiwai - 03-14-06 15:21 
----------------------------------------------------------------------
Push space on 'Mic' in capture view to select as the source.  I'm not sure
whether it's a mic jack or whether any internal mic is equipped on this
laptop.

It's better to show the content of /etc/asound.state after running
"alsactl store", though.

----------------------------------------------------------------------
 sk0rp10 - 03-14-06 16:47 
----------------------------------------------------------------------
On this Laptop there is an input jack for external mic and also an
integrated microphone. 

Another issue : /dev/dsp and /dev/sound/ are missing , so apps like flash
player don't work

----------------------------------------------------------------------
 sk0rp10 - 03-14-06 16:49 
----------------------------------------------------------------------
here is asound.state

state.Intel {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 127'
                iface MIXER
                name 'Master Playback Volume'
                value.0 127
                value.1 127
        }
        control.2 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Master Playback Switch'
                value.0 true
                value.1 true
        }
        control.3 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'CD Capture Volume'
                value.0 4
                value.1 4
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 3
                value.1 3
        }
        control.5 {
                comment.access 'read write'
                comment.type BOOLEAN
                comment.count 2
                iface MIXER
                name 'Capture Switch'
                value.0 false
                value.1 false
        }
        control.6 {
                comment.access 'read write'
                comment.type ENUMERATED
                comment.count 1
                comment.item.0 HP
                comment.item.1 Unknown
                comment.item.2 Mic
                comment.item.3 PCM
                iface MIXER
                name 'Capture Source'
                value HP
        }
        control.7 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 255
                value.1 255
        }
}

----------------------------------------------------------------------
 tiwai - 03-14-06 16:53 
----------------------------------------------------------------------
/dev/dsp is irrelevant.  You didn't load the necessary modules.

Apparently, the capture switch is off, and "HP" is chosen as the recording
source.  Change it via alsamixer.

----------------------------------------------------------------------
 rlrevell - 03-14-06 17:06 
----------------------------------------------------------------------
On my Ubuntu system the flash issue can be fixed by setting
FIREFOX_DSP="aoss" in /etc/firefox/firefoxrc.

You can also load the snd-pcm-oss module but this is not as good as any
app using /dev/dsp will block your soundcard

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-06 18:19 arielo         New Issue                                    
03-04-06 18:19 arielo         Distribution              => Ubuntu          
03-04-06 18:19 arielo         Kernel Version            => Linux haifa
2.6.15-16-686 #1 SMP PREEMPT Mon Feb 20 17:26:04 UTC 2006 i686 GNU/Linux
03-14-06 00:25 sk0rp10        Note Added: 0008471                          
03-14-06 14:55 tiwai          Note Added: 0008475                          
03-14-06 14:56 tiwai          File Added: vaio-stac7661-test3.diff              
     
03-14-06 14:57 tiwai          Relationship added       has duplicate 0001921
03-14-06 15:16 sk0rp10        Note Added: 0008479                          
03-14-06 15:21 tiwai          Note Added: 0008480                          
03-14-06 16:47 sk0rp10        Note Added: 0008485                          
03-14-06 16:49 sk0rp10        Note Added: 0008486                          
03-14-06 16:53 tiwai          Note Added: 0008488                          
03-14-06 17:06 rlrevell       Note Added: 0008491                          
03-14-06 17:17 rlrevell       Relationship added       related to 0001631  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
