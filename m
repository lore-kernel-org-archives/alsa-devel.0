From: Bernard Urban <Bernard.Urban@meteo.fr>
Subject: Re: CMI8330: success !
Date: 17 Jan 2003 14:54:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87el7bkhk4.fsf@merceron.meteo.fr>
References: <s5hy96qro4i.wl@alsa2.suse.de> <87el83q0oh.fsf@merceron.meteo.fr>
	<s5h65szajak.wl@alsa2.suse.de> <s5h1y3naa5u.wl@alsa2.suse.de>
	<s5hlm1u8udt.wl@alsa2.suse.de> <873cnxz8pz.fsf@merceron.meteo.fr>
	<s5hel7hwf4p.wl@alsa2.suse.de> <87ptqy3ij6.fsf_-_@merceron.meteo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <87ptqy3ij6.fsf_-_@merceron.meteo.fr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Bernard Urban <Bernard.Urban@meteo.fr>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


Hello!

I will try to summarize my tests of the current (13 January) CVS tree
for this driver:

For playback, the following /etc/asound.state file works:

state.card0 {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Master Playback Volume'
		value.0 15
		value.1 15
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Loud Playback Switch'
		value true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 63
		value.1 63
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value true
	}
	control.22 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 3'
		iface MIXER
		name 'PC Speaker Playback Volume'
		value 0
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'FM Playback Switch'
		value true
	}
	control.24 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Capture Switch'
		value true
	}
	control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'IEC958 Input Playback Switch'
		value true
	}
}
state.CARD_0 {
	control.1 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'Master Playback Volume'
		value.0 15
		value.1 15
	}
	control.2 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'Loud Playback Switch'
		value true
	}
	control.3 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
	}
	control.4 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 63'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 61
		value.1 61
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'CD Playback Switch'
		value.0 true
		value.1 true
	}
	control.11 {
		comment.access 'read write'
		comment.type INTEGER
		comment.range '0 - 15'
		iface MIXER
		name 'CD Playback Volume'
		value.0 12
		value.1 12
	}
	control.21 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name '3D Control - Switch'
		value true
	}
	control.23 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface MIXER
		name 'FM Playback Switch'
		value true
	}
}

Notice that I have deleted the controls with false or zero values to
save some place. For card0, the SB controls are absent. There are also
some differences between controls for card0 and CARD_0, why ? 
I get the CARD_0 controls when using alsamixer. 
The important thing to notice is that the SB
controls need not to be unmuted (as I first believe was necessary) ! 
So to have playback it is not needed
to define these SB controls in routine cmi8330_add_sb_mixers(). 
But the SB initialization step is probably mandatory (I will test it).

Actually, this is somehow curious, as PLAYBACK_ON_SB is defined, and
so playback should go through SB ??? It is apparently not the case.

Only one application did not work correctly, namely the old libc5
based xquake (yes, I have done
echo "xquake.real 0 0 direct" >/proc/asound/card0/pcm0p/oss).
There is sound, but extremely noisy.

Some words about the behaviour of the SB controls in alsamixer:
"SB" control follows the "SB Capture" control value.
"SB Synth", "SB PCM" and "SB Speaker" do not respond to commands.
"SB CD", "SB Line" and "SB Mic" cannot have values above 10%.

I have also tried both "SB Mic" and "Mic" controls in alsamixer, 
but capture did not work at all (only noise is registered and I have
Larsen effect when the volume is pushed too high). Nevertheless, 
as "SB Mic" cannot have values above 10%, here lies perhaps the 
problem.

I will now try to use #undefine  PLAYBACK_ON_SB.

Concerning the SB16 driver, I could not record either
(arecord is blocking indefinitly). Changing the 16 bits DMA control
did not help.

Regards.

-- 

Bernard Urban


-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
