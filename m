Return-Path: <SRS0=Jk6f=YA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25557C47404
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:07:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DE882070B
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Oct 2019 13:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MkDrY6Hu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SeFZrK8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DE882070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E99B01674;
	Mon,  7 Oct 2019 15:07:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E99B01674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570453672;
	bh=VDJm+MWQFXMeFsGgsuge+xdujl/QJeGf9lIWF44SogE=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MkDrY6Hu2ZekmqROgzrJdWnYpL5JKOquwN7Ne2D0GbCJnp8Svk09tUMh9LqO9q9D/
	 kxTvH7t7+Vuejw1oGz7JnWvrPd9rlTaQENM9PBnmW8BhfQB1ToQs///Qxyxn9gs05j
	 W85NSBI82WXreQP6QSVfdll6we+BbYJSJ18qr8Gg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DBEDF8063C;
	Mon,  7 Oct 2019 15:03:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F10DAF8063D; Mon,  7 Oct 2019 15:03:41 +0200 (CEST)
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com
 [IPv6:2607:f8b0:4864:20::943])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4AF00F80638
 for <alsa-devel@alsa-project.org>; Mon,  7 Oct 2019 15:03:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4AF00F80638
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="SeFZrK8g"
Received: by mail-ua1-x943.google.com with SMTP id b14so4008900uap.6
 for <alsa-devel@alsa-project.org>; Mon, 07 Oct 2019 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ds8WznLX+NYi3ptkiUX0OCakAHSXETW90blbf1WdtvY=;
 b=SeFZrK8gMg6fY4PxMOK0NPAoUBk5SKZP6Rm2RpMc1sRZKgJg2NDDLR9yH+ZTkFrojb
 ECECpc6XwZXZYWrLpY3dkrOp1pLvCwRPEB3LV/Opy8prDkyQaXBI+0Em6seuvBwIpUf3
 WSFX4glUQS905Oi7/4W2htI0p1s5RzgKNERk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ds8WznLX+NYi3ptkiUX0OCakAHSXETW90blbf1WdtvY=;
 b=Wow0Ve21ZM6PMOfX5GTDkr41fA7w12aPzEhFT9zEf478O8QBr97sQTqLC0734TntUG
 4UoToGzQz995rUBOtvvZqUqqMWxPpitm/i6dDrzNUXQOlfbxh9a+VQj3QGInpAfuwgxm
 KBdLYPXJxcgdSPvvD3vaGJF3mmujZX84CreTBd7Aux3N1pXh2XJPfCfts0pX/j9rTG4o
 4uJLI2bTRhmC+/f9JtZNobzntaopG7CUt72QIcVahzBCugMRRmW4UBLcxeVgrHMOpRNd
 0e9RtOp/VLVycjJgAEPjeRQZNhL/vgIGln/tQYmbzFJu2jDFiZzMponcc+4yq5RDsG+g
 NVPQ==
X-Gm-Message-State: APjAAAXWM5R6rOT2IMiVez+kAEcR9ddvAjgL0QmVrLSUnsjlWGTs3O5f
 VdRf+nHPyUonAh2W72ZGrm0Jzhqry1niaCoD3fK0nQ==
X-Google-Smtp-Source: APXvYqyXRPLlM1sC+Qh9Y+U2YnUrT41/QnuLEzazUmqup77OPEOS8gKvErJCG8qbHkr6M+W+SZdp07y4EAEUpxg6cwg=
X-Received: by 2002:a9f:2924:: with SMTP id t33mr11661088uat.69.1570453416905; 
 Mon, 07 Oct 2019 06:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191003041438.194224-1-cychiang@chromium.org>
 <b8ad03db-b93f-44e0-ccd6-fc8bda1af223@baylibre.com>
In-Reply-To: <b8ad03db-b93f-44e0-ccd6-fc8bda1af223@baylibre.com>
From: Cheng-yi Chiang <cychiang@chromium.org>
Date: Mon, 7 Oct 2019 21:03:10 +0800
Message-ID: <CAFv8Nw+xfqzKC+x9m-Zd-dmPNayXxqTCeo8JsO7pQn8Uk1Ybsw@mail.gmail.com>
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jernej Skrabec <jernej.skrabec@siol.net>,
 Doug Anderson <dianders@chromium.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, Jonas Karlman <jonas@kwiboo.se>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Tzung-Bi Shih <tzungbi@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-rockchip@lists.infradead.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Mark Brown <broonie@kernel.org>, dri-devel@lists.freedesktop.org,
 Daniel Kurtz <djkurtz@chromium.org>, Yakir Yang <ykk@rock-chips.com>,
 Dylan Reid <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org,
 Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [alsa-devel] [PATCH v2 RESEND] drm/bridge: dw-hdmi: Restore
 audio when setting a mode
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Mon, Oct 7, 2019 at 7:57 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 03/10/2019 06:14, Cheng-Yi Chiang wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> >
> > When setting a new display mode, dw_hdmi_setup() calls
> > dw_hdmi_enable_video_path(), which disables all hdmi clocks, including
> > the audio clock.
> >
> > We should only (re-)enable the audio clock if audio was already enabled
> > when setting the new mode.
> >
> > Without this patch, on RK3288, there will be HDMI audio on some monitors
> > if i2s was played to headphone when the monitor was plugged.
> > ACER H277HU and ASUS PB278 are two of the monitors showing this issue.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > ---
> >  Change from v1 to v2:
> >   - Use audio_lock to protect audio clock.
> >   - Fix the patch title.
> >
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index aa7efd4da1c8..749d8e4c535b 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1982,6 +1982,17 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
> >                   HDMI_IH_MUTE_FC_STAT2);
> >  }
> >
> > +static void dw_hdmi_audio_restore(struct dw_hdmi *hdmi)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&hdmi->audio_lock, flags);
> > +
> > +     hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
> > +
> > +     spin_unlock_irqrestore(&hdmi->audio_lock, flags);
>
> Dumb question, why is this protected by a spinlock ?
>
> Neil
>

Hi Neil,
Thanks for the review.
Good catch. I found that the spinlock audio_lock was introduced in

b90120a96608 drm: bridge/dw_hdmi: introduce interfaces to enable and
disable audio

to protect N/CTS value.
Actually it was not used to protect audio clock.
So we don't need this spinlock.

Hi Daniel Kurtz,
If this rings any bell in your memory as for why this is protected,
please let me know.
I would like to remove this spinlock and simplify this patch in v3.

Thanks!


> > +}
> > +
> >  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
> >  {
> >       int ret;
> > @@ -2045,7 +2056,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
> >
> >               /* HDMI Initialization Step E - Configure audio */
> >               hdmi_clk_regenerator_update_pixel_clock(hdmi);
> > -             hdmi_enable_audio_clk(hdmi, true);
> > +             dw_hdmi_audio_restore(hdmi);
> >       }
> >
> >       /* not for DVI mode */
> >
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
