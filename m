From: Mark J Roberts <mjr@znex.org>
Subject: Re: Audigy2 mixer not working
Date: Tue, 11 Mar 2003 14:17:02 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311201702.GA260@znex>
References: <200303110926.14478.adq_dvb@lidskialf.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200303110926.14478.adq_dvb@lidskialf.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrew de Quincey:
> If I run alsamixer, I can adjust sliders.... but it has no effect on the 
> output. I can run other programs (e.g. xmms) simultaneously, and see the 
> silder changing in alsamixer, but again, it has no effect on the output.

My mixer is semi-functional (alsa cvs). The outputs on the audigy2
look like this:

	<FIREWIRE> <LINE3> <LINE2> <LINE1> (......)

Line3's channels are independent and controlled by the "Wave Center"
and "Wave LFE" controls. Line2 is controlled by "Wave Surround"
(this is what I use at the moment).

Line1 does not work at all, though I will try your hint about -D
front later.

The "Wave" slider controls the volume of the SPDIF out, which works
fine. I haven't figured out how to monitor or record anything except
what is being output. (I'd like to get SPDIF in working...)

BTW, any slider that does not begin with "Wave" seems useless and I
leave them all muted, unlike the other cards I've tried, where they
interact in various ways.

I've attached my /etc/asound.state file in case it is any help.

--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="asound.state"

state.Audigy {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Wave Playback Volume'
		value.0 100
		value.1 100
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Wave Surround Playback Volume'
		value.0 100
		value.1 100
	}
	control.3 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Wave Center Playback Volume'
		value 0
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Wave LFE Playback Volume'
		value 0
	}
	control.5 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Music Playback Volume'
		value.0 0
		value.1 0
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Wave Capture Volume'
		value.0 0
		value.1 0
	}
	control.7 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Music Capture Volume'
		value.0 0
		value.1 0
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Center Playback Volume'
		value 0
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'LFE Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'AC97 Playback Volume'
		value.0 0
		value.1 0
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'AC97 Capture Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Audigy CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Audigy CD Capture Volume'
		value.0 0
		value.1 0
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Optical IEC958 Playback Volume'
		value.0 0
		value.1 0
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Optical IEC958 Capture Volume'
		value.0 0
		value.1 0
	}
	control.17 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Line2 Playback Volume'
		value.0 0
		value.1 0
	}
	control.18 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Line2 Capture Volume'
		value.0 0
		value.1 0
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'RCA SPDIF Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'RCA SPDIF Capture Volume'
		value.0 0
		value.1 0
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Aux2 Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 100'
		iface MIXER
		name 'Aux2 Capture Volume'
		value.0 0
		value.1 0
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 40'
		iface MIXER
		name 'Tone Control - Bass'
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 40'
		iface MIXER
		name 'Tone Control - Treble'
		value.0 0
		value.1 0
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Tone Control - Switch'
		value.0 false
		value.1 false
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name 'EFX voices mask'
		value.0 true
		value.1 false
		value.2 false
		value.3 false
		value.4 false
		value.5 false
		value.6 false
		value.7 false
		value.8 false
		value.9 false
		value.10 false
		value.11 false
		value.12 true
		value.13 false
		value.14 false
		value.15 false
		value.16 false
		value.17 false
		value.18 false
		value.19 false
		value.20 false
		value.21 false
		value.22 false
		value.23 false
		value.24 false
		value.25 false
		value.26 false
		value.27 false
		value.28 false
		value.29 false
		value.30 false
		value.31 false
		value.32 false
		value.33 false
		value.34 false
		value.35 false
		value.36 false
		value.37 false
		value.38 false
		value.39 false
		value.40 false
		value.41 false
		value.42 false
		value.43 false
		value.44 false
		value.45 false
		value.46 false
		value.47 false
		value.48 false
		value.49 false
		value.50 false
		value.51 false
		value.52 false
		value.53 false
		value.54 false
		value.55 false
		value.56 false
		value.57 false
		value.58 false
		value.59 false
		value.60 false
		value.61 false
		value.62 false
		value.63 false
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value false
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 0
		value.1 0
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Mono Playback Switch'
		value false
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.32 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.33 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.34 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.36 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.39 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.41 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.43 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.44 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.45 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.46 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.47 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 0
		value.1 0
	}
	control.48 {
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
	control.49 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.50 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.51 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.52 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.53 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.54 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name '3D Control Sigmatel - Depth'
		value 0
	}
	control.55 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
	control.56 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.57 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.58 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.59 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 1
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.60 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 1
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.61 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 1
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.62 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 2
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.63 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 2
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.64 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 2
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.65 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 3
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.66 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 3
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.67 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 3
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.68 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 4
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.69 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 4
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.70 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 4
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.71 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 5
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.72 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 5
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.73 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 5
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.74 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 6
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.75 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 6
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.76 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 6
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.77 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 7
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.78 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 7
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.79 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 7
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.80 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 8
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.81 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 8
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.82 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 8
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.83 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 9
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.84 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 9
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.85 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 9
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.86 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 10
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.87 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 10
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.88 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 10
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.89 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 11
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.90 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 11
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.91 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 11
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.92 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 12
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.93 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 12
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.94 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 12
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.95 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 13
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.96 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 13
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.97 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 13
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.98 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 14
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.99 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 14
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.100 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 14
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.101 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 15
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.102 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 15
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.103 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 15
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.104 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 16
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.105 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 16
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.106 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 16
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.107 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 17
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.108 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 17
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.109 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 17
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.110 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 18
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.111 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 18
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.112 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 18
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.113 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 19
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.114 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 19
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.115 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 19
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.116 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 20
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.117 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 20
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.118 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 20
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.119 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 21
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.120 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 21
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.121 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 21
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.122 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 22
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.123 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 22
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.124 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 22
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.125 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 23
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.126 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 23
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.127 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 23
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.128 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 24
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.129 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 24
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.130 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 24
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.131 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 25
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.132 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 25
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.133 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 25
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.134 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 26
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.135 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 26
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.136 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 26
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.137 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 27
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.138 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 27
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.139 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 27
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.140 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 28
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.141 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 28
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.142 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 28
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.143 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 29
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.144 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 29
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.145 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 29
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.146 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 30
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.147 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 30
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.148 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 30
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.149 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'EMU10K1 PCM Send Routing'
		index 31
		value.0 0
		value.1 1
		value.2 2
		value.3 3
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 0
		value.9 1
		value.10 2
		value.11 3
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 1
		value.18 2
		value.19 3
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.150 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 255'
		iface MIXER
		name 'EMU10K1 PCM Send Volume'
		index 31
		value.0 255
		value.1 255
		value.2 0
		value.3 0
		value.4 0
		value.5 0
		value.6 0
		value.7 0
		value.8 255
		value.9 0
		value.10 0
		value.11 0
		value.12 0
		value.13 0
		value.14 0
		value.15 0
		value.16 0
		value.17 255
		value.18 0
		value.19 0
		value.20 0
		value.21 0
		value.22 0
		value.23 0
	}
	control.151 {
		comment.access 'read write inactive'
		comment.type INTEGER
		comment.range '0 - 65535'
		iface MIXER
		name 'EMU10K1 PCM Volume'
		index 31
		value.0 65535
		value.1 65535
		value.2 65535
	}
	control.152 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Mask'
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.153 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value '0492100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.154 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Mask'
		index 1
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.155 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		index 1
		value '0492100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.156 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Mask'
		index 2
		value ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.157 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		index 2
		value '0492100200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.158 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Audigy Analog/Digital Output Jack'
		value true
	}
}
state.AudioPCI {
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
		name 'Master Mono Playback Switch'
		value false
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
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
		value true
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
		comment.type ENUMERATED
		comment.item.0 'pre 3D'
		comment.item.1 'post 3D'
		iface MIXER
		name 'PCM Out Path & Mute'
		value 'pre 3D'
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.27 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.28 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
}

--SUOF0GtieIMvvwua--


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
