From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000749]: Buzz from ALSA setup
Date: Mon, 27 Dec 2004 21:47:53 +0100
Message-ID: <695d83d1f98c4508ef8f9c2b46df9e12@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id E0B3D268
	for <alsa-devel@alsa-project.org>; Mon, 27 Dec 2004 21:47:53 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=749> 
======================================================================
Reported By:                misnagid
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   749
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora FC3
Kernel Version:             2.6.9
======================================================================
Date Submitted:             12-26-2004 15:37 CET
Last Modified:              12-27-2004 21:47 CET
======================================================================
Summary:                    Buzz from ALSA setup
Description: 
I get an almost constant buzz from speakers when I've tried to use ALSA. 
Have followed your directions from the online web page directions to the
letter.  Still buzz.
Have brought all sound levels up ising alsamixer and Kmix.  Of no help. 
Have tried everything I've seen about this problem.
OnBoard NVidia audio from Asus A7N8X-E Deluxe disabled.  Using emu10k1
driver for installed Creative Labs Audigy 2 soundcard. This is a brand new
successful in all other regards install of Fedora FC3.

======================================================================

----------------------------------------------------------------------
 pzad - 12-27-04 21:31 
----------------------------------------------------------------------
Do you have .asoundrc (asound.conf) file in you home directory ?? If yes,
remove it.

Could you attach output of
aplay -L
and
aplay -l

----------------------------------------------------------------------
 misnagid - 12-27-04 21:47 
