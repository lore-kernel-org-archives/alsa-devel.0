From: Klaus-Peter Schrage <kpschrage@gmx.de>
Subject: Re: S/PDIF locked? I have no more output!
Date: Wed, 04 Jun 2003 22:39:21 +0200
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <3EDE58F9.8020807@gmx.de>
References: <5.1.1.6.0.20030527161834.00ac2d90@naxos> <200306042013.15840.edwin@orangeport.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090509010402080609030709"
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <200306042013.15840.edwin@orangeport.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Edwin Boersma <edwin@orangeport.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090509010402080609030709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Edwin Boersma wrote:

>On Saturday 31 May 2003 16:04, Edwin Boersma wrote:
>I managed to get my output back, after trying several combinations of 
>settings. I don't really know what I did actually...
>
>Who can tell me how I can have CD output and XMMS output at the same time on 
>different channels? The nformation from Midiman is very little...
>  
>

Attached you'll find my envy24control settings which are stored in the 
file /etc/asound.state. These give me playback on

CD player (KsCD)
XMMS
mplayer
...
Furthermore, they give me a signal on S/PDIF out that I can record into 
my MD player.

My system:
- TerraTec DMX6Fire 24/96 (chip ICE1712)
- ALSA version 0.9.3.c
- Redhat 9 with kernel 2.4.20-13.9
Klaus

--------------090509010402080609030709
Content-Type: text/plain;
 name="asound.state"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asound.state"

