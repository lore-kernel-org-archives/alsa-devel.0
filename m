From: Peter Enderborg <pme@ufh.se>
Subject: Trident problems.
Date: Thu, 13 Feb 2003 22:00:45 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E4C077C.A72BF6EF@ufh.se>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

(cvs version 2003-02-13)
 /sbin/modprobe snd-trident
Note: /etc/modules.conf is more recent than
/lib/modules/2.4.19/modules.dep
/lib/modules/2.4.19/kernel/sound/pci/trident/snd-trident.o: init_module:
No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.19/kernel/sound/pci/trident/snd-trident.o: insmod
/lib/modules/2.4.19/kernel/sound/pci/trident/snd-trident.o failed
/lib/modules/2.4.19/kernel/sound/pci/trident/snd-trident.o: insmod
snd-trident failed
[root@pescadero Documentation]#


And dmsg:

ALSA ../../alsa-kernel/pci/trident/trident_main.c:3382: AC'97 codec
ready error [0x0]
Trident 4DWave PCI soundcard not found or device busy

What can make it busy?

>From /proc/pci

 Bus  0, device  11, function  0:
    Multimedia audio controller: Trident Microsystems 4DWave NX (rev 2).

      IRQ 17.
      Master Capable.  Latency=32.  Min Gnt=2.Max Lat=5.
      I/O at 0x9400 [0x94ff].
      Non-prefetchable 32 bit memory at 0xd3000000 [0xd3000fff].

I have not had this card running for a year or so. The machine runs on a
dual PII with SMP kernel.
The other soundcard a SB-PCI128 works fine.





-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
