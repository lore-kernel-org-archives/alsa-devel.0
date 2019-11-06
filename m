Return-Path: <SRS0=zQEr=Y6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDB2C5DF60
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 02:36:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73F7222C4
	for <alsa-devel@archiver.kernel.org>; Wed,  6 Nov 2019 02:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="EBLrIk97";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WUAI0Bql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73F7222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 821A216D6;
	Wed,  6 Nov 2019 03:35:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 821A216D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573007761;
	bh=bNyw4zY/xGs3uBUZlxbzRIYTCcKU4zWCzCHIcQlGazY=;
	h=References:In-Reply-To:From:Date:To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EBLrIk97ew/CpiQOcXSoS4Ty6YYf8TYnN7Y+lqVhRINkbce4PvLbOtENVOWkJN8eW
	 SPKG64SyiXc+jvGdvmCTIaQ7YSCaXu+Im6xssyOW5ZUINpnqAwQNwHo0nbfux1B2hG
	 Z1IEDihz/vGN/12xOeDaTo8zkX1U/LYUYsa/WTUc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F11EBF80321;
	Wed,  6 Nov 2019 03:35:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5750F803F4; Wed,  6 Nov 2019 03:35:09 +0100 (CET)
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com
 [IPv6:2607:f8b0:4864:20::141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DF75F80291
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 03:35:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DF75F80291
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com
 header.i=@intel-com.20150623.gappssmtp.com header.b="WUAI0Bql"
Received: by mail-il1-x141.google.com with SMTP id s75so20365077ilc.3
 for <alsa-devel@alsa-project.org>; Tue, 05 Nov 2019 18:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wj7wXMwHyGRgYoh8XbcVtlFO8Qvo4fZtSG5+92RrW1k=;
 b=WUAI0Bqlzqc59DS7xm/5dBMOEb/k4yqmlumjHl5axBYKmdlarAlACq0gt9y0s6zHVk
 nO9jh7YAhhsV6JxfLcQBAaq44JM7sDwHYZMmuq2VAQiVOCqBx5XRVJWRwTgUDRm++fIe
 CqLwinrAe89jSg1e1ZUEzzx/0qKw82ay0FFtDC1aUSrlJ73d1jAtezb3GKs1Z2gf8ryo
 C3F4t/dmW4yMJKA6sIlVpihyFhZsslERm/V+zU/cqBXgcqADtjFGYii60kj9qE2WQuUr
 5fbqT5I3TStBpj9TnqxCRaTy3IW/zMCSDt//WLqmoQHQm4uo9bbsdVbdQt1ILkLRxQlF
 OIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wj7wXMwHyGRgYoh8XbcVtlFO8Qvo4fZtSG5+92RrW1k=;
 b=uXJARnwQp3eg+63cRWXbjWQYxEO/XUlCNQ/HurupsspSMGa1S9o/if1FmLt8FNhEFH
 2OmhQxYWDk+2Dve2j6K4ODJXFhstA6AZGq32wgw5OxKrhAV8UF4rTQT6IBFU7CUAJlzT
 Mq7rAWp/S4zrEUW9mIau3K7KiG5fx0d/nyeOTaW1nTalkLa3jQfcG0VKUgkT2kGCJh7I
 QD1h30trn/Jm5lud7liAw+cESSZ+TI77V8P6acCKd4fC3T06rZYJL4iIeYdrIyqSBlPW
 Gn4+LXeKf8hPxnrmyfbS+emRRUPcsmLwR+dew7Stq6MWq9Dzf/pf6zq6gFKexrChIG1H
 Hphg==
X-Gm-Message-State: APjAAAV/TColIrMSyd6QlSTI3AXdIBNVWQ54dmuC05Kygu+rsIskjnPH
 Vn0tstv60ksW2dUkAch9ji6VLk0HBRXRSYRsXbDpXA==
X-Google-Smtp-Source: APXvYqyPAiJCWejipO2Yeu1+zvhLppvdOpuqEM0Xnqk5umNFB1OYJ8hR6PrG/rJAXZU+rVRrAKt7QWDEb4xu3gSgpFE=
X-Received: by 2002:a92:d64d:: with SMTP id x13mr231009ilp.54.1573007703872;
 Tue, 05 Nov 2019 18:35:03 -0800 (PST)
MIME-Version: 1.0
References: <87wocdhkz6.wl-kuninori.morimoto.gx@renesas.com>
 <87k18dhkw2.wl-kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87k18dhkw2.wl-kuninori.morimoto.gx@renesas.com>
From: "Sridharan, Ranjani" <ranjani.sridharan@intel.com>
Date: Tue, 5 Nov 2019 18:34:58 -0800
Message-ID: <CAFQqKeW9ZuUcGFkjw30q-CuBfWtnDoBB_UsmjFCdBPPS78nZrg@mail.gmail.com>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
X-Content-Filtered-By: Mailman/MimeDel 2.1.15
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 9/9] ASoC: soc-core: call
 snd_soc_dapm_shutdown() at soc_cleanup_card_resources()
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

On Tue, Nov 5, 2019 at 5:14 PM Kuninori Morimoto <
kuninori.morimoto.gx@renesas.com> wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> It is easy to read code if it is cleanly using paired function/naming,
> like start <-> stop, register <-> unregister, etc, etc.
> But, current ALSA SoC code is very random, unbalance, not paired, etc.
> It is easy to create bug at the such code, and it will be difficult to
> debug.
>
> snd_soc_bind_card() is calling snd_soc_dapm_init() for both
> card and component.
> Let's call paired snd_soc_dapm_shutdown() at paired
> soc_cleanup_card_resources().
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  sound/soc/soc-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 927b9c9..0bed63e 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -1940,6 +1940,8 @@ static void soc_cleanup_card_resources(struct
> snd_soc_card *card)
>                 card->snd_card = NULL;
>         }
>
> +       snd_soc_dapm_shutdown(card);
> +
>         /* remove and free each DAI */
>         soc_remove_link_dais(card);
>         soc_remove_link_components(card);
> @@ -2377,7 +2379,6 @@ static void snd_soc_unbind_card(struct snd_soc_card
> *card, bool unregister)
>
Morimoto-san,

You removed snd_soc_bind_card in one of the patches but then leaving
snd_soc_unbind_card() will be unbalanced isnt it?

Why not just have instantiate_card() and cleanup_card_resources()?

Thanks,
Ranjani

>  {
>         if (card->instantiated) {
>                 card->instantiated = false;
> -               snd_soc_dapm_shutdown(card);
>                 snd_soc_flush_all_delayed_work(card);
>
>                 soc_cleanup_card_resources(card);
> --
> 2.7.4
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
