From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock
	detected!
Date: Mon, 29 May 2006 21:07:07 +0200
Message-ID: <20060529190707.GB24445@elte.hu>
References: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from mx2.mail.elte.hu (mx2.mail.elte.hu [157.181.151.9])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 319A014E
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 21:06:48 +0200 (MEST)
Content-Disposition: inline
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
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org


* Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:

> I get this with Ingo's lockdep patch from
> http://people.redhat.com/mingo/generic-irq-subsystem/

sigh, that patchset is not released yet ... it showed up in the genirq 
directory accidentally. (will release it later today)

> ====================================
> [ BUG: possible deadlock detected! ]
> ------------------------------------

at first sight this looks like a rare case of nested locking not yet 
covered by the lock validator. Could you try the patch below, to 
correctly express this locking construct to the lock validator?

Btw., beyond this false positive, i dont see how the lock ordering 
between ports is guaranteed - maybe there's some implicit rule that 
enforces it. And the whole grp->list_lock and grp->list_mutex lock use 
seems quite fragile - using list_lock in atomic contexts and list_mutex 
in schedulable contexts?

	Ingo

Index: linux/sound/core/seq/seq_ports.c
===================================================================
--- linux.orig/sound/core/seq/seq_ports.c
+++ linux/sound/core/seq/seq_ports.c
@@ -518,7 +518,7 @@ int snd_seq_port_connect(struct snd_seq_
 	atomic_set(&subs->ref_count, 2);
 
 	down_write(&src->list_mutex);
-	down_write(&dest->list_mutex);
+	down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
 
 	exclusive = info->flags & SNDRV_SEQ_PORT_SUBS_EXCLUSIVE ? 1 : 0;
 	err = -EBUSY;
@@ -591,7 +591,7 @@ int snd_seq_port_disconnect(struct snd_s
 	unsigned long flags;
 
 	down_write(&src->list_mutex);
-	down_write(&dest->list_mutex);
+	down_write_nested(&dest->list_mutex, SINGLE_DEPTH_NESTING);
 
 	/* look for the connection */
 	list_for_each(p, &src->list_head) {
