From: Uwe Koziolek <uwe.koziolek@gmx.net>
Subject: no Sound with SiS965L / Realtek ALC655
Date: Thu, 22 Sep 2005 12:22:44 +0200
Message-ID: <433285F4.5060509@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
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

Hello,

I have Prolems with the ALSA-sound:

Sep 22 12:09:54 uk5 kernel: ACPI: PCI Interrupt 0000:00:02.7[C] -> Link
[LNKC] -> GSI 11 (level, low) -> IRQ 11
Sep 22 12:09:55 uk5 kernel: ALSA
/usr/src/alsa-driver-1.0.10rc1/pci/intel8x0.c:2216: codec_ready: codec
is not ready [0x340000]
Sep 22 12:09:55 uk5 kernel: ACPI: PCI interrupt for device 0000:00:02.7
disabled
Sep 22 12:09:55 uk5 kernel: Intel ICH: probe of 0000:00:02.7 failed with
error -5

The board is a Fujitsu-Siemens Board D2030 with SiS761 + SiS965L
(SiS7012) + Realtek ALC655

ALSA-modules from ALSA 1.0.10rc1

Same result with modules  from 19.9.2005 CVS

Any idea ?

regards
Uwe Koziolek


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
