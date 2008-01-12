From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] [POWERPC] Update MPC8610 HPCD
	to	support audio drivers
Date: Sat, 12 Jan 2008 13:40:12 +0000
Message-ID: <20080112134011.GA4696@sirena.org.uk>
References: <12000050651235-git-send-email-timur@freescale.com>
	<12000050664035-git-send-email-timur@freescale.com>
	<fa686aa40801101452q608907f3rf6f98a5d091d09d9@mail.gmail.com>
	<47879BD6.9010205@freescale.com> <s5htzlkl3b2.wl%tiwai@suse.de>
	<4787A259.5010200@freescale.com> <s5hmyrcl20j.wl%tiwai@suse.de>
	<4787A478.7050500@freescale.com>
	<Pine.LNX.4.61.0801111820370.30240@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E06EE24792
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 14:40:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0801111820370.30240@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 11, 2008 at 06:23:41PM +0100, Jaroslav Kysela wrote:
> On Fri, 11 Jan 2008, Timur Tabi wrote:

> > So is it okay if I use the git repo to base my work?  I use git for all 
> > other Linux development, so it would be awkward for me to use HG just 
> > for ALSA work.

> I'm not sure how it will work. The mm tree contains all patches going to 
> mainstream kernel, but the tree is rebased regulary - both #mm and #linus 
> branches (Stacked GIT is used to maintain ALSA patches on top of the 
> Linus's tree).

For driver work you will often find that you can just do development
against Linus' repository since it is fairly uncommon to encounter
conflicting changes in the area of the code code that you are working
on.  Changes can be merged with or cherry picked onto one of the ALSA
branches to check that they'll apply correctly before submission without
having to deal with that being rebased during development.
