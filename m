From: Jeremy Hall <jhall@maoz.com>
Subject: I must be really dense
Date: Fri, 11 Jul 2003 09:05:38 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307111305.h6BD5c96023078@sith.maoz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I upgraded from 2.5.68 to 2.5.75 this morning to see if the pcm_multi race 
had made it into the kernel, it had, and now when I try to run alsactl 
restore or alsactl store, it whines about snd_ctl_open no such file or 
directory

This is on another machine than the one I have other alsactl problems.  So 
I am quite confused and am thinking maybe some file from old alsa from 
years ago is conflicting with some current install and thus something 
magical never got installed.

Here is my asound.state file, although an asound.conf file seems to be 
updated periodically too so I'm also confused about that.

_J

state.15 {
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
		comment.type ENUMERATED
		comment.item.0 ADAT1
		comment.item.1 Coaxial
		comment.item.2 Internal
		iface PCM
		name 'IEC958 Input Connector'
		value Coaxial
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name 'IEC958 Output also on ADAT1'
		value false
	}
	control.7 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 AutoSync
		comment.item.1 Master
		comment.item.2 'Word Clock'
		iface PCM
		name 'Sync Mode'
		value Master
	}
	control.8 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'IEC958 In'
		comment.item.1 'ADAT1 In'
		comment.item.2 'ADAT2 In'
		comment.item.3 'ADAT3 In'
		iface PCM
		name 'Preferred Sync Source'
		value 'ADAT1 In'
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name 'Channels Thru'
		value.0 false
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
		value.12 false
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
	}
	control.10 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 96000'
		iface PCM
		name 'IEC958 Sample Rate'
		value -1
	}
	control.11 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT1 Sync Check'
		value 'Lock Sync'
	}
	control.12 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT2 Sync Check'
		value 'Lock Sync'
	}
	control.13 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT3 Sync Check'
		value 'Lock Sync'
	}
	control.14 {
		comment.access read
		comment.type BOOLEAN
		iface PCM
		name 'Timecode Valid'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name Passthru
		value false
	}
	control.16 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT3 Sync Check'
		value 'Lock Sync'
	}
	control.17 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 ADAT1
		comment.item.1 Internal
		iface PCM
		name 'ADAT1 Input Source'
		value ADAT1
	}
}
state.15_1 {
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
		comment.type ENUMERATED
		comment.item.0 ADAT1
		comment.item.1 Coaxial
		comment.item.2 Internal
		iface PCM
		name 'IEC958 Input Connector'
		value Coaxial
	}
	control.6 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name 'IEC958 Output also on ADAT1'
		value false
	}
	control.7 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 AutoSync
		comment.item.1 Master
		comment.item.2 'Word Clock'
		iface PCM
		name 'Sync Mode'
		value 'Word Clock'
	}
	control.8 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 'IEC958 In'
		comment.item.1 'ADAT1 In'
		comment.item.2 'ADAT2 In'
		comment.item.3 'ADAT3 In'
		iface PCM
		name 'Preferred Sync Source'
		value 'ADAT1 In'
	}
	control.9 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name 'Channels Thru'
		value.0 false
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
		value.12 false
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
	}
	control.10 {
		comment.access read
		comment.type INTEGER
		comment.range '0 - 96000'
		iface PCM
		name 'IEC958 Sample Rate'
		value -1
	}
	control.11 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT1 Sync Check'
		value 'Lock Sync'
	}
	control.12 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT2 Sync Check'
		value 'Lock Sync'
	}
	control.13 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT3 Sync Check'
		value 'Lock Sync'
	}
	control.14 {
		comment.access read
		comment.type BOOLEAN
		iface PCM
		name 'Timecode Valid'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type BOOLEAN
		iface PCM
		name Passthru
		value false
	}
	control.16 {
		comment.access read
		comment.type ENUMERATED
		comment.item.0 'No Lock'
		comment.item.1 Lock
		comment.item.2 'No Lock Sync'
		comment.item.3 'Lock Sync'
		iface PCM
		name 'ADAT3 Sync Check'
		value 'Lock Sync'
	}
	control.17 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.item.0 ADAT1
		comment.item.1 Internal
		iface PCM
		name 'ADAT1 Input Source'
		value ADAT1
	}
}


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
