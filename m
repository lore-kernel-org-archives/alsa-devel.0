From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 15:45:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F534D6A.5030706@icem.com>
References: <3F532D5E.6040300@icem.com> <s5hy8x8oefw.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050504000408000309090301"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8x8oefw.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050504000408000309090301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
...
> how did you test spdif out?  

I ran mpg123.
With nvidia's nvaudio driver, sound came out of the analog outputs
and out of the SPDIF output immediately.

With the alsa driver, sound came out of the analog outputs only.
I can control the volume both with the "Master" slider and the
"PCM" slider, as expected.
No matter what combination of the IEC958 switches I set, there
was light coming out of the SPDIF output, but no sound can be
heard.

 > you need to choose the PCM "spdif" (aka
> "iec958") for the proper output over SPDIF.

You mean alsamixer's "Item: IEC958"?
I did turn that on and off. No effect.
Just to make sure I am not misunderstanding you, I am attaching my
/etc/asound.state. With that state, I hear the PCM sound on the analog
output, but not on the SPDIF output.
If you'd like me to use different settings, please let me know and I'll
test them immediately.


> spdif input on ALC650 didn't work until this morning.  i applied the
> patch from James to cvs, so now it should work (as long as sf's
> anon-cvs repository is properly mirrored).

OK, I will update to the latest CVS.
But I guess there is no chance that loop-though will work before
PCM output works, right?

Carsten.

--------------050504000408000309090301
Content-Type: text/plain;
 name="asound.state"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="asound.state"

state.nForce2 {
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
		value.0 22
		value.1 22
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center Playback Switch'
		value false
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
		value false
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
		value.0 false
		value.1 false
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
		name 'Master Mono Playback Switch'
		value false
	}
	control.10 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Master Mono Playback Volume'
		value 0
	}
	control.11 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PC Speaker Playback Switch'
		value false
	}
	control.12 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.13 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Phone Playback Switch'
		value false
	}
	control.14 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Phone Playback Volume'
		value 0
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Playback Switch'
		value false
	}
	control.16 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Mic Playback Volume'
		value 0
	}
	control.17 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic Boost (+20dB)'
		value false
	}
	control.18 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line Playback Switch'
		value false
	}
	control.19 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Line Playback Volume'
		value.0 0
		value.1 0
	}
	control.20 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value false
	}
	control.21 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'CD Playback Volume'
		value.0 0
		value.1 0
	}
	control.22 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Video Playback Switch'
		value false
	}
	control.23 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Video Playback Volume'
		value.0 0
		value.1 0
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Aux Playback Switch'
		value false
	}
	control.25 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'Aux Playback Volume'
		value.0 0
		value.1 0
	}
	control.26 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value true
	}
	control.27 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 22
		value.1 22
	}
	control.28 {
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
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Capture Switch'
		value true
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Capture Volume'
		value.0 0
		value.1 0
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value false
	}
	control.32 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mix
		comment.item.1 Mic
		iface MIXER
		name 'Mono Output Select'
		value Mix
	}
	control.33 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 Mic1
		comment.item.1 Mic2
		iface MIXER
		name 'Mic Select'
		value Mic1
	}
	control.34 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Center'
		value 0
	}
	control.35 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name '3D Control - Depth'
		value 0
	}
	control.36 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Con Mask'
		value '0fff000f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.37 {
		comment.access read
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Pro Mask'
		value cf00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
	}
	control.38 {
		comment.access 'read write'
		comment.type IEC958
		iface MIXER
		name 'IEC958 Playback Default'
		value '0082000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000'
	}
	control.39 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Playback Switch'
		value true
	}
	control.40 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name 'IEC958 Playback AC97-SPSA'
		value 2
	}
	control.41 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Duplicate Front'
		value false
	}
	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Surround Down Mix'
		value false
	}
	control.43 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Center/LFE Down Mix'
		value false
	}
	control.44 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Exchange Center/LFE'
		value false
	}
	control.45 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Line-In As Surround'
		value false
	}
	control.46 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Swap Surround Slot'
		value false
	}
	control.47 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Mic As Center/LFE'
		value false
	}
	control.48 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Capture Switch'
		value false
	}
	control.49 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Analog to IEC958 Output'
		value true
	}
	control.50 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Monitor'
		value true
	}
	control.51 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'External Amplifier Power Down'
		value false
	}
}

--------------050504000408000309090301--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
