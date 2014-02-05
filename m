From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] MIDI driver for Behringer BCD2000 USB
	device
Date: Wed, 05 Feb 2014 16:49:20 +0100
Message-ID: <52F25D80.4060904@zonque.org>
References: <1391284482-7577-1-git-send-email-dev@kicherer.org>
 <52F2184D.9060209@zonque.org> <52F259D0.9070705@kicherer.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 23746265025
 for <alsa-devel@alsa-project.org>; Wed,  5 Feb 2014 16:49:22 +0100 (CET)
In-Reply-To: <52F259D0.9070705@kicherer.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mario Kicherer <dev@kicherer.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/05/2014 04:33 PM, Mario Kicherer wrote:
> 
> Hi Daniel,
> 
> thank you very much for your comments! I hope I fixed most of the
> points but I also have a few questions/comments:
> 
> On 05.02.2014 11:54, Daniel Mack wrote:
>>> +#ifdef CONFIG_USB_DEBUG
>>> +#define DEBUG	1
>>> +#else
>>> +#define DEBUG	0
>>> +#endif
>>
>> Please use the define directly instead of introducing a new one.
> 
> I replaced it with:
> 
> #ifndef CONFIG_USB_DEBUG
> #define CONFIG_USB_DEBUG 0
> #endif

No, don't fiddle with CONFIG_* symbols. What I mean is: use the CONFIG_
macro in your code instead if 'DEBUG'. And also, maybe use
CONFIG_SND_DEBUG instead.

> As it can be undefined. I hope that's okay.

Ah, so I'd recommend you move code that depends on this define into a
separate function, and stub it out with a no-op if it's not defined.
Something like this:

#ifdef CONFIG_SND_DEBUG
static void foo_dump()
{
	...
}
#else
static inline void foo_dump() {}
#endif

...
{
	...
	foo_dump();
	...
}

It makes to code more readable if there are less #ifdef.

>> Your patch has a huge number of style issues, which
>> scripts/checkpatch.pl will point you to. I got:
> 
> Interesting, I copied many issues from other modules. :)

You're welcome to send patches to fix them :)
A general rule is: "Do as we say, not as we do".

> If fixed most of them except these:
> 
> WARNING: quoted string split across lines
> #310: FILE: sound/usb/bcd2000/bcd2000.c:254:
> +                       "bcd2000_midi_send(%p): usb_submit_urb() failed"
> +                       "ret=%d, len=%d\n", substream, ret, len);
> 
> WARNING: quoted string split across lines
> #392: FILE: sound/usb/bcd2000/bcd2000.c:336:
> +                               "bcd2000_init_device: usb_submit_urb() 
> failed,"
> +                               "ret=%d: ", ret);
> 
> I don't know how to avoid them, as all strings in one line would be
> longer than 80 characters.

Yep, I'd say that's okay. I'd prefer non-split string over the 80-char
rule. However, consider using __func__ rather than the manual function
name copy; that might solve your problem as well.

>>> +		/* determine the number of bytes we want to copy this time */
>>> +		tocopy = min( 3 - bcd2k->midi_cmd_offset, length - (buf_offset - 1));
>>> +		
>>> +		if (tocopy > 0) {
>>
>> tocopy is unsigned char, so this check is always true, and the copy
>> routine can overflow in case bcd2k->midi_cmd_offset < 3.
> 
> I don't understand your point here. It could be zero.

Yes, I'm sorry. I was looking at the '< 0' condition that can occur if
'bcd2k->midi_cmd_offset < 3'.

> But I changed it
> to a condition that checks if both offsets are within the length of the
> two involved buffers.

Great. Please also double-check whether a maliciously behaving device
could cause any harm to your buffer logic. It's easy to hack a simple
microcontroller to match the driver and then through random stuff at
your routines. Your code must be able to cope with everything it is fed to.

>> Please, no dead code. Remove those lines entirely if you don't need them.
> 
> Ah okay, I planned to reactive them with the audio part. But I removed
> them for now.
> 
> As far as I understood, I should repost the new patch as [PATCH v2].

Correct.

> I
> will check this evening if the device still works and send it to the
> list afterwards.


Thanks,
Daniel
