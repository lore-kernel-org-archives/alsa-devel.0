From: Steve Strobel <steve.strobel@link-comm.com>
Subject: Re: OSS app works but aplay does not with
 SNDRV_PCM_FMTBIT_U32_LE
Date: Wed, 19 Sep 2007 09:14:42 -0600
Message-ID: <0MKp8S-1IY1GZ25ZF-0008LO@mrelay.perfora.net>
References: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
	<1190184377.23573.1211414421@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
	by alsa0.perex.cz (Postfix) with ESMTP id DC66224393
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Sep 2007 17:15:07 +0200 (CEST)
In-Reply-To: <1190184377.23573.1211414421@webmail.messagingengine.com>
References: <0MKpCa-1IXhxr0egN-0007WC@mrelay.perfora.net>
	<1190184377.23573.1211414421@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

At 12:46 AM 9/19/2007, Clemens Ladisch wrote:
>Steve Strobel wrote:
> > If I set up the snd_pcm_hardware_t structure with
> >
> >    .formats =          SNDRV_PCM_FMTBIT_U32_LE,
> >
> > the OSS test application sends a nice sine wave, but aplay fails with
> > the following messages:
> >
> > root:~> aplay < /dev/urandom
> > ALSA sound/blackfin/ad1836.c:1050: snd_ad1836_playback_open
> > Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
> > snd_pcm_hw_refine()
> > ACCESS = 00000000ffffffffffffffff -> 0000000000000008
> > FORMAT = 0000000000000400 -> 0000000000000000
>
>aplay tries to set S32_LE, but the driver doesn't accept it.
>
>Where does this S32_LE come from?  Did you set up some devices in
>~/.asoundrc or /etc/asound.conf

I don't have either of those files.

>or did you create a card-specific .conf file for your controller?

Not intentionally, but there might be one left over from the AD1836 
driver I started with (I have just been modifying that driver, 
planning to rename it after I get it working).  Where would I look 
for such a file?

The only reference to "alsa" in my /etc directory is in modprobe.conf:

root:~> cat 
/etc/modprobe.conf
# ALSA native device 
support
alias char-major-116 
snd
options snd major=116 
cards_limit=1
alias snd-card-0 
snd-ad1836

#OSS/Free 
setup
alias char-major-14 
soundcore
alias sound-slot-0 
snd-ad1836
alias sound-service-0-0 
snd-mixer-oss
alias sound-service-0-3 
snd-pcm-oss

>(I would guess that the "default" device is set up to use dmix.)

How would I determine that?  Sorry for the elementary questions;  I 
am new to ALSA.  I don't know if this answers the question, but 
"aplay -L" includes the following line:  "default 'cards.pcm.default' 
".  Complete output shown below.

>Regards,
>Clemens

Thanks for your help,

Steve


root:/mnt/Blackfin/Sound Files> aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: ad1836 [ADI ad1836], device 0: AD1836_PCM [AD1836_PCM]
   Subdevices: 1/1
   Subdevice #0: subdevice #0



root:/mnt/Blackfin/Sound Files> aplay -L
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
root:/mnt/Blackfin/Sound Files>


---
Steve Strobel
Link Communications, Inc.
1035 Cerise Rd
Billings, MT 59101-7378
(406) 245-5002 ext 102
(406) 245-4889 (fax)
WWW: http://www.link-comm.com
MailTo:steve.strobel@link-comm.com
