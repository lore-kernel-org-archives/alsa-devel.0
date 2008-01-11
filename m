From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD to
 support audio drivers
Date: Fri, 11 Jan 2008 18:23:41 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0801111820370.30240@tm8103.perex-int.cz>
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
	<47879BD6.9010205@freescale.com> <s5htzlkl3b2.wl%tiwai@suse.de>
	<4787A259.5010200@freescale.com> <s5hmyrcl20j.wl%tiwai@suse.de>
	<4787A478.7050500@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BB5DC245DE
	for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2008 18:23:42 +0100 (CET)
In-Reply-To: <4787A478.7050500@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 11 Jan 2008, Timur Tabi wrote:

> Takashi Iwai wrote:
> 
> > The problem is that HG repo doesn't contain the whole kernel tree but
> > only the ALSA subtree to reduce the repo size.
> 
> So is it okay if I use the git repo to base my work?  I use git for all 
> other Linux development, so it would be awkward for me to use HG just 
> for ALSA work.

I'm not sure how it will work. The mm tree contains all patches going to 
mainstream kernel, but the tree is rebased regulary - both #mm and #linus 
branches (Stacked GIT is used to maintain ALSA patches on top of the 
Linus's tree).

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
