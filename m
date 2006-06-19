From: Ian Malone <ibmalone@gmail.com>
Subject: Re: Fwd: [Alsa-user] Recording spdif/iec958 on ice1724
 terratec aureon 7.1 space
Date: Tue, 20 Jun 2006 00:38:05 +0100
Message-ID: <4497355D.80704@gmail.com>
References: <124299980606190740v47ab8c9dgedbb88a9f607a572@mail.gmail.com>
	<s5hwtbdi02g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080204090309070409030102"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hwtbdi02g.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080204090309070409030102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Mon, 19 Jun 2006 15:40:00 +0100,
> Ian Malone wrote:

>> I'm unable to record from a toslink source as described below, it's
>> possible I've just missed some detail.
>>
>> Fedora Core 5
>> Kernel: 2.6.16-1.2122_FC5
>> Alsa: alsa-lib-1.0.11-4.rc2
>> details follow:

>>
>> Summary:
>> Recording from SPDIF input on ICE1724 device (Terratec 7.1
>> Space, but same chipset as the 5.1 Sky) records only silence.
>> Rebooting the same machine into windows recording works fine.
>> Recording source is a DAB radio, apparently at 32kHz (at least,
>> arecord tells me it was unable to select the requested rate
>> if I choose anything else).
>>

>> $ arecord -D hwplug:0,1 -f cd test.wav

>>
>> The equivalent hw:0,0 (analogue) successfully records from
>> line-in with a loopback cable.
>>
>> I have checked alsamixer, and the IEC958 source has capture
>> enabled, as does line-in.  The alsa matrix claims tosio for
>> the 5.1, does that work?
> 
> Is "Optical" chosen for "IEC958 Capture Source"? 
> Better to show the mixer status (e.g. /etc/asound.state) for further
> diagnosis.
> 

Well, this is /etc/asound.state, whether it corresponds to what
I'm actually using I don't know.

Optical is selected for the IEC958 capture source, I also tried
CD just to see if it made a difference.

Thanks for your time.

-- 
imalone

--------------080204090309070409030102
Content-Type: text/plain;
 name="asound.state"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asound.state"

state.rev50 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 22
		value.1 22
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Headphone Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Headphone Playback Volume'
		value.0 20
		value.1 20
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 23
		value.1 23
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 8
		value.1 8
	}
	control.24 {
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
		value.0 CD
		value.1 CD
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.29 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 0
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.32 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.33 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.34 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.36 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 1
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value true
	}
}
state.T71Space {
	control.1 {
		comment.access read
		comment.type BYTES
		comment.count 52
		iface CARD
		name 'ICE1724 EEPROM'
		value '1145153b13020b80fcc3ffff5f0000000000000000000000000000000000000000000000000000000000000000000000ffff5f00'
	}
	control.2 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
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
		comment.item.13 '176400'
		comment.item.14 '192000'
		comment.item.15 'IEC958 Input'
		iface MIXER
		name 'Multi Track Internal Clock'
		value '44100'
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Multi Track Rate Locking'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Multi Track Rate Reset'
		value true
	}
	control.5 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		value 'PCM Out'
	}
	control.6 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 1
		value 'PCM Out'
	}
	control.7 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 2
		value 'PCM Out'
	}
	control.8 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 3
		value 'PCM Out'
	}
	control.9 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 4
		value 'PCM Out'
	}
	control.10 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 5
		value 'PCM Out'
	}
	control.11 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 6
		value 'PCM Out'
	}
	control.12 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'H/W Playback Route'
		index 7
		value 'PCM Out'
	}
	control.13 {
		comment.access read
		comment.type INTEGER
		comment.count 22
		comment.range '0 - 255'
		iface MIXER
		name 'Multi Track Peak'
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 0
		value.10 255
		value.11 255
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 0
		value.18 0
		value.19 0
		value.20 0
		value.21 0
	}
	control.14 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'IEC958 Playback Route'
		value 'PCM Out'
	}
	control.15 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 'PCM Out'
		comment.item.1 'H/W In 0'
		comment.item.2 'H/W In 1'
		comment.item.3 'IEC958 In L'
		comment.item.4 'IEC958 In R'
		iface MIXER
		name 'IEC958 Playback Route'
		index 1
		value 'PCM Out'
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Output Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Default'
		value '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.18 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Con Mask'
		value '3fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.19 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Playback Pro Mask'
		value df00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Master Playback Switch'
		value.0 true
		value.1 true
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 255'
		iface MIXER
		name 'Master Playback Volume'
		value.0 118
		value.1 118
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Front Playback Switch'
		value.0 true
		value.1 true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		iface MIXER
		name 'Front Playback Volume'
		value.0 107
		value.1 107
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Rear Playback Switch'
		value.0 false
		value.1 false
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		iface MIXER
		name 'Rear Playback Volume'
		value.0 0
		value.1 0
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		value false
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		iface MIXER
		name 'Center Playback Volume'
		value 0
	}
	control.28 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		value false
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 127'
		iface MIXER
		name 'LFE Playback Volume'
		value 0
	}
	control.30 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Side Playback Switch'
		value.0 false
		value.1 false
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 127'
		iface MIXER
		name 'Side Playback Volume'
		value.0 0
		value.1 0
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 128'
		iface MIXER
		name 'PCM Playback Volume'
		value 118
	}
	control.34 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Capture Switch'
		value.0 true
		value.1 true
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Capture Volume'
		value.0 31
		value.1 31
	}
	control.36 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 CD
		comment.item.1 Aux
		comment.item.2 Line
		comment.item.3 Mic
		comment.item.4 AC97
		iface MIXER
		name 'Capture Source'
		value.0 Line
		value.1 Line
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'External Amplifier'
		value false
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'DAC Deemphasis Switch'
		value false
	}
	control.39 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 '128x'
		comment.item.1 '64x'
		iface MIXER
		name 'ADC Oversampling'
		value '128x'
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'AC97 Playback Switch'
		value true
	}
	control.41 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'AC97 Playback Volume'
		value.0 18
		value.1 18
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'CD Playback Switch'
		value true
	}
	control.43 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 24
		value.1 24
	}
	control.44 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.45 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 23
		value.1 23
	}
	control.46 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.47 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 23
		value.1 23
	}
	control.48 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.49 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.51 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.52 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 1
		comment.item.0 CD
		comment.item.1 Optical
		iface MIXER
		name 'IEC958 Capture Source'
		value Optical
	}
	control.53 {
		comment.access read
		comment.type BYTES
		comment.count 10
		iface PCM
		device 1
		name 'IEC958 Q-subcode Capture Default'
		value '00000000000000000000'
	}
	control.54 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Capture Mask'
		value ffffffffffffffffffffffffffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.55 {
		comment.access read
		comment.type IEC958
		comment.count 1
		iface PCM
		device 1
		name 'IEC958 Capture Default'
		value '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.56 {
		comment.access read
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 192000'
		iface PCM
		device 1
		name 'IEC958 Capture Rate'
		value 48000
	}
}

--------------080204090309070409030102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------080204090309070409030102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------080204090309070409030102--
