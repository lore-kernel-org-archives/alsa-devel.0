From: Joerg Mayer <jmayer@loplof.de>
Subject: Problems with VIA8233A (todays cvs)
Date: Tue, 22 Jul 2003 20:26:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030722182649.GP9899@thot.informatik.uni-kl.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CUfgB8w4ZwR/yMy5"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


--CUfgB8w4ZwR/yMy5
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by uni-kl.de id h6MIQocm017399

Hello,

I'm having trouble with a motherboard that has a via8233 chipset
(msi kt3 Ultra series, MS-6380E v1.X). Sound is sort of working, but
not quite perfect: when using winex, sound effects stutter, sometimes
it "=FCbersteuert" (I don't know the English word :) and some not so nice
messages are displayed:

kernel: PCI: Setting latency timer of device 00:11.5 to 64
kernel: ALSA ../alsa-kernel/pci/via82xx.c:687: invalid via82xx_cur_ptr, u=
sing last valid pointer
last message repeated 8 times
modprobe: modprobe: Can't locate module sound-slot-1
modprobe: modprobe: Can't locate module sound-service-1-3
modprobe: modprobe: Can't locate module sound-slot-2
modprobe: modprobe: Can't locate module sound-service-2-3
modprobe: modprobe: Can't locate module sound-slot-3
modprobe: modprobe: Can't locate module sound-service-3-3
modprobe: modprobe: Can't locate module sound-slot-1
modprobe: modprobe: Can't locate module sound-service-1-3
modprobe: modprobe: Can't locate module sound-slot-2
modprobe: modprobe: Can't locate module sound-service-2-3
modprobe: modprobe: Can't locate module sound-slot-3
modprobe: modprobe: Can't locate module sound-service-3-3
kernel: ALSA ../alsa-kernel/pci/via82xx.c:687: invalid via82xx_cur_ptr, u=
sing last valid pointer
last message repeated 205 times
kernel: ALSA ../../../alsa-kernel/core/seq/oss/seq_oss_init.c:213: no dev=
ice found
kernel: ALSA ../alsa-kernel/core/memory.c:71: Not freed snd_alloc_kmalloc=
 =3D 820
kernel: ALSA ../alsa-kernel/core/memory.c:81: kmalloc(820) from d40f8827 =
not freed

This is with SuSE 8.2 with all patches applied (including k_deflt-2.4.20-=
96).
All alsa-rpms were removed (with --nodeps where necessary), and alsa buil=
t
from cvs (updated after 18:00 MEST today).

Some more stuff (e.g. contents of /proc/interesting-stuff) is attached
to this mail.

Ideas how to fix the sound problems?

Thanks
    J=F6rg
--=20
Joerg Mayer                                           <jmayer@loplof.de>
We are stuck with technology when what we really want is just stuff that
works. Some say that should read Microsoft instead of technology.

--CUfgB8w4ZwR/yMy5
Content-Type: application/x-bunzip2
Content-Disposition: attachment; filename="alsa-murx.tar.bz2"
Content-Transfer-Encoding: base64

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
KEhKvt/aAA==

--CUfgB8w4ZwR/yMy5--


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
