From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: Re: SoundScape driver... FIXMEs
Date: Mon, 23 Sep 2002 13:28:56 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020923122856.24522.qmail@web40606.mail.yahoo.com>
References: <s5hd6r5otz1.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6r5otz1.wl@alsa2.suse.de>
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

 --- Takashi Iwai <tiwai@suse.de> wrote: > At Sun, 22
Sep 2002 20:09:52 +0100 (BST),
> i don't think so.  more modulalization doesn't mean
> to remove the
> ability of built-in drivers.  (and i heard that
> Linus still prefers
> built-in drivers to modules :)

I definitely hadn't heard that! I thought Linus's
preferred mode of use was to load all necessary
modules up front at boot-time and then leave them
loaded (i.e. not using kmod). IMHO, monolithic kernels
are just a PITA.

> i don't see any particular part that restricts to
> module (except that
> the driver needs firmware to be loaded via ioctl).
> am i missing something?

Only that it's OBSCENELY more difficult to develop a
driver if you compile it into the kernel every time...
Unless you ENJOY rebooting your machine, of course. 

> > - I was not aware that "verify_area()" had been
> > deprecated.

> verify_area() is simply not necessary
> if you use copy_from/to_user().

Aha, but that's not the same as "deprecated" at all
;-).

I only do one big "verify_area()" up front to simplify
the DMA-uploading loop. This way, I know before I even
begin that *entire* address range is valid, and so I
don't need to worry about __copy_from_user() being
passed an invalid address.

There is only one verify_area() call, but several
__copy_from_user() calls because the firmware is 64K
long, but I upload it in contiguous chunks.

> generally it's recommended to check the return value
> from
> copy_from/to_user() at each call and to return
> -EFAULT, because it can be faster.

Note that copy_from_user() effectively calls
verify_area() and so may return -EFAULT. However, I
call __copy_from_user() instead, having already
checked the entire address range. In other words, I
perform 1 call to verify_area() and N calls to
__copy_from_user(), rather than the equivalent of N
calls to verify_area() and N calls to
__copy_from_user(). Also, I don't need to keep on
checking for -EFAULT
 inside the loop.

> another point:  doesn't the busy-loop in
> host_read/write_ctrl_unsafe
> need udelay() or something to produce a certain
> delay length?
> otherwise the timeout is very dependent on a
> machine.

Yes, possibly. Provided udelay() isn't deprecated and
doesn't schedule or anything. I tested this driver on
a P120 - not exactly a speed daemon... ;-)!

Cheers,
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
