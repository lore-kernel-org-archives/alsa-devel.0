From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: smix plugin available?
Date: Thu, 28 Nov 2002 08:50:49 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18HP0O-00024U-00@sc8-sf-list1.sourceforge.net>
References: <Pine.LNX.4.21.0211271625190.2146-100000@mailserver.intern.bfad.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 27 Nov 2002 16:47:46 +0100."
             <Pine.LNX.4.21.0211271625190.2146-100000@mailserver.intern.bfad.de>
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

>> actually, it can't. if the user space application is delayed for
>> precisely 1 buffer's worth of data, it will see the pointer at what
>> appears to the the right place and believe that no xrun has
>> occured. the only way around this is to provide either:
>
>Well, but if you combine it with the current time information, then
>you will know whether the buffer has wrapped around or not - if you
>have 1000 ms of buffer, but always run 20 ms from the front, then if
>you notice 1010 ms has passed since the last action - then you have
>an overrun, even if the HW pointe r seems to be in the right
>place. So, configuration + mmaped buffer + gettimeoda y + HW pointer
>and I am happy. 

you should trying playing with a system driven by varispeed word
clock. you'll soon find that gettimeofday(2) is completely useless to
you. the sample clock is the only clock that counts. say it twice
every morning when you get up :)

>		 And may be system call "mix data into buffer (start,
>n_frames,data)" for atomic add. This provides minimum interference
>between programs (if they will agree on frame rate, format, etc.).

that is quite a big "if". still, the plughw layer can help with that i
suppose. 

>Well, I use that method for reading data - I know how much samples I need
>to gather before I send them, so I may calculate how many ms to sleep. If I

if you have a kernel that will reliably sleep for 1ms, i envy you :)

>But how did you do for writing data to the card? Are your read and
>write buffer HW synchronized?

i used the same technique as for reading. the buffer gets scribbled
with a bit pattern and we look for the "leading edge" location with
two bytes containing the special pattern. this minimizes the problems
caused by actual sample values that match that pattern. the chances of
two in a row doing so are so small as to be mostly ignorable.

but note: this technique doesn't work so well for PCI cards because of
the bus transfer block size.

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
