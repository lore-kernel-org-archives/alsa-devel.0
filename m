From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: HG vs GIT
Date: Thu, 07 Feb 2008 22:14:57 +0100
Message-ID: <47AB74D1.1070700@keyaccess.nl>
References: <Pine.LNX.4.61.0802071024530.8113@tm8103.perex-int.cz>
	<s5habmdknw0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B1CE2464A
	for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2008 22:13:40 +0100 (CET)
In-Reply-To: <s5habmdknw0.wl%tiwai@suse.de>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 07-02-08 12:27, Takashi Iwai wrote:

> BTW, one big annoying thing is that developers have no complete kernel
> tree to access, and thus the patches that touch outside the ALSA
> subdirectory cannot be merged easily.  People often send patches
> fixing together with OSS, etc, and I had to skip them.  So, frankly,
> I'd love to have an access to the whole kernel tree.  But, OTOH, this
> would make harder for other naive guys to give it a try because they
> need to download the big linux kernel tree git.
> 
> Maybe we can think reversely.  Keep the kernel git tree as the primary
> development tree and generate the subset as the alsa-kernel package
> from the kernel tree automatically.  In this way, you can avoid also 
> sign-off messes, too.

This sounds good...

> In this scheme, you don't have to stick with stgit.  The normal git
> can handle patches well enough (via occasional rebase), and it's much
> much faster than stgit.  Of course, stgit is still good for small
> number of patches, but it's not true for shared devel trees.

Rene.
