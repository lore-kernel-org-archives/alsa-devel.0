From: Travis Place <wishie@wishie.net>
Subject: Re:
	=?iso-8859-1?q?=5BPATCH=5D_alsa-info=2Esh_-_Fixed_ty?=
	=?iso-8859-1?q?po_that_stops_the=09=27Automatic_Upload=27_warning_?=
	=?iso-8859-1?q?from_appearing=2E?=
Date: Tue, 20 May 2008 23:44:38 +1000
Message-ID: <200805202344.38679.wishie@wishie.net>
References: <200804290010.52696.wishie@wishie.net>
	<200805190008.30421.wishie@wishie.net>
	<1211288841.3811.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wishie.net (202-137-102-183.dial.usertools.net
	[202.137.102.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 482D5248A1
	for <alsa-devel@alsa-project.org>;
	Tue, 20 May 2008 15:45:07 +0200 (CEST)
Received: from [192.168.0.2] (fallen [192.168.0.2])
	by wishie.net (Postfix) with ESMTP id 8B2D331DB6
	for <alsa-devel@alsa-project.org>; Tue, 20 May 2008 14:06:14 +1000 (EST)
In-Reply-To: <1211288841.3811.1.camel@localhost>
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

On Tue, 20 May 2008 11:07:21 pm Ben Stanley wrote:
> Travis,
>
> Thanks for fixing this. I got burned by it today running it on a
> computer at work. I was none too pleased to see my machine details
> uploaded.
>
> Anyway, thanks for fixing it.
>
> Ben Stanley.
>
> On Mon, 2008-05-19 at 00:08 +1000, Travis Place wrote:
> > Fixed a typo that was causing no warning about the script automatically
> > uploading info to a pastebin. Some users were NOT too happy with this.
> >
> > Also, bumped up the version number so existing versions will
> > automatically update to the fixed version upon next script run.
> >
> >
> > diff -r 93548f7b2086 alsa-info.sh
> > --- a/alsa-info.sh	Wed Apr 30 14:47:42 2008 +0200
> > +++ b/alsa-info.sh	Mon May 19 00:01:04 2008 +1000
> > @@ -1,6 +1,6 @@
> >  #!/bin/bash
> >
> > -SCRIPT_VERSION=0.4.43
> > +SCRIPT_VERSION=0.4.44
> >  CHANGELOG="http://hg.alsa-project.org/alsa/log/tip/alsa-info.sh"
> >
> >
> > #########################################################################
> >######## @@ -215,7 +215,7 @@ if [ "$QUESTION" = "yes" ]; then
> >  if [ "$QUESTION" = "yes" ]; then
> >  if [[ -n "$DIALOG" ]]
> >  then
> > -if [ -z "NOUPLOAD" ]; then
> > +if [ -z "$NOUPLOAD" ]; then
> >  	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v
> > $SCRIPT_VERSION" --yesno "\nThis script will collect information about
> > your ALSA installation and sound related hardware, to help diagnose your
> > problem\n\nBy default, this script will AUTOMATICALLY UPLOAD your
> > information to a pastebin site.\n\nSee $0 --help for options\n\nDo you
> > want to run this script?" 0 0
> >  else
> >  	dialog --backtitle "$BGTITLE" --title "ALSA-Info script v
> > $SCRIPT_VERSION" --yesno "\nThis script will collect information about
> > your ALSA installation and sound related hardware, to help diagnose your
> > problem\n\nSee $0 --help for options\n\nDo you want to run this script?"
> > 0 0
> >
> >
> > Thanks,
> > Travis Place
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

No worries, Im sorry that it happened in the first place.

Travis.

-- 
Happiness is like peeing your pants. Everyone can see it, but only you can 
feel its warmth 
