From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 08:53:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18H2Zy-0006Ck-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 27 Nov 2002 12:36:31 +0100."
             <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: Jaroslav Kysela <perex@suse.cz>, James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>This is my personal preference. In this model the only service ALSA has to
>supply are:
>
>1. initial configuration/start/stop.
>2. mmapable DMA buffer
>3. fact and precise ioctl telling the current HW pointer in the buffer. If the
>card is not queried each time, then the "last period interrupt" timestamp
>should be included.

ALSA supplies all 3 of these. You can use them by themselves without
the rest of the API if you want. The only problem arises with hardware
that cannot give you accurate h/w pointer positions.

>Please stop the complication of "available/delay" etc. Just the raw
>pointer.  Each application knows where its application pointer is, so
>it can easily calculate delay/available and decide for itself whether
>there was an overrun or not.

actually, it can't. if the user space application is delayed for
precisely 1 buffer's worth of data, it will see the pointer at what
appears to the the right place and believe that no xrun has
occured. the only way around this is to provide either:

	* h/w pointer position as a steadily incrementing value
	* h/w pointer position *plus* interrupt count

i favor the latter since it provides for a longer time before wrapping
becomes an issue (ULONG_MAX interrupts).

>Each application/thread should not just copy the data to DMA buffer, but _add_
>to it - in this way we get very efficient mixing (zero copy). Of course here I
>assume that "add" operations on volatile buffers are atomic vs. context
>switches - probably not on all architectures - we may need mutexes.

they are not atomic on any architecture that i know of.

>I was able to achieve about 20 ms delay (analog-to-analog) when
>transmitting 10 ms RTP packets of data over the LAN with no
>overruns! OK, I have used HZ=2000 and low latency patches+soft RT.

for the record, i've used this approach (inspired by someone from
poland whose name i forget) with an ISA card (no PCI burst size
issues) to achieve <10 sample processing latency. i scribbled a
special bit pattern into the hardware buffer, then looped over it
watching to see where the audio interface was and writing/reading data
directly ahead of it or behind it. it works, but of course it burns
CPU cycles like crazy (there is no wait for the device or anything
else, its just a continuous while loop).

>Callbacks are not the most efficient there. If the data arrives 1 ms
>too late I would loose the whole 10 ms period. If I still add it to
>the buffer, I will loose only 1 ms and the card will play the
>remaining 9 ms of sound.

this isn't a function of callbacks. its a function of the response of
the callback system to the delay. if the system notices that its
running late but goes ahead and executes anyway, the results are just
the same as you suggest for your approach. however, since there is
still a glitch in the audio stream (1ms of data is repeated/lost), a
system like JACK considers this an error.

--p



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
