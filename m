From: Lee Revell <rlrevell@joe-job.com>
Subject: memory leaks?
Date: Sat, 26 Mar 2005 23:14:46 -0500
Message-ID: <1111896886.2408.1.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

I recently started getting these messages every time I relaod my ALSA modules:

usbcore: registered new driver snd-usb-audio
usbcore: deregistering driver snd-usb-audio
ALSA /home/rlrevell/cvs/alsa/alsa-driver/usb/usbmidi.c:178: urb status -108
ALSA /home/rlrevell/cvs/alsa/alsa-driver/usb/usbmidi.c:163: usb_submit_urb: -90
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:71: Not freed snd_alloc_kmalloc = 864
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(164) from e0979806 not freed
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(268) from e09796fe not freed
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(164) from e0979806 not freed
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(268) from e09796fe not freed
PCI: Found IRQ 7 for device 0000:00:0f.0
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:71: Not freed snd_alloc_kmalloc = 432
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(164) from e098a806 not freed
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(268) from e098a6fe not freed
(     ksoftirqd/0-2    |#0): new 48 us maximum-latency wakeup.
PCI: Found IRQ 7 for device 0000:00:0f.0
usb 2-2: USB disconnect, address 3
(          IRQ 12-664  |#0): new 51 us maximum-latency wakeup.
(          IRQ 10-2804 |#0): new 70 us maximum-latency wakeup.
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:71: Not freed snd_alloc_kmalloc = 432
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(164) from e08b4806 not freed
ALSA /home/rlrevell/cvs/alsa/alsa-driver/alsa-kernel/core/memory.c:80: kmalloc(268) from e08b46fe not freed
PCI: Found IRQ 7 for device 0000:00:0f.0
(     ksoftirqd/0-2    |#0): new 85 us maximum-latency wakeup.
(     ksoftirqd/0-2    |#0): new 90 us maximum-latency wakeup.
(          IRQ 11-691  |#0): new 100 us maximum-latency wakeup.

Does this indicate a memory leak in ALSA?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
