From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Experimental USB audio support
Date: Thu, 30 May 2002 14:15:55 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF5B58B.59E5A233@boosthardware.com>
References: <s5hy9e2hk02.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

As you can tell I'm very excited about this.

Here's some preliminary stuff.

#dmesg
----
usb.c: registered new driver audio
hub.c: USB new device connect on bus1/1, assigned device number 3
ALSA usbaudio.c:1134: 3:1:1 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1134: 3:2:1 : AS_GENERAL descriptor not found
devfs: devfs_register(): device already registered: "unknown"
ALSA usbaudio.c:1191: 3:4:1 : frame size 3 doesn't match ALSA 24bit
sample format
ALSA usbaudio.c:1134: 3:4:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1191: 3:4:3 : frame size 3 doesn't match ALSA 24bit
sample format
ALSA usbaudio.c:1191: 3:5:1 : frame size 3 doesn't match ALSA 24bit
sample format
ALSA usbaudio.c:1134: 3:5:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1191: 3:5:3 : frame size 3 doesn't match ALSA 24bit
sample format
devfs: devfs_register(): device already registered: "unknown"
ALSA usbaudio.c:1191: 3:7:1 : frame size 3 doesn't match ALSA 24bit
sample format
ALSA usbaudio.c:1134: 3:7:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1191: 3:7:3 : frame size 3 doesn't match ALSA 24bit
sample format
ALSA usbaudio.c:1191: 3:8:1 : frame size 3 doesn't match ALSA 24bit
sample format
ALSA usbaudio.c:1134: 3:8:2 : AS_GENERAL descriptor not found
ALSA usbaudio.c:1191: 3:8:3 : frame size 3 doesn't match ALSA 24bit
sample format
devfs: devfs_register(): device already registered: "unknown"
----
 more /proc/asound/cards 
0 [card0          ]: CMI8738 - C-Media PCI CMI8738
                     C-Media PCI CMI8738 (model 37) at 0xa400, irq 5
1 [card1          ]: ICH - Intel 82801BA-ICH2
                     Intel 82801BA-ICH2 at 0xdc00, irq 3
2 [card2          ]: USB-Audio - USB Audio Driver
                     M Audio USB AudioSport Quattro (tm)
3 [card3          ]: USB-Audio - USB Audio Driver
                     M Audio USB AudioSport Quattro (tm)
4 [card4          ]: USB-Audio - USB Audio Driver
                     M Audio USB AudioSport Quattro (tm)
----
# lsusb -p /proc/asound/card2/ -vv
# lsusb -p /proc/asound/card3/ -vv
# lsusb -p /proc/asound/card4/ -vv
# lsusb -p /proc/asound/card4/ -vv -t
cannot open /proc/asound/card4//devices, No such file or directory (2)
----

I cannot get more out of lsusb than that. I assume it is somethign to do
with the fact the /proc/bus/usb has no entries. I will look into fixing
that unless the device is not supposed to register there.


-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
=======================================================================

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
