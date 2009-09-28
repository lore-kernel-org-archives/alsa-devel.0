From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH 0/1] alsa-lib: pcm_hw: Always use delay
	ioctl in snd_pcm_delay()
Date: Mon, 28 Sep 2009 14:37:54 +0800
Message-ID: <4f3252890909272337x33df5f4es4debd933d1f8fb13@mail.gmail.com>
References: <alpine.DEB.1.10.0909110058130.3417@ecabase.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f184.google.com (mail-pz0-f184.google.com
	[209.85.222.184])
	by alsa0.perex.cz (Postfix) with ESMTP id C8AC524364
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Sep 2009 08:37:55 +0200 (CEST)
Received: by pzk14 with SMTP id 14so1987711pzk.23
	for <alsa-devel@alsa-project.org>; Sun, 27 Sep 2009 23:37:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.10.0909110058130.3417@ecabase.localdomain>
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

It seem that the problem is snd_pcm_rewindable() return a wrong value

It is unlikely for the application to rewind the application pointer to
hardware pointer (e.g. usb audio, cs46xx and au88x0 )

http://thread.gmane.org/gmane.linux.alsa.devel/65759/focus=65773

2009/9/11 Kai Vehmanen <kvehmanen@eca.cx>

> Hello all,
>
> this is a updated version of the alsa-lib patch I mentioned in
> the earlier thread:
>
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-August/020377.html
>
> That was meant to just describe the possible problem, but now I'm more
> confident that this should be considered for merging. The related
> alsa-kernel patch is 'ALSA: Add extra delay count in PCM', which added the
> 'runtime->delay' property.
>
> Please review if this patch makes sense.
>
> Kai Vehmanen (1):
>   pcm_hw: Always use delay ioctl in snd_pcm_delay()
>
>  src/pcm/pcm_hw.c |   22 ----------------------
>  1 files changed, 0 insertions(+), 22 deletions(-)
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
