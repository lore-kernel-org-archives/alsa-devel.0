From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock
	detected!
Date: Mon, 29 May 2006 11:47:49 -0700
Message-ID: <20060529114749.ba020660.akpm@osdl.org>
References: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 10EC3159
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 20:43:35 +0200 (MEST)
In-Reply-To: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, mingo@elte.hu, alsa-devel@alsa-project.org, perex@suse.cz, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 29 May 2006 20:32:47 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> I get this with Ingo's lockdep patch from
> http://people.redhat.com/mingo/generic-irq-subsystem/
> 
> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------
> modprobe/592 is trying to acquire lock:
>  (&grp->list_mutex){----}, at: [<fd9ee555>]
> snd_seq_port_connect+0xc0/0x337 [snd_seq]
> 
> but task is already holding lock:
>  (&grp->list_mutex){----}, at: [<fd9ee4fb>]
> snd_seq_port_connect+0x66/0x337 [snd_seq]
> 
> which could potentially lead to deadlocks!
> 
> other info that might help us debug this:
> 1 locks held by modprobe/592:
>  #0:  (&grp->list_mutex){----}, at: [<fd9ee4fb>]
> snd_seq_port_connect+0x66/0x337 [snd_seq]

yes,

        down_write(&src->list_mutex);
        down_write(&dest->list_mutex);

I wonder if there's anything which prevents another task from concurrently
coming in and trying to perform the opposite connection and causing a
deadlock.

The way we normally handle this is

	if (src < dest) {
		down_write(&src->list_mutex);
		down_write(&dest->list_mutex);
	} else {
		down_write(&dest->list_mutex);
		down_write(&src->list_mutex);
	}
