From: Raymond <rayau@netvigator.com>
Subject: Re: aplay - How to use device 3 of card 0 ?
Date: Tue, 08 Mar 2005 22:45:34 +0800
Message-ID: <422DBA8E.70900@netvigator.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070507080902090606050206"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------070507080902090606050206
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

 > > # aplay --verbose -d hw:0,3 piano.wav
 > > Playing WAVE 'piano.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Mono
 > > Plug PCM: Hardware PCM card 0 'au8830' device 0 subdevice 0
 >   ^^^^^^^^^
 >  It's already wrong.  Instead of hw:0,3, plug layer is used.

 >  Do you have any definition in ~/.asoundrc or /etc/asound.state?
 >  Is /usr/share/alsa/alsa.conf is properly updated from the latest
 >  alsa-lib, too


Which definition in /etc/asound.state ?

alsa.conf and AU8830.conf from alsa-lib-1.0.8


--------------070507080902090606050206
Content-Type: text/plain;
 name="asound.state"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asound.state"

state.au8830 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'EQ Enable'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ0 31Hz'
		value.0 16022
		value.1 16022
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ1 63Hz'
		value.0 16022
		value.1 16022
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ2 125Hz'
		value.0 16022
		value.1 16022
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ3 250Hz'
		value.0 16022
		value.1 16022
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ4 500Hz'
		value.0 16022
		value.1 16022
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ5 1KHz'
		value.0 16022
		value.1 16022
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ6 2KHz'
		value.0 16022
		value.1 16022
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ7 4KHz'
		value.0 16022
		value.1 16022
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ8 8KHz'
		value.0 16022
		value.1 16022
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ9 16KHz'
		value.0 16022
		value.1 16022
	}
	control.12 {
		comment.access read
		comment.type INTEGER
		comment.count 20
		comment.range '0 - 32767'
		iface MIXER
		name 'EQ Peaks'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 0
		value.18 0
		value.19 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 26
		value.1 26
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Surround Playback Switch'
		value true
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 27
		value.1 27
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Sigmatel Surround Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Sigmatel Surround Playback Volume'
		value.0 18
		value.1 18
	}
	control.19 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.37 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 26
		value.1 26
	}
	control.38 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 Mic
		value.1 Mic
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.41 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		value 'pre 3D'
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.43 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.44 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.45 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name '3D Control Sigmatel - Depth'
		value 0
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name '3D Control Sigmatel - Rear Depth'
		value 0
	}
	control.47 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Sigmatel Output Bias Switch'
		value false
	}
	control.48 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Sigmatel 4-Speaker Stereo Playback Switch'
		value false
	}
	control.49 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Sigmatel Surround Phase Inversion Playback '
		value false
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value false
	}
	control.51 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		name 'IEC958 Playback Default'
		value '0000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.52 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		name 'IEC958 Playback Con Mask'
		value fdffff0f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
}

--------------070507080902090606050206
Content-Type: text/plain;
 name="alsa.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa.conf"

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

--------------070507080902090606050206
Content-Type: text/plain;
 name="AU8830.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="AU8830.conf"

#
# Configuration for the AU8830 chip
#

<confdir:pcm/front.conf>

AU8830.pcm.front.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 0
}	

<confdir:pcm/surround40.conf>

AU8830.pcm.surround40.0 "cards.AU8830.pcm.front.0"

<confdir:pcm/iec958.conf>

AU8830.pcm.iec958.0 {
	@args [ CARD AES0 AES1 AES2 AES3 ]
	@args.CARD {
		type string
	}
	@args.AES0 {
		type integer
	}
	@args.AES1 {
		type integer
	}
	@args.AES2 {
		type integer
	}
	@args.AES3 {
		type integer
	}
	type hw
	card $CARD
	device 1
}

--------------070507080902090606050206--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
