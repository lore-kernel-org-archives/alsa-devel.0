From: "John S. Denker" <jsd@monmouth.com>
Subject: many utils fail for extigy (usb)
Date: Fri, 06 Dec 2002 09:22:28 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF0B2A4.1020009@monmouth.com>
References: <Pine.HPX.4.33n.0212060935510.27122-100000@studcom.urz.uni-halle.de> <3DF0A26B.6060804@monmouth.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010107010909060500040205"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0212060935510.27122-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010107010909060500040205
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

  ; alsactl -f /tmp/foo.ctl store
alsactl: get_control:202: Cannot read control '2,0,0,Digital In Playback 
Source,0': Invalid argument
alsactl: get_control:202: Cannot read control '2,0,0,3D Stereo Extender 
Switch,0': Invalid argument
alsactl: get_control:202: Cannot read control '2,0,0,Up Down Switch,0': 
Invalid argument
alsactl: get_control:202: Cannot read control '2,0,0,Up Down Mode 
Select,0': Invalid argument

The resulting alsactl file is attached.

Note that I have hacked alsactl to make such errors
non-fatal;  otherwise it would have died after the
first message.

Also, in the following, note the bizarre numbers (values
of the 'index' variable)

  ; alsactl -f /tmp/foo.ctl restore
alsactl: set_control:976: Cannot write control '2:0:0:Digital In 
Playback Source:134521100' : Invalid argument
alsactl: set_control:976: Cannot write control '2:0:0:3D Stereo Extender 
Switch:134521100' : Invalid argument
alsactl: set_control:976: Cannot write control '2:0:0:Up Down 
Switch:134521100' : Invalid argument
alsactl: set_control:976: Cannot write control '2:0:0:Up Down Mode 
Select:134521100' : Invalid argument

  ; amixer
amixer: Mixer load error: default

  ; alsamixer
alsamixer: function snd_mixer_load failed: Invalid argument

--------------010107010909060500040205
Content-Type: text/plain;
 name="foo-ctl.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="foo-ctl.txt"

state.82801BAICH2 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value false
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Headphone Playback Switch'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 0
		value.1 0
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type ENUMERATED
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
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		value 'pre 3D'
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.30 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 0
	}
	control.32 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
}
state.Extigy {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'PCM Playback Volume'
		value 25600
	}
	control.3 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 PCM
		comment.item.1 'Input 1'
		iface MIXER
		name 'Digital In Playback Source'
		value PCM
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital In Switch'
		value true
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Digital In Volume'
		value 25600
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Line Playback Volume'
		value.0 22528
		value.1 22528
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Line Playback Volume'
		index 1
		value 22528
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Stereo Extender Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Mic Playback Volume'
		value 25600
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Up Down Switch'
		value false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 1'
		iface MIXER
		name 'Up Down Mode Select'
		value 0
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'Input 0'
		comment.item.1 Mic
		comment.item.2 Mixer
		iface MIXER
		name 'Capture Source'
		value 'Input 0'
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Capture Volume'
		value 25600
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Master Playback Volume'
		value.0 19456
		value.1 19456
		value.2 19456
		value.3 19456
		value.4 19456
		value.5 19456
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Master Playback Volume'
		index 1
		value 19456
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Tone Control - Bass'
		value 48
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Tone Control - Treble'
		value 48
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Speaker Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital Out Playback Switch'
		value true
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital Out1 Playback Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital Out2 Playback Switch'
		value true
	}
}

--------------010107010909060500040205--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
