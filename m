From: Paul Davis <pbd@Op.Net>
Subject: Re: latency timer
Date: Wed, 27 Feb 2002 09:54:01 -0500
Message-ID: <200202271454.JAA09713@renoir.op.net>
In-reply-to: Your message of "Wed, 27 Feb 2002 08:48:13 +0100."
             <001501c1bf63$23656680$0300a8c0@wgilmenau>
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

>> i would also mention that you may have potential problems doing this
>> with word-clock synced interfaces. its likely that they will generate
>> interrupts sufficiently close in time that you could be severely
>> stressing the full compliance of the PCI interrupt detect/CPU notify
>> system. basically, each card is going to reach the interrupt point at
>> almost exactly the same time, and this could cause problems even
>> though it theoretically should not (the APIC should buffer the 2nd
>> interrupt while the first is processed).
>> 
>> i would be very suprised if even RME have tried this experiment: I
>> don't think ASIO has any way to link two physical devices together in
>> the way that ALSA permits. i may be wrong about that.
>
>So do you mean there is another way of synchronizing the cards?

no. what i meant was that running two cards in sync might cause
problems like this. it would depend on the quality of the APIC
implementation and it might also depend on the kernel. maybe even the
drivers, i'm not sure. 

whatever mechanism is used to sync them, if they truly are in sync
they will be generating interrupts at almost precisely the same moment
in time, all the time.

i would check with RME that they have actually attempted to use
multiple synchronized cards in a Windows or MacOS system before
beating yourself (and myself :) up too much over this.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
