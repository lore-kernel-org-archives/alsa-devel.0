From: "Jan P." <jipekau@yahoo.com>
Subject: mtpav MIDI and MOTU PocketExpress
Date: Thu, 7 Mar 2002 20:39:33 -0800 (PST)
Message-ID: <20020308043933.83976.qmail@web9104.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tweakoz@pacbell.net, alsa-users@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Michael && ALSAList:

I am trying to get your MTPAV drivers to work with my
MOTU PocketExpress on the parallel port. The short of
it is, sending works, but receiving doesn't. I am on
IRQ5. I tried IRQ7 but this causes sporadic hangs. I
understand the drivers were written for the TimePiece,
but if I need to make some changes for the
PocketExpress, no problem... 

so I am testing with:

utils/seq sender 72.0
and 
utils/seq decoder

When I run sender, the B Out port LED on the
PocketExpress lights briefly (some data received!).
/proc/asound/card1/midi0 confirms about 10 bytes
transmitted.. But hooking a MIDI keyboard up, the
Input LEDs light on the PocketExpress, but no bytes
are received (in card1/midi0, or using seq decoder).

I am new to MIDI with ALSA, so perhaps I am doing
something wrong.. 

Interestingly, running: 
aconnect 72.0 72.0, 

causes an immediate hang. 

so;

I uncommented the printk("irqh... line in the IRQ
handler for mtpav.c, and monitored the kernel message
log... the irq handler isnt called at all, even when
im hitting keys on the keyboard. only when i call
aconnect 72.0 72.0, do i get a brief burst of irqs
before the crash.

anyone know what's up with this? i thought the irq
handler is always connected to the parallel port. how
can aconnect influence its behavior, and why am i not
getting any receive bytes? ideas?


thanks,
jan p.


__________________________________________________
Do You Yahoo!?
Try FREE Yahoo! Mail - the world's greatest free email!
http://mail.yahoo.com/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
