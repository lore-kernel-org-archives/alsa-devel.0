From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp patch
Date: 15 Jun 2003 13:12:36 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055707956.1551.55.camel@Wizard.knechthome.com>
References: <200306140455.h5E4tao15150@linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-R6dFzjLXiBj7YH7E2NqZ"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306140455.h5E4tao15150@linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-R6dFzjLXiBj7YH7E2NqZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Paul,
   I've been trying for the last day or so to get some sound out of the
card. Still no luck. The setup does work fine when I boot into Windows.
I've certainly had a few problems on this end, like getting
/etc/asound.state into a funny configuration that had both the on-board
Via chipset and the HDSP 9652 in it. That's fixed, but still no sound.

   I'm running as root. I've tried both Jack and straight Alsa with
aplay and alsaplayer. Everything acts like I should be getting sound,
but I don't. The Alsa drivers appear to be loaded. Restarting Alsa looks
pretty normal.

   alsamixer says everything is turned up to 30. 'M' doesn't seem to
mute or unmute and channels for this card.

   Can you clarify - do I need to make any 'connections' through the
HDSP 9652 to get the alsa_pcm:playback_1/2 to be enabled and supplying
audio to my amp? If so, what commands are you using?

   I'm attaching asound.state, .asoundrc and a little more info. Let me
know what else you want to see.

   Thanks for any pointers you can provide.

Cheers,
Mark

Wizard root # lsmod
Module                  Size  Used by    Not tainted
snd-hdsp               32556   3 
snd-rawmidi            15040   0  [snd-hdsp]
snd-seq-device          4352   0  [snd-rawmidi]
snd-pcm                64928   2  [snd-hdsp]
snd-timer              15876   0  [snd-pcm]
snd-hwdep               5216   0  [snd-hdsp]
snd                    32836   1  [snd-hdsp snd-rawmidi snd-seq-device
snd-pcm snd-timer snd-hwdep]
radeon                107972   1 
agpgart                11920   3  (autoclean)
ide-cd                 27080   0  (autoclean)
cdrom                  25984   0  (autoclean) [ide-cd]
snd-page-alloc          5404   0  [snd-pcm]
snd-hammerfall-mem      1920   0  [snd-hdsp]
Wizard root # 





