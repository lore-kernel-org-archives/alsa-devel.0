From: Paul Davis <pbd@Op.Net>
Subject: Re: latency timer
Date: Tue, 26 Feb 2002 18:18:54 -0500
Message-ID: <200202262319.SAA08267@renoir.op.net>
In-reply-to: Your message of "Wed, 27 Feb 2002 00:01:42 +0100."
             <000d01c1bf19$96361960$0300a8c0@wgilmenau>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Br ckmann <robert.brueckmann@stud.tu-ilmenau.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>if I set the latency timer to 0x30, I am able to stream 48 channels of data
>to a speed-optimized raid system. However this is not the point. The arecord

i would also mention that you may have potential problems doing this
with word-clock synced interfaces. its likely that they will generate
interrupts sufficiently close in time that you could be severely
stressing the full compliance of the PCI interrupt detect/CPU notify
system. basically, each card is going to reach the interrupt point at
almost exactly the same time, and this could cause problems even
though it theoretically should not (the APIC should buffer the 2nd
interrupt while the first is processed).

i would be very suprised if even RME have tried this experiment: I
don't think ASIO has any way to link two physical devices together in
the way that ALSA permits. i may be wrong about that.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
