From: Kristof vansant <de_lupus@pandora.be>
Subject: When I use xmms with OSS plugin sound is normal with the ALSA
 plugin sound skips sometimes
Date: Wed, 11 Feb 2004 18:42:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076521331.2782.5.camel@D5E03F95.kabel.telenet.be>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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



When I use xmms with OSS plugin sound is normal but with the ALSA plugin
sound skips sometimes.

Is this a xmms problem? Or makes OSS emulation the sound stable?

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/
A/8235 AC97 Audio Controller (rev 60)

0-0/0: C-Media Electronics CMI9739

modprobe.conf:

alias eth0 ne2k-pci
alias eth1 b44
alias sound-slot-0 snd-via82xx
install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null
2>&1 || :
remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null
2>&1 || :
alias char-major-81 bttv
alias usb-controller ehci-hcd
alias usb-controller1 uhci-hcd

alsa-driver-1.2c
kernel-2.6.1




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
