From: tomasz motylewski <T.Motylewski@bfad.de>
Subject: Re: smix plugin available?
Date: Wed, 27 Nov 2002 16:47:46 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0211271625190.2146-100000@mailserver.intern.bfad.de>
References: <200211271350.OAA22613@mail.bodensee.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200211271350.OAA22613@mail.bodensee.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Jaroslav Kysela <perex@suse.cz>, James Courtier-Dutton <James@superbug.demon.co.uk>, Florian Bomers <Florian.Bomers@sun.com>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 27 Nov 2002, Paul Davis wrote:

> >Please stop the complication of "available/delay" etc. Just the raw
> >pointer.  Each application knows where its application pointer is, so
> >it can easily calculate delay/available and decide for itself whether
> >there was an overrun or not.
> 
> actually, it can't. if the user space application is delayed for
> precisely 1 buffer's worth of data, it will see the pointer at what
> appears to the the right place and believe that no xrun has
> occured. the only way around this is to provide either:

Well, but if you combine it with the current time information, then you will
know whether the buffer has wrapped around or not - if you have 1000 ms of
buffer, but always run 20 ms from the front, then if you notice 1010 ms has
passed since the last action - then you have an overrun, even if the HW pointer
seems to be in the right place. So, configuration + mmaped buffer + gettimeoday
+ HW pointer and I am happy. And may be system call "mix data into buffer
(start, n_frames,data)" for atomic add. This provides minimum interference
between programs (if they will agree on frame rate, format, etc.).

> for the record, i've used this approach (inspired by someone from
> poland whose name i forget) with an ISA card (no PCI burst size
> issues) to achieve <10 sample processing latency. i scribbled a
> special bit pattern into the hardware buffer, then looped over it
> watching to see where the audio interface was and writing/reading data
> directly ahead of it or behind it. it works, but of course it burns
> CPU cycles like crazy (there is no wait for the device or anything
> else, its just a continuous while loop).

Well, I use that method for reading data - I know how much samples I need
to gather before I send them, so I may calculate how many ms to sleep. If I
read few samples too much, I will just sleep less next time. Jitter about 300
microseconds in RTP data stream which I send, and quite CPU efficient.

But how did you do for writing data to the card? Are your read and write buffer
HW synchronized?


> this isn't a function of callbacks. its a function of the response of
> the callback system to the delay. if the system notices that its
> running late but goes ahead and executes anyway, the results are just
> the same as you suggest for your approach. however, since there is

well, no. Lets say I have got "write callback" in time and I should give some
data to the card. But I do not have it - it may arrive in 1 ms, but then I can
only through it away, because I will get next "write callback" in 9 ms from
then.

I like callbacks for "read" direction.

Best regards,
--
Tomasz Motylewski



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
