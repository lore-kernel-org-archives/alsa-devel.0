From: Alan Jenkins <aj504@student.cs.york.ac.uk>
Subject: Re: SiS 7012 with snd_intel8x0 is silent
 [aj504@student.cs.york.ac.uk]
Date: Sat, 08 Jan 2005 09:16:26 +0000
Message-ID: <1105175786l.10260l.0l@localhost>
References: <1105049276.12514.11.camel@localhost>
	<1105105972l.10186l.0l@localhost> <s5h3bxdw4az.wl@alsa2.suse.de>
	<1105133121.21211.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; DelSp=Yes; Format=Flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1105133121.21211.3.camel@localhost> (from
	aj504@student.cs.york.ac.uk on Fri Jan  7 21:25:21 2005)
Content-Disposition: inline
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

Copied to list for posterity.

On Fri, 2005-01-07 at 17:13, Takashi Iwai wrote:
> At Fri, 07 Jan 2005 13:52:52 +0000,
> Alan Jenkins wrote:
> >
> > My original message was too big for the list; I have now replaced
two
> > kernel configurations with the more recent one one and a diff.
> >
> > The problem is in linux 2.6.10 but not 2.6.9
> > The OSS driver i810_audio works on both versions
> > I compiled the driver as a module
> > I have tried to make sure the kernel configurations are comparable
by
> > using make oldconfig and answering "n" to (almost) everything.
>
> This kind of problem is likely a mixer configuration, not the kernel
> configuration.  Make sure that you set up the mixer properly.
>
> For debugging, please attach the content of /etc/asound.state and the
> output of /proc/asound/card0/codec97#0/* files.
>
>
> Takashi

Attached as requested.

I ran out of time last night.  I ran alsamixer and mixer configuration
problems did appear to be involved.

When I boot the 2.6.10 kernel I get zero volume on every channel though
not muted), when previouslly runlevel scripts would restore the volume
level set last time.  I still get no sound if I push every channel
possible to 100% unmuted (as shown in the attached files).  Restarting
the runlevel script responsible seems to preseve volume settings but
occasionally mutes channels which where not previously muted.

I am using an analogue output (3.5mm jack plug), and have set
the "IEC958 Playback Source" (in alsamixer) option to Analog.

My suspicion is that the output selection is at fault.

Thanks!


state.SI7012 {
	control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Playback Volume'
		value.0 11
		value.1 11
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		value true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Center Playback Volume'
		value 0
	}
	control.5 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'LFE Playback Switch'
		value true
	}
	control.6 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'LFE Playback Volume'
		value 0
	}
	control.7 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Playback Switch'
		value.0 true
		value.1 true
	}
	control.8 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Surround Playback Volume'
		value.0 0
		value.1 0
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value true
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value true
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value.0 0
		value.1 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value true
	}
	control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value true
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
		value true
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
		value true
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
		value true
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
		value true
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
		value.0 'Mix Mono'
		value.1 'Mix Mono'
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
	control.29 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value =20
'0fff000f000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000'
	}
	control.30 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value =20
cf0000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
0000000000000000000000000000000000000000000000000000
	}
	control.31 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value =20
'00820002000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
000000000000000000000000000000000000000000000000000000000000000000000000000=
00000000000000000000000000000000000000000000000000000'
	}
	control.32 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.33 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 0
	}
	control.34 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Analog
		comment.item.1 Digital
		iface MIXER
		name 'IEC958 Playback Source'
		value Analog
	}
	control.35 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Valid Switch'
		value true
	}
	control.36 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Monitor'
		value true
	}
	control.37 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.38 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line-In As Surround'
		value true
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic As Center/LFE'
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier'
		value true
	}
}





-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
