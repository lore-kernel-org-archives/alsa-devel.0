From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001380]: Scratchy Intel HDA
Date: Tue, 20 Sep 2005 04:20:50 +0200
Message-ID: <807eb8c4c6bc3796678ee686a93ea968@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9485196
	for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2005 04:20:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1380> 
======================================================================
Reported By:                Varanger
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1380
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu 5.04 "Hoary Hedgehog"
Kernel Version:             Linux 2.6.11-1-686-smp
======================================================================
Date Submitted:             08-30-2005 20:07 CEST
Last Modified:              09-20-2005 04:20 CEST
======================================================================
Summary:                    Scratchy Intel HDA
Description: 
Hello.

I am getting very scratchy audio in my Intel HDA card besides the sound is
very low.

lspci output is:  

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)

Reading every article I could have found on the net regarding this
card, I discovered that i needed snd-azx (ALSA 1.0.8 ) or
snd-hda-intel modules (ALSA 1.0.9rc* or later).

I have downloaded every sources from 1.0.8 up to 1.0.10rc1 (including
1.0.9 release candidates) from http://www.alsa-project.org, then built and
installed them.

In all those versions, I have followed this steps:
alsa-driver : ./configure --with-oss=yes --with-cards=hda-intel && make &&
make install
library / oss-lib / utils : ./configure && make && make install

I've looked every on the net and found that I could use position_fix=1
or position_fix=2 to help me  but no good either.

I've tried in Ubuntu, Kubuntu, Debian, even Mandriva 2005 LE and
Fedora Core 4 (using the modules from the kernel) and it's the same
problem in all of them.

The card came with the mainboard Intel 915G (D915GEV or 915GEV)  

more info about my soundcard:

Running: "lspci -v" 

0000:00:1b.0 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)
High Definition Audio Controller (rev 03)
        Subsystem: Intel Corp.: Unknown device e200
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at ff43c000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: [50] Power Management version 2
        Capabilities: [60] Message Signalled Interrupts: 64bit+
Queue=0/0 Enable-
        Capabilities: [70] #10 [0091]

/proc/sound/version
Advanced Linux Sound Architecture Driver Version 1.0.9b.
Compiled on Jul  7 2005 for kernel 2.6.10-5-686-smp (SMP).

/proc/asound/devices
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  0: [0- 0]: ctl
 33:       : timer

aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: ALC880 Analog [ALC880 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

Thanks for the help,
Varanger
======================================================================

----------------------------------------------------------------------
 chrome - 09-16-05 05:14 
----------------------------------------------------------------------
It is set to default. Toggling MMAP mode has no effect.

I grabbed the latest CVS and compiled it with 'cvscompile' then did a make
install. After a reboot, I confirmed the new version of Alsa:

[root@vaio ~]# cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.10rc1.
Compiled on Sep 16 2005 for kernel 2.6.12-1.1447_FC4.

I get the same results as above with the default settings.

I then tried it with the following:

[root@vaio ~]# rmmod snd_hda_intel
[root@vaio ~]# modprobe snd_hda_intel position_fix=0
[root@vaio ~]# rmmod snd_hda_intel
[root@vaio ~]# modprobe snd_hda_intel position_fix=1
[root@vaio ~]# rmmod snd_hda_intel
[root@vaio ~]# modprobe snd_hda_intel position_fix=2
[root@vaio ~]# rmmod snd_hda_intel
[root@vaio ~]# modprobe snd_hda_intel position_fix=3

None of these helped with the current CVS drivers... any other ideas?

----------------------------------------------------------------------
 chrome - 09-20-05 04:20 
----------------------------------------------------------------------
Someone suggested it might be my alsa.conf:

[chrome@vaio ~]$ cat /etc/alsa/alsa.conf
#
#  ALSA library configuration file
#

# pre-load the configuration files

@hooks [
        {
                func load
                files [
                        "/etc/asound.conf"
                        "~/.asoundrc"
                ]
                errors false
        }
]

# load card-specific configuration files (on request)

cards.@hooks [
        {
                func load
                files [
                        {
                                @func concat
                                strings [
                                        { @func datadir }
                                        "/cards/aliases.conf"
                                ]
                        }
                ]
        }
        {
                func load_for_all_cards
                files [
                        {
                                @func concat
                                strings [
                                        { @func datadir }
                                        "/cards/"
                                        { @func private_string }
                                        ".conf"
                                ]
                        }
                ]
                errors false
        }
]

# defaults

defaults.ctl.card 0
defaults.pcm.card 0
defaults.pcm.device 0
defaults.pcm.subdevice -1
defaults.pcm.front.card defaults.pcm.card
defaults.pcm.front.device defaults.pcm.device
defaults.pcm.rear.card defaults.pcm.card
defaults.pcm.rear.device defaults.pcm.device
defaults.pcm.center_lfe.card defaults.pcm.card
defaults.pcm.center_lfe.device defaults.pcm.device
defaults.pcm.side.card defaults.pcm.card
defaults.pcm.side.device defaults.pcm.device
defaults.pcm.surround40.card defaults.pcm.card
defaults.pcm.surround40.device defaults.pcm.device
defaults.pcm.surround41.card defaults.pcm.card
defaults.pcm.surround41.device defaults.pcm.device
defaults.pcm.surround50.card defaults.pcm.card
defaults.pcm.surround50.device defaults.pcm.device
defaults.pcm.surround51.card defaults.pcm.card
defaults.pcm.surround51.device defaults.pcm.device
defaults.pcm.surround71.card defaults.pcm.card
defaults.pcm.surround71.device defaults.pcm.device
defaults.pcm.iec958.card defaults.pcm.card
defaults.pcm.iec958.device defaults.pcm.device
defaults.pcm.modem.card defaults.pcm.card
defaults.pcm.modem.device defaults.pcm.device
defaults.rawmidi.card 0
defaults.rawmidi.device 0
defaults.rawmidi.subdevice -1
defaults.hwdep.card 0
defaults.hwdep.device 0
defaults.timer.class 2
defaults.timer.sclass 0
defaults.timer.card 0
defaults.timer.device 0
defaults.timer.subdevice 0

#
#  PCM interface
#

pcm.hw {
        @args [ CARD DEV SUBDEV ]
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars [
                                ALSA_PCM_CARD
                                ALSA_CARD
                        ]
                        default {
                                @func refer
                                name defaults.pcm.card
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars [
                                ALSA_PCM_DEVICE
                        ]
                        default {
                                @func refer
                                name defaults.pcm.device
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name defaults.pcm.subdevice
                }
        }
        type hw
        card $CARD
        device $DEV
        subdevice $SUBDEV
}

pcm.plughw {
        @args [ CARD DEV SUBDEV ]
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars [
                                ALSA_PCM_CARD
                                ALSA_CARD
                        ]
                        default {
                                @func refer
                                name defaults.pcm.card
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars [
                                ALSA_PCM_DEVICE
                        ]
                        default {
                                @func refer
                                name defaults.pcm.device
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name defaults.pcm.subdevice
                }
        }
        type plug
        slave.pcm {
                type hw
                card $CARD
                device $DEV
                subdevice $SUBDEV
        }
}

pcm.plug {
        @args [ SLAVE ]
        @args.SLAVE {
                type string
        }
        type plug
        slave.pcm $SLAVE
}

pcm.shm {
        @args [ SOCKET PCM ]
        @args.SOCKET {
                type string
        }
        @args.PCM {
                type string
        }
        type shm
        server $SOCKET
        pcm $PCM
}

pcm.tee {
        @args [ SLAVE FILE FORMAT ]
        @args.SLAVE {
                type string
        }
        @args.FILE {
                type string
        }
        @args.FORMAT {
                type string
                default raw
        }
        type file
        slave.pcm $SLAVE
        file $FILE
        format $FORMAT
}

pcm.file {
        @args [ FILE FORMAT ]
        @args.FILE {
                type string
        }
        @args.FORMAT {
                type string
                default raw
        }
        type file
        slave.pcm null
        file $FILE
        format $FORMAT
}

pcm.null {
        type null
}

# redirect to load-on-demand extended pcm definitions
pcm.cards cards.pcm
# some links for easy use
pcm.front cards.pcm.front
pcm.rear cards.pcm.rear
pcm.center_lfe cards.pcm.center_lfe
pcm.side cards.pcm.side
pcm.surround40 cards.pcm.surround40
pcm.surround41 cards.pcm.surround41
pcm.surround50 cards.pcm.surround50
pcm.surround51 cards.pcm.surround51
pcm.surround71 cards.pcm.surround71
pcm.iec958 cards.pcm.iec958
pcm.spdif cards.pcm.iec958
pcm.modem cards.pcm.modem

pcm.default cards.pcm.default
pcm.dmix cards.pcm.dmix
pcm.dsnoop cards.pcm.dsnoop

#
#  Control interface
#

ctl.hw {
        @args[ CARD ]
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars [
                                ALSA_CTL_CARD
                                ALSA_CARD
                        ]
                        default {
                                @func refer
                                name defaults.ctl.card
                        }
                }
        }
        type hw
        card $CARD
}

