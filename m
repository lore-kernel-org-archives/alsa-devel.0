From: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Subject: Intel8x0 still broken in 2.6.9-ac16
Date: Thu, 16 Dec 2004 23:54:07 +0100
Message-ID: <ae4c715704121614542739c909@mail.gmail.com>
Reply-To: =?ISO-8859-1?Q?David_G=F3mez?= <dabisu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

Hi,

I downloaded ac16 because i saw that a fix from Takashi was included
in previous ac12 patch. In summary: sound is still broken in
2.6.9-ac16 for the snd_intel8x0 alsa driver, but it's working in
2.6.8.

Errors it get,

When playing mp3 file:

codec_read 0: semaphore is not ready for register 0x2c
codec_read 0: semaphore is not ready for register 0x2c
codec_read 0: semaphore is not ready for register 0x2c
...

When changing mixer settings with alsamixer:

codec_write 0: semaphore is not ready for register 0x2
codec_write 0: semaphore is not ready for register 0x2
codec_write 0: semaphore is not ready for register 0x2

Some info about my system:
0000:00:00.0 Host bridge: Intel Corp. 82852/855GM Host Bridge (rev 02)
0000:00:00.1 System peripheral: Intel Corp. 855GM/GME GMCH Memory I/O
Control Registers (rev 02)
0000:00:00.3 System peripheral: Intel Corp. 855GM/GME GMCH
Configuration Process Registers (rev 02)
0000:00:02.0 VGA compatible controller: Intel Corp. 82852/855GM
Integrated Graphics Device (rev 02)
0000:00:02.1 Display controller: Intel Corp. 82852/855GM Integrated
Graphics Device (rev 02)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller (rev=
 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
0000:02:02.0 Ethernet controller: Broadcom Corporation BCM4401
100Base-T (rev 01)
0000:02:04.0 Network controller: Intel Corp. PRO/Wireless 2200BG (rev 05)
0000:02:06.0 CardBus bridge: Texas Instruments: Unknown device 8031
0000:02:06.2 FireWire (IEEE 1394): Texas Instruments: Unknown device 8032
0000:02:06.3 Unknown mass storage controller: Texas Instruments:
Unknown device 8033



--=20

David G=F3mez


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
