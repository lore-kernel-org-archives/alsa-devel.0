From: Josh Green <jgreen@users.sourceforge.net>
Subject: Edirol PCR-50 keyboard with ALSA USB MIDI
Date: 01 Jan 2003 21:16:12 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041484574.19564.23.camel@sprekhole>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-UxwlV6Qi50QvkhfVFKa9"
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


--=-UxwlV6Qi50QvkhfVFKa9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I sent an email to alsa-user about this issue a few days ago, but now
I've delved into the problem a little more and believe it to be a bug
(rather than user error :)

I'm having some troubles getting my Edirol PCR-50 keyboard working via
USB with my laptop. I'm using latest CVS of ALSA (as of December 28
2002) and stock linux-2.4.20 on a Mandrake 9.0 system. The keyboard is
detected and the snd-usb-audio module hotplugs itself, but I'm not
getting any data via the raw MIDI port or sequencer ports. Here is the
output from /var/log/messages when plugging the device:

Dec 29 19:39:44 SillyPuddy kernel: hub.c: new USB device 00:07.2-1.3,
assigned address 4
Dec 29 19:39:44 SillyPuddy kernel: usb.c: USB device 4 (vend/prod
0x582/0x33) is not claimed by any active driver.
Dec 29 19:39:47 SillyPuddy /etc/hotplug/usb.agent: Setup snd-usb-audio
for USB product 582/33/100
Dec 29 19:39:47 SillyPuddy kernel: usb.c: registered new driver
snd-usb-audio
Dec 29 19:39:47 SillyPuddy kernel: snd-usb-midi: created 2 output and 3
input ports
Dec 29 19:39:47 SillyPuddy kernel: usb-uhci.c: uhci_submit_urb: pipesize
for pipe 40008480 is zero
Dec 29 19:39:47 SillyPuddy kernel: snd-usb-midi: usb_submit_urb: -90


The last 2 log lines I believe are significant. Looking at the code I
found that the usb_maxpacket macro is returning 0 for the input endpoint
for the PCR USB device which causes uhci_submit_urb to fail (-90 =
EMSGSIZE which probably isn't really the right code, EINVAL maybe). I
couldn't figure out if this size was set by ALSA or supplied by the
device info or something, and since its a bit over my head, I decided to
post this here. I hope someone has a better idea of whats going on.

Some more info:

/proc/asound/cards:

0 [PCR            ]: USB-Audio - EDIROL PCR
                     Roland EDIROL PCR


cat /proc/asound/PCR/midi0:

Roland EDIROL PCR

Output 0
  Tx bytes     : 0
Output 1
  Tx bytes     : 0
Input 0
  Rx bytes     : 0
Input 1
  Rx bytes     : 0
Input 2
  Rx bytes     : 0

I've also attached lsusb -v output. Cheers.
	Josh Green

--=-UxwlV6Qi50QvkhfVFKa9
Content-Disposition: attachment; filename=lsusb.txt
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=lsusb.txt; charset=ISO-8859-1

Bus 001 Device 001: ID 0000:0000 =20
Bus 001 Device 002: ID 05e3:0604 Genesys Logic, Inc.=20
Bus 001 Device 006: ID 0582:0033 Roland Corp.=20

--=-UxwlV6Qi50QvkhfVFKa9--



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
