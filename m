From: Pierre Ossman <drzeus-list@drzeus.cx>
Subject: Re: No sound with snd_cmipci
Date: Mon, 09 Oct 2006 16:09:38 +0200
Message-ID: <452A5822.9090804@drzeus.cx>
References: <452936A5.1020902@drzeus.cx> <s5hk639r4tz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_hera.drzeus.cx-13193-1160402966-0001-2"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hk639r4tz.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-13193-1160402966-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> It's weird.  Possibly a new chip revision that is slightly
> incompatible with the olders?  Check /proc/asound/cards which revision
> it has.
>
>   

 1 [CMI8738MC6     ]: CMI8738-MC6 - C-Media PCI CMI8738-MC6
                      C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 11

> Anyway, please show the current mixer state (/etc/asound.state, or a
> file generated via "alsactl -f somefile store"), and the register dump
> of /proc/asound/card0/cmipci.
>
>   

State file included.

Register dump:

[root@chronos ~]# cat /proc/asound/card1/cmipci
C-Media PCI CMI8738-MC6 (model 55) at 0xe800, irq 11

00: 00 00 00 00
04: 10 fc 00 00
08: 0f 00 09 00
0c: 00 00 00 0b
10: c0 00 00 00
14: 00 00 00 00
18: 00 80 80 0c
1c: c8 fe fe ff
20: 10 40 f9 00
24: ef 3e ff 00
28: ff ff ff ff
2c: ff ff ff ff
30: 00 00 00 00
34: 00 00 00 00
38: 00 00 00 00
3c: 00 00 00 00

Are there any specs available on this chip or is it all reverse engineered?

Rgds
Pierre


--=_hera.drzeus.cx-13193-1160402966-0001-2
Content-Type: text/plain; name="cmipci.state"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cmipci.state"

state.CMI8738MC6 {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 20
		value.1 20
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name '3D Control - Switch'
		value true
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 31
		value.1 31
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'PCM Capture Switch'
		value.0 true
		value.1 true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Synth Playback Volume'
		value.0 31
		value.1 31
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Synth Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 4
		iface MIXER
		name 'Synth Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 31
		value.1 31
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'CD Playback Switch'
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 4
		iface MIXER
		name 'CD Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 31
		value.1 31
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Line Playback Switch'
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 4
		iface MIXER
		name 'Line Capture Route'
		value.0 false
		value.1 false
		value.2 false
		value.3 false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 11
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Capture Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 3
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 15
		value.1 15
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Aux Playback Switch'
		value.0 true
		value.1 true
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Aux Capture Switch'
		value.0 false
		value.1 false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 7'
		iface MIXER
		name 'Mic Capture Volume'
		value 7
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 7'
		iface MIXER
		name 'Phone Playback Volume'
		value 7
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playnack Switch'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost Capture Switch'
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Four Channel Mode'
		value true
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Line-In
		comment.item.1 'Rear Output'
		comment.item.2 'Bass Output'
		iface MIXER
		name 'Line-In Mode'
		value 'Rear Output'
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Valid'
		value false
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Copyright'
		value false
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 5V'
		value true
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Loop'
		value false
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Monitor'
		value true
	}
	control.36 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.37 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback Con Mask'
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.38 {
		comment.access 'read write inactive'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 2
		name 'IEC958 Playback PCM Stream'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Select'
		value false
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 In Phase Inverse'
		value false
	}
	control.41 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic-In
		comment.item.1 'Center/LFE Output'
		iface MIXER
		name 'Mic-In Mode'
		value Mic-In
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface CARD
		name Modem
		value false
	}
}

--=_hera.drzeus.cx-13193-1160402966-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=_hera.drzeus.cx-13193-1160402966-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=_hera.drzeus.cx-13193-1160402966-0001-2--
