From: Travis Place <wishie@wishie.net>
Subject: Re:
	=?iso-8859-1?q?PATCH_for_alsa-info=2Esh_-_using_mkte?=
	=?iso-8859-1?q?mp_for_instead_of=09hardcoded_temp_dir=2E?=
Date: Thu, 28 Feb 2008 03:07:39 +1000
Message-ID: <200802280307.39573.wishie@wishie.net>
References: <200802280036.52665.wishie@wishie.net>
	<200802280242.20175.wishie@wishie.net>
	<s5hr6eys54p.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-101-003.auto.usertools.net [202.137.101.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 527C41038D5
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 18:08:06 +0100 (CET)
Received: from [192.168.0.2] (unknown [192.168.0.200])
	by wishie.net (Postfix) with ESMTP id C65875C787
	for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2008 17:29:32 +1000 (EST)
In-Reply-To: <s5hr6eys54p.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Feb 2008 3:04:06 am Takashi Iwai wrote:
> At Thu, 28 Feb 2008 02:42:20 +1000,
>
> Travis Place wrote:
> > On Thu, 28 Feb 2008 2:39:16 am you wrote:
> > > At Thu, 28 Feb 2008 00:36:52 +1000,
> > >
> > > Travis Place wrote:
> > > > Email subject should explain well enough.
> > >
> > > I see some problems with this change:
> > > - it doesn't work if /tmp/alsainfo doesn't exist
> > > - temp directory isn't removed if --no-upload is given
> > >
> > > I think you should avoid --tempdir=xxx with mktemp.
> > >
> > > The output file name is another question.
> > > IMO, it'd be better to pass the output file name via a command line
> > > option, and put it on the home directory (e.g. ~/alsa-info.out) as
> > > default rather than /tmp.
> >
> > well, /tmp/alsainfo/ will exist, as we create it in the script.. its
> > $ALSAINFODIR .. the temp dir is then created inside that.
>
> It's created too late.  And, if we create /tmp/alsainfo, there is
> little merit of mktemp as /tmp/alsainfo could be a symlink.  Simply
> TEMPDIR should be what mktemp creates, and clean it up after
> quitting.
>
> > As for not being cleaned up, if --no-upload is specified, ill check that
> > now..
> >
> > Also, is outputting the resulting file to ~/ wise ?
>
> It's at least safer than the fixed filename on /tmp.  I don't insist
> on this option, though.
>
> Anyway, --output-file=xxx would be a nice addition.
>
> > should this occur even if the result is uploaded, or only on
> > --no-upload ?
>
> I don't think it's needed when uploaded (except for any debugging
> reason).
>
>
> Just my $0.02.
>
> thanks,
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel


I will impement this all correctly tomorrow.. why do i always decide to tinker 
at about 3am ? heh

Nice to see other people adding to the script too.. 

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
