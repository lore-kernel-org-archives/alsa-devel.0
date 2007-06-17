From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Sun, 17 Jun 2007 21:15:31 +0530
Message-ID: <61445c750706170845v7072428n6b4e6d41561fe065@mail.gmail.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by alsa0.perex.cz (Postfix) with ESMTP id 29C3A24405
	for <alsa-devel@alsa-project.org>;
	Sun, 17 Jun 2007 17:45:34 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so1920457wag
	for <alsa-devel@alsa-project.org>; Sun, 17 Jun 2007 08:45:31 -0700 (PDT)
In-Reply-To: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
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

On 6/16/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi
> I am writing an alsa driver for my omap based board. I am testing it using
> cat /dev/audio currently, i.e. I have OSS emulation turned on. This is
> an initial round of testing and I will use alsa-libs and utils later.
>
> My problem is:
>
> I have set the pcm->private_data = my_chip after registering the pcm ops,
> after referring various standard drivers in alsa tree. My module is
> insmoded properly but after I do snd_card_register(card) the
> pcm->private_data is corrupted !! Before this step, the
> pcm->private_data is intact.  But after looking at the
> snd_card_register(), I realized that it doesn't even touch the pcm
> pointer.
>
> So, when I cat the device I get huge segfault in
> snd_pcm_attach_substream(), since pcm->private_data is NULL but
> surprisingly all the other fields are intact in pcm pointer.
>
>  Even the OSS code doesn't touch the pcm pointer, what must be wrong?
> I have checked my source atleast 5 times and couldn't find anything in it.
>
> -pharaoh.
>



Is the above post visible? I didn't receive it like all the other
mails sent to this list.
