From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5.50: sleeping function called from illegal context
Date: Tue, 3 Dec 2002 04:55:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212030455.16379.baldrick@wanadoo.fr>
References: <200212030407.53337.baldrick@wanadoo.fr> <s5hk7ir9ura.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hk7ir9ura.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 03 December 2002 13:01, Takashi Iwai wrote:
> At Tue, 3 Dec 2002 04:07:52 +0100,
>
> Duncan Sands wrote:
> > Got this with today 2.5 BK tree:
> >
> > Debug: sleeping function called from illegal context at
> > include/asm/semaphore.h:119 Call Trace:
> >  [<c0113f1a>] __might_sleep+0x52/0x58
> >  [<c024291a>] snd_cs46xx_iec958_put+0x36/0xf8
> >  [<c0217f28>] snd_ctl_elem_write+0xe0/0x1a4
> >  [<c0218360>] snd_ctl_ioctl+0x184/0x2c8
> >  [<c01462e6>] sys_ioctl+0x1fa/0x244
> >  [<c01088f7>] syscall_call+0x7/0xb
>
> ouch, we are using rwlock in the control ioctls.
>
> mutex is necessary for many controls, so we cannot suppress the use of
> mutex in control callbacks.
> but temporary unlocking looks ad-hoc, too...

If I understand right, the problem is that snd_ctl_elem_write
acquires control_rwlock, which is a rw spinlock.  It then calls
snd_cs46xx_iec958_put which acquires chip->spos_mutex,
which is a semaphore.  Thus the message.  Now I deduce
from the fact that  you don't use read_lock_irqsave that the
data structure is not read from interrupt context.  That means
you are only protecting against other CPUs.  So why not use
a semaphore instead of a spinlock?

All the best,

Duncan.


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