state.DMX6Fire {
	control.1 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 255'
		iface PCM
		name 'IEC958 CS8427 Input Status'
		value 65
	}
	control.2 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 255'
		iface PCM
		name 'IEC958 CS8427 Error Status'
		value 63
	}
	control.3 {
		comment.access read
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Mask'
		value ffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.4 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Default'
		value '0202000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.5 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback PCM Stream'
		value '0202000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.6 {
		comment.access read
		comment.type BYTES
		iface PCM
		name 'IEC958 Q-subcode Capture Default'
		value '00000000000000000000'
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		value.0 true
		value.1 false
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 1
		value.0 false
		value.1 true
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 2
		value.0 false
		value.1 false
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 3
		value.0 false
		value.1 false
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 4
		value.0 false
		value.1 false
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 5
		value.0 false
		value.1 false
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 6
		value.0 false
		value.1 false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 7
		value.0 false
		value.1 false
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 8
		value.0 false
		value.1 false
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Playback Switch'
		index 9
		value.0 false
		value.1 false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		value.0 96
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 1
		value.0 0
		value.1 96
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 2
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 3
		value.0 0
		value.1 0
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 4
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 5
		value.0 0
		value.1 0
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 6
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 7
		value.0 0
		value.1 0
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 8
		value.0 0
		value.1 0
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Playback Volume'
		index 9
		value.0 0
		value.1 0
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		value.0 true
		value.1 false
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 1
		value.0 false
		value.1 true
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 2
		value.0 false
		value.1 false
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 3
		value.0 false
		value.1 false
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 4
		value.0 false
		value.1 false
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 5
		value.0 false
		value.1 false
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 6
		value.0 false
		value.1 false
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 7
		value.0 true
		value.1 true
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 8
		value.0 false
		value.1 false
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Capture Switch'
		index 9
		value.0 false
		value.1 false
	}
	control.37 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		value.0 96
		value.1 0
	}
	control.38 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 1
		value.0 0
		value.1 96
	}
	control.39 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 2
		value.0 0
		value.1 0
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 3
		value.0 0
		value.1 0
	}
	control.41 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 4
		value.0 0
		value.1 0
	}
	control.42 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 5
		value.0 0
		value.1 0
	}
	control.43 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 6
		value.0 0
		value.1 0
	}
	control.44 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 7
		value.0 0
		value.1 0
	}
	control.45 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 8
		value.0 0
		value.1 0
	}
	control.46 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Multi Capture Volume'
		index 9
		value.0 0
		value.1 0
	}
	control.47 {
		comment.access read
		comment.type BYTES
		iface CARD
		name 'ICE1712 EEPROM'
		value '1138153b1c012f80f003c0ff7f000000000000440303030003030300000000000000000000000000c0000000ff0000007f000000'
	}
	control.48 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 '8000'
		comment.item.1 '9600'
		comment.item.2 '11025'
		comment.item.3 '12000'
		comment.item.4 '16000'
		comment.item.5 '22050'
		comment.item.6 '24000'
		comment.item.7 '32000'
		comment.item.8 '44100'
		comment.item.9 '48000'
		comment.item.10 '64000'
		comment.item.11 '88200'
		comment.item.12 '96000'
		comment.item.13 'IEC958 Input'
		iface MIXER
		name 'Multi Track Internal Clock'
		value '44100'
	}
	control.49 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Track Rate Locking'
		value false
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Multi Track Rate Reset'
		value true
	}
	control.51 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		comment.item.11 'Digital Mixer'
		iface MIXER
		name 'H/W Playback Route'
		value 'Digital Mixer'
	}
	control.52 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		comment.item.11 'Digital Mixer'
		iface MIXER
		name 'H/W Playback Route'
		index 1
		value 'Digital Mixer'
	}
	control.53 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 2
		value 'PCM Out'
	}
	control.54 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 3
		value 'PCM Out'
	}
	control.55 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 4
		value 'PCM Out'
	}
	control.56 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 5
		value 'PCM Out'
	}
	control.57 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		comment.item.11 'Digital Mixer'
		iface MIXER
		name 'IEC958 Playback Route'
		value 'Digital Mixer'
	}
	control.58 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'H/W In 2'
		comment.item.4 'H/W In 3'
		comment.item.5 'H/W In 4'
		comment.item.6 'H/W In 5'
		comment.item.7 'H/W In 6'
		comment.item.8 'H/W In 7'
		comment.item.9 'IEC958 In L'
		comment.item.10 'IEC958 In R'
		comment.item.11 'Digital Mixer'
		iface MIXER
		name 'IEC958 Playback Route'
		index 1
		value 'Digital Mixer'
	}
	control.59 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'Multi Track Volume Rate'
		value 48
	}
	control.60 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'Multi Track Peak'
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
		value.18 10
		value.19 1
		value.20 0
		value.21 0
	}
	control.61 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'DAC Volume'
		value 127
	}
	control.62 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'DAC Volume'
		index 1
		value 127
	}
	control.63 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'DAC Volume'
		index 2
		value 0
	}
	control.64 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'DAC Volume'
		index 3
		value 0
	}
	control.65 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'DAC Volume'
		index 4
		value 0
	}
	control.66 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'DAC Volume'
		index 5
		value 0
	}
	control.67 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'ADC Volume'
		value 129
	}
	control.68 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 36'
		iface MIXER
		name 'IPGA Analog Capture Volume'
		value 1
	}
	control.69 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'ADC Volume'
		index 1
		value 129
	}
	control.70 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 36'
		iface MIXER
		name 'IPGA Analog Capture Volume'
		index 1
		value 1
	}
	control.71 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'ADC Volume'
		index 2
		value 128
	}
	control.72 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 36'
		iface MIXER
		name 'IPGA Analog Capture Volume'
		index 2
		value 0
	}
	control.73 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'ADC Volume'
		index 3
		value 128
	}
	control.74 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 36'
		iface MIXER
		name 'IPGA Analog Capture Volume'
		index 3
		value 0
	}
	control.75 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'ADC Volume'
		index 4
		value 128
	}
	control.76 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 36'
		iface MIXER
		name 'IPGA Analog Capture Volume'
		index 4
		value 0
	}
	control.77 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 127'
		iface MIXER
		name 'ADC Volume'
		index 5
		value 128
	}
	control.78 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 36'
		iface MIXER
		name 'IPGA Analog Capture Volume'
		index 5
		value 0
	}
	control.79 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 '44.1kHz'
		comment.item.1 Off
		comment.item.2 '48kHz'
		comment.item.3 '32kHz'
		iface MIXER
		name Deemphasis
		value Off
	}
	control.80 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 '44.1kHz'
		comment.item.1 Off
		comment.item.2 '48kHz'
		comment.item.3 '32kHz'
		iface MIXER
		name Deemphasis
		index 1
		value Off
	}
	control.81 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 '44.1kHz'
		comment.item.1 Off
		comment.item.2 '48kHz'
		comment.item.3 '32kHz'
		iface MIXER
		name Deemphasis
		index 2
		value Off
	}
	control.82 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Internal
		comment.item.1 'Front Input'
		comment.item.2 'Rear Input'
		comment.item.3 'Wave Table'
		iface MIXER
		name 'Analog Input Select'
		value 'Wave Table'
	}
	control.83 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Front Digital Input Switch'
		value true
	}
	control.84 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Optical Digital Input Switch'
		value true
	}
	control.85 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phono Analog Input Switch'
		value true
	}
	control.86 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Breakbox LED'
		value true
	}
}

--------------090509010402080609030709--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
