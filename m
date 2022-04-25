Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8FAC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Apr 2022 16:57:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A8AC161E;
	Mon, 25 Apr 2022 18:56:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A8AC161E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650905843;
	bh=FZ03P9rSuvGw9MwQAl3eR+tRDxsAWBsguuX9Kn7uHpU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hyJ7m+HUKXw6RVLL1NT1AzEQm331vKzagpHD4b0wcT6F+iB8Xo5BwF2Cs53y1l0Or
	 WGv0Dlugj0SC3Rr0tJdtuDyLgFZtzhvUX1B8ZwHmWUvI0k9IbfIBzF3mpGkTlMsMex
	 sXpQHidOXOOWADTYDVLVClVp6+bI1KfhK/dAGYPk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC1BAF8014B;
	Mon, 25 Apr 2022 18:56:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F9C1F800FA; Mon, 25 Apr 2022 18:56:30 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2D4C8F800FA
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2022 18:56:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2D4C8F800FA
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="TNxzFJ8s"
Received: by mail-yb1-xb2f.google.com with SMTP id r189so28168115ybr.6
 for <alsa-devel@alsa-project.org>; Mon, 25 Apr 2022 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3nHqpeRMqi5ydu/1+qACR0gpSXJ+684PjSvA8TxDFDQ=;
 b=TNxzFJ8skf6JzWlQLq0qfcPcp7scN5ongV1p4rF70j/cQMSIwM3xmHdr80cGpfnQ8t
 bwU+6TOYcj9nf/oQV2ZDfEAdjpln2UkrxwU/0EGj0iOaLrsX4/cm/hZEEALcXe5VrY6/
 epw0T6c0XF4XjmANfKc5Ro97ve1Wni1Yb4QjwuoQ0ic9X4aaAhzZ3QkwzFRrCGZEw+9F
 4DxdR8elStD1ojHmhL/sxWsFJ1pSQ3sm5tHtwLFQtbLxEz9Au5fk5Y/8i2DZIhaNnmNy
 Lnr3yoHg7X4I2WDsUGxjIcgC/MW+iUyyipAXDluVM+TRG+++tnVEarotaTD+ex+NJAu4
 gtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3nHqpeRMqi5ydu/1+qACR0gpSXJ+684PjSvA8TxDFDQ=;
 b=EoOHUeTej6jVfx1Li08EHRfvw4t4V+zdVkXK9+KXqseR7rQ5Dxf/5qOlebOaCMuSuh
 DIoeDJayJRUm/jlSP7SpLM8yI7RXLky87IyMP5acFFQK0QXWuX8piTYzRx7sSH5l9KEP
 L6vNYopKPuigptvnzNs6lS2+4ofAyRAy2p2uqe9im/NjILxJUAE0znKEKssFBzX8ZOa9
 NTv6DyynYJasrckVfDvbvHc7VOxodIye5CxGzfXWuVRJ27yagTfDt+Fx+vXALUayNmNg
 5i/f4CSn2izg+tvsLLlXm+eMrO/PMXE8699LP5EOkEcsKe8JdwauuTYzr+4lla0wmKHQ
 2Oqw==
X-Gm-Message-State: AOAM531gOAX0SCLh9PCfiSK/9HB7BtkNuQMLgafNtSz5WZID6SxmbQuM
 Ikq1U9a0D++zgYOpGktXfr5e2e/nSuvQE4ZdSNw=
X-Google-Smtp-Source: ABdhPJyWZiXKSCBdfFrt30g49h5Yv7uJinQN6d/QX58gjVXXpGO8EFW+Kr8l2GgSAyg0gVQdgXt/gqLoy+hS947pohI=
X-Received: by 2002:a25:42cd:0:b0:645:d805:4fcb with SMTP id
 p196-20020a2542cd000000b00645d8054fcbmr13531376yba.182.1650905782127; Mon, 25
 Apr 2022 09:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220421203555.29011-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220421203555.29011-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdX4_PKsGGRj6yGhDGfaRD-6PqiJeCnKq0yUicfMutOP4g@mail.gmail.com>
 <CA+V-a8uJM0etygB-v+rs0+EKY6_tz90wH_ZOVH8Zbc8dQPmQGw@mail.gmail.com>
 <CAMuHMdXHqn5_segVMhn_biEXnOSyaLpPfv4jkFp2uxv-=bfqew@mail.gmail.com>
In-Reply-To: <CAMuHMdXHqn5_segVMhn_biEXnOSyaLpPfv4jkFp2uxv-=bfqew@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 25 Apr 2022 17:55:55 +0100
Message-ID: <CA+V-a8sYWv+K8_QRFFzEupWMD3i4Y9MCta-FfM2_Qv37dHNsAg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: sh: rz-ssi: Drop unused macros
To: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Pavel Machek <pavel@denx.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Takashi Iwai <tiwai@suse.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>,
 Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Hi Geert,

On Mon, Apr 25, 2022 at 5:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Apr 25, 2022 at 6:09 PM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
> > On Mon, Apr 25, 2022 at 1:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Apr 22, 2022 at 7:32 PM Lad Prabhakar
> > > <prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> > > > Drop unused macros SSIFSR_TDC and SSIFSR_RDC.
> > > >
> > > > Reported-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Thanks for your patch!
> > >
> > > What does this fix?
> > > Is the real issue that there are 32 FIFO entries, and the TDC and RDC
> > > fields are 6 bits wide, while the mask uses 0x1f instead of 0x3f?
> > >
> > I was in two minds here as you have already spotted the masks are
> > incorrect, instead of fixing the masks I choose to drop the macros
> > itself as they were not used. Let me know what are your thoughts on
> > this.
>
> IC.
>
> I don't have a preference.
> So please either remove them, and make it clear they were wrong,
> so no one is tempted to just revert the removal to start using the
> definitions, or either keep them, and fix the definitions.
>
I'll go with dropping them and make it clear they were wrong.

Cheers,
Prabhakar

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
