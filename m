From: Noel Bourke <cros13+alsa@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Wed, 20 May 2009 20:19:07 +0100
Message-ID: <2eeb67a60905201219m561a26d5v677bcb3f9c6fcee1@mail.gmail.com>
References: <2eeb67a60905181526x22be771ek4b4277617b371563@mail.gmail.com>
	<s5htz3hk1o5.wl%tiwai@suse.de>
	<2eeb67a60905201021w28aee8d1yd3be960400b9fd77@mail.gmail.com>
	<s5h8wkrpsr2.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 46F84243EA
	for <alsa-devel@alsa-project.org>;
	Wed, 20 May 2009 21:19:28 +0200 (CEST)
Received: by qyk1 with SMTP id 1so990970qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 20 May 2009 12:19:27 -0700 (PDT)
In-Reply-To: <s5h8wkrpsr2.wl%tiwai@suse.de>
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

Yep, ran it in bash. I thought it might be something simple but the line in
question barring the comment is just "fi"

On Wed, May 20, 2009 at 18:51, Takashi Iwai <tiwai@suse.de> wrote:

> At Wed, 20 May 2009 18:21:04 +0100,
> Noel Bourke wrote:
> >
> > I'm getting the following output from that script...
> > I took a look and couldn't find the problem.
> >
> > alsa-info.sh: 365: [[: not found
>
> You must be using a shell that doesn't support it.
> The script is supposed to run with bash.   (OK, we need to fix it...)
>
>
> Takashi
>
> > ALSA Information Script v 0.4.56
> > --------------------------------
> >
> > This script will collect information about your ALSA installation and
> sound
> > related hardware, to help diagnose your problem.
> >
> > Do you want to run this script? [y/n] : read: 365: Illegal option -e
> >
> > Thank you for using the ALSA-Info Script
> >
> > On Tue, May 19, 2009 at 08:11, Takashi Iwai <tiwai@suse.de> wrote:
> >
> >     At Mon, 18 May 2009 23:26:47 +0100,
> >     Noel Bourke wrote:
> >     >
> >     > Hi Takashi,
> >     >
> >     > I set this up with an Auzentech X-Fi Prelude.
> >     > Driver works OK but sound seemed a bit off.
> >     > According to speaker-test I seem to only
> >     > have one audio channel!
> >     >
> >     > Any thoughts?
> >
> >     Please run alsa-info.sh with --no-upload option, and attach the
> >     generated file.  This will show a bit more detailed driver
> >     information.
> >
> >     thanks,
> >
> >     Takashi
> >
> >
>
