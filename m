From: Jonathan Kraut <krautj@earthlink.net>
Subject: alsa-driver-0.9.8, jack, cmipci
Date: Fri, 31 Oct 2003 12:06:26 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E1AFcj9-0004Jd-00@scaup.mail.pas.earthlink.net>
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


(I sent this earlier twice but forgot to subscribe and then gave wrong email address, so earlier two are pending moderator approval.  Please ignore those, and sorry).

Hi,

Alsa-driver-0.9.8 doesn't work properly for full duplex operation with jack-0.80 and spdif from a cmedia 8738. (I had been using alsa 0.9.2, before, and it worked just fine).  Here's what happens:

starting jack with
jackd -d alsa -d cmipci
causes the D/A Valid light on my external DA converter (a midiman flying cow) to go off, the levels to get pegged, and i can hear what sounds like spdif in my speakers.  I quit jack, the flying cow remains in it's weird loop, and i do something like starting and quitting esd to reset it.

if i only do capture (jackd -d alsa -d cmipci -C) it seems fine, but of course no output.

if i don't use .asoundrc (jackd -d alsa -d hw:0) the output is fine, but jack can't read any input. Note: recording without jack using arecord doesn't work with hw:0,0, but arecord -Dhw:0,2 does (as expected)

Since 0.92 works with the same jack version (0.80), I decided to post here first.  I'm more than willing to send along any other info to help resolve this problem.

my .asoundrc:
pcm.cmipci {
	type hw
	card 0
	device 2
}

ctl.cmipci {
	type hw
	card 0
}


my /proc/asound/devices: (device 3 is the dummy driver)
  1:       : sequencer
  0: [0- 0]: ctl
  8: [0- 0]: raw midi
 18: [0- 2]: digital audio playback
 26: [0- 2]: digital audio capture
 17: [0- 1]: digital audio playback
 16: [0- 0]: digital audio playback
 24: [0- 0]: digital audio capture
  4: [0- 0]: hardware dependent
 33:       : timer
 32: [1- 0]: ctl
 43: [1- 3]: raw midi
 42: [1- 2]: raw midi
 41: [1- 1]: raw midi
 40: [1- 0]: raw midi
 64: [2- 0]: ctl
 72: [2- 0]: raw midi
 96: [3- 0]: ctl
112: [3- 0]: digital audio playback
120: [3- 0]: digital audio capture

Thanks a bunch!
Jon

- --------
Jonathan Kraut
NYC
jak76@columbia.edu

------- End of Forwarded Message



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