----------------------------------------------------------------------
I do not have either of those 2 files.
Here are the outputs:
[root@ashkenazi jerry]# aplay -L
PCM list:
hw {
        @args.0 CARD
        @args.1 DEV
        @args.2 SUBDEV
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars {
                                0 ALSA_PCM_CARD
                                1 ALSA_CARD
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.card'
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars {
                                0 ALSA_PCM_DEVICE
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.device'
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name 'defaults.pcm.subdevice'
                }
        }
        type hw
        card $CARD
        device $DEV
        subdevice $SUBDEV
}
plughw {
        @args.0 CARD
        @args.1 DEV
        @args.2 SUBDEV
        @args.CARD {
                type string
                default {
                        @func getenv
                        vars {
                                0 ALSA_PCM_CARD
                                1 ALSA_CARD
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.card'
                        }
                }
        }
        @args.DEV {
                type integer
                default {
                        @func igetenv
                        vars {
                                0 ALSA_PCM_DEVICE
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.device'
                        }
                }
        }
        @args.SUBDEV {
                type integer
                default {
                        @func refer
                        name 'defaults.pcm.subdevice'
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
plug {
        @args.0 SLAVE
        @args.SLAVE {
                type string
        }
        type plug
        slave.pcm $SLAVE
}
dmix {
        @args.0 SLAVE
        @args.1 FORMAT
        @args.2 RATE
        @args.SLAVE {
                type string
                default 'hw:0,0'
        }
        @args.FORMAT {
                type string
                default S16_LE
        }
        @args.RATE {
                type integer
                default 48000
        }
        type dmix
        ipc_key 5678293
        ipc_key_add_uid yes
        slave {
                pcm $SLAVE
                format $FORMAT
                rate $RATE
        }
}
dsnoop {
        @args.0 SLAVE
        @args.1 FORMAT
        @args.2 RATE
        @args.SLAVE {
                type string
                default 'hw:0,0'
        }
        @args.FORMAT {
                type string
                default S16_LE
        }
        @args.RATE {
                type integer
                default 48000
        }
        type dsnoop
        ipc_key 5778293
        ipc_key_add_uid yes
        slave {
                pcm $SLAVE
                format $FORMAT
                rate $RATE
        }
}
shm {
        @args.0 SOCKET
        @args.1 PCM
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
tee {
        @args.0 SLAVE
        @args.1 FILE
        @args.2 FORMAT
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
file {
        @args.0 FILE
        @args.1 FORMAT
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
null {
        type null
}
default {
        type plug
        slave.pcm {
                type hw
                card {
                        @func getenv
                        vars {
                                0 ALSA_PCM_CARD
                                1 ALSA_CARD
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.card'
                        }
                }
                device {
                        @func igetenv
                        vars {
                                0 ALSA_PCM_DEVICE
                        }
                        default {
                                @func refer
                                name 'defaults.pcm.device'
                        }
                }
                subdevice {
                        @func refer
                        name 'defaults.pcm.subdevice'
                }
        }
}
cards 'cards.pcm'
front 'cards.pcm.front'
rear 'cards.pcm.rear'
center_lfe 'cards.pcm.center_lfe'
side 'cards.pcm.side'
surround40 'cards.pcm.surround40'
surround41 'cards.pcm.surround41'
surround50 'cards.pcm.surround50'
surround51 'cards.pcm.surround51'
surround71 'cards.pcm.surround71'
iec958 'cards.pcm.iec958'
spdif 'cards.pcm.iec958'
modem 'cards.pcm.modem'
[root@ashkenazi jerry]#                                                   
                                                   

[root@ashkenazi jerry]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: Audigy2 [Sound Blaster Audigy2], device 0: emu10k1 [EMU10K1]
  Subdevices: 32/32
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=8
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=9
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=10
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=11
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=12
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=13
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=14
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=15: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=15
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=16: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=16
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=17: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=17
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=18
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=19: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=19
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=20: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=20
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=21
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=22: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=22
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=23
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=24
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=25: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=25
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=27: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=27
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=28: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=28
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=29: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=29
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=30: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=30
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=31: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=31
card 0: Audigy2 [Sound Blaster Audigy2], device 2: emu10k1 efx [EMU10K1
EFX]
  Subdevices: 8/8
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=0
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=4
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=6
  Subdevice https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7: subdevice
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=7
[root@ashkenazi jerry]#

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-26-04 15:37 misnagid       New Issue                                    
12-26-04 15:37 misnagid       Distribution              => Fedora FC3      
12-26-04 15:37 misnagid       Kernel Version            => 2.6.9           
12-26-04 15:58 pzad           Note Added: 0002935                          
12-26-04 16:31 misnagid       Note Added: 0002936                          
12-26-04 16:44 misnagid       Note Added: 0002937                          
12-26-04 16:56 pzad           Note Added: 0002938                          
12-26-04 17:47 misnagid       Note Added: 0002939                          
12-26-04 18:07 misnagid       Note Added: 0002940                          
12-26-04 18:17 misnagid       Note Added: 0002942                          
12-26-04 18:38 misnagid       Note Added: 0002943                          
12-26-04 19:27 pzad           Note Added: 0002944                          
12-26-04 19:44 misnagid       File Added: test.state                       
12-26-04 19:44 misnagid       Note Added: 0002945                          
12-26-04 20:02 misnagid       Note Added: 0002946                          
12-26-04 20:09 misnagid       Note Added: 0002947                          
12-26-04 20:22 pzad           File Added: newtest.state                    
12-26-04 20:27 pzad           Note Added: 0002948                          
12-26-04 20:32 pzad           Note Added: 0002949                          
12-26-04 20:59 misnagid       Note Added: 0002950                          
12-26-04 21:11 misnagid       Note Added: 0002951                          
12-26-04 21:19 pzad           Note Added: 0002952                          
12-26-04 21:22 pzad           Note Added: 0002953                          
12-26-04 21:43 misnagid       Note Added: 0002954                          
12-26-04 21:47 pzad           Note Added: 0002955                          
12-26-04 22:18 misnagid       Note Added: 0002956                          
12-26-04 23:46 misnagid       Note Added: 0002957                          
12-27-04 10:46 pzad           Note Added: 0002958                          
12-27-04 16:33 misnagid       Note Added: 0002964                          
12-27-04 16:34 misnagid       File Added: test2.state                      
12-27-04 16:38 misnagid       Note Added: 0002965                          
12-27-04 16:45 pzad           Note Added: 0002966                          
12-27-04 16:58 misnagid       Note Added: 0002967                          
12-27-04 16:58 misnagid       File Added: test3.state                      
12-27-04 17:42 misnagid       Note Added: 0002968                          
12-27-04 17:57 misnagid       Note Added: 0002969                          
12-27-04 18:16 pzad           Note Added: 0002970                          
12-27-04 18:43 misnagid       Note Added: 0002971                          
12-27-04 19:27 misnagid       Note Added: 0002972                          
12-27-04 21:09 misnagid       Note Added: 0002975                          
12-27-04 21:31 pzad           Note Added: 0002976                          
12-27-04 21:47 misnagid       Note Added: 0002977                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
