From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: rawmidi problems
Date: Mon, 8 Jul 2002 17:41:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207081741.46397.plcl@telefonica.net>
References: <200207051753.54999.plcl@telefonica.net> <200207051930.42945.plcl@telefonica.net> <s5h65zqv6xx.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h65zqv6xx.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

El Lun 08 Jul 2002 12:40, Takashi Iwai escribió:
> At Fri, 5 Jul 2002 19:30:42 +0200,
> Pedro Lopez-Cabanillas wrote:
> > with /dev/midi00 ouput goes to ens-1371, /dev/midi01 goes to the first
> > usb midi device, and /dev/midi02 goes to the second, but both usb devices
> > have 2 inputs ans 2 outputs. Can I get all my five midi ports work with
> > oss midi emulation?
>
> do you really need to use oss midi devices?
> as long as you only reading/writing midi byte streams (i.e. no
> ioctls), you can use simply alsa rawmidi devices, /dev/snd/midiCxDx,
> instead of /dev/midiXX.

No, I agree with you. In fact, I don't need the raw midi devices at all, as 
the sequencer API can do all and more.

My question was if I made a mistake or I am forgiving something, or if it is a  
limitation on ALSA OSS emulation. Only trying to deeply test the new  
snd-usb-midi driver. And for the fun of doing the things in several different 
ways.

As an example, and only for fun, this is a bash script for cron (hourly, of 
course) that plays thru raw midi devices without any special program.

Best regards,
Pedro

#!/bin/bash
#
# London Tower Big Ben tune as a simple bash script
# Copyright (C) 2002  Pedro Lopez-Cabanillas
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
tune="C 4, E 4, D 4, g 2, C 4, D 4, E 4, C 2, \
      E 4, C 4, D 4, g 2, g 4, D 4, E 4, C 2,"

mididev="/dev/midi03"
tempo=80 				# quarters per minute

function playnote() {
	let "ms = 240000 / ($2 * $tempo)"
	echo -ne '\x90' >&3
	echo -ne "$1\144" >&3
	sleep $ms'e-3s'
	echo -ne '\x80' >&3
	echo -ne "$1\000" >&3
}

function playtune() {
	echo $1 | tr "cdefgabCDEFGAB" "<>@ACEGHJLMOQS" | \
		while read -rd, note length; do
			playnote $note $length
		done
}

function playhour() {
	h=`date +%l`
	while [ $h -gt 0 ]; do
	    playnote $'\x37' 2
	    let "h--"
	done
}

if [ -c $mididev -a -w $mididev ]; then
	exec 3>$mididev
	echo -ne '\xb0\x07\x7f' >&3	# volume = 127
	echo -ne '\xc0\x0e' >&3		# instrument = bells
	playtune "$tune"
	sleep 2
	playhour
	exec 3<&-
else
	echo "`basename $0` : invalid MIDI device ( $mididev )"
fi



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
