From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH 3/3] hdsploader: Temporary define for RPM
Date: Fri, 29 Jul 2011 17:46:53 +0200
Message-ID: <20110729154653.GV19500@ltw.loris.tv>
References: <1311889548-28617-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1311889548-28617-4-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hk4b163fb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id C3AC11037EE
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jul 2011 17:47:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk4b163fb.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 29, 2011 at 07:50:32AM +0200, Takashi Iwai wrote:

> > Right now (1.0.24.1), alsa-lib's hdsp.h doesn't know about the RPM. To
> > avoid a strong dependency on unreleased code, temporary provide the
> > define here.
> > 
> > It can be dropped as soon as a new version of alsa-lib will be released,
> > thus effectively making it the required minimum version for alsa-tools.
> > 
> > Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> > 
> > diff --git a/hdsploader/hdsploader.c b/hdsploader/hdsploader.c
> > index fa488a2..bfbe3bc 100644
> > --- a/hdsploader/hdsploader.c
> > +++ b/hdsploader/hdsploader.c
> > @@ -27,6 +27,10 @@
> >  
> >  static u_int32_t code[24413];
> >  
> > +#ifndef RPM
> > +# define RPM	5
> > +#endif
> 
> Now (after committing it), I found that it should be 4 instead of 5...?

Indeed. That's why repeated code is evil. ;) I'll come up with a fix.

Thanks for spotting.
