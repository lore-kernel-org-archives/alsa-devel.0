From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: control: add .flush operation to
 release blocked operation
Date: Fri, 31 Jul 2015 06:30:07 +0900
Message-ID: <55BA975F.9000504@sakamocchi.jp>
References: <1437825240-11222-1-git-send-email-o-takashi@sakamocchi.jp>
 <1437825240-11222-2-git-send-email-o-takashi@sakamocchi.jp>
 <s5h1tftyjyh.wl-tiwai@suse.de> <55B67B11.3070808@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 7D48526070C
 for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2015 23:30:14 +0200 (CEST)
In-Reply-To: <55B67B11.3070808@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

Hi, Iwai-san, Lars,

Thanks for your replies. And I realize that this idea is wrong.

I wrote somewhat that blocking operations to file descriptors for files
on filesystems, sockets, virtual character devices are released after
closing. But this is completely wrong. I did test wrongly and had
misunderstanding about these behaviour. Please drop this patch from your
memory...

On Jul 28 2015 03:40, Lars-Peter Clausen wrote:
> Is it really a problem? I'd say it's the expected behavior. What close
> does is destroys the mapping between the process local fd and the global
> struct file. It does not abort any pending blocking operations. If you
> want to wakeup a blocking operation you need to send a signal to the
> thread.

Indeed. Usually, blocking operations are not waken up after closing. We
have only a way to do it, sending signals.

>>  One thing I'm not sure is the
>> case where the file descriptor is copied.  Is the flush op called only
>> if one of the multiple processes is closed, or is it after all fps
>> closed?  In the former case, this might be a problem.
> 
> Should be on every close. Especially with close-on-exec this quickly
> becomes a problem.

After dup()/dup2()/dup3(), file descriptors are duplicated but still
refer to the same file structure. This is the same as execve() executed.
These operations are completed within VFS and character device drivers
or file system implementation can do nothing for it.

We can set a flag of 'close_on_exec' to file descriptors by several
ways. When a file descriptsor has this flag, the old file descriptors
are closed when duplicated, even if it's an operation of duplicating
process image.

On Jul 27 2015 19:27, Takashi Iwai wrote:
> BTW, a minor nitpick: please omit the explicit 0 or 1 comparison for
> subscribed field.  It's a (kind of) boolean flag, so a form like
>     if (ctl->subscribed)
>
> or
>     if (!ctl->subscribed)
>
> is preferred.

OK, sure. I have a habit to write codes so that the type of variables
are clear at a glance (I'm not so familiar with weak-typing language).
When posting, I'll folliw to C-like idioms.


# My brain may be beaten by terrible summer heat...


Thanks

Takashi Sakamoto
