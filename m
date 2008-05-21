From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: HG -> GIT migration
Date: Wed, 21 May 2008 17:40:33 +0200
Message-ID: <48344271.3090700@keyaccess.nl>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>	<200805211430.06653.linux@audioscience.com>	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>	<s5hve18vtml.wl%tiwai@suse.de>	<483415E7.5080402@keyaccess.nl>	<s5hfxsbx27f.wl%tiwai@suse.de>	<48341DF5.4090307@keyaccess.nl>
	<s5habijww7r.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id CA26324391
	for <alsa-devel@alsa-project.org>;
	Wed, 21 May 2008 17:38:03 +0200 (CEST)
In-Reply-To: <s5habijww7r.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 21-05-08 16:47, Takashi Iwai wrote:

> Theoretically we can work only using merges.  However, the resultant
> tree will look too complex with lots of merge points at the time of
> the next merge window.  This is also a nightmare for bisecting.  Thus,
> most subsystem trees do rebase before the merge window in practice,
> AFAIK.
> 
> It'd be appreciated if someone can tell me any good workflow to keep a
> good-shaped tree without rebasing...

Over here:

http://lkml.org/lkml/2008/5/17/203

Linus suggests to just not do many merges from upstream -- basically 
only at releases.

I'm only looking at and experiencing things from the limited viewpoint 
of a leaf node though so I'll shut up for a bit first now as this might 
not be helpful.

Rene.
