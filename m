From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Fri, 13 Apr 2012 08:19:51 +0200
Message-ID: <4F87C587.9000101@gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
	<CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
	<CACckToU+zq2jrPFRJmYGA05REtfPkRjf05JqiGY+bSyDkk=p+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AAE910B8C0
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 08:19:57 +0200 (CEST)
Received: by bkwj10 with SMTP id j10so2212280bkw.38
	for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2012 23:19:57 -0700 (PDT)
In-Reply-To: <CACckToU+zq2jrPFRJmYGA05REtfPkRjf05JqiGY+bSyDkk=p+w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On 13.04.2012 03:39, Grant Diffey wrote:
> On Fri, Apr 13, 2012 at 9:59 AM, Grant Diffey <gdiffey@gmail.com
> <mailto:gdiffey@gmail.com>> wrote:
> 
>     On Thu, Apr 12, 2012 at 9:51 PM, Daniel Mack <zonque@gmail.com
>     <mailto:zonque@gmail.com>> wrote:
> 
>         Here's the 7th iteration of patches that reimplement the
>         streaming logic of
>         the ALSA USB audio driver.
> 
>         There were some bugs reportes by Felix and Grant, which have
>         been resolved.
> 
>         More testing is definitely important, but maybe the code will
>         get a wider
>         test coverage when merged to the development tree?
> 
> 
>     So I've also tested this against the current -rt head and can report
>     that it solves the clicking problem with playback there as well.
> 
>     Grant.

Good, thanks.

> so dumb question...
> 
> is setting a sane set of alsa controls a problem for the driver or
> userspace/distributions?
> 
> the problem is.
> 
> if all volumes are max on module insert. the ftu is essentially unusable
> untill they're corrected

What about alsactl? Set the mixers once, then call "alsactl store". Does
that help?
