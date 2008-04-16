From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: [PATCH 002b/003] snd-powermac: style awacs.s and
	awacs.h
Date: Wed, 16 Apr 2008 13:53:31 +0300
Message-ID: <46e1c7760804160353g30fddca3icea6d6fe5635b856@mail.gmail.com>
References: <46e1c7760804160002j6d24d074qbb2192280ab23d4d@mail.gmail.com>
	<s5hk5iyf672.wl%tiwai@suse.de>
	<46e1c7760804160335uc272440n179c2dec9622d348@mail.gmail.com>
	<s5hfxtmf5hc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.184])
	by alsa0.perex.cz (Postfix) with ESMTP id EA51A247C7
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Apr 2008 12:53:31 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id f40so5004903fka.0
	for <alsa-devel@alsa-project.org>; Wed, 16 Apr 2008 03:53:31 -0700 (PDT)
In-Reply-To: <s5hfxtmf5hc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/4/16, Takashi Iwai <tiwai@suse.de>:
>
> Thanks, that works.  But, I get checkpatch errors:
>
>  ERROR: do not use assignment in if condition
>  #116: FILE: ppc/awacs.c:704:
>
> +               if ((err = snd_ctl_add(chip->card,
>
>
> ERROR: do not use assignment in if condition
>  #171: FILE: ppc/awacs.c:982:
>
> +               if ((err = build_mixers(chip,
>
>
> ERROR: do not use assignment in if condition
>  #191: FILE: ppc/awacs.c:999:
>
> +               if ((err = build_mixers(chip,
>
>
>
> Please fix?
>

I can do that but it will make the code much clumsier. Actually, I
think this is checkpatch misunderstanding something. There is a '< 0'
at the end of those conditions. Is it really this kind of assingment
they want to forbid? This is the style there has been all the time.

Risto
