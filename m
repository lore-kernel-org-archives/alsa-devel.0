From: Georgi Georgiev <chutz@gg3.net>
Subject: Re: snd-ioctl32 is failing on x86_64 (no crashes, just errors)
Date: Mon, 10 Jan 2005 21:33:42 +0900
Message-ID: <20050110123342.GA243173@lion.gg3.net>
References: <20050106130649.GA253131@lion.gg3.net> <s5h1xcxy0tj.wl@alsa2.suse.de> <20050108074026.GA8595@lion.gg3.net> <s5h7jmlv82j.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tiger.gg3.net (142.13.111.219.st.bbexcite.jp [219.111.13.142])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0A3B1284
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2005 13:33:45 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <s5h7jmlv82j.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

maillog: 10/01/2005-12:26:28(+0100): Takashi Iwai types
> At Sat, 8 Jan 2005 16:40:27 +0900, Georgi Georgiev wrote:
> 
> It's SNDRV_CTL_IOCTL_ELEM_READ.  Could you check which place returns
> -EINVAL in _snd_ioctl32_ctl_elem_value in
> alsa-kernel/core/ioctl32/ioctl32.c?

It says:

        /* FIXME: indirect access is not supported */
        if (data->indirect) {
                err = -EINVAL;
                goto __end;
        }

There is another one shortly after this:

        switch (type) {
	...
        default:
                printk(KERN_ERR "snd_ioctl32_ctl_elem_value: unknown type %d\n", type);
                err = -EINVAL;
                goto __end;
        }

Seeing the printk I checked my logs:

Jan 10 21:08:24 lion ioctl32(amixer:243138): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc610) on /dev/snd/controlC0
Jan 10 21:08:27 lion ioctl32(amixer:243139): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc600) on /dev/snd/controlC0
Jan 10 21:21:06 lion ioctl32(amixer:243280): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc670) on /dev/snd/controlC0
Jan 10 21:21:09 lion ioctl32(amixer:243281): Unknown cmd fd(3) cmd(c2c45512){02} arg(ffffc670) on /dev/snd/controlC0

though the error message is quite different than the printk above, it
could still be helpful.

I also don't see any differences between ioctl32.c from CVS and
1.0.8rc2. CVS version is at rev.1.26 and tagged as v1-0-8rc1.

> > > ALSA ioctl32 in 2.6.10 or older is buggy.  Try to avoid it.
> > 
> > Avoid using ioctl32? I don't have much of a choice since it doesn't work
> > anyway. It would be nice to get some sound on flash pages and wine,
> > though.
> 
> Yes, but the code in 2.6.10 may crash your system.
> (On x86-64, this might work, though...)
> 
> > 2.6.10 or older pretty much covers every kernel out there. What kernel
> > version is it OK to test this with?
> 
> The one in latest alsa-driver (alsa-kernel) tree.
> I think Linus's bk and mm trees have included already fixes.

The most important point that I did not get -- your advice about
avoiding ioctl32 is a different point of concern, that is completely
unrelated to the current problem, is it? In case this sounded rude --
advice is appreciated. Looked into it (I actually read a few reports
from sparc people whose machines ioctl32 broke, before submitting mine),
and if my machine ever crashes, I'll first upgrade the kernel and then
submit bugreports. But I don't have to worry about it until (if ever) my
machine hangs, right?

-- 
|    Georgi Georgiev   |  Zounds! I was never so bethumped with        |
|     chutz@gg3.net    |  words since I first called my brother's      |
|   +81(90)6266-1163   |  father dad. -- William Shakespeare, "Kind    |
|  ------------------- |  John" er                                     |


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
