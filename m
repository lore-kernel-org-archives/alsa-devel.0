From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: HG -> GIT migration
Date: Thu, 22 May 2008 22:43:04 +0200
Message-ID: <4835DAD8.2090204@keyaccess.nl>
References: <Pine.LNX.4.61.0805201314190.1798@tm8103-a.perex-int.cz>	<200805211430.06653.linux@audioscience.com>	<Pine.LNX.4.61.0805210805080.1798@tm8103-a.perex-int.cz>	<s5hve18vtml.wl%tiwai@suse.de>	<483415E7.5080402@keyaccess.nl>	<s5hfxsbx27f.wl%tiwai@suse.de>	<48341DF5.4090307@keyaccess.nl>	<Pine.LNX.4.61.0805211517290.1798@tm8103-a.perex-int.cz>	<48343465.2030905@keyaccess.nl>	<s5h8wy3wvyv.wl%tiwai@suse.de>	<48343FF4.8090107@keyaccess.nl>
	<20080522112412.4a8406fd.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id CB4B124453
	for <alsa-devel@alsa-project.org>;
	Thu, 22 May 2008 22:40:35 +0200 (CEST)
In-Reply-To: <20080522112412.4a8406fd.sfr@canb.auug.org.au>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 22-05-08 03:24, Stephen Rothwell wrote:

> Linux-next is rebuilt every day based on Linus' current kernel.  I merge
> all the trees I have been told about and fixup minor conflicts (sometimes
> reverting commits, sometimes applying patches).  So everyday, linux-next
> is completely new.  I do not care if the trees I am merging get rebased.

This means you're going to redo all those (same) minor conflict fixups 
each day again, doesn't it? Or do you pass the fixups back to (one of) 
the conflicting trees?

> I have only had a couple of occasions when the merge conflicts were so
> bad that I had to drop a whole tree, but they were fixed up the next day.
> 
> Linux-next has only one downstream - Andrew's mm tree and he bases on a
> particular day's linux-next tree each time he rebuilds mm.  Testers just
> need to take the complete tree (which isn't too bad if you are using git
> since all the linux-next trees share a lot of objects).
> 
> Does that answer your question?

But yes, it does, thanks.

Rene
