From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: 1.0.5rc1 release
Date: Tue, 25 May 2004 15:31:43 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0405251505051.6093-100000@studcom.urz.uni-halle.de>
References: <s5haczwwtob.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5haczwwtob.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> I wrote:
> >
> > Clemens Ladisch wrote:
> > >
> > > depmod: *** Unresolved symbols in
> > > /lib/modules/2.4.26/kernel/sound/isa/wavefront/snd-wavefront.o
> > > depmod:         errno
> > >
> > > The open/close/read system calls are implemented as inline functions
> > > which change errno which isn't exported from the kernel.
>
> does the attached patch work?

> +static int errno;

I don't have access to my Linux machine here, but I guess it does.

> > i guess sys_* functions are also not defined correctly on older
> > kernels.  they were open(), close(), read() with __KERNEL_SYSCALLS__.

> +#define sys_open open
> +#define sys_close close
> +#define sys_read read

These definitions are already in alsa-driver/include/syscalls_26.h.


I'm going to test and apply this until tomorrow, but feel free to
apply it now if you want to release rc2 earlier. :)


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
