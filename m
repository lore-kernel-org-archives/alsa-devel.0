From: "Ivica Bukvic" <ico@fuse.net>
Subject: problems with Midisport 2x2
Date: Mon, 24 Feb 2003 21:07:59 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000c01c2dc72$b8427220$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
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
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



-----Original Message-----
From: Ivica Bukvic [mailto:ico@fuse.net] 
Sent: Monday, February 24, 2003 3:59 PM
To: linux-audio-dev@music.columbia.edu
Cc: linux-audio-user@music.columbia.edu; ico@fuse.net
Subject: problems with Midisport 2x2

Hi all,

I've got a small problem with my Midisport 2x2 MIDI interface. While it
worked 
ok before, now for some odd reason I cannot get it to open for MIDI
output 
(from the computer). I've checked the /var/log/messages and this is what
I 
got:

Feb 24 20:44:41 mycomp kernel: hub.c: USB new device connect on bus2/1, 
assigned device number 2
Feb 24 20:44:41 mycomp kernel: usb.c: USB device 2 (vend/prod
0x763/0x1001) is 
not claimed by any active driver.
Feb 24 20:44:44 mycomp /etc/hotplug/usb.agent: Setup ezusbmidi for USB
product 
763/1001/1
Feb 24 20:44:44 mycomp /etc/hotplug/usb.agent: Module setup ezusbmidi
for USB 
product 763/1001/1
Feb 24 20:44:44 mycomp /etc/hotplug/usb/ezusbmidi: load 
/usr/share/usb/ezusbmidi/ezusbmidi2x2.ihx for 763/1001/1 to 
/proc/bus/usb/002/002
Feb 24 20:44:44 mycomp kernel: usb-uhci.c: interrupt, status 2, frame#
1645
Feb 24 20:44:44 mycomp kernel: usb.c: USB disconnect on device 2
Feb 24 20:44:44 mycomp kernel: hub.c: USB new device connect on bus2/1, 
assigned device number 3
Feb 24 20:44:44 mycomp kernel: usb.c: USB device 3 (vend/prod
0x763/0x1110) is 
not claimed by any active driver.
Feb 24 20:44:48 mycomp /etc/hotplug/usb.agent: Setup snd-usb-audio audio
usb 
usb-midi for USB product 763/1110/1
Feb 24 20:44:48 mycomp kernel: usb.c: registered new driver
snd-usb-audio
Feb 24 20:44:48 mycomp kernel: snd-usb-midi: MIDIStreaming version 01.00
Feb 24 20:44:48 mycomp kernel: snd-usb-midi: EP 01: 2 jack(s)
Feb 24 20:44:48 mycomp kernel: snd-usb-midi: EP 81: 2 jack(s)
Feb 24 20:44:48 mycomp kernel: snd-usb-midi: created 0 output and 4
input 
ports
Feb 24 20:44:48 mycomp kernel: usb-uhci.c: ENXIO c0008380, flags 0, urb 
cdc59d60, burb cdc59ce0
Feb 24 20:44:48 mycomp kernel: snd-usb-midi: usb_submit_urb: -6
Feb 24 20:44:48 mycomp /etc/hotplug/usb.agent: ... blacklisted module:
audio
Feb 24 20:44:48 mycomp kernel: usb.c: registered new driver midi
Feb 24 20:44:48 mycomp /etc/hotplug/usb.agent: ... blacklisted module:  
usb-midi

It says that the device was opened with 4 input and 0 output ports. Why
is 
this the case? I have no problem getting the midi input going, but my
output 
is mysteriously dead.

I've read somewhere that if the device is reconnected that the output
stops 
working (might have been CCRMA's Fernando), but this is the log from the

initial connect as soon as the computer boots.

I've also made sure that no MIDI devices were connected to the MIDISPORT
upon 
starting up.

Any help on this issue is greatly appreciated! Sincerely,

Ico



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
