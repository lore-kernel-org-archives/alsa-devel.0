From: Falko Schmidt <kaethorn@stud.uni-stuttgart.de>
Subject: trouble on ppc32?
Date: Tue, 21 Feb 2006 00:12:40 +0100
Message-ID: <20060220231240.GB6186@celes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

Hello,

I'm using a 32bit PowerPC based RS/6000 (43p-140) trying to get at least
one sound card to work. All other 'machine-independent' drivers for
cards such as NICs and disk controllers work fine.

I tried four different sound cards on kernels 2.6.8 and 2.6.15 which
work fine on x86 and non-x86 machines (using the same kernel versions).

Are there known issues regarding ALSA drivers on ppc? Or might it be
faulty hardware on the system side?

I'd like to fix some of the drivers but I doubt that it's a driver
specific problem looking at the number of different cards used.

Any ideas are welcome.

Thanks a lot in advance,

Falko

-------------
Soundblaster 16 PnP (ISA):
-------------

pnp: Device 00:01.00 activated.
pnp: Device 00:01.00 disabled.
ALSA /usr/src/modules/alsa-driver/alsa-kernel/isa/sb/sb16.c:653: Sound Blaster 16 soundcard not found or device busy
ALSA /usr/src/modules/alsa-driver/alsa-kernel/isa/sb/sb16.c:657: In case, if you have AWE card, try snd-sbawe module
pnp: Device 00:01.00 activated.
pnp: Device 00:01.00 disabled.
ALSA /usr/src/modules/alsa-driver/alsa-kernel/isa/sb/sb16.c:653: Sound Blaster 16 soundcard not found or device busy
ALSA /usr/src/modules/alsa-driver/alsa-kernel/isa/sb/sb16.c:657: In case, if you have AWE card, try snd-sbawe module

-------------
Terratec DMX Xfire 1024 (PCI):
-------------

Feb 20 14:39:21 cyan kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/c
s46xx/cs46xx_lib.c:427: cs46xx: failure waiting for FIFO command to complete
Feb 20 14:43:20 cyan kernel: ALSA /usr/src/modules/alsa-driver/alsa-kernel/pci/c
s46xx/cs46xx_lib.c:427: cs46xx: failure waiting for FIFO command to complete

-------------
Soundblaster Live 512 (PCI):
-------------

Feb 20 21:54:43 cyan kernel: PCI: Enabling device 0000:01:03.0 (0104 -> 0105)
Feb 20 21:54:43 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba3f000)!!
Feb 20 21:54:59 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
Feb 20 21:54:59 cyan kernel: emu: failure page = 0
Feb 20 21:54:59 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
Feb 20 21:54:59 cyan kernel: emu: failure page = 0
Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
Feb 20 21:55:13 cyan kernel: emu: failure page = 0
Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8ba21000)!!
Feb 20 21:55:13 cyan kernel: emu: failure page = 0
Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8baa1000)!!
Feb 20 21:55:13 cyan kernel: emu: failure page = 0
Feb 20 21:55:13 cyan kernel: max memory size is 0x7fffffff (addr = 0x8baa1000)!!
Feb 20 21:55:13 cyan kernel: emu: failure page = 0

-------------
S3 Sonic Vibes (PCI):
-------------

Feb 20 18:34:48 cyan kernel: PCI: Enabling device 0000:01:03.0 (0004 -> 0005)
Feb 20 18:34:48 cyan kernel: BIOS did not allocate DDMA channel A i/o, allocated
 at 0x7a00
Feb 20 18:34:48 cyan kernel: BIOS did not allocate DDMA channel C i/o, allocated
  at 0x7a10


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
