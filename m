From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: RME9632 Precise Pointer option problem (attn
	Thomas Charbonnel)
Date: Mon, 27 Sep 2004 10:07:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1096294072.2173.18.camel@localhost>
References: <4157DB53.2030801@wildgooses.com>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4157DB53.2030801@wildgooses.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 2004-09-27 at 05:20, Ed Wildgoose wrote:
> Hi folks,
> 
> I haven't been able to get in touch with Thomas with this question, but 
> perhaps someone here can help (or perhaps he will see it?)
> 
> With this driver the free space call returns only an approximate value, 
> however, the "precise pointer" module option returns apparently garbage 
> (and there are notes in the source to say this).  Looking at the code 
> it's just returning the value from a register, so it's hard to see that 
> the driver is doing anything bad.

This would not be the first soundcard that needs some conditions to be
met, in order to have a valid value on such kind of register. There
maybe some flags that indicate that the value is correct, or you need to
flag eplicitly that you want to read it. Hopefuly you have the specs, if
not, pass the WDM driver through IDA pro and you probably know what i
mean :). Or maybe a previous I/O operation, register access or whatever
keeps the card busy ? There are many things that could be wrong (check
timing issues).

If it turns out to be a hardware design problem, you could also use the
trustable "not accurate pointer" value to estimate if the "precise
pointer" is on crack or not, and return the most apropriate value. a few
comparison should not represent a considerable amount of overhead, and
you would get a sort of a combination of both "options".

> Does anyone have any insight on whether it's possible to get a good 
> value for free space in the buffers?  From a design point of view is it 
> sensible to add some kind of fixup which counts ticks to estimate free 
> space in the buffers at the driver level, or should stuff like that 
> exist only at userspace level, probably in the app?  I realise that we 
> can't do this perfectly, but it occurs to me that we can probably remain 
> quite accurate estimating the current point location based on counting 
> ticks since we started and noting when we add new data, etc.

Hmm. What about mmap mode ? AFAIK, the idea is that you should not need
to bother about the buffer internals of ALSA. You should just write and
read data. 

Best Regards




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
