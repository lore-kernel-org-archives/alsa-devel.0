From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: SoundScape driver... FIXMEs
Date: Mon, 23 Sep 2002 20:43:19 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020923194319.55687.qmail@web40607.mail.yahoo.com>
References: <s5h7khcq37e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7khcq37e.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

 --- Takashi Iwai <tiwai@suse.de> wrote: > At Mon, 23
> yes, but it should not be the reason to stop
> compiling the built-in
> driver via ifdef.

Well, it would be more accurate to say that the
"built-in" code wasn't a priority. I was also hoping
that Linux 2.5+ would make the entire problem go
away... ;-).

> why not just put a warning something like "this
> driver is not tested as built-in", if you are not
> sure?

Yeah, I can do that. The difference with the built-in
case is also that the driver is going to have to
wrestle with the ISA-PnP bus, try and grab resources
and probably activate the hardware. Now THAT could get
ugly. For example, my test box is so short of
resources that there is one only one practical way to
configure it so that every device works. (Some of the
those other devices can reasonably be expected to have
modular drivers, regardless of whether this driver is
compiled into the kernel or not.) This implies that
I'd need a lot of extra kernel options... Ugh.

> > > verify_area() is simply not necessary
> > > if you use copy_from/to_user().
> > 
> > Aha, but that's not the same as "deprecated" at
> all
> > ;-).
>  
> no.  it's still alive even on 2.5 tree.

So that FIXME is incorrect?

> I
> > perform 1 call to verify_area() and N calls to
> > __copy_from_user(), rather than the equivalent of
> N
> > calls to verify_area() and N calls to
> > __copy_from_user(). Also, I don't need to keep on
> > checking for -EFAULT
> >  inside the loop.
> 
> yeah, i know.  that's why i wrote "generally",
> above. 
> i don't think putting these checks into one
> verify_area() improves the
> performance so much.  checking the return value of
> copy_from/to_user()
> is more obvious, i think.

It wasn't really a "performance-thing". The logic was
easier to write with one fewer error to check for. Why
tie myself up in knots making sure I release all
resources along yet *another* error path, when I get
check for that particular error up-front?

> > > another point:  doesn't the busy-loop in
> > > host_read/write_ctrl_unsafe
> > > need udelay() or something to produce a certain
> > > delay length?
> > > otherwise the timeout is very dependent on a
> > > machine.
> > 
> > Yes, possibly. Provided udelay() isn't deprecated
> and
> > doesn't schedule or anything.
> 
> no and no.  it's a simply busy delay for the given
> time length
> with _relatively_ good accuracy (up to 1ms).
> 
> > I tested this driver on
> > a P120 - not exactly a speed daemon... ;-)!
> 
> ah, then the current driver will fail definitely on
> 2GHz P4 ;)

Yeah, if you can find one with an ISA slot free...
;-). Anyway, I'll put that udelay() in then; udelay(1)
will probably be enough. I'll also remove that #error
if there's no OSS emulation, and I don't think any
action is needed for the verify_area() calls.

Chris


__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
