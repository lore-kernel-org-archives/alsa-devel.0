From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: difference between OSS mmap and alsa mmap? [alsa-oss]
Date: Mon, 05 Jul 2004 09:13:46 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200407051313.i65DDlH7023180@localhost.localdomain>
References: <20040705144251.6a286c94@mango.fruits.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 05 Jul 2004 14:42:51 +0200."
             <20040705144251.6a286c94@mango.fruits.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>the last thing i can see not working correctly in alsa-oss is the mmap emulati
>on [may closed source apps use OSS with mmap emu]. jcdutton told me on irc tha
>t this is due to the differences in OSS mmaping and ALSA mmaping and it might 
>not be possible to resolve these issues..

i don't think its possible. the OSS mmap API provides raw ptr access
to the DMA area of the h/w. you cannot intercede when an app just uses
pointer indirection and advance to read/write data. ALSA's API does
the same, of course, but access is bounded by two calls that allow
correct handling for devices where the DMA area is a bit more complex
than the OSS model allows for (e.g. 2 devices, or a device that can't
support mmap in hardware, or a dmix device, or ...)

--p


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
