From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 10:04:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18H3g4-0000RD-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.33.0211271541100.532-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 27 Nov 2002 15:43:14 +0100."
             <Pine.LNX.4.33.0211271541100.532-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: tomasz motylewski <T.Motylewski@bfad.de>, James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>> actually, it can't. if the user space application is delayed for
>> precisely 1 buffer's worth of data, it will see the pointer at what
>> appears to the the right place and believe that no xrun has
>> occured. the only way around this is to provide either:
>> 
>> 	* h/w pointer position as a steadily incrementing value
>> 	* h/w pointer position *plus* interrupt count
>> 
>> i favor the latter since it provides for a longer time before wrapping
>> becomes an issue (ULONG_MAX interrupts).
>
>The ALSA internal code already uses hw_ptr and appl_ptr within range 0 to
>boundary, where boundary is close to ULONG_MAX and expression boundary / 
>period_size == an integer value. So, the hardware pointer also contains 
>count of hardware interrupts as well.

i know that. my point was that wraparound happens much earlier than if
we used a two part system (pointer-in-buffer + interrupt count). this
would be a similar system to the one used by the RTC, btw. we wouldn't
wrap with a two part system for around 66 days with 64 frames/period
at 48kHz. in the current system we wrap in about 1 day or so.

it doesn't make much difference either way, i was just pointing out a
different way to do it, and more importantly, correcting the claim
that by knowing where the h/w pointer is *in the buffer*, the
application can know if there has been an xrun. the ALSA API h/w
pointer, as you point out, implicitly contains the interrupt count,
but its not as raw as was being requested.

its also worth noting that it too is not immune from missing xruns,
but there isn't anything we can do about kernel/driver code that
blocks interrupts for an entire buffer :(

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
