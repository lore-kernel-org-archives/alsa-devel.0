From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5.50: sleeping function called from illegal context
Date: Fri, 6 Dec 2002 14:13:50 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212061413.51333.baldrick@wanadoo.fr>
References: <200212030407.53337.baldrick@wanadoo.fr> <200212030657.45283.baldrick@wanadoo.fr> <s5hhedv9mng.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhedv9mng.wl@alsa2.suse.de>
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

> > I guess another way of dealing with this kind of problem is to use a
> > semaphore rather than a spinlock, and a workqueue: when the interrupt
> > comes in, the call to snd_ctl_notify is put on the queue, where it will
> > later be run in process context, and can safely take the semaphore.
>
> yes, basically what snd_ctl_notify() does is the same.
> it queues an event and wakes up the sleepers.
> thus, it's ok to separate the stuff from the semaphore.
>
> the attached is a patch to rewrite the locks with rwsem.
> please check whether it works for you.

It seems to work fine.

Thanks a lot,

Duncan.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
