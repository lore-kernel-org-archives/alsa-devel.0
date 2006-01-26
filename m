From: =?ISO-8859-1?Q?Petter_Sundl=F6f?= <petter.sundlof@findus.dhs.org>
Subject: Some problems with two 1010LTs (pcm_multi & jackd)
Date: Thu, 26 Jan 2006 15:04:25 +0100
Message-ID: <43D8D6E9.80902@findus.dhs.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000606050203070900060107"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from findus.dhs.org (gl177a.glassen.ac [82.182.223.101])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 710C718B
	for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2006 14:58:00 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000606050203070900060107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello.

I've added a second 1010LT in my studio box. The two LTs are card1 and=20
card2.
Following the steps from=20
http://www.sound-man.co.uk/linuxaudio/ice1712multi.html I created the=20
.asoundrc (and modified it to hw:1 and 2 where appropriate. I have=20
attached this file.
I then proceeded to patch jack 0.100.7 (release tarball) with the=20
MMAP_COMPLEX patch. This was installed to the /usr/ prefix.

I then downloaded alsa-lib-1.0.10 (release) and applied pcm_multi-patch.=20
I installed this over the existing alsa-lib, into prefix /usr/lib.

After this I tried to run jackd -d alsa -r44100 -p512 -C multi_capture=20
-P multi_playback

I then get this stdout message:

jackd 0.100.7
Copyright 2001-2005 Paul Davis and others.
jackd comes with ABSOLUTELY NO WARRANTY
This is free software, and you are welcome to redistribute it
under certain conditions; see the file COPYING for details

JACK compiled with System V SHM support.
loading driver ..
creating alsa driver ...=20
multi_playback|multi_capture|1024|2|48000|0|0|nomon|swmeter|-|32bit
configuring for 48000Hz, period =3D 1024 frames, buffer =3D 2 periods
nperiods =3D 2 for capture
nperiods =3D 2 for playback

I then start Ardour and open a session. I place the playhead somewhere=20
and try to start playback. Nothing happens. After a few seconds, Ardour=20
is disconnected from JACK, and I receive this in jackd's stdout:

ALSA: poll time out, polled for 17416024 usecs
DRIVER NT: could not run driver cycle
jack main caught signal 12
no message buffer overruns

Clues?

Info: Kernel 2.6.14-0.10.rrt.rhfc4.ccrma #1 PREEMPT
Cards are not connected via S/PDIF or World clock -- don't have any such=20
cables, and besides, I read it isn't working _yet_ with LT cards.
Hardware: Sempron 2600, 1GB RAM.
Software: Fedora Core 4 + CCRMA.

Any tips appreciated.

Thanks in advance,
Petter Sundl=F6f

--------------000606050203070900060107
Content-Type: text/plain;
 name=".asoundrc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename=".asoundrc"

# .asoundrc for two Delta 1010s
#
# Create virtual devices out of multiple soundcards.
# JACK will need MMAP_COMPLEX support to use this. 
# ICE1712 chip has 12 capture channels and 10 playback channels.
# No. of channels in slaves must equal 12 for capture and 10 for playback
# otherwise "invalid argument" errors result.

pcm.multi_capture {
	type multi
	slaves.a.pcm hw:1 
	slaves.a.channels 12
	slaves.b.pcm hw:2
	slaves.b.channels 12

# First 8 channels of first soundcard (capture)
 	bindings.0.slave a
 	bindings.0.channel 0
 	bindings.1.slave a
 	bindings.1.channel 1
 	bindings.2.slave a
 	bindings.2.channel 2
 	bindings.3.slave a
 	bindings.3.channel 3
 	bindings.4.slave a
 	bindings.4.channel 4
 	bindings.5.slave a
 	bindings.5.channel 5
 	bindings.6.slave a
 	bindings.6.channel 6
 	bindings.7.slave a
 	bindings.7.channel 7
    
# First 8 channels of second soundcard (capture)
 	bindings.8.slave b
 	bindings.8.channel 0
 	bindings.9.slave b
 	bindings.9.channel 1
 	bindings.10.slave b
 	bindings.10.channel 2
 	bindings.11.slave b
 	bindings.11.channel 3
 	bindings.12.slave b
 	bindings.12.channel 4
 	bindings.13.slave b
 	bindings.13.channel 5
 	bindings.14.slave b
 	bindings.14.channel 6
 	bindings.15.slave b
 	bindings.15.channel 7

# S/PDIF section. Comment out if not required.

# S/PDIF first soundcard (capture)
 	bindings.16.slave a
 	bindings.16.channel 8
 	bindings.17.slave a
 	bindings.17.channel 9
    
# S/PDIF second soundcard (capture)
 	bindings.18.slave b
 	bindings.18.channel 8
 	bindings.19.slave b
 	bindings.19.channel 9
}

ctl.multi_capture {
	type hw
	card 1
}

pcm.multi_playback {
	type multi
	slaves.a.pcm hw:1
	slaves.a.channels 10
	slaves.b.pcm hw:2
	slaves.b.channels 10

# First 8 channels of first soundcard (playback)
 	bindings.0.slave a
 	bindings.0.channel 0
 	bindings.1.slave a
 	bindings.1.channel 1
 	bindings.2.slave a
 	bindings.2.channel 2
 	bindings.3.slave a
 	bindings.3.channel 3
 	bindings.4.slave a
 	bindings.4.channel 4
 	bindings.5.slave a
 	bindings.5.channel 5
 	bindings.6.slave a
 	bindings.6.channel 6
 	bindings.7.slave a
 	bindings.7.channel 7

# First 8 channels of second soundcard (playback)
 	bindings.8.slave b
 	bindings.8.channel 0
 	bindings.9.slave b
 	bindings.9.channel 1
 	bindings.10.slave b
 	bindings.10.channel 2
 	bindings.11.slave b
 	bindings.11.channel 3
 	bindings.12.slave b
 	bindings.12.channel 4
 	bindings.13.slave b
 	bindings.13.channel 5
 	bindings.14.slave b
 	bindings.14.channel 6
 	bindings.15.slave b
 	bindings.15.channel 7

# S/PDIF section. Comment out if not required.

# S/PDIF first soundcard (playback)
 	bindings.16.slave a
 	bindings.16.channel 8
 	bindings.17.slave a
 	bindings.17.channel 9
    
# S/PDIF second soundcard (playback)
 	bindings.18.slave b
 	bindings.18.channel 8
 	bindings.19.slave b
 	bindings.19.channel 9
}

ctl.multi_playback {
	type hw
	card 1
}

--------------000606050203070900060107--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
