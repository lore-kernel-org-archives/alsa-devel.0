From: mark@undertone.org
Subject: Re: btw
Date: Tue, 15 Oct 2002 12:57:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021015175750.GA8918@undertone.org>
References: <20021014191214.GB6704@undertone.org> <20021014192959.GA6792@undertone.org> <20021014193407.GA6821@undertone.org> <s5h8z106km8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8z106km8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 15, 2002 at 12:51:11PM +0200, Takashi Iwai wrote:
> At Mon, 14 Oct 2002 14:34:07 -0500,
> mark@undertone.org wrote:
> > 
> > I have got to stop spamming, you -- sincere apologies. Mixer apps will
> > start up, but it wont actually let me change any settings.
> 
> ok, could you show /etc/asound.state (suppose it works now :)
> it could be the mixer config problem.

Included. Seems like I should be able to read/write to the
device. Incidentally, with the code as it stands now (im guessing
because of that define invoked for testing), the mixer exhibits the
same exact behavior for the cs4281 card in my laptop. I can't change
any settings. I mean I can try to, and it seems to go "through" but
nothing changes.

> and, does aplay look as if working?
> i mean, the aplay starts and stops at the correct time length?
> please try to run "aplay -vv foo.wav".

It seems to "play" when i shove a wav into either pcmC1D0p or
pcmC1D0c.

> also, please check the status shown in /proc/asound/card0/stream0
> while running (playback or capture).

Included is the contents of the stream file while doing
so. Doesn't seem to be too revealing.

thanks,
-mark
--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asound.state"

state.card0 {
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
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.16 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
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
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name '3D Control Sigmatel - Depth'
		value 0
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Synth Playback Volume'
		value.0 0
		value.1 0
	}
	control.31 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Stream Playback Volume'
		value.0 0
		value.1 0
	}
}
state.card1 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'PCM Playback Volume'
		value 0
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
		value false
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Digital In Volume'
		value 0
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
		value.0 0
		value.1 0
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Line Playback Volume'
		index 1
		value 0
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
		value 0
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
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Capture Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
		value.2 0
		value.3 0
		value.4 0
		value.5 0
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 25600'
		iface MIXER
		name 'Master Playback Volume'
		index 1
		value 0
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Tone Control - Bass'
		value 0
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 96'
		iface MIXER
		name 'Tone Control - Treble'
		value 0
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Speaker Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital Out Playback Switch'
		value false
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital Out1 Playback Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Digital Out2 Playback Switch'
		value false
	}
}

--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stream0-while-playing.txt"

Creative Technology Ltd. : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 2 OUT (ASYNC)
    Rates: 48000

Capture:
  Status: Stop
  Interface 2
    Altset 1
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 8000
  Interface 2
    Altset 2
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 16000
  Interface 2
    Altset 3
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 24000
  Interface 2
    Altset 4
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 32000
  Interface 2
    Altset 5
    Format: S16_LE
    Channels: 2
    Endpoint: 6 IN (ASYNC)
    Rates: 48000

--PEIAKu/WMn1b1Hv9--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
