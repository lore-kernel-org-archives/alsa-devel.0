From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: novation remote 25 usb midi controller
Date: Wed, 30 Jul 2003 22:33:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F288002.214F08C9@zhevny.com>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa user <alsa-user@lists.sourceforge.net>, linux-audio-user <linux-audio-user@music.columbia.edu>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I have not been successful in getting this keyboard recognized on the
usb bus, let alone by the usb-audio driver. I'm going to see if I can
get it working via straight midi into my ymfpci-based guillemot
maxisound fortissimo. But, can anyone see anything else I can try? I've
tried to gather as much info as I could think of...maybe I'm just not
understanding something basic ... Please help.


My system is debian testing (sarge) with kernel 2.4.19 with preempt and
lowlatency patches and the following usb options turned on:

CONFIG_USB=m
CONFIG_USB_DEVICEFS=y
CONFIG_USB_UHCI_ALT=m
CONFIG_USB_AUDIO=m

lsusb returns nothing and there is nothing in /proc/bus/usb/devices (
which I
guess says the same thing. ) 

I compiled and installed alsa-0.9.6 drivers, libs, utils and
envy24control.
the drivers were configured like this:

./configure --with-cards=ice1712,usb-audio --with-sequencer=yes
--with-oss=no

I have the following in modules.conf:

#sound specific modules

alias char-major-116 snd
alias snd-card-0 snd-ice1712
alias snd-card-1 snd-usb-audio


lsmod looks like this:

Module                  Size  Used by    Not tainted
input                   3296   0  (autoclean)
snd-seq                35088   0  (autoclean)
snd-usb-audio          36992   0  (unused)
usbcore                55968   0  [snd-usb-audio]
snd-ice1712            35656   0 
snd-pcm                54528   0  [snd-usb-audio snd-ice1712]
snd-page-alloc          5392   0  [snd-pcm]
snd-timer              13284   0  [snd-seq snd-pcm]
snd-ac97-codec         34008   0  [snd-ice1712]
snd-mpu401-uart         3088   0  [snd-ice1712]
snd-rawmidi            11616   0  [snd-usb-audio snd-mpu401-uart]
snd-seq-device          3652   0  [snd-seq snd-rawmidi]
snd-ice17xx-ak4xxx      1344   0  [snd-ice1712]
snd-cs8427              5188   0  [snd-ice1712]
snd-ak4xxx-adda         3372   0  [snd-ice1712 snd-ice17xx-ak4xxx]
snd-i2c                 2092   0  [snd-ice1712 snd-cs8427]
snd                    23812   0  [snd-seq snd-usb-audio snd-ice1712
snd-pcm snd-timer snd-ac97-codec snd-mpu401-uart snd-rawmidi
snd-seq-device snd-cs8427 snd-ak4xxx-adda snd-i2c]

aconnect -i:

client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '

acconnect -o:
<nothing>

lspci:
00:00.0 Host bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
(rev 03)
00:01.0 PCI bridge: Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX AGP bridge
(rev 03)
00:07.0 ISA bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
00:07.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01)
00:07.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0a.0 Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S
Audio Controller] (rev 02)
00:0b.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24]
(rev 02)
00:0d.0 Ethernet controller: Accton Technology Corporation SMC2-1211TX
(rev 10)
01:00.0 VGA compatible controller: 3Dfx Interactive, Inc. Voodoo 3 (rev
01)

This box is a PII 400 on a AOpen AX6-BC motherboard.

-Eric Rz.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
