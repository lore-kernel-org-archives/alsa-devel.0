From: David Parker <david@neongoat.com>
Subject: Re: Trident problems.
Date: Thu, 28 Aug 2003 00:57:41 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030828005741.162b0565.david@neongoat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

A long time ago (many months... sorry I don't know exactly when), my Trident
card stopped working with ALSA on a Debian unstable box. It still works with
the kernel OSS module, but ALSA has problems with the AC'97 codec. Here's what
I tried and the resulting log messages/output:

hypnotic:/home/dap# modprobe snd-trident
ALSA ../../alsa-kernel/pci/trident/trident_main.c:3394: AC'97 codec ready error
Trident 4DWave PCI soundcard not found or device busy
devfs_register(unknown): could not append to parent, err: -17
ALSA ../../alsa-kernel/pci/ac97/ac97_codec.c:2096: AC'97 0:0 does not respond - RESET
Trident 4DWave PCI soundcard not found or device busy

hypnotic:/home/dap# modprobe trident
Trident 4DWave/SiS 7018/ALi 5451,Tvia CyberPro 5050 PCI Audio, version 0.14.10h, 18:35:01 Jul 19 2003
trident: Trident 4DWave DX found at IO 0x1400, IRQ 19
ac97_codec: AC97  codec, id: ""D68 (Unknown)

hypnotic:/home/dap# uname -a
Linux hypnotic 2.4.22-pre7 #1 SMP Sat Jul 19 18:29:55 PDT 2003 i686 GNU/Linux

hypnotic:/proc/asound# cat version 
Advanced Linux Sound Architecture Driver Version 0.9.4.
Compiled on Jul 19 2003 for kernel 2.4.22-pre7 (SMP) with versioned symbols.

hypnotic:/home/dap# lspci -n -v -s 00:0b.0
00:0b.0 Class 0401: 1023:2000 (rev 02)
        Subsystem: 1023:2000
        Flags: bus master, medium devsel, latency 64, IRQ 19
        I/O ports at 1400 [size=256]
        Memory at e8002000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [48] Power Management version 1

I saw someone else had this same problem on the alsa-devel list a while ago
(http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg06500.html)
but it doesn't look like it was ever resolved. Is there something I need to
tweak, or is this a valid bug? If it would help to test specific old versions
of ALSA I could do that too.

Thanks,
David

-------
David Parker <david@neongoat.com>
Neon Goat Productions
http://www.neongoat.com
0xF90FFFE5 / F362 51F7 6D51 85EB AF68 75B9 D29B 1AFC F90F FFE5
-------



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
