From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Some quick pointers requested
Date: Fri, 27 Jan 2006 21:16:30 +0000
Message-ID: <1138396590.9446.4.camel@localhost.localdomain>
References: <33237.217.150.108.178.1138279298.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 72FD019D
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 22:16:43 +0100 (MET)
Received: from bossclass (bossclass [192.168.62.105])
	by localhost.localdomain (8.13.4/8.13.1) with ESMTP id k0RLGVp9019555
	for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2006 21:16:31 GMT
In-Reply-To: <33237.217.150.108.178.1138279298.squirrel@newgolddream.dyndns.info>
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

On Thu, 2006-01-26 at 12:41 +0000, Adrian McMenamin wrote:
> I am writing a driver for the sound card on the Dreamcast (I have been for
> about three years now, but i am actually making progress now).
> 
> I have a shell of a driver which doesn't do very much (you can see the
> sources at http://newgolddream.dyndns.info/repos) but I have now built and
> installed alsalib and alsa-utils against uClibc to test what I have.
> 
> However a quick use of aplay generates a number of errors:
> 
> 
> /sys/devices/platform/snd_card_aica # aplay -L
> aplay: pcm_list:280: snd_config_update: Invalid argument

> 
> 
OK, reading through the sources I worked out that this was essentially
because I didn't have any config files and I just copied over the
alsa.conf file in the lib sources - but, for instance, typing aplay -L
doesn't really produce any sensible output (see below) - do I have to
build a sensible config file by hand? (I cannot find much documentation
so any points would be a great help)

/ # aplay -L
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
phoneline 'cards.pcm.phoneline'
default 'cards.pcm.default'
dmix 'cards.pcm.dmix'
dsnoop 'cards.pcm.dsnoop'




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
