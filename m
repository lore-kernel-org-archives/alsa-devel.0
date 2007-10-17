From: "=?KOI8-R?B?98HTyczJyg==?=" <anarsoul@gmail.com>
Subject: Re: 1.0.15rc3 patch_analog.s bug + fix
Date: Wed, 17 Oct 2007 19:10:45 +0300
Message-ID: <8f9284c20710170910t695696fbu39b0c246306d784@mail.gmail.com>
References: <20071015025303.GA17664@jay.phy.queensu.ca>
	<200710161039.55191.anarsoul@gmail.com> <s5hmyuj47zf.wl%tiwai@suse.de>
	<200710162130.51168.anarsoul@gmail.com> <s5hir562nzj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id CF1CF2477B
	for <alsa-devel@alsa-project.org>;
	Wed, 17 Oct 2007 18:10:47 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so1446361rvb
	for <alsa-devel@alsa-project.org>; Wed, 17 Oct 2007 09:10:45 -0700 (PDT)
In-Reply-To: <s5hir562nzj.wl%tiwai@suse.de>
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

2007/10/17, Takashi Iwai <tiwai@suse.de>:
>
> At Tue, 16 Oct 2007 21:30:50 +0300,
>
> >> But it seems that there's another bug - i have loud click when i try to
> play
> >> something or change mixer settings after not using audio for ~1min
>
> > I guess it's likely the auto power-saving feature.
> > Could you set the module option power_save=0 for snd-hda-intel?
>
> Thanks, it works. But why such feature is enabled by default?
AFAIK such loud clicks are harmful for speakers or headphones.

Regards
Vasily
