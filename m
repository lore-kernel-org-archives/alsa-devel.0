From: William <walsac3@orthoset.com>
Subject: Bad IRQs from using pcm in alsa-driver-1.0.7
Date: Fri, 19 Nov 2004 16:28:47 GMT
Message-ID: <200411191628.QAA01370@orthoset.com>
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

Using ALSA PCM always disables the IRQ for my mouse (USB Logitech wheelmouse).
Is this a known problem?  

I'm using alsa-*1.0.7 on a laptop with a VIA-8235 sound system.
Whenever I use aplay, the kernel disables IRQ 11 ("kernel: Disabling IRQ 11")
leaving the mouse disabled though the touchpad does still work
and there are kernel error messages ("nobody cared!  __report_bad_irq etc" ).

   $ grep ERR /proc/interrupts
   ERR:     33

Every time this happens I have to reboot to get IRQ 11 working again
so I can use the mouse again.
The kernel does not disable IRQ 11 if I use only ALSA MIDI.

Is there a fix?

Thanks,

William



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
