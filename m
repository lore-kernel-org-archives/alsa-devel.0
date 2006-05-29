From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.17-rc4-mm3-lockdep BUG: possible deadlock
	detected!
Date: Mon, 29 May 2006 21:53:25 +0200
Message-ID: <6bffcb0e0605291253w627570efn2cb3b6f08ba1b39@mail.gmail.com>
References: <6bffcb0e0605291132u701cd69tb855cf60fa317994@mail.gmail.com>
	<20060529190707.GB24445@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ED53513B
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 21:53:26 +0200 (MEST)
Received: by nz-out-0102.google.com with SMTP id l1so615072nzf
	for <alsa-devel@alsa-project.org>; Mon, 29 May 2006 12:53:25 -0700 (PDT)
In-Reply-To: <20060529190707.GB24445@elte.hu>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, alsa-devel@alsa-project.org, LKML <linux-kernel@vger.kernel.org>, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On 29/05/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
>
> > I get this with Ingo's lockdep patch from
> > http://people.redhat.com/mingo/generic-irq-subsystem/
>
> sigh, that patchset is not released yet ... it showed up in the genirq
> directory accidentally. (will release it later today)

Ok. So I'll wait with reporting that
http://www.stardust.webpages.pl/files/lockdep/2.6.17-rc4-mm3-lockdep1/lockdep-dmesg2
:)

>
> > ====================================
> > [ BUG: possible deadlock detected! ]
> > ------------------------------------
>
> at first sight this looks like a rare case of nested locking not yet
> covered by the lock validator. Could you try the patch below, to
> correctly express this locking construct to the lock validator?

Problem fixed. Thanks!

>
> Btw., beyond this false positive, i dont see how the lock ordering
> between ports is guaranteed - maybe there's some implicit rule that
> enforces it. And the whole grp->list_lock and grp->list_mutex lock use
> seems quite fragile - using list_lock in atomic contexts and list_mutex
> in schedulable contexts?
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
