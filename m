From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: 1.0.16rc2 -build issues
Date: Wed, 30 Jan 2008 21:03:45 +0000
Message-ID: <200801302103.45969.gineera@aspect135.co.uk>
References: <Pine.LNX.4.61.0801291553220.11819@tm8103.perex-int.cz>
	<200801301241.46610.gineera@aspect135.co.uk>
	<s5h3asf4gai.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 9854B247B7
	for <alsa-devel@alsa-project.org>; Wed, 30 Jan 2008 21:44:10 +0100 (CET)
In-Reply-To: <s5h3asf4gai.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wednesday 30 January 2008 13:03, you wrote:
> At Wed, 30 Jan 2008 12:41:46 +0000,
>
> Alan Horstmann wrote:
> > On Wednesday 30 January 2008 11:21, Takashi wrote:
> > >
> > > Could you apply the patch below and use ./hgcompile to configure?
> > >
> > > thanks,
> > >
> > > Takashi
> >
> > Patch applied OK.  Unfortunately, hgcompile complains that the Autoconf
> > version is too old on this system -needs >2.59 (looks like I have 1.4o).
> > What is the difference using that rather than straight configure?
>
> You need to regenerate the configure script itself.
>
> >  Is there a
> > way to work round it?
>
> Remove the line "AC_PREREQ(2.59)" in configure.in.

Thanks.  However, I could not get (the old) autoconf to produce a working configure script due to 'AS_HELP_STRING', so I added
	#define CONFIG_HAVE_FFS
to the patched adriver.h and used the original configure script, to proceed for now (which it did).

Unfortunately make didn't get much further, having more ??historic kernel?? trouble in memalloc:

memalloc.c: In function `snd_mem_proc_open':
memalloc.c:611: warning: implicit declaration of function `single_open'
memalloc.c: At top level:
memalloc.c:715: error: `single_release' undeclared here (not in a function)
memalloc.c:715: error: initializer element is not constant
memalloc.c:715: error: (near initialization for `snd_mem_proc_fops.release')
memalloc.c: In function `snd_mem_init':
memalloc.c:731: warning: assignment discards qualifiers from pointer target type

Sorry if this is causing a lot of extra trouble.

Regards  Alan
