From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 6
Date: Wed, 11 Apr 2012 01:35:08 +1000
Message-ID: <CACckToWkSptJd=8EjXH-RiEUqf3SqNU4ByVGKDEx8FdAhmVXuA@mail.gmail.com>
References: <1324656947-23169-1-git-send-email-zonque@gmail.com>
	<4EFDC32B.10808@gmail.com>
	<CAFz=ag7_qzPJq44havp=EbFVKud5VvKaOLJk0i0dM43X3urp9Q@mail.gmail.com>
	<CAFz=ag6pqhfOvxv_ScbxJFs6OEZt18GM+Dgs1KWQMG7mdZO21g@mail.gmail.com>
	<CACckToXJAJxGo-LSM3X-q=6Vo=-KzuE2Om9bgFiDnWPFNWmnSQ@mail.gmail.com>
	<4F8336CA.9060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id 3BA33246DC
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Apr 2012 17:35:09 +0200 (CEST)
Received: by werg1 with SMTP id g1so3453910wer.38
	for <alsa-devel@alsa-project.org>; Tue, 10 Apr 2012 08:35:08 -0700 (PDT)
In-Reply-To: <4F8336CA.9060809@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: =?ISO-8859-1?Q?Aur=E9lien_Leblond?= <blablack@gmail.com>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Felix Homann <linuxaudio@showlabor.de>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 10, 2012 at 5:21 AM, Daniel Mack <zonque@gmail.com> wrote:

> Hi Grant et al,
>
>
> Again sorry for catching up so late on this.
>
>
> On 16.01.2012 21:26, Grant Diffey wrote:
> > So I've had a chance to do some testing. I can reliably generate then
> > following trace with daniels patch on 3.2-rt10
> >
> > [  188.561901] ------------[ cut here ]------------
> > [  188.561908] WARNING: at fs/proc/generic.c:586
> proc_register+0x181/0x1c7()
> > [  188.561909] Hardware name: HP Compaq 6910p
> > [  188.561911] proc_dir_entry 'card1/pcm0p' already registered
>
> There might have been a race condition in the shutdown path which I fixed.
>
> Could you repeat the tests you did some months ago and report whether
> you still see this issue? I would also appreciate test input from other
> people. Any kind of USB device is good to track these issues.
>
> Regarding the difference in reported channel numbers, I can't really
> point my finger to any specific line. It really puzzles me, as my patch
> set leaves the detection of interfaces and the registration of pcm
> streams untouched. It would help to know whether there is any difference
> in the output of "aplay -l" with and without my patches applied.
>
> To test the new set of patches, please start off with a 3.4.0 vanilla
> kernel and then either
>
>  git pull git://github.com/zonque/linux.git usb-audio
>
> or manually apply the combined patch from https://gist.github.com/1168715
>
>
> I hope to *finally* get this topic finished in this round, but I need
> the some helpers for testing :)
>
>
>
> Daniel
>
>
So this seems to be good it solves the clicking problem for me generating
sine wave's

I need to do some further testing. which is unlikely to happen this morning.

Grant.
