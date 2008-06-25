From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: ALSA 1.0.17rc2 release
Date: Wed, 25 Jun 2008 09:16:14 -0700
Message-ID: <1214410574.4303.193.camel@razman>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
	<20080618235305.bddd8fa2.pochini@shiny.it>
	<Pine.LNX.4.61.0806191110150.1798@tm8103-a.perex-int.cz>
	<20080620230822.49388d19.pochini@shiny.it>
	<Pine.LNX.4.61.0806210927431.1798@tm8103-a.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 99671243BD
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Jun 2008 18:16:17 +0200 (CEST)
In-Reply-To: <Pine.LNX.4.61.0806210927431.1798@tm8103-a.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I am now seeing this script miscompile issue as well on x86 hardware
(Mandriva 2008 and Ubuntu 8.04 x86 32 bit editions).  The second part of
the mod-deps.c patch is generating an extra ) for the
"fm801-tea575x-bool" test and the "usb-caiaq-input" test sections of
acinclude.m4.

Tobin

On Sat, 2008-06-21 at 09:28 +0200, Jaroslav Kysela wrote:

> On Fri, 20 Jun 2008, Giuliano Pochini wrote:
> 
> > On Thu, 19 Jun 2008 11:11:56 +0200 (CEST)
> > Jaroslav Kysela <perex@perex.cz> wrote:
> > 
> > > > Just like rc1, it doesn't compile the powermac driver (Linux Jay 2.6.25 #1
> > > > SMP Sat Apr 26 00:55:22 CEST 2008 ppc 7455, altivec supported PowerMac3,6
> > > > GNU/Linux). The patch below fixes the problem, but I'm not sure it's the
> > > > right fix.
> > > 
> > > Could you try this patch on fresh tree?
> > > 
> > > diff --git a/utils/mod-deps.c b/utils/mod-deps.c
> > > index baf21b8..8c9d2a6 100644
> > > --- a/utils/mod-deps.c
> > > +++ b/utils/mod-deps.c
> > > @@ -130,6 +130,7 @@ static char *kernel_deps[] = {
> > >  	"SUPERH",
> > >  	"SUPERH64",
> > >  	"IA32_EMULATION",
> > > +	"M68K",
> > >  	/* architecture specific */
> > >  	"ARCH_*",
> > >  	"X86_PC9800",
> > > @@ -601,6 +602,10 @@ static struct cond *join_cond(struct cond *cond1, struct cond *cond2)
> > >  	while (cond1->next)
> > >  		cond1 = cond1->next;
> > >  	cond1->next = cond2;
> > > +	cond2->left += 1;
> > > +	while (cond2->next)
> > > +		cond2 = cond2->next;
> > > +	cond2->right += 1;
> > >  	return orig;
> > >  }
> > 
> > No, it miscompiles the configure script: a couple of lines have a
> > superfluous closing parenthesis. I fixed them, but it still didn't set
> > CONFIG_SND_POWERMAC and CONFIG_SND_POWERMAC_AUTO_DRC.
> 
> Could you, please, send me your .config from kernel tree privately? 
> Thanks.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
