From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 12:36:31 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0211271149000.2146-100000@mailserver.intern.bfad.de>
References: <Pine.LNX.4.33.0211270949140.532-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211270949140.532-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: James Courtier-Dutton <James@superbug.demon.co.uk>, Paul Davis <paul@linuxaudiosystems.com>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Jaroslav Kysela wrote:

> In my brain, there is also totaly different solution with the zero context 
> switching overhead - sharing the soundcard DMA buffer among more 
> applications. There is only one problem: snd_pcm_rewind() implementation 

This is my personal preference. In this model the only service ALSA has to
supply are:

1. initial configuration/start/stop.
2. mmapable DMA buffer
3. fact and precise ioctl telling the current HW pointer in the buffer. If the
card is not queried each time, then the "last period interrupt" timestamp
should be included.

Please stop the complication of "available/delay" etc. Just the raw pointer.
Each application knows where its application pointer is, so it can easily
calculate delay/available and decide for itself whether there was an overrun or
not.

The driver does not care at all whether applications are writing to this buffer
or not. There should be one thread (ISR, kernel or separate application) which
zeroes part of the buffer just after the card has played it.

Each application/thread should not just copy the data to DMA buffer, but _add_
to it - in this way we get very efficient mixing (zero copy). Of course here I
assume that "add" operations on volatile buffers are atomic vs. context
switches - probably not on all architectures - we may need mutexes.

ALSA API should also tell the applications how big the "hot zone" is (the area
where the data is first played and then set to 0).

I was able to achieve about 20 ms delay (analog-to-analog) when transmitting 10
ms RTP packets of data over the LAN with no overruns! OK, I have used HZ=2000
and low latency patches+soft RT.

I am mixing several RTP  streams in this way, when 1 packet does not
arrive, the data from the other streams are there and I resynchronize just this
single stream. But the only buffering I do is in the DMA buffer of the card!
Each RTP source has its own "application ptr" and the data are added to the
buffer as they come.

Callbacks are not the most efficient there. If the data arrives 1 ms too late I
would loose the whole 10 ms period. If I still add it to the buffer, I will
loose only 1 ms and the card will play the remaining 9 ms of sound.

You will probably consider my method "ugly", "full of race conditions" etc. But
it gives mimimum sound latency.

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
