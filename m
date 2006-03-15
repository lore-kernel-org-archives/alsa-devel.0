From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001927]: Capture Device not working
Date: Wed, 15 Mar 2006 20:20:54 +0100
Message-ID: <6535347975d588558e7732e130d4fb37@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7F7F4176
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 20:20:54 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1927> 
======================================================================
Reported By:                sk0rp10
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1927
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Slackware current
Kernel Version:             2.6.15.6 vanilla
======================================================================
Date Submitted:             03-15-2006 19:23 CET
Last Modified:              03-15-2006 20:20 CET
======================================================================
Summary:                    Capture Device not working
Description: 
I tryed use krec to record from internal mic but no sound is recorded. 
I applyed the patch from issue #1890.

here asound.state:

state.Intel {
        control.1 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 127'
                iface MIXER
                name 'Master Playback Volume'
                value.0 121
                value.1 121
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
                value.0 7
                value.1 7
        }
        control.4 {
                comment.access 'read write'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 15'
                iface MIXER
                name 'Capture Volume'
                value.0 11
                value.1 11
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
                value Mic
        }
        control.7 {
                comment.access 'read write user'
                comment.type INTEGER
                comment.count 2
                comment.range '0 - 255'
                iface MIXER
                name 'PCM Playback Volume'
                value.0 232
                value.1 232
        }
}

======================================================================

----------------------------------------------------------------------
 tiwai - 03-15-06 19:38 
----------------------------------------------------------------------
Try CVS version at first.  If still doesn't work, please upload the
contents of /proc/asound/card0/codec#* files, and the product name of your
machine, laptop or mobo, whatever information to identify.
The detailed description of the existing I/O (jacks, etc) is also
appreciated.

----------------------------------------------------------------------
 sk0rp10 - 03-15-06 20:20 
----------------------------------------------------------------------
Product Name: SONY VAIO VGN-FE11S (Notebook)

Exixting I/O : headphone jack , mic in jack , embedded microphone
(internal)

Uploaded: codec output

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 19:23 sk0rp10        New Issue                                    
03-15-06 19:23 sk0rp10        Distribution              => Slackware current
03-15-06 19:23 sk0rp10        Kernel Version            => 2.6.15.6 vanilla
03-15-06 19:38 tiwai          Note Added: 0008569                          
03-15-06 20:20 sk0rp10        Note Added: 0008572                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
