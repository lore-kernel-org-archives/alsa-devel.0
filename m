From: William <walsac3@orthoset.com>
Subject: VIA 8235: Bad IRQ after PCM playback and moving the mouse
Date: Thu, 18 Nov 2004 19:43:38 GMT
Message-ID: <200411181943.TAA28593@orthoset.com>
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

VIA 8235 sound system on a laptop:

I keep getting bad IRQ errors after PCM playback and moving the mouse.
I tried loading via82xx first with dxs_support=1, then with dxs_support=2,
then dxs_support=4 but the same errors happen.

For example, while playing:
 $ aplay -c 2 -f S16_LE -r 22000 music 2216.raw
if I move the mouse, the kernel gives error messages:

   Nov 18 19:55:18 kernel: ACPI: PCI interrupt 0000:00:11.5[C] -> GSI 9 (level, low) -> IRQ 9
   Nov 18 19:55:19 kernel: usbcore: registered new driver snd-usb-audio
   Nov 18 19:55:34 kernel: spurious 8259A interrupt: IRQ7.
   Nov 18 19:55:47 kernel: irq 11: nobody cared!
   Nov 18 19:55:47 kernel:  __report_bad_irq+0x17/0x7f
   Nov 18 19:55:47 kernel:  note_interrupt+0x5d/0x3c
   Nov 18 19:55:47 kernel:  do_IRQ+0x71/0xe2
   Nov 18 19:55:47 kernel:  common_interrupt+0x18/0x20
   Nov 18 19:55:47 kernel:  default_idle+0x21/0x35
   Nov 18 19:55:47 kernel:  cpu_idle+0x1d/0x22
   Nov 18 19:55:47 kernel:  start_kernel+0x10b/0x13a
   Nov 18 19:55:47 kernel: handlers:
   Nov 18 19:55:47 kernel:  (usb_hcd_irq+0x0/0xed)
   Nov 18 19:55:47 kernel: Disabling IRQ #11

The mouse is now disabled. The pointer can moved only by using the touchpad.

 modprobe.conf has:

   alias char-major-14-* soundcore
   alias char-major-116-* snd
   options snd major=116 cards_limit=1

   alias snd-card-0 snd-via82xx
   options snd-via82xx enable=1 dxs_support=1
   alias snd-card-0 snd-via82xx
   alias sound-slot-0 snd-card-0
   alias sound-service-0-0 snd-mixer-oss
   alias sound-service-0-3 snd-pcm-oss
   alias sound-service-0-12 snd-pcm-oss
   alias /dev/dsp1 snd-pcm-oss

Any suggestions please?

William


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
