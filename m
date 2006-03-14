From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001890]: Only the PCM channel in alsa mixer, unmuted, no sound at all
Date: Tue, 14 Mar 2006 16:49:03 +0100
Message-ID: <21d9d3d2da783227a1e794da62385be1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 6978F1B9
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 16:49:03 +0100 (MET)
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
Last Modified:              03-14-2006 16:49 CET
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
======================================================================

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
