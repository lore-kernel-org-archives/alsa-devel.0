From: =?utf-8?q?Ren=C3=A9_Rebe?= <rene@exactcode.de>
Subject: regression in handling VIA onboard sound chip, ALSA, 2.6.13, 2.6.14-rc4
Date: Mon, 17 Oct 2005 10:32:28 +0200
Message-ID: <200510171032.29040.rene@exactcode.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi all,

up to 2.6.12-* the VIA onboard sound chip did always work as expected.=20
Recently (2.6.13.* - I also tested 2.6.14-rc4) I get a timeout reading=20
AC97 registers:

PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 4
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 0000:00:11.5 to 64
via82cxxx: timeout while reading AC97 codec (0xAA0000)
ac97_codec: AC97 Audio codec, id: ADS112 (Analog Devices AD1981)
via82cxxx: board #1 at 0xE000, IRQ 20

And no entry in /proc/asound/cards, there is only one for the Midiman Delta=
=20
1010 also in the system:

0 [M1010          ]: ICE1712 - M Audio Delta 1010
                     M Audio Delta 1010 at 0xb400, irq 19

An the working kernel (2.6.12.5) I get this in dmesg:

PCI: Via IRQ fixup for 0000:00:11.5, from 0 to 6
PCI: Setting latency timer of device 0000:00:11.5 to 64
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]
codec_read: codec 0 is not valid [0xfe0000]

However the device works well, devices entry:

0 [M1010          ]: ICE1712 - M Audio Delta 1010
                     M Audio Delta 1010 at 0xb400, irq 18
1 [V8235          ]: VIA8233 - VIA 8235
                     VIA 8235 with AD1980 at 0xe000, irq 22

Any known regressions or something I could give a try?

Yours,

=2D-=20
Ren=C3=A9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://www.exactcode.de | http://www.t2-project.org
            +49 (0)30  255 897 45


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