ctl.shm {
        @args [ SOCKET CTL ]
        @args.SOCKET {
                type string
        }
        @args.CTL {
                type string
        }
        type shm
        server $SOCKET
        ctl $CTL
}

ctl.default {
        type hw
        card {
                @func getenv
                vars [
                        ALSA_CTL_CARD
                        ALSA_CARD
                ]
                default {
                        @func refer
                        name defaults.ctl.card
                }
        }
}

#
#  RawMidi interface
#

rawmidi.hw {
        @args [ CARD DEV SUBDEV ]
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars [
                                ALSA_RAWMIDI_CARD
                                ALSA_CARD
                        ]
                        default {
                                @func refer
                                name defaults.rawmidi.card
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars [
                                ALSA_RAWMIDI_DEVICE
                        ]
                        default {
                                @func refer
                                name defaults.rawmidi.device
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default -1
        }
        type hw
        card $CARD
        device $DEV
        subdevice $SUBDEV
}

rawmidi.default {
        type hw
        card {
                @func getenv
                vars [
                        ALSA_RAWMIDI_CARD
                        ALSA_CARD
                ]
                default {
                        @func refer
                        name defaults.rawmidi.card
                }
        }
        device {
                @func igetenv
                vars [
                        ALSA_RAWMIDI_DEVICE
                ]
                default {
                        @func refer
                        name defaults.rawmidi.device
                }
        }
}

rawmidi.virtual {
        @args [ MERGE ]
        @args.MERGE {
                type string
                default 1
        }
        type virtual
        merge $MERGE
}

#
#  Sequencer interface
#

seq.default {
        type hw
}

seq.hw {
        type hw
}

#
#  HwDep interface
#

hwdep.hw {
        @args [ CARD DEV ]
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars [
                                ALSA_HWDEP_CARD
                                ALSA_CARD
                        ]
                        default {
                                @func refer
                                name defaults.hwdep.card
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars [
                                ALSA_HWDEP_DEVICE
                        ]
                        default {
                                @func refer
                                name defaults.hwdep.device
                        }
                }
        }
        type hw
        card $CARD
        device $DEV
}

hwdep.default {
        type hw
        card {
                @func getenv
                vars [
                        ALSA_HWDEP_CARD
                        ALSA_CARD
                ]
                default {
                        @func refer
                        name defaults.hwdep.card
                }
        }
        device {
                @func igetenv
                vars [
                        ALSA_HWDEP_DEVICE
                ]
                default {
                        @func refer
                        name defaults.hwdep.device
                }
        }
}

#
#  Timer interface
#

timer_query.hw {
        type hw
}

timer_query.default {
        type hw
}

timer.hw {
        @args [ CLASS SCLASS CARD DEV SUBDEV ]
        @args.CLASS {
                type integer
                default {
                        @func refer
                        name defaults.timer.class
                }
        }
        @args.SCLASS {
                type integer
                default {
                        @func refer
                        name defaults.timer.sclass
                }
        }
        @args.CARD {
                type string
                default {
                        @func refer
                        name defaults.timer.card
                }
        }
        @args.DEV {
                type integer
                default {
                        @func refer
                        name defaults.timer.device
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name defaults.timer.subdevice
                }
        }
        type hw
        class $CLASS
        sclass $SCLASS
        card $CARD
        device $DEV
        subdevice $SUBDEV
}

timer.default {
        type hw
        class {
                @func refer
                name defaults.timer.class
        }
        sclass {
                @func refer
                name defaults.timer.sclass
        }
        card {
                @func refer
                name defaults.timer.card
        }
        device {
                @func refer
                name defaults.timer.device
        }
        subdevice {
                @func refer
                name defaults.timer.subdevice
        }
}

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-30-05 20:07 Varanger       New Issue                                    
08-30-05 20:07 Varanger       Distribution              => Ubuntu 5.04 "Hoary
Hedgehog"
08-30-05 20:07 Varanger       Kernel Version            => Linux
2.6.11-1-686-smp
09-08-05 09:27 cventers       Note Added: 0006070                          
09-12-05 19:02 mico           Note Added: 0006149                          
09-12-05 19:04 mico           Note Edited: 0006149                         
09-13-05 18:26 tiwai          Note Added: 0006154                          
09-15-05 19:19 Varanger       Note Added: 0006218                          
09-16-05 03:35 chrome         Note Added: 0006236                          
09-16-05 04:03 rlrevell       Note Added: 0006237                          
09-16-05 04:49 chrome         Note Added: 0006238                          
09-16-05 05:06 rlrevell       Note Added: 0006239                          
09-16-05 05:14 chrome         Note Added: 0006240                          
09-20-05 04:20 chrome         Note Added: 0006309                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