Wizard root # cat /proc/asound/card0/hdsp 
RME HDSP 9652 (Card #1)
Buffers: capture df000000 playback dee00000
IRQ: 17 Registers bus: 0xe8800000 VM: 0xe08e6000
Control register: 0x10080b3
Status register: 0x2043088
Status2 register: 0xffff8041
FIFO status: 0
MIDI1 Output status: 0xffffff00
MIDI1 Input status: 0xffffff5e
MIDI2 Output status: 0xffffff00
MIDI2 Input status: 0xffffff4b

Buffer Size (Latency): 128 samples (2 periods of 512 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Sample Clock Source: Internal 44.1 kHz
Preferred Sync Reference: ADAT1
AutoSync Reference: ADAT1
AutoSync Frequency: 44100
System Clock Mode: Master
System Clock Frequency: 44100

IEC958 input: Internal
IEC958 output: Coaxial only
IEC958 quality: Consumer
IEC958 emphasis: off
IEC958 NonAudio: off
IEC958 sample rate: Error flag set

ADAT1: Sync
ADAT2: No Lock
ADAT3: No Lock
SPDIF: No Lock
Word Clock: No Lock
ADAT Sync: No Lock

Wizard root # 



On Fri, 2003-06-13 at 21:55, Paul Davis wrote:
> this patch fixes some basic problems with the hdsp driver with respect
> to the hdsp9652 card. it also cleans up a few minor issues with naming
> in the driver, and slightly rationalizes initialization to involve
> the minimum of special-casing for the hdsp9652.
> 
> the basic problem with the hdsp9652 was related to 8 bit versus 32 bit
> offsets when addressing the mixer memory. once this was fixed,
> everything worked. this driver continues to work fine on my
> pci+digiface unit as well.
> 
> my apologies for this taking so long - it has taken a long time to ask
> RME the "right" question, and quite a long time to get the
> answer. once i got down to it, the fix took 5 minutes!
> 
> now we just need to solve the multiface initialization problems :(
> 
> --p
> 


--=-R6dFzjLXiBj7YH7E2NqZ
Content-Disposition: attachment; filename=asound.state
Content-Type: text/plain; name=asound.state; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

state.'' {
	control.1 {
		comment.access 'read write'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback Default'
		value '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.2 {
		comment.access 'read write inactive'
		comment.type IEC958
		iface PCM
		name 'IEC958 Playback PCM Stream'
		value '0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.3 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '3b00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.4 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value '1f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface HWDEP
		name Mixer
		value.0 0
		value.1 0
		value.2 0
	}
	control.6 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 ADAT1
		comment.item.1 Coaxial
		comment.item.2 Internal
		iface PCM
		name 'IEC958 Input Connector'
		value Internal
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface HWDEP
		name 'IEC958 Output also on ADAT1'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface HWDEP
		name 'IEC958 Professional Bit'
		value false
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface HWDEP
		name 'IEC958 Emphasis Bit'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface HWDEP
		name 'IEC958 Non-audio Bit'
		value false
	}
	control.11 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 AutoSync
		comment.item.1 'Internal 32.0 kHz'
		comment.item.2 'Internal 44.1 kHz'
		comment.item.3 'Internal 48.0 kHz'
		comment.item.4 'Internal 64.0 kHz'
		comment.item.5 'Internal 88.2 kHz'
		comment.item.6 'Internal 96.0 kHz'
		iface PCM
		name 'Sample Clock Source'
		value 'Internal 44.1 kHz'
	}
	control.12 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 Master
		comment.item.1 Slave
		iface HWDEP
		name 'System Clock Mode'
		value Master
	}
	control.13 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Word
		comment.item.1 'ADAT Sync'
		comment.item.2 IEC958
		comment.item.3 ADAT1
		comment.item.4 ADAT2
		comment.item.5 ADAT3
		iface HWDEP
		name 'Preferred Sync Reference'
		value ADAT1
	}
	control.14 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 Word
		comment.item.1 'ADAT Sync'
		comment.item.2 IEC958
		comment.item.3 None
		comment.item.4 ADAT1
		comment.item.5 ADAT2
		comment.item.6 ADAT3
		iface HWDEP
		name 'AutoSync Reference'
		value None
	}
	control.15 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 '32000'
		comment.item.1 '44100'
		comment.item.2 '48000'
		comment.item.3 '64000'
		comment.item.4 '88200'
		comment.item.5 '96000'
		comment.item.6 None
		iface HWDEP
		name 'SPDIF Sample Rate'
		value None
	}
	control.16 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 0'
		iface HWDEP
		name 'System Sample Rate'
		value 44100
	}
	control.17 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 '32000'
		comment.item.1 '44100'
		comment.item.2 '48000'
		comment.item.3 '64000'
		comment.item.4 '88200'
		comment.item.5 '96000'
		comment.item.6 None
		iface PCM
		name 'External Rate'
		value '48000'
	}
	control.18 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 Sync
		iface HWDEP
		name 'Word Clock Lock Status'
		value 'No Lock'
	}
	control.19 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 Sync
		iface HWDEP
		name 'SPDIF Lock Status'
		value 'No Lock'
	}
	control.20 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 Sync
		iface HWDEP
		name 'ADAT Sync Lock Status'
		value 'No Lock'
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface HWDEP
		name Passthru
		value false
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface HWDEP
		name 'Line Out'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 1
		value 19665
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 2
		value 19665
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 3
		value 19665
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 4
		value 19665
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 5
		value 19665
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 6
		value 19665
	}
	control.29 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 7
		value 19665
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 8
		value 19665
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 9
		value 19665
	}
	control.32 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 10
		value 19665
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 11
		value 19665
	}
	control.34 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 12
		value 19665
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 13
		value 19665
	}
	control.36 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 14
		value 19665
	}
	control.37 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 15
		value 19665
	}
	control.38 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 16
		value 19665
	}
	control.39 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 17
		value 19665
	}
	control.40 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 18
		value 19665
	}
	control.41 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 19
		value 19665
	}
	control.42 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 20
		value 19665
	}
	control.43 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 21
		value 19665
	}
	control.44 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 22
		value 19665
	}
	control.45 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 23
		value 19665
	}
	control.46 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 24
		value 19665
	}
	control.47 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 25
		value 19665
	}
	control.48 {
		comment.access 'read write volatile'
		comment.type INTEGER
		comment.range '0 - 65536 (step 1)'
		iface MIXER
		name Chn
		index 26
		value 19665
	}
	control.49 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 Sync
		iface HWDEP
		name 'ADAT Lock Status'
		index 1
		value Sync
	}
	control.50 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 Sync
		iface HWDEP
		name 'ADAT Lock Status'
		index 2
		value 'No Lock'
	}
	control.51 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 Sync
		iface HWDEP
		name 'ADAT Lock Status'
		index 3
		value 'No Lock'
	}
}

--=-R6dFzjLXiBj7YH7E2NqZ
Content-Disposition: attachment; filename=RME.asoundrc
Content-Type: text/plain; name=RME.asoundrc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

pcm.hdsp {
           type hw
	   card 0
         }

ctl.hdsp {
           type hw
           card 0
         }

--=-R6dFzjLXiBj7YH7E2NqZ--



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
