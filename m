From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] Allow to switch hardware sampe rate on EMU
Date: Mon, 25 Feb 2013 17:44:23 +0800
Message-ID: <CAN8cciZ3ufnr1SKCUBSF=xF8rkFSzJOfFYjRXTY-ocD3C-_mzw@mail.gmail.com>
References: <CAD-m0i9NwmVsGH53cphNM3ikDAanBU2bwE7Wa0KTASbwnW-aqA@mail.gmail.com>
 <s5h8v6cu5oo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id D9400265182
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 10:44:25 +0100 (CET)
Received: by mail-ie0-f174.google.com with SMTP id k10so2870664iea.33
 for <alsa-devel@alsa-project.org>; Mon, 25 Feb 2013 01:44:23 -0800 (PST)
In-Reply-To: <s5h8v6cu5oo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mihail Zenkov <mihail.zenkov@gmail.com>
List-Id: alsa-devel@alsa-project.org

> >
> > Commit 57e5c63007955838043e34c732d224b2cbbb128f "emu10k1: allow to
> > disable the SRC"
> > force hardware use only one rate (48000 hz), but EMU have support two
hardware
> > sampling rates (44100 and 48000 hz).
>
> The commit serves for its purpose: it restricts the sample rate only
> when user specifies to disable h/w resample.  Emu chip is driven in
> 48k rate and other rates are the result of resampling.
>
> In other words, if user doesn't specify the flag, all sample rates are
> still allowed.
>
>

I agree that some emu10k1 does not work well with 44100Hz but why 96000Hz
are not allowed in Audigy

Does it mean that DSP can not provide accurate pointer for other rate such
as 8000Hz playback ?
